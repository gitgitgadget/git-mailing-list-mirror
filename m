Received: from mail.helgefjell.de (mail.helgefjell.de [142.132.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEA12EBE7
	for <git@vger.kernel.org>; Wed,  8 May 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.201.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186120; cv=none; b=VeQjslxaw1gEIFt32ya1BujN5evBu1RrCQ0jRMk8hwBDj64ae2LaLMgmxlxAFeoJmvCLFW3qKCBQxa5W3ThB9BY1ni9jr6NmnSFpXH53lhWV6EP60KAlQWL0RvYsOnyVn11OBBAI6MGKoSC1HYaivpEAm6OR7JFeLgqsxMM6nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186120; c=relaxed/simple;
	bh=l6V7gSJV03mExTiBLa8zBmNZYlPOp5lVOKT27XJdcWM=;
	h=Date:From:To:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=iKAMg7yDlIsguINpsBNLP7g5j37BTOpAVq/IYVYmkQc1aUqxS43nOJ0M+e64apCToYJKFPj1c9hdA2n/7MnzXuxr8LP3KAkTbdZ8IeCQquOoc7xKb1RVFCpROKolx27JudlDXfOS8qHFjwW/g32arMVkWi0uFXaaz/pRpD7Tigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de; spf=pass smtp.mailfrom=helgefjell.de; arc=none smtp.client-ip=142.132.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helgefjell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helgefjell.de
Received: from localhost (localhost [127.0.0.1])
  (uid 1002)
  by mail.helgefjell.de with local
  id 00000000000200DB.00000000663BA891.0000E1AA; Wed, 08 May 2024 16:30:09 +0000
Date: Wed, 8 May 2024 16:30:09 +0000
From: Helge Kreutzmann <debian@helgefjell.de>
To: git@vger.kernel.org
Subject: i18n of git man pages
Message-ID: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
Mail-Followup-To: Helge Kreutzmann <debian@helgefjell.de>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_meinfjell-57770-1715185809-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_meinfjell-57770-1715185809-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
I'm maintainer of manpages-l10n[1], a collection of translations of man
pages for over 100 projects into many languages.=20

Our policy is to move translations into the upstream project where
possible. Only where projects are not interested in maintaining the
translations for their man pages themselves we host them[2].

Recently one of our translators approached me to translate the man
pages for git. Before adding them, I want to check with you if you are
interested in adding translations of the man pages directly in the git
project.=20

(Technically, po4a has been proven to be a good tool to maintain
man page translations).

Thanks for considering i18n your man page part.

Greetings

         Helge


[1]
https://manpages-l10n-team.pages.debian.net/manpages-l10n/index.html

[2] We collected many translated man pages from the web in the past
    and transferring them upstream is a (very) slow process.
--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_meinfjell-57770-1715185809-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmY7qI4ACgkQQbqlJmgq
5nB6BxAAntwzjCgIHGapGp15wmhnMQcPkB6/IODmR0OvjDiWW2GeBPZwJobv1+km
YjG0rkIRnGAvigCYBHk48t7FHKzsMaLlu7QQf3zCOvevJFYgfpPd7wZ6pm2mvjJa
OTXftfRO/19VXA9MlaZ8Fvg1GAk/rAz90JH2kWJ3BvbjUjI5XU/kyEHNHmpuNvfc
zcclIvaWi/n+urAlPopr/nyR2WVfYJn5K5dmW0GxiOHkSBunI65hsKnfX0qoFUf7
Z7ZR0XvFH2cu4GyE+54W6w7HvAZQjKdn4eqX0H4dljEFZ6YSRo/CvnvKreGPR99G
wr2ru/RwncezMGjY1TVZcu4mzQFIfWmC4B4uLMgf/IqEby3K8oPTq4Kto5D63vh6
Ons13VHJ5VujJp0qLy/BHCNzsu1imC8eDwye1Ru1vIFZ55h72c9rHUUkvHYMl68d
GXD+edmjSHjvusyc2sO9wnP5Ha3ZlP4Ncwl004MErhafyYmiv47YNisEvrQLF49H
0NT8tP/qNFZceo3sYd6jZACsCf7Ln6yyUDuEf+rn/0Dyc6/eOpQlpuvwh3eG26Y3
/K05KTR5y3/ngtADe1A0A2+Yoqy9Ij8tf56YwXdi6EJYzNf/iwrg0PQ5y5xRsQ8s
OSWXznA8//o0YZp3akWYKZ8sQ5+t73XuoIPcWziX0TaEo0cCQE4=
=3b8F
-----END PGP SIGNATURE-----

--=_meinfjell-57770-1715185809-0001-2--
