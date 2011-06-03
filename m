From: "Neal Kreitzinger" <neal@rsss.com>
Subject: pre-commit hook to reject whitespace
Date: Fri, 3 Jun 2011 18:31:26 -0500
Message-ID: <isbqsf$vh8$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 01:31:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSdqH-0000JY-77
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 01:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872Ab1FCXbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 19:31:44 -0400
Received: from lo.gmane.org ([80.91.229.12]:35083 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655Ab1FCXbn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 19:31:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QSdqA-0000Ir-Bk
	for git@vger.kernel.org; Sat, 04 Jun 2011 01:31:42 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 01:31:42 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 01:31:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6090
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175040>

The reference manuals state in the hooks documentation that the pre-commit 
hook sample will reject whitespace only changes.  However, the 
pre-commit.sample in the 1.7.1 and 1.7.5.4 downloads do not appear to do 
this (I'm new to linux scripts).  The appear to only reject non-ascii 
filenames.  Does someone have a pre-commit hook example I can use to reject 
whitespace-only changes?  Thanks!

v/r,
neal 
