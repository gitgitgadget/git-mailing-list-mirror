Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672321D3FB
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922570; cv=none; b=Xsy/kyg3mcNO/tiEELmO/1g7DykVHQcU6350+zRy0IlcG3PWq29MKK4wzD0oBCfJtDH5SrJLqfq1l8cWAuCmoY04j6bBF6wJhsj1kpQfd9La29BUYj7pvBIdvUYnATQbE9/rdre5Jdpf3doHbYyl7aeYPm6yLrw5RI5dDcS16hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922570; c=relaxed/simple;
	bh=NlRpXDnR6n76VWyOZOp5O6vDschU36iqHmd1q2wEtuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua96c+pctqe3zDRmCoo0dASBGxjRMBnsLAZ3ujbRNKRkNqrCU5HzEDXdk5trsEYVJIcRzb5GDmGBnVmJd+Dl2KAwjaDHEgLdzCGZpScIROAuRoDXo/9/wBNB4jcIHwqCeHKoHpw7wigpk5pA/EeLJoa/lot/5LeNTqWLJJP6TbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=C3qaXeBe; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="C3qaXeBe"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 6FB7A4D42E
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 23:02:08 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:3b20:483d:eac5:8dac])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5530D13F89C;
	Mon,  7 Jul 2025 23:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1751922121;
	bh=NlRpXDnR6n76VWyOZOp5O6vDschU36iqHmd1q2wEtuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3qaXeBeebzOrUyMfettorC75mKM1jCeKc6T3EeFoHPOri3BY5pU84+WdjJrYEwdN
	 6mI3ijs2naOE+RMZnGfyNowpbDefzscZx5lkHdnlKEIBZ56w83PeCF2rfPf+KG7fWz
	 uPOUo9EXK7Iu3ZYMVZskXmcJPmuuJLU43NwHSx+A1+Db9gWBfsvMWhO5sVhwG2cgKv
	 DHakPCaUDUrbNpaoIYnQ5ipu1u2hYDiB9XMo6d8IhyIjl/fiBE+OveMqYuDSuV7zzs
	 0kfXnXlHNPJXYw/iEQi5bXnsSy9Fyez/K2efIpi/hdcZXhy6lrZsaj/jJRsc9r+T3P
	 XxBLAKLquyl6A==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject:
 Re: [PATCH v3 0/9] doc: convert git log man page to new synopsis format
Date: Mon, 07 Jul 2025 23:01:58 +0200
Message-ID: <2788919.mvXUDI8C0e@cayenne>
In-Reply-To: <xmqqzfdf3efc.fsf@gitster.g>
References:
 <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
 <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
 <xmqqzfdf3efc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 7 July 2025 22:59:35 CEST Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > This series converts the man page of git log to the synopsis format sty=
le.
> > Git log is the second largest manpage after git config, which makes the
> > changes quite large.
> >=20
> > A special note about the log format description which required escaping=
=20
the
> > synopsis processing of parentheses.
> >=20
> > Changes since V1:
> >  * rework the grammar style when refering to plural placeholders . The=
=20
text
> > =20
> >    is more descriptive and does not rely on puns. Puns may be difficult=
 to
> >    understand and to translate.
> > =20
> >  * change commit message to reflect the conversion of inline descriptio=
n of
> > =20
> >    several option to a list.
>=20
> Changes since v2 is a minor but necessary mark-up fix, as we do not
> want to leave `enclosing` mark-up elements unclosed.
>=20
> Will queue.  Shall we mark the topic for 'next' now?
>=20
> Thanks.

I think so. Reworking the formatter logic will be proposed in another patch=
=20
series.





