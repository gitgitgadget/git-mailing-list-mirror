From: "Neal Kreitzinger" <neal@rsss.com>
Subject: merge removed content back into current content
Date: Fri, 24 Sep 2010 22:06:10 -0500
Message-ID: <i7jp1a$kc0$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 05:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzL77-00006p-9m
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 05:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab0IYDHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 23:07:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:50133 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325Ab0IYDHh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 23:07:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OzL6r-0008Tx-Gz
	for git@vger.kernel.org; Sat, 25 Sep 2010 05:07:33 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 05:07:33 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 05:07:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157109>

How do I tell git to merge a single program from an old commit into the 
current version of that program in the HEAD commit?  In this scenario, I 
want to get back some removed code but still keep the new code.

e.g.

Commit-1 = initial commit containing Program-A, and other programs

Commit-2 = add Changeset-1 to Program-A , and make changes to other programs

Commit-3 = remove Changeset-1 from Program-A, then add Changeset-2 to 
Program-A, and make changes to other programs

*desired* Commit-4 = only merge Program-A from Commit-2 into Program-A of 
Commit-3, and don't change any other programs
(in other words, get my old changes from Commit-2 back, but don't loose the 
new changes from Commit-3)

v/r,
Neal 
