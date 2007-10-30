From: Nicolas Pitre <nico@cam.org>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 16:36:08 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710301631150.21255@xanadu.home>
References: <20071029174000.GA4449@efreet.light.src>
 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org>
 <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
 <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
 <20071030044026.GA9600@thunk.org>
 <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <20071030053732.GA16963@hermes.priv>
 <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
 <20071030160232.GB2640@hermes.priv>
 <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
 <vpq8x5kh4rr.fsf@bauges.imag.fr>
 <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
 <4727839B.9070205@obry.net>
 <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
 <86tzo81hrd.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pascal Obry <pascal@obry.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imxp6-0006oM-7z
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbXJ3UgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbXJ3UgO
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:36:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16460 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXJ3UgO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 16:36:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ004CARW8QEI1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 16:36:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <86tzo81hrd.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62753>

On Tue, 30 Oct 2007, Randal L. Schwartz wrote:

> >>>>> "Linus" == Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> Linus> So the only argument really is:
> 
> Linus>  - Nobody has pointed to *any* reason to follow 1738.
> 
> Linus>  - I have pointed to reasons *not* to do it.
> 
> I can support non-compliance with 1738.  However, I'd also suggest
> that outside of this cozy group of developers, URL already has a heavily
> defined meaning associated with 1738.
> 
> Therefore, I propose that the git docs refrain from calling these things
> "URLs" because they're not, and instead adopt something like "GRL" (git
> resources locator) or whatever.

And what do you do with the remote.<name>.url config option?
Add some backward compatibility cruft for some... well... issue that 
turns out not to be one in practice?

Again, can someone point to a real usage scenario where all this 
discussion is solving something?


Nicolas
