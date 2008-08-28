From: Nicolas Pitre <nico@cam.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 10:13:54 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808281011550.1624@xanadu.home>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
 <20080826145719.GB5046@coredump.intra.peff.net>
 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
 <20080827001705.GG23698@parisc-linux.org>
 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
 <1219907659.7107.230.camel@pmac.infradead.org>
 <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
 <1219912327.7107.245.camel@pmac.infradead.org>
 <alpine.LFD.1.10.0808281002270.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Matthew Wilcox <matthew@wil.cx>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:19:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYiHK-0002nk-Mu
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYH1OOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYH1OOG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:14:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23034 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYH1OOD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 10:14:03 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6B00HDBE76DPB0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Aug 2008 10:13:55 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0808281002270.1624@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94060>

On Thu, 28 Aug 2008, Nicolas Pitre wrote:

> On Thu, 28 Aug 2008, David Woodhouse wrote:
> 
> > I'm not asking you to make another change in upstream git. You've told
> > us the workaround (gitexecdir=/usr/bin), and that workaround is no
> > longer going to be deprecated, which is great. It's just up to us to
> > ensure that we use that workaround when we build git for ourselves, and
> > to ensure that our distributions also build packages using that
> > workaround.
> 
> ... effectively denying all those who asked for "git " from _easily_ 
> getting it.

By this I mean "git-" out of /usr/bin, before someone replies saying 
that "git " is always available.


Nicolas
