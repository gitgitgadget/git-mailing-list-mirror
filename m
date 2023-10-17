Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024E430E5
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="Z9ZSKqth"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA694
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 14:10:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso49084451fa.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1697577001; x=1698181801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rEIB9Is5y9falJSjgxaMGKaMxmspDmDlPa9XsBDnbsA=;
        b=Z9ZSKqthqSG+K5F8CEmGFr5b8xhCdOYOV9oHDPgrlhet/AYV5CPGZ/cOUNYV+Uh5d6
         wdqTfjCVfsSxYrdRvayjGZE4tquA+qlWaBALaWeJ1PIttKOjNcXEafHlHIt/7UsbIWGN
         yRTI36X9YzBE8F+YXoTZm69cRg+LSCctoklV1pC0gOknWOHg+7ZBPklUP/a+Uhqlhyb2
         MWHI0aM0vg0Tj40Sz/nduqbxb6sK5VvhTLmaob7KR9h+UdM7jzYsf5ruOB5VCMFnXG0C
         w6rChaUsqLeu8nyDXSVgzePVJmOHi8MBWZSb3JWsWc2MV/Yjn/evxov4KomXCF7UqWQP
         zgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577001; x=1698181801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEIB9Is5y9falJSjgxaMGKaMxmspDmDlPa9XsBDnbsA=;
        b=if3VjfSaaYkPghDQdssTj+/8Rv2tnaK0okIPsjCea6pCP4/qUpZg8Ou3D7vwSjo85M
         P/ItNcDqFDCcyk8LcYO64hFpYVqilbdrgA4u/iHFeVu91ql+h56zmJKIHENqjhy22P5o
         sdEPFtmZV7QR5N16jYkqIPKcpLCEHItJsizaFo9m5kVAPQW3Ni8UUq84zBmbqVRe8nrI
         /ISA+DIcjs03sNdnGXl9J30fIQiXhnVwIZhmPMZ+Sw32ccXUo6DXJxGLLOY3QthTTqP8
         cPckDcLHp8mSM0mlaKtspQXiQNJqPCKoJgGXE6ZHs5YoInHRfzY1IaVc0tODDQgF9s19
         aPqw==
X-Gm-Message-State: AOJu0YwLjJvQHnwQCuMnuR4hBQS3ratEikjIvaS2T8Ik3PX9RuIZ+QH9
	aKQ1quaFOivwqIHiAgoUDeEIKDO36wkZsPdJU1iAvbE5hP3kAe7Hig51eU1p
X-Google-Smtp-Source: AGHT+IHA7ZGtbRTnx48O3rG5QZQFLUJJxEif7mG3+96C6WKDucfGtHWWLtX0iJim+1pDyvUH6xhw2z2x8lTjIda1bGQ=
X-Received: by 2002:a05:651c:96:b0:2c5:e0:1634 with SMTP id
 22-20020a05651c009600b002c500e01634mr2229420ljq.35.1697577000813; Tue, 17 Oct
 2023 14:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Shopov <ash@kambanaria.org>
Date: Tue, 17 Oct 2023 23:09:50 +0200
Message-ID: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
Subject: Is there any interest in localizing term delimiters in git messages?
To: Git List <git@vger.kernel.org>
Cc: jmas@softcatala.org, alexhenrie24@gmail.com, ralf.thielow@gmail.com, 
	matthias.ruester@gmail.com, phillip.szelat@gmail.com, vyruss@hellug.gr, 
	christopher.diaz.riv@gmail.com, jn.avila@free.fr, flashcode@flashtux.org, 
	bagasdotme@gmail.com, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	alessandro.menti@alessandromenti.it, elongbug@gmail.com, cwryu@debian.org, 
	uneedsihyeon@gmail.com, arek_koz@o2.pl, dacs.git@brilhante.top, 
	"insolor@gmail.com" <insolor@gmail.com>, peter@softwolves.pp.se, bitigchi@me.com, ark@cho.red, 
	kate@kgthreads.com, "vnwildman@gmail.com" <vnwildman@gmail.com>, pclouds@gmail.com, 
	"dyroneteng@gmail.com" <dyroneteng@gmail.com>, "oldsharp@gmail.com" <oldsharp@gmail.com>, 
	"lilydjwg@gmail.com" <lilydjwg@gmail.com>, me@angyi.io, Xin Jiang <worldhello.net@gmail.com>, 
	"pan93412@gmail.com" <pan93412@gmail.com>, 
	"franklin@goodhorse.idv.tw" <franklin@goodhorse.idv.tw>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello all,

Is there any interest in being able to change the delimiters of the
changeable terms in git messages?

Typical example:
ORIGINAL
msgid "  (use \"git rm --cached <file>...\" to unstage)"

TRANSLATION
msgstr ""
"  (=D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =E2=
=80=9Egit rm --cached %s =D0=A4=D0=90=D0=99=D0=9B=E2=80=A6=E2=80=9C, =D0=B7=
=D0=B0 =D0=B4=D0=B0 =D0=B8=D0=B7=D0=B2=D0=B0=D0=B4=D0=B8=D1=82=D0=B5 =D0=A4=
=D0=90=D0=99=D0=9B=D0=B0 =D0=BE=D1=82 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=
=D0=B0)"

The important part are the `<' and `>' delimiters of the term "file"

Instead of using them - I omit them and capitalize the term. As if `<'
and `>' are declared as localizable and then I translate them as `',
`'

This has the following benefits:
1. The translation gets shorter
2. We skip potentially dangerous shell characters (<> redirect IN/OUT)
3. Readability improves for some strings, ex:
- git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]
- git mailinfo [<options>] <msg> <patch> < mail >info

On the other hand - this can increase the maintenance burden of
messages and tests and the shortening benefit is applicable to
languages using capitalization or some other form of letter changing
that preserves readability (I understand there are many languages with
lots of speakers that are not like that). They might decide to convey
`<' and `>' as `=C2=AB', `=C2=BB' to get benefits 2 and 3.

So I am asking - is there any interest from other localizers to have
such a feature? Would the additional maintenance be OK for the
developers?

It is possible that no one besides me is interested in this - in which
case I will rework the Bulgarian translation as:
- More and more messages containing only the term automatically add
the `<' and `>'
- I need to keep adding smudge rules to the git-po-helper tool
(https://github.com/git-l10n/git-po-helper).

Kind regards:
al_shopov
