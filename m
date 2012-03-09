From: Jeff King <peff@peff.net>
Subject: Re: git push default behaviour?
Date: Thu, 8 Mar 2012 22:38:27 -0500
Message-ID: <20120309033826.GA6164@sigill.intra.peff.net>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <4F58C977.8000400@xiplink.com>
 <vpq62efjeqd.fsf@bauges.imag.fr>
 <CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
 <vpqfwdjas0m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 04:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5qf5-0001LU-8z
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 04:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab2CIDi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 22:38:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45127
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab2CIDi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 22:38:29 -0500
Received: (qmail 14217 invoked by uid 107); 9 Mar 2012 03:38:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Mar 2012 22:38:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Mar 2012 22:38:27 -0500
Content-Disposition: inline
In-Reply-To: <vpqfwdjas0m.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192673>

On Thu, Mar 08, 2012 at 07:04:25PM +0100, Matthieu Moy wrote:

> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > When you silently change
> > the default value of push, you silently break their workflow.
> 
> No one talked about changing it silently. Quoting myself:
> 
> | it needs to be done with a sane migration path, however
> 
> There is already a configuration variable, so it's easy to fix a default
> value change if you rely on it, but the first thing to do is to
> encourage people to explicitely set push.default, so that they are not
> affected by a potential future default change.

This is all sounding eerily familiar. Indeed:

  $ git log --oneline -Swarn_unconfigured_push -- builtin-push.c
  bba0fd2 push: do not give big warning when no preference is configured
  665d3e8 Display warning for default git push with no push.default config

I don't remember the mailing list conversations that surrounded those
patches, but if we are going to have the same conversation again, maybe
it is worth looking them up.

-Peff
