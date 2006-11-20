X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG] StGit removed git branch of the same name as StGit branch
Date: Mon, 20 Nov 2006 22:01:44 +0100
Message-ID: <200611202201.45521.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 21:00:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VAeSqsI7wVnWqXhDeV21v/Ygrj9MahrKjtgIEyPAi5U1c56ohO0Y4WOhyk+qUXpyXfmslWZY/GR2cGvx0MlqVcKncVmexYndgUOMnijWlAKmLHE0iVt4eSzTRsCmm+DB95WnYRxcuB4B/Z7E/VtA47jGb0BX4auKD7iqpIbBdg4=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31937>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmGFw-0001e0-Jw for gcvg-git@gmane.org; Mon, 20 Nov
 2006 22:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966728AbWKTVAk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 16:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966729AbWKTVAk
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 16:00:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:63421 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966728AbWKTVAj
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 16:00:39 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1315300ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 13:00:38 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr8100832ugi.1164056416174; Mon, 20
 Nov 2006 13:00:16 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id j34sm8333178ugc.2006.11.20.13.00.15; Mon, 20 Nov
 2006 13:00:15 -0800 (PST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

I have used StGit (wonderfull tool) to manage patches on git branch 
gitweb/web. Unfortunately, I have named stg branch the same as git 
branch. When removing stg branch (I wanted to remove 
heads/base/gitweb/web) using "stg branch --delete gitweb/web" it 
deleted also git branch when I wanted to remove only the StGit managed 
indicator. Fortunately I was able to recover the branch from reflog, as 
StGit didn't delete reflog with deletion of git branch.

Perhaps that is correct behavior... but certainly unexpected.

Stacked GIT 0.11
git version 1.4.3.4
Python version 2.4.3 (#1, Jun 13 2006, 16:41:18) 
[GCC 4.0.2 20051125 (Red Hat 4.0.2-8)]
-- 
Jakub Narebski
