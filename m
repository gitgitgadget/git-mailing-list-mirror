Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DC61F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 18:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfJKSor (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 14:44:47 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35133 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfJKSor (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 14:44:47 -0400
Received: by mail-pf1-f202.google.com with SMTP id r7so8153780pfg.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=r/5kb+JRaO6slyJh71ESbUPwNTB2hpY7OVqKu4C3Cy0=;
        b=Iic61DadRrtdhLCe05Gqp1b140j2VAIsErt6BDbK81GUZDNfnoD9B/gLamYK4lVPSV
         RBrEX2IR4HlNpg0BiBrojKdq7GilrXKqc6Gb0xwvmIZu2mwQX+suiJvP8+2FT6Qxt85x
         HL53JGFnh1LH3yWLvbKF6oLoGndinKAbF8vT99F+OUfe9P6RN5sCjYhiA2z0edPLHhP/
         E/2TjG/0KaP5W/QQAgA4xEu1X4B1ZEJOrxOGqV2kvaGdCvAyqccXKNNaOAyGhlOnkagV
         v8PzuM4ssJX4K7SDK08/qxJ8LjwmpHvgrRcrtKKkVFx7Q89eWibFlIdYZ4jWbrNDE0tV
         GM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=r/5kb+JRaO6slyJh71ESbUPwNTB2hpY7OVqKu4C3Cy0=;
        b=VjZ8NVXIePqcoa0hBydq3f+k0KxzoZwddjUYlgtMQy4HiKlUktFOBsKtOrCGsONoe/
         en5l9PI29f7mIfoLg5LY/pK4pwrrLe/IiZ3YHcfAitQpLYC3pOBgc8F+ndGv7uiLn1i4
         80McHTTax5PRp+R4erz3fj1ZQyy+H7BKfX44KCrQ5IXam+IaAuizeNaNpMYPXX7m7F7m
         UuJMWEpvWTILsENmPZoMzuUWZGMgx1YfHY9CNMmhtQGWVNWhS09SpY2dkZgbEFx+wfuY
         LNVTPiuqD3dnSdbu14oN7rvzNILsyad+KU4IUHO3dBjphov9qz7RSYam9uQl2z11vV/Y
         U3rw==
X-Gm-Message-State: APjAAAUlw343PlY2Dp+y9knVjBfnKb0V5yKwVmpLfq3GCrtib4RbsIp5
        KgJbdYges1ZVlIRPEIn90Sww4Cl+JFWhI/smHjsG
X-Google-Smtp-Source: APXvYqxd3nBf1LD9YtacpNMYe0XPiI6j6/7MzuyM/W1bIw1X+uClyCIjWytXzRYZ0tFwnq1r8wwpeA15hCImrUyC3Gg/
X-Received: by 2002:a63:5618:: with SMTP id k24mr18142088pgb.443.1570819485081;
 Fri, 11 Oct 2019 11:44:45 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:44:41 -0700
In-Reply-To: <xmqqsgnzj4vs.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191011184441.103527-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqsgnzj4vs.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, wambui.karugax@gmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
>=20
> >> -	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
> >> -	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
> >> +	if ((opt & BLAME_COPY_HARDEST)
> >> +	    || ((opt & BLAME_COPY_HARDER)
> >
> > Any reason why the names are renamed to omit "PICKAXE_"? In particular,
> > these names are still global, so it is good to retain the extra context=
.
>=20
> Absolutely.  Removing them is wrong, I would have to say.

Thanks for clarifying.

> >>  #define BLAME_DEFAULT_MOVE_SCORE	20
> >>  #define BLAME_DEFAULT_COPY_SCORE	40
> >> =20
> >> +enum pickaxe_blame_action {
> >> +	BLAME_MOVE =3D 01,
> >> +	BLAME_COPY,
> >> +	BLAME_COPY_HARDER =3D 04,
> >> +	BLAME_COPY_HARDEST =3D 010,
> >> +};
>=20
> We had a bit of discussion recently about using (or rather, not
> abusing) enum for set of bits on a different topic.

For reference, the discussion is here [1]. Szeder G=C3=A1bor has a dissenti=
ng
argument in [2] that makes sense to me (gdb on my desktop also shows an
enum used as a bitset as "(A | B)"). But in any case, perhaps we should
decide if it's fine to use an enum here before Wambui Karuga continues
development.

[1] https://public-inbox.org/git/xmqqsgobg0rv.fsf@gitster-ct.c.googlers.com=
/
[2] https://public-inbox.org/git/20191007171249.GB11529@szeder.dev/

> > Also, I have a slight preference for putting "=3D 02" on the BLAME_COPY
> > line but that is not necessary.
>=20
> That is absolutely necessary; it is not like "we do not care what
> exact value _COPY gets; it can be any value as long as it is _MOVE
> plus 1", as these are used in set of bits (and again, I do not think
> it is such a brilliant idea to use enum for such a purpose).

Good point.
