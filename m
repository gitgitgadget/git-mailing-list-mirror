Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFE1E5735
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966058; cv=none; b=IIsyKo8xDf0Uy0U60wSBzn1/hVK/NZ4xM87Kb+a3RLLQkG2LCyGn0LpNVtlLwOcVo5ZcRQ5H+Zk0KnlQpG6o1lYNoxkbapllZlTpAlq8l+sV8u2rwks5yBNDJm+C5HbS3ZJXADcK8ju1wvtp/5A8zC/k0lFQeof4ctXxhjBz4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966058; c=relaxed/simple;
	bh=TYh3EtHdaFGbrjaa7OTZwYGf2CwRu+HQ637xz1iLOtU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ8kYjSI/eVtd1T/amAtsbvMwq4ou63fQvm9oj/suTO9iDaIaM8OpIudhf4eg3zYj3QLLnJzo8hp5rJixjmmG52mlmwzPTa4jMBdGitM4CY0EalR4UOQf7C703DU7s1UuzG2yDvySLnM1ZVzLbzo/vgSMrkk+rsoUbn7zShwjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Q+GuKmJh; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Q+GuKmJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731966054; x=1732225254;
	bh=TYh3EtHdaFGbrjaa7OTZwYGf2CwRu+HQ637xz1iLOtU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Q+GuKmJh8zkbOaJz+CLXbSFNclGIz4s28VIvoyjQec/Qxuc7XEUr9IIZiW1NPPUnW
	 ZsIutBAAbuj8a9SFVRKkU6pCZJsiYgPEtbeuMw8lJ2F5sHY3Z+4kvRhTHaIxCqeKbz
	 Wjx1lzfRr0EJhynVnrYd/7WC+cdDBrcbV/4fjbUHqWJTeYDmV8MYVjaR7aJTqj+UbU
	 21qr0dCRoeTbogdgGTjoCPtZeVl9Sj+hsyIvEThRrhAdqxkYFeExkxbhanfhV7QqLp
	 31D/k/Tij5++v+8D2xAk+QzkusxruGsERAybuWoUilWVxU/MjxpB9et4sl32yPpvAG
	 W67SAeed+VchQ==
Date: Mon, 18 Nov 2024 21:40:51 +0000
To: Yongmin <yewon@revi.email>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: How do you hyperlink a thread
Message-ID: <iT3xHcHCZEHBfwKqIhzG1M2P2NawmBzhUtu_JS0PAE-yvlAXG5wLQquajeHJ6m2icOHeHdZybX3ppdp-P6oFgrtiA4T0tzONpvC6AJUiEso=@proton.me>
In-Reply-To: <055a53b5-2107-4547-8a64-e269705de80a@app.fastmail.com>
References: <Sj2qFJa5yPRxluqhZvXlMwgfLuX9n6Um4OOS9IHNXCJU3jjE0YblQDUt0rOpEzY-fUHs5CiognunZO-ddQN-1IVVBEyxLz_2hl936VBW-JU=@proton.me> <lLSbsbSEi1ltdY3N1MKhGPVHTPeII5XsqVcYwmh_WHIjVAlNyktnNEaLgBUkh6stvHLE371tlmlhOTdoFloVic-Wq0wE0pQYLBeeVuvA_oA=@proton.me> <055a53b5-2107-4547-8a64-e269705de80a@app.fastmail.com>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 2078228b9d088bab1b40d0abb004e9398b9e8046
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_2nvSwmGKUILKUwZg2EKjbB9MkNqQgK82uTQJpfWs"

--b1=_2nvSwmGKUILKUwZg2EKjbB9MkNqQgK82uTQJpfWs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512





from A_bughunter@proton.me

Sent with Proton Mail secure email.

On Monday, November 18th, 2024 at 20:04, Yongmin <yewon@revi.email> wrote:

> On 2024-11-19 (Tue) 04:51:49+09:00, A bughunter A_bughunter@proton.me wro=
te:
>=20
> > Hello, why isn't anybody answering me? I see an active list.
>=20
>=20
> Because, when you display aggressive attitude[1][2] for those who try to =
help you on their (mostly) free time, you do not want to involve yourself w=
ith them.
>=20
> Anyway, check out https://lore.kernel.org/git/ . (You see an example belo=
w.)
>=20
> [1]: https://lore.kernel.org/all/82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwC=
EC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=3D@prot=
on.me/
> [2]: https://lore.kernel.org/all/xDO5bMcFOIbJ5FhdpoxteVDBBjf5xXcVxQ5HboXd=
p-l_JojbIZ5gKERafNA0DdIFubVEupPQ3NqyoovEgsFJannL8A-9WqpzJIq-5sC0chI=3D@prot=
on.me/
>=20
> --
> ----
> revi | =EB=A0=88=EB=B9=84 (IPA: l=C9=9Bbi)
> - https://revi.xyz
> - he/him https://revi.xyz/pronoun-is/
>=20
> - What time is it in my timezone? https://issuetracker.revi.xyz/u/time
>=20
> - OpenPGP https://revi.xyz/pgp/
>=20
> - In this Korean name https://en.wikipedia.org/wiki/Korean_name, the fami=
ly name is Hong https://en.wikipedia.org/wiki/Hong_(Korean_surname),
>=20
> which makes my name HONG Yongmin.
> - I reply when my time permits. Don't feel pressured to reply ASAP;
> take your time and respond at your schedule.

