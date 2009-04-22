From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 22 Apr 2009 10:14:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221011340.6741@xanadu.home>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <20090407142147.GA4413@atjola.homenet>
 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet>
 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
 <20090407202725.GC4413@atjola.homenet>
 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
 <20090410T203405Z@curie.orbis-terrarum.net>
 <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
 <20090414T202206Z@curie.orbis-terrarum.net>
 <1240362948.22240.76.camel@maia.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 16:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwdFz-00028t-W0
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 16:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbZDVOPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 10:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbZDVOPV
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 10:15:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29156 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbZDVOPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 10:15:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KII0069DA8OK3H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Apr 2009 10:14:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1240362948.22240.76.camel@maia.lan>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117199>

On Wed, 22 Apr 2009, Sam Vilain wrote:

> On Tue, 2009-04-14 at 13:27 -0700, Robin H. Johnson wrote:
> > On Tue, Apr 14, 2009 at 04:17:55PM -0400, Nicolas Pitre wrote:
> > > WRT the HTTP protocol, I was questioning git's ability to resume the 
> > > transfer of a pack in the middle if such transfer is interrupted without 
> > > redownloading it all. And Mike Hommey says this is actually the case.
> > With rsync:// it was helpful to split the pack, and resume there worked
> > reasonably (see my other mail about the segfault that turns up
> > sometimes).
> > 
> > More recent discussions raised the possibility of using git-bundle to
> > provide a more ideal initial download that they CAN resume easily, as
> > well as being able to move on from it.
> 
> Hey Robin,
> 
> Now that the GSoC projects have been announced I can give you the good
> news that one of our two projects is to optimise this stage in
> git-daemon; I'm hoping we can get it down to being almost as cheap as
> the workaround you described in your post.  I'll certainly be using your
> repository as a test case :-)

Please keep me in the loop as much as possible.  I'd prefer we're not in 
disagreement over the implementation only after final patches are posted 
to the list.


Nicolas
