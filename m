From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 06/11] Makefile: split GIT_USER_AGENT from GIT-CFLAGS
Date: Wed, 20 Jun 2012 18:16:16 -0400
Message-ID: <20120620221616.GC3302@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183151.GF30995@sigill.intra.peff.net>
 <20120620212135.GE6142@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 00:16:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShTCJ-0002Kg-DY
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 00:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192Ab2FTWQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 18:16:20 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39350
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758184Ab2FTWQT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 18:16:19 -0400
Received: (qmail 30972 invoked by uid 107); 20 Jun 2012 22:16:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 18:16:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 18:16:16 -0400
Content-Disposition: inline
In-Reply-To: <20120620212135.GE6142@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200370>

On Wed, Jun 20, 2012 at 04:21:35PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > +	@if test x'$(GIT_USER_AGENT_SQ)' != x"`cat GIT-USER-AGENT 2>/dev/null`"; then \
> > +		echo >&2 "    * new user-agent flag"; \
> 
> Micronit: the term "new user-agent string" would be clearer.

Probably. I am tempted to get rid of the informative message altogether.
For CFLAGS, you might be confused why everything is being rebuilt, since
the dependency chain is not straightforward. For this, it's kind of
obvious.

> Re the lack of _HTTP: interesting.  Is the plan to use this for
> other protocols, too?

Look at the jk/version-string topic that this is based on. :)

-Peff