Angyh yeoung hasaeo Yongmin! My reply is interspersed. Did you catch any ep=
isodes of Black Mirror TV series?

On Monday, November 18th, 2024 at 20:04, Yongmin <yewon@revi.email> wrote:

> On 2024-11-19 (Tue) 04:51:49+09:00, A bughunter A_bughunter@proton.me wro=
te:
>=20
> > Hello, why isn't anybody answering me? I see an active list.
=20
No, there is nothing too agressive there. You are making a drama and distra=
cting from productivity.
> Because, when you display aggressive attitude[1][2] for those who try to =
help you on their (mostly) free time, you do not want to involve yourself w=
ith them.
>=20
> Anyway, check out https://lore.kernel.org/git/ . (You see an example belo=
w.)
>=20
> [1]: https://lore.kernel.org/all/82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwC=
EC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=3D@prot=
on.me/
> [2]: https://lore.kernel.org/all/xDO5bMcFOIbJ5FhdpoxteVDBBjf5xXcVxQ5HboXd=
p-l_JojbIZ5gKERafNA0DdIFubVEupPQ3NqyoovEgsFJannL8A-9WqpzJIq-5sC0chI=3D@prot=
on.me/
Oh so you simply do a manual footnote.

> --
> ----
> revi | =EB=A0=88=EB=B9=84 (IPA: l=C9=9Bbi)
> - https://revi.xyz
> - he/him https://revi.xyz/pronoun-is/
>=20
> - What time is it in my timezone? https://issuetracker.revi.xyz/u/time
>=20
> - OpenPGP https://revi.xyz/pgp/
>=20
> - In this Korean name https://en.wikipedia.org/wiki/Korean_name, the fami=
ly name is Hong https://en.wikipedia.org/wiki/Hong_(Korean_surname),
>=20
> which makes my name HONG Yongmin.
> - I reply when my time permits. Don't feel pressured to reply ASAP;
> take your time and respond at your schedule.

...do a manual footnote. I was seeking something that would link the thread=
 aggregated and maybe a simpler link without all of that mess. Something li=
ke: lore.kernel.org/git/thread/[bug]%20report or maybe like a link to an At=
om feed by thread.=20
 This is the bugreport[1] though if I link it I will have to keep getting a=
 new link to display latter replies. This is the question[2] and use-case[3=
]. These are all related but separate threads for the purposes as labled.=
=20

[1]: https://lore.kernel.org/git/20241115093214.GA1749331@coredump.intra.pe=
ff.net/T/#t
[2]: https://lore.kernel.org/all/xDO5bMcFOIbJ5FhdpoxteVDBBjf5xXcVxQ5HboXdp-=
l_JojbIZ5gKERafNA0DdIFubVEupPQ3NqyoovEgsFJannL8A-9WqpzJIq-5sC0chI=3D@proton=
.me/#r
[3]: https://lore.kernel.org/all/4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlS=
I5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=3D@proton=
.me/#r
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc7tF8JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAANJ/APwK16kmwlIg/VPARKUudBpiU7wIcjs4B+Sb3sqKcDi+zQEAg5g2
mhZQ4xiJY8ThKilNoE61mh/EvZGDvMaPs7WkhQA=3D
=3DBQH2
-----END PGP SIGNATURE-----

--b1=_2nvSwmGKUILKUwZg2EKjbB9MkNqQgK82uTQJpfWs
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_2nvSwmGKUILKUwZg2EKjbB9MkNqQgK82uTQJpfWs
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc7tF8JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAIlyAQDuvSJW
2+spidlufY8R0qFwYrNXg1KwusNYDpbpvIjXjgD/RtZlTIz455/pz6ofB2sy+G678iF5tmogMSJk
Nky37QM=

--b1=_2nvSwmGKUILKUwZg2EKjbB9MkNqQgK82uTQJpfWs--

