From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] credential: convert "url" attribute into its parsed
 subparts
Date: Wed, 18 Jul 2012 08:25:56 -0400
Message-ID: <20120718122555.GA11482@sigill.intra.peff.net>
References: <20120718120307.GA6399@sigill.intra.peff.net>
 <20120718120626.GC6726@sigill.intra.peff.net>
 <vpqeho9jlzy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTKN-0008H3-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab2GRM0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:26:00 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39102
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab2GRMZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:25:58 -0400
Received: (qmail 19337 invoked by uid 107); 18 Jul 2012 12:26:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 08:26:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 08:25:56 -0400
Content-Disposition: inline
In-Reply-To: <vpqeho9jlzy.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201684>

On Wed, Jul 18, 2012 at 02:24:01PM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   $ echo https://user@example.com | git credential ident
> >   protocol=https
> >   host=example.com
> >   username=user
> >
> > since I had no use for it, but it would obviously be an easy one-liner
> > to write (it's just "fill" without the actual fill call).
> 
> I was thinking the same, except I would have spelled it "git credential
> parse" (but ident is fine too). On the perl side, that would allow
> getting a credential hash very simply (but it was already simple in
> perl, and made useless by your code).

I wanted to give it some name that meant "pass-through" rather than just
parse, in case we add more magic attributes later. I meant "ident" to be
like "mathematical identity", but in the context of a credential tool,
it is probably somewhat ambiguous. :)

Anyway, the fact that we can just do the parsing as part of the "fill"
means we don't need it for now, so I'll leave it until somebody really
cares.

-Peff
