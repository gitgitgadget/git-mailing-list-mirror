From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 02/15] branch: report errors in tracking branch setup
Date: Wed, 17 Feb 2016 11:34:35 +0100
Message-ID: <20160217103435.GB743@pks-xps.fritz.box>
References: <1455627402-752-1-git-send-email-ps@pks.im>
 <1455627402-752-3-git-send-email-ps@pks.im>
 <xmqq1t8cmeyc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 11:34:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVzRX-0002i7-Le
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 11:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbcBQKel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 05:34:41 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33797 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161041AbcBQKei (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2016 05:34:38 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E034B20991
	for <git@vger.kernel.org>; Wed, 17 Feb 2016 05:34:37 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 17 Feb 2016 05:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=RFPJQQ5AILDD+GfLr+OUZ1m4RcM=; b=mtEM7
	zdjPx3svkDcxRvQ2JJpAzXroJUrjcI3joBjlQautE9qW9PlmO+WjuQ5UmXl+k8IX
	mxROEE402ebZ3+84TbbbQ7Rkn2ThdvnIJz/vTfMpTyAW2bcuTZw2mBh33ZAmYtUy
	AiRP8fPORXa6HyT+17i1miIDPPgdRxWF7SoeZo=
X-Sasl-enc: k+g9eavMeA36s/yenIni+oAGAGzSA6oYGize0Aem3dfn 1455705277
Received: from localhost (p5088a9c6.dip0.t-ipconnect.de [80.136.169.198])
	by mail.messagingengine.com (Postfix) with ESMTPA id 482E7C00014;
	Wed, 17 Feb 2016 05:34:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqq1t8cmeyc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286493>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 16, 2016 at 03:07:55PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >  	if (rebasing) {
> >  		strbuf_reset(&key);
> >  		strbuf_addf(&key, "branch.%s.rebase", local);
> > -		git_config_set(key.buf, "true");
> > +		if (git_config_set(key.buf, "true") < 0)
> > +		    goto out_err;
>=20
> The indentation here is suspect.

Thanks, will fix.

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxEy7AAoJEBF8Z7aeq/EsHAMP/3wOpXFES2CgpI2FDQgLwO2N
PG1zLIWsloPmpPJ5J14DdJcFUGvXQOqFzweZAYGm1fYOfjkxW47Fc6vl3HjSVs1H
0H3svDzFfakOqXEXmekTx1zC0LHJWc5i2BOm1UScyVliPFm2nT/zzBNaEJc1z28e
bFmiPEhPQs4th4aZqpD1t83/F+J5El1QeOm9iu91224l02xyQONunjN1r+sBAsAJ
tVMJ07VaUGQmlalrPBg/ZOMbLxd9HMVqpJmQ71ck9NgXOA/GZQfmMeJR/cHNXM4j
qFhaDQ5rr0Puoi1mN4W9FHLMtdpz7TsEhZnTqla/J9W1r71usJW3M5zDmrXGRVVx
dV/1elH3adsA0cVfVl/rh0k7HHJGNgpQ09uoM0vUmgyjHQ4DqP1f8d5kOAnYjrrf
j22DlojegD5hmJ62x0Opv9SjkrUpjtP+K75sfW+Fo2TcxSgj+7uOdoMLWUWbwJUE
lu5t+EIuu61tDTwtWQ6ca/rtXpAk/PrrZNSSHD/NsJT8OwALKglIVKWRwWZElgdA
wW+2/8KjnT950F5ixodhxOUYi0EYbdbEU8k9xpJKltxsgA2LZKkkFQoBO4iBHekI
0aiE2J9Oh4C6w4yb2v7EwT1BR0GfeR165Z3o1tTmtlQimsYg6ssFvtpqMX7eZy4h
ObC6rIH0dKlUL/70yuY2
=XFuc
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
