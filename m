From: Jeff King <peff@peff.net>
Subject: Re: More formatting with 'git tag -l'
Date: Mon, 29 Aug 2011 17:37:57 -0400
Message-ID: <20110829213757.GB14299@sigill.intra.peff.net>
References: <20110829211018.2ce4ebab@pomiocik.lan>
 <20110829193658.GG756@sigill.intra.peff.net>
 <20110829232011.565ea553@pomiocik.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 23:38:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9Wv-0001Wl-Fx
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab1H2ViA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 17:38:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56652
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab1H2Vh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:37:59 -0400
Received: (qmail 21219 invoked by uid 107); 29 Aug 2011 21:38:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 17:38:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 17:37:57 -0400
Content-Disposition: inline
In-Reply-To: <20110829232011.565ea553@pomiocik.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180362>

On Mon, Aug 29, 2011 at 11:20:11PM +0200, Micha=C5=82 G=C3=B3rny wrote:

> > You can do something similar with 'git for-each-ref', which is
> > probably what you should be using if you are scripting, anyway (as =
it
> > is "plumbing" and guaranteed not to change in future releases).
> > Something like:
>=20
> Thanks, that looks great. The only thing I am missing right now is
> a simple %(body) variant which would strip the GPG signature. I'd
> really like to avoid establishing a shell oneliner to do that.

Yeah, I don't think that's possible with the current code. I don't thin=
k
it would be unreasonable to add "%(tagcontents)" and "%(tagsignature)"
or something similar, though.

Want to try a patch?

-Peff
