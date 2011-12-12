From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] mv: improve overwrite warning
Date: Mon, 12 Dec 2011 16:52:39 -0500
Message-ID: <20111212215238.GD9754@sigill.intra.peff.net>
References: <20111212074503.GB16511@sigill.intra.peff.net>
 <20111212075227.GD17532@sigill.intra.peff.net>
 <7vobvd36ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:52:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDni-0005Uu-7N
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1LLVwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:52:42 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48345
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab1LLVwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:52:41 -0500
Received: (qmail 5811 invoked by uid 107); 12 Dec 2011 21:59:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 16:59:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 16:52:39 -0500
Content-Disposition: inline
In-Reply-To: <7vobvd36ms.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186959>

On Mon, Dec 12, 2011 at 11:57:31AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This message looks overly long to me, but I wanted to match the existing
> > messages. Another option would be just:
> >
> >   warning: overwriting 'three/one'
> 
> Yes, I think it makes perfect sense to drop the ugly "source=one destination=two"
> cruft, both for single-source and multiple-source cases.

Yeah, the more I look at the message in the patch I sent, the uglier it
gets. Here's a re-rolled 4 and 5 with the nicer format.

-Peff
