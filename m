From: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Thu, 1 Sep 2011 09:34:50 +0200
Organization: Gentoo
Message-ID: <20110901093450.57512480@pomiocik.lan>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
	<1314781909-19252-1-git-send-email-mgorny@gentoo.org>
	<7vy5y9xkd0.fsf@alter.siamese.dyndns.org>
	<20110831232201.GA29296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/ioREA9uSpRy0Cyx7zawFlfK"; protocol="application/pgp-signature"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 09:33:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz1lx-0004Gb-8e
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 09:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab1IAHdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 03:33:08 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:54573 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab1IAHdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 03:33:06 -0400
Received: from pomiocik.lan (unknown [81.219.205.214])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 460831B402A;
	Thu,  1 Sep 2011 07:33:04 +0000 (UTC)
In-Reply-To: <20110831232201.GA29296@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180524>

--Sig_/ioREA9uSpRy0Cyx7zawFlfK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Aug 2011 19:22:01 -0400
Jeff King <peff@peff.net> wrote:

> On Wed, Aug 31, 2011 at 03:54:35PM -0700, Junio C Hamano wrote:
>=20
> > > +The complete message in a commit and tag object is `contents`.
> > > +Its first line is `contents:subject`, the remaining lines
> > > +are `contents:body` and the optional GPG signature
> > > +is `contents:signature`.
> >=20
> > To match the parsing of commit objects, I would prefer to see
> > "subject" to mean "the first paragraph" (usually the first line
> > alone but that is purely from convention), but that probably is a
> > separate topic.
>=20
> Good idea. I suspect pretty.c:format_subject can be reused here.

Should I fix regular 'subject' and 'body' as well, or just
the 'contents:' variants?

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--Sig_/ioREA9uSpRy0Cyx7zawFlfK
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQEIAAYFAk5fNZsACgkQfXuS5UK5QB1z5QP/U85OFqiaK2hgvK5wgr8IBfMT
IPVXb0L/wXfMSXkUeaTgOOJbPOzLTmk8b1GwJ7fuxX2sSdZ8cTB309e4r55GsdGg
754YMmwafqGpQqs5RrP9dYho0PGEOyArAdkjno5GRZ1bpdWxDSoAhEzjcr0BrXiw
Pp7nZkqqAXWz9iGmoP0=
=1qEy
-----END PGP SIGNATURE-----

--Sig_/ioREA9uSpRy0Cyx7zawFlfK--
