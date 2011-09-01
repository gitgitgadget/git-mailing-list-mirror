From: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Thu, 1 Sep 2011 18:48:15 +0200
Organization: Gentoo
Message-ID: <20110901184815.2cd8b472@pomiocik.lan>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
	<1314781909-19252-1-git-send-email-mgorny@gentoo.org>
	<7vy5y9xkd0.fsf@alter.siamese.dyndns.org>
	<20110831232201.GA29296@sigill.intra.peff.net>
	<20110901093450.57512480@pomiocik.lan>
	<7vbov4xnfc.fsf@alter.siamese.dyndns.org>
	<20110901162222.GC15018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/BMk2aLoY2rLK_l640WTyqwe"; protocol="application/pgp-signature"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 18:46:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAPY-0001Lf-NZ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab1IAQqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:46:35 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55849 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab1IAQqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:46:34 -0400
Received: from pomiocik.lan (unknown [81.219.205.214])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6F3CD66A46;
	Thu,  1 Sep 2011 16:46:32 +0000 (UTC)
In-Reply-To: <20110901162222.GC15018@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180541>

--Sig_/BMk2aLoY2rLK_l640WTyqwe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Sep 2011 12:22:22 -0400
Jeff King <peff@peff.net> wrote:

> On Thu, Sep 01, 2011 at 09:00:39AM -0700, Junio C Hamano wrote:
>=20
> > >> > To match the parsing of commit objects, I would prefer to see
> > >> > "subject" to mean "the first paragraph" (usually the first line
> > >> > alone but that is purely from convention), but that probably
> > >> > is a separate topic.
> > >>=20
> > >> Good idea. I suspect pretty.c:format_subject can be reused here.
> > >
> > > Should I fix regular 'subject' and 'body' as well, or just
> > > the 'contents:' variants?
> >=20
> > I thought you made them synonyms...
>=20
> No, %(body) retains its historical usage as body+signature. If you
> think it's OK to change that.
>=20
> We could either leave %(subject) with its historical behavior, or fix
> it to handle multi-line subjects. Although it's technically a
> regression to change it, I tend to think it is simply a bug, as it
> doesn't match what the rest of git (like "git log --format=3D%s") does.

Ok, I'll go with fixing it. If we want to have old behavior back, it's
as simple as putting the line copying function in the right place.

Sadly, I had to add a few magical '-1's and '+1's to get whitespace
in-place. It seems that signed, unannotated signatures glue to subject.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--Sig_/BMk2aLoY2rLK_l640WTyqwe
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQEIAAYFAk5ft08ACgkQfXuS5UK5QB3PEQP/ROXCxhGlRq+wj1vcjPjpFg59
RcyZum3REabc+yVPVQgZWWuBqrrxDU24aFM7CmQEXAi2U8/NXIaozFBuBcGT53x0
kf0mvMY+1sTW2OTX5qf6p+q6RgK3bLUnhK9yu0gMu5u9GfTScvEw19um0RaVtUF7
7RmZMQyn9slkkFllxqk=
=4tsb
-----END PGP SIGNATURE-----

--Sig_/BMk2aLoY2rLK_l640WTyqwe--
