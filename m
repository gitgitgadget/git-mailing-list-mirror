From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t0303: resurrect commit message as test documentation
Date: Tue, 13 Mar 2012 17:38:50 -0400
Message-ID: <20120313213850.GB27752@sigill.intra.peff.net>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
 <1331553907-19576-3-git-send-email-zbyszek@in.waw.pl>
 <20120312204340.GA10661@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 22:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ZQp-00022z-NV
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 22:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759747Ab2CMViy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 17:38:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48723
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844Ab2CMVix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 17:38:53 -0400
Received: (qmail 2484 invoked by uid 107); 13 Mar 2012 21:39:04 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 17:39:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 17:38:50 -0400
Content-Disposition: inline
In-Reply-To: <20120312204340.GA10661@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193072>

On Mon, Mar 12, 2012 at 03:43:40PM -0500, Jonathan Nieder wrote:

> > +# Test harness for external credential helpers
> > +#
> > +# This is a tool for authors of external helper tools to sanity-check
> > +# their helpers. If you have written the "git-credential-foo" helper,
> > +# you check it with:
> > +#
> > +# GIT_TEST_CREDENTIAL_HELPER=foo make t0303-credential-external.sh
> > +#
> > +# This assumes that your helper is capable of both storing and
> > +# retrieving credentials (some helpers may be read-only, and
> > +# they will fail these tests).
> > +#
> > +# If your helper supports time-based expiration with a
> > +# configurable timeout, you can test that feature with:
> > +#
> > +#  GIT_TEST_CREDENTIAL_HELPER_TIMEOUT="foo --timeout=1" \
> > +#      make t0303-credential-external.sh
> > +
> >  test_description='external credential helper tests'
> 
> Nice idea, but shouldn't this description be in test_description so I
> can view it by running "sh t0303-credential-external.sh --help"?

Yes, that makes sense. I didn't even know that "--help" printed out the
test description; most of our descriptions are not very useful, so I
never bothered. But this is the perfect thing to put in there.

-Peff
