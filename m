From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cloning empty repositories,
 was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 17:06:01 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711121702030.21255@xanadu.home>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
 <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site>
 <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site>
 <18232.35893.243300.179076@lisa.zopyra.com>
 <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr>
 <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:06:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrhQD-0000dg-I2
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbXKLWGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbXKLWGF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:06:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27518 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654AbXKLWGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:06:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRE00DUIYQ18N51@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Nov 2007 17:06:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64718>

On Mon, 12 Nov 2007, Junio C Hamano wrote:

> His second point is also a real issue.  If you allowed cloning
> an empty repo (either bare or non-bare), then you and Bill can
> both clone from it, come up with an initial commit each.  Bill
> pushes his initial commit first.  Your later attempt to push
> will hopefully fail with "non fast forward", if you know better
> than forcing such a push, but then what?  You need to fetch, and
> merge (or rebase) your change on top of Bill's initial commit,
> and at that point the history you are trying to merge does not
> have any common ancestor with his history.

While that could well be true, I don't see this condition happening 
solely in the context (hence because) of an empty clone.


Nicolas
