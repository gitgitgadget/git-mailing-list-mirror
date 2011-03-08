From: "Neal Kreitzinger" <neal@rsss.com>
Subject: rsync busy non-bare git repo 'source' to quiet
Date: Tue, 8 Mar 2011 15:25:00 -0600
Message-ID: <il66rd$46u$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 22:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4PF-0008Px-BG
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622Ab1CHVZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:25:17 -0500
Received: from lo.gmane.org ([80.91.229.12]:37577 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329Ab1CHVZP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:25:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Px4P4-0008KS-9N
	for git@vger.kernel.org; Tue, 08 Mar 2011 22:25:14 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 22:25:14 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 22:25:14 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168699>

Does anyone have an example of an rsync bash script that will make a good 
copy of a non-bare git repo (including the working tree) while the "source" 
git repo is busy and the "destination" git repo is quiet?

We do not use symlinks in our working-tree or in our .git directory (unless 
git is using symlinks on its own behind-the-scenes that I am not aware of).

This would make it very easy for us to refresh our "beta" livebox to emulate 
the current "gold" livebox using a single rsync instead of a combination of 
rsync and git-clone/pull due to the pieces that git does not replicate (ie, 
hooks) and the non-git components of our git based change control menu 
system (which is written in bash scripts on linux).

Thanks!

v/r,
Neal 
