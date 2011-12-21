From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-commit: add option --date-now
Date: Wed, 21 Dec 2011 15:25:01 -0500
Message-ID: <20111221202501.GA14895@sigill.intra.peff.net>
References: <4EF1F3AB.5080607@elegosoft.com>
 <20111221153837.GC2160@beez.lab.cmartin.tk>
 <vpqmxalrixy.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Dec 21 21:25:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdSit-0006LR-1G
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 21:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab1LUUZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 15:25:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50874
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab1LUUZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 15:25:05 -0500
Received: (qmail 21532 invoked by uid 107); 21 Dec 2011 20:31:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Dec 2011 15:31:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Dec 2011 15:25:01 -0500
Content-Disposition: inline
In-Reply-To: <vpqmxalrixy.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187586>

On Wed, Dec 21, 2011 at 05:24:57PM +0100, Matthieu Moy wrote:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > I was surpised when I tried 'git commit --amend --date=3Dnow' that =
git
> > didn't understand 'now' as a date, which seems like a more obvious
> > place to fix it.
>=20
> +1
>=20
> I really don't think Git wants yet-another-option for each use-case w=
e
> find, and accepting "now" as a date (either by hardcoding "now" as an
> accepted value, or by running approxidate on the argument of --date).

I'm curious of the use case where one wants "--date=3Dnow" but not
"--reset-author". Or is it simply that "--reset-author" is a less
obvious thing to try?

At any rate, if we are going to do that, I agree it should be spelled
"--date=3Dnow", and not "--date-now".

-Peff
