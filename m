From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git (stable)
Date: 22 Dec 2006 10:12:47 -0800
Message-ID: <861wmrsstc.fsf@blue.stonehenge.com>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
	<86k60jsvh8.fsf@blue.stonehenge.com>
	<86fyb7sv9f.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0612221902490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 19:13:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxot9-0004K9-MS
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 19:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWLVSMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 13:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWLVSMt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 13:12:49 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:27017 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbWLVSMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 13:12:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 5978E8FEFC;
	Fri, 22 Dec 2006 10:12:48 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 14321-01-90; Fri, 22 Dec 2006 10:12:47 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 650088FF02; Fri, 22 Dec 2006 10:12:47 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.16.9; tzolkin = 10 Muluc; haab = 2 Kankin
In-Reply-To: <Pine.LNX.4.63.0612221902490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35193>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Ahh, it's "git-pull . origin".

Johannes> This is just a merge, not a real pull (it leaves out the fetch part).

OK, so what does what a naked "git-pull" used to do before, which was
"fetch origin, then pull it into the current branch"?

Johannes> So, for each branch (e.g. "xyz") for which you have a preferred upstream 
Johannes> (e.g. remote "linus" with branch "master"), say

Johannes> 	$ git repo-config branch.xyz.remote linus
Johannes> 	$ git repo-config branch.xyz.merge refs/heads/master

But that's not upward compatible.  The default should be the old behavior,
or we need a better way to notify people that this breaks things.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
