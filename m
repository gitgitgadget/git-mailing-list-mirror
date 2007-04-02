From: James Cloos <cloos@jhcloos.com>
Subject: Re: Distribution of longest common hash prefixes
Date: Mon, 02 Apr 2007 13:18:22 -0400
Message-ID: <m3tzvylmoa.fsf@lugabout.jhcloos.org>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
	<86bqi6kae7.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Eriksen <s022018@student.dtu.dk>,
	merlyn@stonehenge.com (Randal L. Schwartz)
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 19:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYQBc-0002dC-Ea
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 19:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933686AbXDBRTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 13:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933875AbXDBRTR
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 13:19:17 -0400
Received: from atl.uu.jhcloos.net ([207.210.96.115]:47264 "EHLO
	atl.uu.jhcloos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933686AbXDBRTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 13:19:16 -0400
Received: by atl.uu.jhcloos.net (Postfix, from userid 10)
	id 23A86BB4B7; Mon,  2 Apr 2007 17:19:11 +0000 (UTC)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id B12EC1EB787; Mon,  2 Apr 2007 17:18:46 +0000 (UTC)
In-Reply-To: <86bqi6kae7.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Mon\, 02 Apr 2007 09\:29\:20 -0700")
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMnRFWHRUaXRsZQAvbWF4dG9y
 L2Nsb29zL2luY29taW5nLzIwMDQvMDIvUFdHL0pIQzE2LnBuZyJMlEwAAAAadEVYdFNvZnR3YXJl
 AEdOT01FIEljb24gRWRpdG9ynioKbAAAAHFJREFUeJzFk8EKwCAMQ1/ED9cvzw6iuM0N9WIvDTWE
 1KjAxmKnLBEBjLcEIBCeI2nccy5YKrjxwbbvAvZ37zlo4GB9iRMC/cq/AppItwmMyJ5I98wd9G7P
 xxgrSKlYS2lMrOcV13o95aVSKA7E5ndGXG+IIzcl4BNfAAAAAElFTkSuQmCC
Copyright: Copyright 2007 James Cloos
X-Hashcash: 1:23:070402:merlyn@stonehenge.com::fIJG4nxxVL5EkOvw:00000000000000000000000000000000000000002Oqd
X-Hashcash: 1:23:070402:s022018@student.dtu.dk::8vgk4B9Vnq+oF8ue:000000000000000000000000000000000000000BLkA
X-Hashcash: 1:23:070402:git@vger.kernel.org::gYyRXG3p/U3tnmXU:000000000000000000000000000000000000000000CkoX
X-Hashcash: 1:23:070402:torvalds@linux-foundation.org::Spjgj28QEPeV02cc:00000000000000000000000000000000ECqt
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43607>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> I don't have access to the linux-2.6 kernel

As of commit b6a8b31, I get this for the kernel tree from Randal's code:

0: 16
1: 240
2: 3840
3: 61357
4: 293437
5: 74792
6: 5373
7: 350
8: 16
9: 1

(That is, of course, counting hex digits (aka nybbles), not bits as
Peter's code does.)

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
