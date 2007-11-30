From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 20:33:39 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711292029420.9605@xanadu.home>
References: <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
 <20071129211409.GA16625@sigill.intra.peff.net>
 <Pine.LNX.4.64.0711292218240.27959@racer.site>
 <20071129231444.GA9616@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org>
 <20071130003512.GB11683@coredump.intra.peff.net>
 <alpine.LFD.0.99999.0711291950590.9605@xanadu.home>
 <20071130010055.GB12224@coredump.intra.peff.net>
 <alpine.LFD.0.99999.0711292013580.9605@xanadu.home>
 <20071130012536.GA12615@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixv0w-0004Lh-SW
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763809AbXK3Bti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763761AbXK3Bti
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:49:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49087 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763560AbXK3Bth (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:49:37 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA00BNRPO35E30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 20:33:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071130012536.GA12615@coredump.intra.peff.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66598>

On Thu, 29 Nov 2007, Jeff King wrote:

> On Thu, Nov 29, 2007 at 08:19:38PM -0500, Nicolas Pitre wrote:
> 
> > > In principle, yes, though one man's porcelain is another man's plumbing,
> > > so determining the correct set is hard (and why bother if they are all
> > > hidden from mere mortals, anyway?).
> > 
> > That would be a good reason not to bother determining which set to 
> > preserve and remove them all then.
> 
> It clearly argues for putting all in the same boat, yes (but obviously
> we disagree on which boat).
> 
> > Sure you'll miss the dashed form for, say, one week? After that your 
> > fingers should be retrained.
> 
> Perhaps, although that doesn't address my other point, about non-bash
> program in the world which already does filename completion (in my case,
> I am specifically thinking about vim's ":r!", but surely emacs users
> must have a similar issue).
> 
> But that is just talking about the disadvantages; you can argue that
> they are small, but they are clearly non-zero. More importantly, what
> are the _advantages_ of removing the hardlinks (and if you haven't read
> the other message I just sent you, I am talking not about putting
> hardlinks into a non-PATH directory, but about removing them entirely
> once they are already in that alternate directory)? If there aren't any
> advantages, or they are also small, then it makes sense to keep the
> hardlinks.

So what you want is for the dashed hardlinks to exist _inside_ the 
libexec directory, even if most people won't "see" them due to that 
libexec directory not being in the shell path, right?

If that is what you mean then I personally don't care at all.


Nicolas
