From: matt davies <mjdavies@glam.ac.uk>
Subject: Starting off
Date: Wed, 7 May 2008 12:38:38 +0100
Message-ID: <681A7BF7-FB8E-442A-82E9-EC1FEC33A7B2@glam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 14:27:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtikT-0007jl-0H
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 14:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbYEGM07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 08:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbYEGM07
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 08:26:59 -0400
Received: from jess.glam.ac.uk ([193.63.147.97]:32824 "EHLO jess.glam.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbYEGM05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 08:26:57 -0400
X-Greylist: delayed 2907 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2008 08:26:56 EDT
Received: from mailserv1.isd.glam.ac.uk ([192.168.244.1])
	by jess.glam.ac.uk with esmtp (Exim 3.35 #1)
	id 1JthyO-0001T1-00
	for git@vger.kernel.org; Wed, 07 May 2008 12:38:12 +0100
Received: from j235-md.isd.glam.ac.uk ([193.63.135.79]) by MAILSERV1.isd.glam.ac.uk with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 May 2008 12:38:26 +0100
X-Mailer: Apple Mail (2.919.2)
X-OriginalArrivalTime: 07 May 2008 11:38:26.0303 (UTC) FILETIME=[DD0760F0:01C8B036]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81431>

Hello everyone

I'm as new as new can be so please be gentle.

git version 1.5.4.5

I'm following the peepcode tutorial peepcode-015-git.mov

I've created a branch, and now we're trying to use rebase to 'watch'  
the master branch from the new branch.

When I run the rebase command from the other branch I get these types  
of warnings/errors

j235-md:gcal mjdavies$ git rebase master
First, rewinding head to replay your work on top of it...
HEAD is now at 8b18ef3... Assing test line to master branch
Applying adding the cas stuff from Kevs app
.dotest/patch:52: trailing whitespace.

.dotest/patch:120: trailing whitespace.
   reused by the Rails filter in subsequent requests (see the note below
.dotest/patch:121: trailing whitespace.
   in the 2.0.1 release). From the user's and integrator's point of view
.dotest/patch:123: trailing whitespace.
* Redirection loop interception: The client now logs a warning message  
when it
.dotest/patch:124: trailing whitespace.
   believes that it is stuck in a redirection loop with the CAS  
server. If more
warning: squelched 226 whitespace errors
warning: 231 lines add whitespace errors.
Applying adding the before filter to the application.rb, otherwise it  
knoweth not what to do

Can someone explain to me what's happening here and if I should be  
worried about it?

If I should be worried about it, can anyone point me in the direction  
of some documentation of a good (easy)way to remove the whitespace?

Thanks everyone.

PS, I do check the archives and found this from yesterday

http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=81336

Does that mean that if I update my git this problem will be resolved?   
Sorry for being so naive, I wont be for long (hopefully)
