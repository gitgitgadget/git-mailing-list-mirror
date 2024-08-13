Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB438FB9
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581769; cv=none; b=L646NKU+KWr6twEHDZvI4h19mblUfMf2Pgnc5BZX8c9mHyXozljuPoD95tsKsAaMFqtIrruG4e16V8gygD3q1vHCQwJooYvr9nwUO9Oohx5J3s5aLzpBPTqLFBDxEPw6g/rnV3HiVy4bt0UMMH130eepVhjSl68TNX4WPFVSgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581769; c=relaxed/simple;
	bh=cuFLRClvY/t+LpMVdIc519VZb53P1+94NlaLNvrlH4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0ZAKqQlxR8W8gmVxGq1vKaFo96YWhNDny/VWSWSKz3jo7Pu126Hol8g48VLjegcXYN8lFbDK8NDyEalBuI1pjTj/FyK0fVOaEDhnyHwpcjYxnFOcyFCOw9y45wbOASpOUutPnhUwRKjzRr/evFTQPKfmGbvsCR0kqGLz5L2+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=T6RGXVJv; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="T6RGXVJv"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 636B2DF9EF2
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 22:42:37 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:d713:b0b1:9800:110a])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id A072A19F57E;
	Tue, 13 Aug 2024 22:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1723581749;
	bh=cuFLRClvY/t+LpMVdIc519VZb53P1+94NlaLNvrlH4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6RGXVJvzEs2/LuRYauV/EnykmZ86x+f+Tdcg6ddFfZLDm6sszU+OBpirJHInaTgk
	 soKqALMDgYGNK6wqal8hCMErSvpjrDVRz/OheojreRmutCIOC2h+q0gE2Uw05X+kau
	 7y16HrUFgH5/ElVMn3vCOFTmNKjSrNMxlz81TcFhaOCQ2qpmm30BH164KW5evFkwle
	 SwZLTGF48UQ1eYfhr8Qv5asRUx6VN+aiCtap546eP5v/8MrQfYaf0qOnQbhxGzd2hW
	 lmbaI5zbLcog/RQJ2ukst7XjQTCUBmWnZ1ETW0PSc4m57HPeTuN0ePFhI7D/1CHabV
	 6fxFBlAJj6L1g==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Johannes Sixt <j6t@kdbg.org>
Cc:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] formatting macro
Date: Tue, 13 Aug 2024 22:42:26 +0200
Message-ID: <3596897.iIbC2pHGDl@cayenne>
In-Reply-To: <f44c253d-9b37-451d-902d-486adb8e3d72@kdbg.org>
References:
 <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <4617471.LvFx2qVVIh@cayenne> <f44c253d-9b37-451d-902d-486adb8e3d72@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 12 August 2024 08:35:39 CEST Johannes Sixt wrote:
> Am 07.08.24 um 22:43 schrieb Jean-No=EBl AVILA:
>=20
> I would like tone down my harsh opposition to mild opposition. IMO, it
> should still be easy to *write* the documentation. It should not be
> necessary that authors remember to use macros all over the place.

The purpose of this series is to clarify the formatting rules for keywords =
and=20
placeholders, and to uniformly apply them, so that the readers can relate t=
he=20
meaning of what they are reading with the visual cues in the text.  The mor=
e=20
uniform the typesetting, the less surprised the reader, the smaller the=20
communication impedance.

This requirement makes the documentation *less* easy to write, for sure.
It is no question of forcing authors to use the formatting macro everywhere=
=2E=20
As explained in the Guildelines V3 of the series, the macro is introduced i=
n=20
order to remove the most hairy forms where manually doing the formatting wo=
uld=20
lead to difficult to read/write sequences. I bet most writers will remember=
 and=20
use the s macro when they want to typeset something like=20
=2D-ignore-submodules[=3D<when>]

As an added benefit, we can also simplify some existing parts, for instance=
 see=20
the ones in urls.txt.

>=20
> And I still think that we should not introduce macros just to please all
> renderers. Let's just pick the one renderer that can do the job best. If
> it means that some distribution cannot render the documentation
> perfectly themselves (Debian? I don't know), they can always use the
> pre-rendered version that Junio kindly produces.

I do not understand how the renderer could solve the issue of typesetting t=
he=20
"good part" in the place of the writers. The macro is there to mechanize th=
e=20
typesetting of selected parts, but it is up to the writers to define what i=
s a=20
keyword and what is a placeholder in their prose. Please note also that usi=
ng=20
proper placeholder differentiating and typesetting should have the side-eff=
ect=20
of making the prose lighter, by removing the need to express which placehol=
der=20
we are talking about.

To me, Asciidoc strikes a good balance for a tool that makes it easy to wri=
te=20
simple things and not too complicated to write more complex ones. It is als=
o=20
customizable for specific needs, which is handy for our use case.  I am not=
=20
aware of an existing renderer that would do the job really best. What do yo=
u=20
have in mind?

JN






