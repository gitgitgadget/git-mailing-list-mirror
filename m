From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: stop using asciidoc no-inline-literal
Date: Thu, 26 Apr 2012 05:13:43 -0400
Message-ID: <20120426091343.GA16663@sigill.intra.peff.net>
References: <20120426085156.GB22819@sigill.intra.peff.net>
 <vpqehra97wo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:13:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNKly-0005iR-HX
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 11:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab2DZJNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 05:13:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45112
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754160Ab2DZJNq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 05:13:46 -0400
Received: (qmail 12621 invoked by uid 107); 26 Apr 2012 09:13:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Apr 2012 05:13:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Apr 2012 05:13:43 -0400
Content-Disposition: inline
In-Reply-To: <vpqehra97wo.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196361>

On Thu, Apr 26, 2012 at 11:09:11AM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The patch is below. I'm slightly nervous because it means topics in
> > flight will need to have their documentation tweaked, too.
> 
> ... or, at worse, they will be broken for a while, and we can grep again
> the tip of pu after a few weeks to fix them.

Yes. Though having just done that grep, it is quite tedious.  You will
get many false positives in the existing documentation that do not need
changed (e.g., stash@{0}, or a literal backslash that is meant to be in
the output). So I think it will be simpler to just diff Documentation/
for the new topics and scan them manually (or grep the diff output).

> Plus, the possible breakage due to your patch are compensated by the
> existing breakage you fixed ;-). So, I'd say this is a valid concern,
> but the benefit seem clearly greater than the drawbacks.

Yeah, that was my conclusion, too.

-Peff
