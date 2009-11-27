From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 15:50:04 -0500
Message-ID: <20091127205004.GA26921@coredump.intra.peff.net>
References: <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
 <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
 <7vpr73n7ns.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 21:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE7ln-0008S5-F0
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbZK0Ut5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 15:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbZK0Ut5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:49:57 -0500
Received: from peff.net ([208.65.91.99]:56471 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbZK0Ut4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:49:56 -0500
Received: (qmail 29481 invoked by uid 107); 27 Nov 2009 20:54:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 15:54:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 15:50:04 -0500
Content-Disposition: inline
In-Reply-To: <7vpr73n7ns.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133935>

On Fri, Nov 27, 2009 at 10:29:11AM -0800, Junio C Hamano wrote:

> > If only somebody had written a "pager.status" configuration variable,
> > you could use that. Oh wait. I did. And it shipped in v1.6.0.
> 
> Nice try but, "grep" and "status" are apples and oranges comparision.

Yes, I think you are right that the existence of pager.* does not
necessarily imply that there should be a config option for grep. But
that makes his example even more irrelevant: he is advocating that I use
a solution in this instance because he uses it in another instance, when
that solution is not even necessary in the other instance (and as I have
hopefully already made clear, is in my opinion inferior).

It is probably better to stay on the topic of the grep option, though.

-Peff
