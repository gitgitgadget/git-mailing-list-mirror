From: James Cloos <cloos@jhcloos.com>
Subject: Re: Distribution of longest common hash prefixes
Date: Wed, 04 Apr 2007 17:03:02 -0400
Message-ID: <m3bqi3ons2.fsf@lugabout.jhcloos.org>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
	<86bqi6kae7.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
	<86y7laitlz.fsf@blue.stonehenge.com>
	<86r6r2isva.fsf@blue.stonehenge.com>
	<m3r6r1jsmq.fsf@lugabout.jhcloos.org>
	<867istcrhr.fsf@blue.stonehenge.com>
	<20070403172123.GD27706@spearce.org>
	<Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Eriksen <s022018@student.dtu.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 23:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZCmW-0004gN-7V
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 23:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbXDDVM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 17:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbXDDVM3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 17:12:29 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:4838 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbXDDVM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 17:12:27 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Apr 2007 17:12:27 EDT
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id D42AB4028B; Wed,  4 Apr 2007 21:04:12 +0000 (UTC)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id B406B2A267F; Wed,  4 Apr 2007 21:03:25 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue\, 3 Apr 2007 10\:50\:34 -0700 \(PDT\)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMnRFWHRUaXRsZQAvbWF4dG9y
 L2Nsb29zL2luY29taW5nLzIwMDQvMDIvUFdHL0pIQzE2LnBuZyJMlEwAAAAadEVYdFNvZnR3YXJl
 AEdOT01FIEljb24gRWRpdG9ynioKbAAAAHFJREFUeJzFk8EKwCAMQ1/ED9cvzw6iuM0N9WIvDTWE
 1KjAxmKnLBEBjLcEIBCeI2nccy5YKrjxwbbvAvZ37zlo4GB9iRMC/cq/AppItwmMyJ5I98wd9G7P
 xxgrSKlYS2lMrOcV13o95aVSKA7E5ndGXG+IIzcl4BNfAAAAAElFTkSuQmCC
Copyright: Copyright 2007 James Cloos
X-Hashcash: 1:23:070404:torvalds@linux-foundation.org::nn5ZwAVR1ssAl2mA:00000000000000000000000000000000Ddor
X-Hashcash: 1:23:070404:s022018@student.dtu.dk::qPMDkt0yLTS4Uukh:000000000000000000000000000000000000000Ex2u
X-Hashcash: 1:23:070404:merlyn@stonehenge.com::5xDoXoDyJmcurzxY:0000000000000000000000000000000000000000gvbB
X-Hashcash: 1:23:070404:git@vger.kernel.org::VfjtBbtJQInK9crj:000000000000000000000000000000000000000000xk2G
X-Hashcash: 1:23:070404:spearce@spearce.org::awJJI6Xk2Y4PWRML:000000000000000000000000000000000000000000+bYN
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43777>

>>>>> "Linus" == Linus Torvalds <torvalds@linux-foundation.org> writes:

Linus> Well, neither of the the two objects at 9 bytes may not be (and
Linus> probably aren't) commits and of the 32 8-nibble cases who knows
Linus> how many are actually commits (probably none), so an 8-byte SHA1
Linus> is *probably* unique at least if you just look at commits.

Linus> Remove the "--objects" to find out.

That makes for:

0: 
1: 
2: 1
3: 23320
4: 25431
5: 2259
6: 134
7: 8

But is the kernel large enough to be sufficiently representative?

Did Jon complete an import of the 'zilla src?  

Has anyone tried to import OOo?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
