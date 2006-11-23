X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: rebase fails but not sure why
Date: Thu, 23 Nov 2006 00:26:58 +0000
Message-ID: <200611230026.58936.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 00:27:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32112>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn2Qu-0007FO-M6 for gcvg-git@gmane.org; Thu, 23 Nov
 2006 01:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757212AbWKWA1D (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 19:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757223AbWKWA1D
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 19:27:03 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:64984 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1757212AbWKWA1B (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22
 Nov 2006 19:27:01 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gn2Qe-00040g-GO for git@vger.kernel.org; Thu, 23 Nov 2006 00:27:00 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I have been doing repeated rebase on my repository to try and separate out 
mixed streams of development into separate branches.

I have now got to a point where the following error occurs during a rebase.

fatal: empty ident  <alan@chandlerfamily.org.uk> not allowed
Commit failed, please do not call "git commit"
directly, but instead do one of the following:

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

but I am not sure how to solve issue.

git status shows a number of files waiting to be commited, but no unmerged 
files. but git rebase --continue just pumps out the same error message.


-- 
Alan Chandler
