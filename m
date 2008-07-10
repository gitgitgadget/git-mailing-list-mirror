From: Nicolas Pitre <nico@cam.org>
Subject: Re: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 16:26:03 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807101625330.12484@xanadu.home>
References: <20080710075327.GD24819@artemis.madism.org>
 <7vy749pxbe.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807101212000.12484@xanadu.home>
 <20080710201352.GA3717@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH2jS-0003q0-QX
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 22:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbYGJU0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbYGJU0G
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 16:26:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19037 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYGJU0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 16:26:05 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3T00B954RFZA70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 10 Jul 2008 16:26:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080710201352.GA3717@blimp.local>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88008>

On Thu, 10 Jul 2008, Alex Riesen wrote:

> Nicolas Pitre, Thu, Jul 10, 2008 18:21:09 +0200:
> > On Thu, 10 Jul 2008, Junio C Hamano wrote:
> > >  (2) exploding memory use, suspected to be due to malloc pool
> > >      fragmentation under multithreading.
> ...
> > > but I do not
> > > recall the latter issue has been addressed.
> > 
> > Well, for "standard" repositories such as the Linux kernel, things 
> > always worked just fine.  And commit eac12e2d is apparently helping a 
> > lot with the remaining odd cases.  And if someone has problems due to 
> > this then a simple 'git config --global pack.threads 1' would restore 
> > the non threaded behavior.
> 
> Have you ever seen what happens to Windows XP on memory shortage?

Who said this would be enabled on Windows?


Nicolas
