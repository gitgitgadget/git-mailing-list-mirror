From: "Neal Kreitzinger" <neal@rsss.com>
Subject: suggestion: git status = restored
Date: Fri, 25 Mar 2011 12:59:34 -0500
Message-ID: <imil67$oec$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 19:00:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BIj-0007Sx-L9
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 18:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab1CYR7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 13:59:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:60351 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559Ab1CYR7v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 13:59:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q3BIc-0007O4-Hd
	for git@vger.kernel.org; Fri, 25 Mar 2011 18:59:50 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 18:59:50 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 18:59:50 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170006>

We deleted (git-rm) a file from the repo by mistake.  Several commits later 
we restored it (git-checkout, git-commit).  Git status shows "added" for 
this file.  IMHO, it seems like git status should be "restored" or 
"unremoved", etc, for this file.  Git detects renames and copies so it seems 
like it could detect restores.

v/r,
Neal 
