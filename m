From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 20:19:38 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711292013580.9605@xanadu.home>
References: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <20071129150849.GA32296@coredump.intra.peff.net>
 <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
 <20071129211409.GA16625@sigill.intra.peff.net>
 <Pine.LNX.4.64.0711292218240.27959@racer.site>
 <20071129231444.GA9616@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org>
 <20071130003512.GB11683@coredump.intra.peff.net>
 <alpine.LFD.0.99999.0711291950590.9605@xanadu.home>
 <20071130010055.GB12224@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuYh-0005mQ-K4
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847AbXK3BTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbXK3BTk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:19:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61398 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbXK3BTj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:19:39 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA000XBP0QXE30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 20:19:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071130010055.GB12224@coredump.intra.peff.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66595>

On Thu, 29 Nov 2007, Jeff King wrote:

> On Thu, Nov 29, 2007 at 07:52:01PM -0500, Nicolas Pitre wrote:
> 
> > > I am still against this step, for the reasons mentioned in the mails
> > > leading up to the one you just quoted. I am fine with "does not install
> > > hardlinks for builtin-commands on systems that don't support hardlinks"
> > > (and of course all such hardlinks are in $(libexecdir)/git-core at this
> > > point).
> > 
> > But only for porcelain, right?  You certainly don't need the dashed form 
> > of plumbing commands?
> 
> In principle, yes, though one man's porcelain is another man's plumbing,
> so determining the correct set is hard (and why bother if they are all
> hidden from mere mortals, anyway?).

That would be a good reason not to bother determining which set to 
preserve and remove them all then.

Sure you'll miss the dashed form for, say, one week? After that your 
fingers should be retrained.


Nicolas
