From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 15:37:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002161529411.1946@xanadu.home>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
 <20100216180209.GA1532@book.hvoigt.net>
 <7vocjpng1w.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
 <alpine.DEB.1.00.1002162118060.8642@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhUBW-0000NV-NM
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 21:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054Ab0BPUiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 15:38:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27353 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966Ab0BPUiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 15:38:12 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXY001CHBZ9T420@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Feb 2010 15:37:57 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.1002162118060.8642@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140154>

On Tue, 16 Feb 2010, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 16 Feb 2010, Nicolas Pitre wrote:
> 
> > On Tue, 16 Feb 2010, Junio C Hamano wrote:
> > 
> > [...]
> > > Notice how your version (xyzzy) broke the cascade of if..elseif..else.
> > > 
> > > Don't they teach this in schools anymore?
> > 
> > What do you expect from academia?  School and real life are still too 
> > often disconnected.
> 
> Actually, you know, I am quite happy that they do not teach _that_ 
> particular code template. It is enough that I have to suffer this ugliness 
> from oldtimers, no need for newtimers piling onto this particular pile.

Unfortunately the real world is not without its share of ugliness.
And newtimers need to be better prepared to cope when they get loose.

I guess that's one of the reasons I skipped many lectures at Uni...
to hack on Linux 1.0.x instead.


Nicolas
