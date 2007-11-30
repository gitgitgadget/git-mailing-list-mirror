From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 20:13:04 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711292004340.9605@xanadu.home>
References: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <20071129150849.GA32296@coredump.intra.peff.net>
 <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com>
 <20071129211409.GA16625@sigill.intra.peff.net>
 <Pine.LNX.4.64.0711292218240.27959@racer.site>
 <20071129231444.GA9616@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org>
 <20071130003512.GB11683@coredump.intra.peff.net>
 <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
 <20071130005852.GA12224@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuRc-0004Ak-De
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763316AbXK3BNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763136AbXK3BNI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:13:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48355 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762939AbXK3BNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:13:05 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA00KVDOPSOD60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 20:13:05 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071130005852.GA12224@coredump.intra.peff.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66592>

On Thu, 29 Nov 2007, Jeff King wrote:

> On Thu, Nov 29, 2007 at 04:49:26PM -0800, Junio C Hamano wrote:
> 
> > I understand your point was primarily "git-a<tab>".  I think it has been
> > solved for bash and zsh but not for other shells.  I think possible and
> > sensible avenues are (1) punt -- cvs, svn nor hg people do not seem to
> > have problem with it, or (2) implement completion in your other favorite
> > shells.
> 
> My point is that (2) is already implemented for every program (shell or
> no) which understands filename completion, and there is a proposal for
> taking it away. I would consider that, except I haven't see any claimed
> advantages except that the hardlinks are awful under Windows.

Weren't enough complaints about Git having waaaaaaaaaaay too many 
commands?  Didn't those complaints come about often enough already?

	$ git-[tab]
	Display all 135 possibilities? (y or n)


Nicolas
