From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 1/2] Add a remote helper to interact with mediawiki,
 pull & clone handled
Date: Fri, 10 Jun 2011 03:22:46 -0400
Message-ID: <20110610072245.GA3385@sigill.intra.peff.net>
References: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
 <20110610002137.GA11585@sigill.intra.peff.net>
 <BANLkTimruGZsh0aq7gOKmLUiJFwz3beU3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	git@vger.kernel.org, Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 10 09:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUw3T-0005sG-St
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 09:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab1FJHWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 03:22:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52208
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab1FJHWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 03:22:50 -0400
Received: (qmail 24209 invoked by uid 107); 10 Jun 2011 07:22:57 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Jun 2011 03:22:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jun 2011 03:22:46 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimruGZsh0aq7gOKmLUiJFwz3beU3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175597>

On Fri, Jun 10, 2011 at 08:31:41AM +0200, Arnaud Lacurie wrote:

> > =C2=A0git clone \
> > =C2=A0 =C2=A0-c mediawiki.page=3DGitWorkflows \
> > =C2=A0 =C2=A0-c mediawiki.page=3DTig \
> > =C2=A0 =C2=A0https://git.wiki.kernel.org
> >
>=20
> So we give up on the mediawiki prefix (mediawiki::https://git.wiki.ke=
rnel.org)
> when it comes to partial cloning ?

Oops, no, I just forgot it. You need the mediawiki prefix so git knows
to invoke the mediawiki helper.

Sorry for the confusion.

-Peff
