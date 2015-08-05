From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Wed, 5 Aug 2015 08:08:52 +0200
Message-ID: <20150805060852.GA1103@pks-pc.localdomain>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
 <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
 <20150804043401.4494.43725@typhoon>
 <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
 <20150804224246.GA29051@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 08:09:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMrsr-00018I-Q3
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 08:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbbHEGI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 02:08:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54842 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750727AbbHEGI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 02:08:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id CA37E20836
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 02:08:53 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 05 Aug 2015 02:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=h9MAMYAKsfhzHj1IlztrdyPeRMo=; b=i9jLM
	QyLjWKKOBFpisTMJoBlI45iYGbIJhhDWWbe139PZScwwzI70+7ZG2lq/FlJTGrN0
	VxO7cAUFOrZzwnzvLXhioHia4VdQYPQWtCXSs4py3zEAR76Dmvpl+MWG+RHz4sCD
	uxfDTuynZwmgSQ3VQNHMoC42ol2VS7TuYImEcE=
X-Sasl-enc: dt4KsB8uIW0SHNC9lUJb9ybQR8UnmFEmFlEQWaX51k3U 1438754933
Received: from localhost (x5ce10e86.dyn.telefonica.de [92.225.14.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5FFF76801C4;
	Wed,  5 Aug 2015 02:08:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20150804224246.GA29051@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275351>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2015 at 06:42:46PM -0400, Jeff King wrote:
> On Tue, Aug 04, 2015 at 09:31:18AM +0200, Sebastian Schuberth wrote:
[snip]
> Sadly we cannot just `strip_suffix_mem(repo, &len, "/.git"))` in the
> earlier code, as we have to account for multiple directory separators. I
> believe the above code does the right thing, though. I haven't looked at
> how badly it interacts with the other guess_dir_name work from Patrick
> Steinhardt that has been going on, though.
>=20
> -Peff

It shouldn't be hard rebasing my work onto this. If it's being
applied I'll come up with a new version.

Patrick

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVwahzAAoJEBF8Z7aeq/EsfVgP/jQZwnJYKEgrDPCqGEzc9rVb
sAat8hF5/POR68EtgXDmYqImASrIj2dMhix3q+HTd2sK8O249ELAQnlGXEoJPqUh
fT1Qb69iqPjSoYn91GhGOn57agjzdogIPVlqqhM3Xfn2431v0N2i2ts+cdW854hd
xJTQs6HtwaZVaqCezHpWf4765eLCzDFZMk2l1KQOxgbH4B+NyWf5CoqgpQVj4pV8
/5NBiuLChnX3KBl2EnIyTnI0Ew3rinDa0f7hak6mmsICsHA1mcYhtcMatcw+T2Z1
gN5wE2fuR9YsrsuUcveSaoynIjLMIUwGD+I6ilSpErErfu3x9C6MZjfCpCA8fIfz
xfIiS4Ie7kzgANV9Sa9apBDzbOCd2MllqQvfsgd704i4rtIpJqvtGZTRMxk8s65g
P934tiRyGQUe2V1/1jzyvg6tIlLwsZBiLA0kaqR9refI8iMTVnYNnilv1hGmkElF
p3cVxgURdrHvpt2iQ6pK364BM7yxeOKkGktCZa23cKQSDnrhzMkixfgasgFQoCXl
tFkYUn1BWMt6Rz8Uv+ucpzp9LJBtsVlT+//D8RWKY/V3gptuUM9XtCBIapH0Df58
MF3lxBN9P1K5i5KRQcSGZlZNDuoM4cyXIm4WS8Adn6IfDHkw8V485+jA8Uf9oxVK
tb9ok7iPbB9vD/NO7gr5
=Qqej
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
