From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 22:23:50 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711282220300.9605@xanadu.home>
References: <Pine.LNX.4.64.0710260007450.4362@racer.site>
 <7v3avy21il.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0710261047450.4362@racer.site>
 <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711281307420.27959@racer.site>
 <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
 <Pine.LNX.4.64.0711282039430.27959@racer.site>
 <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>
 <7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711282156520.27959@racer.site>
 <20071128223339.GF7376@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 04:24:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixa15-0006jm-Hm
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 04:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbXK2DXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 22:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757875AbXK2DXx
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 22:23:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38900 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597AbXK2DXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 22:23:52 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS900MHZ03QRBM0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Nov 2007 22:23:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071128223339.GF7376@fieldses.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66497>

On Wed, 28 Nov 2007, J. Bruce Fields wrote:

> On Wed, Nov 28, 2007 at 09:58:52PM +0000, Johannes Schindelin wrote:
> > Not so sure about that.  We already have too many commands, according to 
> > some outspoken people, and this would add to it.
> 
> What they're really complaining about is the size and complexity of the
> interface, and the lack of a clearly identified subset for them to learn
> first.

Well, the idea is that once all those plumbing commands are hidden away 
in some libexec dir, that makes a _lot_ of breathing room for a few 
more porcelain commands if needed.


Nicolas
