Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C1C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A04F2339D
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbhAOPpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 10:45:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:46895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbhAOPpv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 10:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610725457;
        bh=cn0NyaYNAbkbEFtZuQ/P2PQ+BqHM2EgzEXvYpww58Sk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KEGoD47ITjfqvKhKjFj2EnW18+y7xFbWJXEkCdzF1dVtxKpXkBgPrPohxZ/HQH0sJ
         jV9PbjMmpxiurRfNoUOxbTxYtf/oRp0U7FyzvBSG5RaSEmPlhtezBUEiDqtXdoAtYm
         kKFv3e9RUCh3lmUv2Ztw1tKk7S61ZjPZAm1iuwW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1lby9K28pX-00cQ0G; Fri, 15
 Jan 2021 16:44:17 +0100
Date:   Fri, 15 Jan 2021 16:44:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/11] GETTEXT_POISON=rot13: do compare the output in
 `test_i18ncmp`
In-Reply-To: <xmqqeeiq3pkf.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101151643410.52@tvgsbejvaqbjf.bet>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com> <4669ccbb1ae40f0c58a2d8e3c8b3a34d82176c7a.1610441263.git.gitgitgadget@gmail.com> <xmqqeeiq3pkf.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P0RtTUTaMMfZSlSKQjblXkCYiWGzlw2IdpzNDgIuNl7GgdNPONF
 fiO488bPzDntEFl+8a+IQ7190/VcV4gmup4xgW/tBDofex1dduuB9F3rxUMz9IUZ0LslLvB
 eUUwWN+UHGTNssAj+is5C/E/JeI7xHLH78gq5QG1d+2aGilgPgV/3CXiPy5q6n6huQJ8bRt
 8GFs9vTplmrtD325SHABg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6A8XaHbgLnE=:F693E4OTW3mGkpBOVjh6bX
 gFdola4DrHTE0hze6LV5qSXMLODw5ubsfDaGOA+smETFgULhiO9fjQKmlhW9qjvP+GXOfed9S
 KdxkwbosQa3haxUIpYJFOZg30Tkdrvt9LqpJByR1FRvJvSzHplr0i151zi85694WNOwqB840y
 VijY6B+SALjXaGfUUF+sVKS7xkBkK2Q26WVj7gfwcgFbG6vCTCNVph1r1TRVn+rznBGT6Qm04
 GQ0CVDnyOHRk8KdRFOh2XAjPdrOPkfWGE5zqtPNtZ8866HEwFUPH9X7zc6Kha7FmZ9G18kupB
 PrmnHDQMRQd5ZIyDo1Q6PVqZHAhSU7lbvP7FSvL7Y+0gHoxKJwTGZsLJtyXUxerBr1PwlqpfX
 dhNjQiqqEaxNUhKuIGFbqd/VHlRie4nZLUfSzB2zw304On3qmwKXhIEKXF1Kyg+p45mf1nBM+
 OutgIGUMzxSX8nWetEmDBR2iHYYdCo5KaFCaVbR07QULC/vN9WipgfBIa30VPTxcGG+KsEV/W
 pXAkO67bHFSOxKw2C+b9ICq0dIA4ylIeAptQWl/LpvKpM6WkfQxXI/o8UX+prjNokU/JzkYTk
 hyTHtJ78WybTr7xAVy7+Li+i8ye1hPr9CXKJ1AP4OohqUwWQQuAhe3RQtTeInpLHb/UR89lBf
 noz8kCSTjQ5cw/0wmyitaFk/vKJvfArp0qDSLUzpjkV/W4N51t4p03hWxL7HBE3xdf9d+tmGI
 3f3Vwo7TkWSFjHXXC02cysIPWSMMoCQ6Lv3r4aQzgEqACWNfq5Q/IdQ/lyJfzds5clzZj+TWl
 9HP1V3cyVOJoifGHh9BZIOeUh1zbtDHGp7CfOxL/eOJ9pnokuFCKZZiBgSprbweSM736jHqFI
 x+yrCrNc8by5om4XMykHPyJspoiLmkffP5N44tPXQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 12 Jan 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +static size_t unrot13(char *buf)
> > +{
> > +	char *p =3D buf, *q =3D buf;
> > +
> > +	while (*p) {
> > +		const char *begin =3D strstr(p, "<rot13>"), *end;
>
> AFAIR from my reading of [02/11], the encoding side did not special
> case the payload that has <ebg13> or </ebg13>; if we want to make it
> reversible conversion (which is excellent improvement over the
> current "# GETTEXT_POISON #" obfuscation), we'd need to do something
> about it, I think.

Do you expect any message to be translated _twice_?

Ciao,
Dscho

> But on second thought, nobody can prevent a caller to die(_("%s", msg));
> to have "<rot13>" in the msg part, so perhaps punting like this
> series does is sufficient.  I dunno.
>
> > +		if (!begin)
> > +			break;
> > +
> > +		while (p !=3D begin)
> > +			*(q++) =3D *(p++);
> > +
> > +		p +=3D strlen("<rot13>");
> > +		end =3D strstr(p, "</rot13>");
> > +		if (!end)
> > +			BUG("could not find </rot13> in\n%s", buf);
>
> And the user of this looks quite straightforward and nice.
>
> >  test_i18ncmp () {
> > -	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
> > +	if test rot13 =3D "$GIT_TEST_GETTEXT_POISON"
> > +	then
> > +		test-tool i18n cmp "$@"
> > +	elif test_have_prereq C_LOCALE_OUTPUT
> > +	then
> > +		test_cmp "$@"
> > +	fi
> >  }
>
>
