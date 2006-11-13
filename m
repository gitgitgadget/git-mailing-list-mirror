X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alexander Litvinov" <litvinov2004@gmail.com>
Subject: Getting new branches from remote repo.
Date: Mon, 13 Nov 2006 10:33:52 +0600
Message-ID: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 04:35:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A0mqsPbCjCxYxgS0OmZHJPRqw3Q6/HLL3WvdZn8Yt/j0IuniFiv9VS90iadpXXkkR2Xt7sM72HUWZFyl0z650Xx5pD+G17Eca7P0CnAsdtJU1G3aXAyWDmNIWFj0MDie3OfeLXZhOT7BX/S/AeCz9u35f58oGvQWDf3JGIXzOYg=
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.5/2188/Sun Nov 12 20:32:01 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31286>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjTXz-0004AJ-3R for gcvg-git@gmane.org; Mon, 13 Nov
 2006 05:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753877AbWKMEfX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 23:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbWKMEfX
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 23:35:23 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:36001 "EHLO
 zeus1.kernel.org") by vger.kernel.org with ESMTP id S1753877AbWKMEfW (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 23:35:22 -0500
Received: from py-out-1112.google.com (py-out-1112.google.com
 [64.233.166.181]) by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id
 kAD4Z9tH010411 for <git@vger.kernel.org>; Mon, 13 Nov 2006 04:35:22 GMT
Received: by py-out-1112.google.com with SMTP id a29so675049pyi for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 20:34:09 -0800 (PST)
Received: by 10.35.53.18 with SMTP id f18mr9320568pyk.1163392433665; Sun, 12
 Nov 2006 20:33:53 -0800 (PST)
Received: by 10.35.108.4 with HTTP; Sun, 12 Nov 2006 20:33:52 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello list,

I have a trouble I don't know how to solve. When I am cloning remote
repo I automatically get all it's branches stored at my repo (they are
listed at .git/remotes/origin). When someone adds new branch(es) to
remote repo git pull (git fetch) does not automatically add them to my
repo. I have a tool to list all remote branches (git ls-remote --heads
origin) but I can't find how to add interesting (or all) branches to
by repo.

By the way, how can I clone remote repo created by cloning another
repo using git clone --use-separate-remotes ? Even git ls-remote
--heads origin does not show all branches taken from that another
repo.

