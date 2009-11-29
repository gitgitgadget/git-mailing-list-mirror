From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 11:21:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911291118280.4985@pacific.mpi-cbg.de>
References: <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com> <20091127062013.GA20844@coredump.intra.peff.net> <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302> <20091127095914.GA4865@sigill.intra.peff.net> <7vpr73n7ns.fsf@alter.siamese.dyndns.org>
 <20091127205004.GA26921@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 11:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEgq1-0003gy-7S
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 11:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZK2KQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 05:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZK2KQx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 05:16:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:45569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751737AbZK2KQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 05:16:52 -0500
Received: (qmail invoked by alias); 29 Nov 2009 10:16:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 29 Nov 2009 11:16:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RBzMbjOeR16EEcixSQG/vtQcnWuou6GV25snHXW
	Ov8Qy//1XaOePb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091127205004.GA26921@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134008>

Hi,

On Fri, 27 Nov 2009, Jeff King wrote:

> On Fri, Nov 27, 2009 at 10:29:11AM -0800, Junio C Hamano wrote:
> 
> > > If only somebody had written a "pager.status" configuration variable,
> > > you could use that. Oh wait. I did. And it shipped in v1.6.0.
> > 
> > Nice try but, "grep" and "status" are apples and oranges comparision.
> 
> Yes, I think you are right that the existence of pager.* does not
> necessarily imply that there should be a config option for grep. But
> that makes his example even more irrelevant: he is advocating that I use
> a solution in this instance because he uses it in another instance, when
> that solution is not even necessary in the other instance (and as I have
> hopefully already made clear, is in my opinion inferior).

Sorry, no, you got it all wrong.

My point was that your config option introduced something _BAD_.  And my 
point was that now, as a consequence of having managed to put it into Git, 
you want more of such bad stuff.

You continue to ignore that inconsistency -- even if it is introduced with 
the best of all intentions -- is bad, bad, bad.

But I guess that I continue to get ignored,
Dscho
