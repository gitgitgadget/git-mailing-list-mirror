From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable
 descriptions
Date: Mon, 25 Oct 2010 11:04:05 -0400
Message-ID: <20101025150405.GC28278@sigill.intra.peff.net>
References: <cover.1287690696.git.trast@student.ethz.ch>
 <20101022155307.GB5554@sigill.intra.peff.net>
 <201010240324.42721.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 25 17:03:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAOa1-0007IQ-B9
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 17:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab0JYPDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 11:03:16 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52388 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159Ab0JYPDP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 11:03:15 -0400
Received: (qmail 20692 invoked by uid 111); 25 Oct 2010 15:03:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (74.7.61.109)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 25 Oct 2010 15:03:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Oct 2010 11:04:05 -0400
Content-Disposition: inline
In-Reply-To: <201010240324.42721.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159955>

On Sun, Oct 24, 2010 at 03:24:42AM +0200, Thomas Rast wrote:

> Jeff King wrote:
> >   1. It looks like you're more or less just parsing "::" list keys from
> >      all of the manpages. This seems somewhat fragile, as there could be
> >      other non-config lists. Can we at least restrict it to
> >      CONFIGURATION sections? It would be nice if we could put in some
> >      kind of semantic markup, but I'm not sure how painful that would be
> >      with asciidoc (we could always resort to comments in the source,
> >      but that would probably get unreadable quickly).
> 
> I figured for consistency and ease of lookup *all* configuration docs
> should name the variables in the same format.  It can still be helpful
> to mention them elsewhere, e.g. in the option documentations, but the
> main docs should be a CONFIGURATION section formatted like this.
> 
> Or do you think that would be a bad thing?

No, I think everything should be in a CONFIGURATION section. So checking
for that is probably enough. I was more concerned about false positives
creeping in. Checking just the CONFIGURATION section would probably make
that unlikely, though.

-Peff
