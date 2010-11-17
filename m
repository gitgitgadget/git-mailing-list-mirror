From: Jeff King <peff@peff.net>
Subject: Re: groff .ft command use in asciidoc
Date: Wed, 17 Nov 2010 09:38:55 -0500
Message-ID: <20101117143855.GA1987@sigill.intra.peff.net>
References: <20101117095233.GA23817@basil.fritz.box>
 <20101117101516.GA12416@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 15:39:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIjAB-0004wJ-Lu
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 15:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934357Ab0KQOjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 09:39:00 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44665 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884Ab0KQOjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 09:39:00 -0500
Received: (qmail 5368 invoked by uid 111); 17 Nov 2010 14:38:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 17 Nov 2010 14:38:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Nov 2010 09:38:55 -0500
Content-Disposition: inline
In-Reply-To: <20101117101516.GA12416@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161616>

On Wed, Nov 17, 2010 at 04:15:16AM -0600, Jonathan Nieder wrote:

> This is in my opinion a bug: unless you use ASCIIDOC_NO_ROFF, git's
> asciidoc.conf will include raw roff directives in the docbook markup
> it generates.  And then docbook will escape the periods, producing
> the output you see.

IIRC, that depends very much on the versions of asciidoc and docbook you
have. Once upon a time, not setting ASCIIDOC_NO_ROFF was required for
sane output.

Andi, I would be curious to hear which asciidoc and docbook-xsl versions
you are using.

> I think the only reason this is not the default is that no one has
> tested it with old DocBook XSL versions, but I'm not sure.
> Documentation/Makefile has some notes about this.

At the time those knobs came into being, the defaults were set for
then-current versions of the software. I suspect ASCIIDOC8 and
ASCIIDOC_NO_ROFF should be the default these days.

-Peff
