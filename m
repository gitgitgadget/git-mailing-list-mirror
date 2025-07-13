Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AF278772
	for <git@vger.kernel.org>; Sun, 13 Jul 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415757; cv=none; b=IK+kRId/WAZLTwWlOHV6l7tnvJdQB+OjcvRZQY2/XKRjzm+n4HNHZJ7F9+gfbJRojQXOhbp5U0/GL3NsEdrtDZRoyNdqS3Kl/0+NceCm966VFfOPtqqLN/2ESu5Y8hegfcwoqh9m1H+ViRMVvkKQzQ0HuTm2WpzDUrG3BH66++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415757; c=relaxed/simple;
	bh=UOCnoH5Z/eiugvonaBp3cteu96iOzXljCqskq9FV6D8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7C+SKOeBCTie2Ea5lDDtq9HYLXwKMqHd9pZqm/vPnyc1b0ilTqAE3ctVRzX0cmUzR8SBoeMtdVrZ+PaK1wwx+XiAi+iFkuTle5ns05+oT9o+0CYdM+B1G/gKp3jhjCN9/CYh6YRhQvbXWxIZgJA5nzZlYuPdxNE/xgGS9fiCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QCKotCQQ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QCKotCQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1752415752; x=1752674952;
	bh=UOCnoH5Z/eiugvonaBp3cteu96iOzXljCqskq9FV6D8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QCKotCQQjBwUt+eLwWo9RRKej3dJlB4v9E9yE8ysnCzTyHBftpgHdcRHcLysKGfvl
	 v1WWQHSR0n0Aha5HSuC/zqKRJpZb/5r/xc0/lJxtDgHLSMQ0bCUQuujllHOICEeQNv
	 bZd7A0LPej+yxs284YjvR7mP1VBns1PWORV5S4C3p27vBxZTfJDMGfCCoPrNk1tD9l
	 s/aGNNQwXXIOFOwNn3NC+avJRsrQvUyNsuz7wqOrAB9kmd4FuooCQEMq96HYJ3M71j
	 RnjyDucZEI5dNzQ8Jcdqm40ixiZTcE7xZnM31XgH7lP2v/4EmUu5T/JCbctWXUuXgR
	 RLNonpPPXK6Hw==
Date: Sun, 13 Jul 2025 14:08:56 +0000
To: Lidong Yan <yldhome2d2@gmail.com>
From: Jason Cho <jason11choca@proton.me>
Cc: Johannes Sixt <j6t@kdbg.org>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why doesn't git core.eol=lf work?
Message-ID: <wzZi9r7E7j1avCRjH89z3cdSJnwdoam1xRulfmRkybAYRIGxmZeZCYqRALW-b0B2lKnZ8xnuoAjwpWpMeDAx2oSW4qnlmS8iuUKit3And6Q=@proton.me>
In-Reply-To: <C41F422E-8C9D-4BC7-BA0B-57B7D13D6557@gmail.com>
References: <8jPyf4EU-z7W6OHX4j_kba2G-1c2RIDtgBcSkFjWSNhMuE6pxOOyxSGBnguoZvuDQSaJPypH0u1vLJf6FBX_ahUn3bBO_1DVscfOQm4Jovw=@proton.me> <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me> <23f2bbea-1294-4773-89d8-b270e2c3bb52@kdbg.org> <sAxC2ASixUyCVtsk22zrxI2vAeM546T7O2tyWIS2vv_TGFo2OXWegg8J_r0zGzo5bZOA-BrwHa5yjAv2-Ewusjv9Fa9YYocrRkaIfpxhv_c=@proton.me> <C41F422E-8C9D-4BC7-BA0B-57B7D13D6557@gmail.com>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: 32ed33753b2f7737750821547b288eaad5845ab0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> I believe that it's impossible to check out CRLF from the index as LF.
> You have to use your tool to do that.
>=20
> The definition of core.eol=3Dlf is here:
> https://git-scm.com/docs/gitattributes/2.9.5#:~:text=3DSet,-to string val=
ue "lf
>=20
> This means that when you use git add to stage files, Git will convert
> CRLF line endings to LF. However, when you check out files, Git will
> leave the line endings unchanged.
>=20

I see. Thank you so much. This detail was so subtle and it totally flew und=
er my radar.

