From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 14:30:03 -0500
Message-ID: <20111216193003.GC19924@sigill.intra.peff.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <4EEB4F13.2010402@viscovery.net>
 <20111216192104.GA19924@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:30:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbdTv-0004ud-I5
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760589Ab1LPTaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:30:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44278
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab1LPTaG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:30:06 -0500
Received: (qmail 7198 invoked by uid 107); 16 Dec 2011 19:36:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 14:36:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 14:30:03 -0500
Content-Disposition: inline
In-Reply-To: <20111216192104.GA19924@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187306>

On Fri, Dec 16, 2011 at 02:21:04PM -0500, Jeff King wrote:

> At the same time, I think we have seen people complaining that the
> regular dumb funcname detection is not good enough[1], and that using
> language-specific funcnames, while not 100% perfect, produces better
> results on the whole.

I forgot to include my footnote, but it was:

[1] We've seen requests on the list, and we also receive similar
    requests at GitHub for web-based diffs to use better funcnames. We
    just enabled the mapping ourselves a week or two ago via a system
    /etc/gitattributes file.
