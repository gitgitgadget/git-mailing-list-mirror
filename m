Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C6185D
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhFvnIU/"
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A81F7
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 19:02:04 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-579de633419so78111557b3.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 19:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697594524; x=1698199324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2AGfuyzKbxdUIfI7ATw6oWwni0+hmtjYpLxQgz+a6g=;
        b=hhFvnIU/iDylViP21tdhAGdAlgqZh9QvL4JsiIRmNNL0yDgEfAnrRW0Evxh0YqNAtA
         Qll8kSA2r7qM/HSlnix5svoysH0RUuZyT8E/PJZo1tqBxntakupOVy8Nuod/JxItZ9IJ
         +RPEUXgFYDgV/YVy1xJc5nBXXxvIWhz23m7ZZxasIX8pxzF1jNYYoqdxk9/kqhSll52x
         Mk5MwfWcJ5DnO13+uAiG2tFZcH1fdRErD5qEfcP15APEWhxz9e/BiwReBWOK+NSjXuUR
         t+6Ou4kR96fDbcY1JmZ/IHzQBoEwtnIEHEU8nGKYJ/co6wTWADse06LwNPfZle32fFrf
         RVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697594524; x=1698199324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2AGfuyzKbxdUIfI7ATw6oWwni0+hmtjYpLxQgz+a6g=;
        b=jwL67cYs+ObY3a/LcH8EsrH3pFn4zGZP1MIcOloBv6juvS/YzNw61cMFpAtDBIIf6e
         nsHZ793DazQdDbxo8R1Esu30P+FQg/RuiX/8d8FP3VQuoIYK5TM84/8NHOYi1igq2Ecv
         3yXI0XrBChkSUKZP72BpipwruJ9IOIaPp/i1F0QYEQsm0FC2OOMDmGc2G4PRmdGp5BW6
         UkKhH4tDi9Dn/j9dXdyPjuVBpCXMfm0yFLs7vdQhC80lINiEzhU2f7i0P5AsiKfhyFu4
         QtCMMSbqLKoCmlK7Z+TtaEjFhwq0Hc/f/9NBZH1wXvF84w8/2/9GIxq53lftEy8mEh2g
         C7RQ==
X-Gm-Message-State: AOJu0Yzw0Efn3HyXwDUOrY1rEUHTn+QvD5yOzu+IeabkQBxRoDHNkf/x
	hqlZLP8JizAPJyh6DyQ/yU7QtzSR0GH8ssTGy+A=
X-Google-Smtp-Source: AGHT+IHRwBpGqekr436J3z9NSamOiOaw0goW2RP+zWL/h7kwKuZAIVEJyQUVyBSg5q3obIVQ4kan4tKp8PVNBXZFqoM=
X-Received: by 2002:a0d:db56:0:b0:5a7:b930:16a8 with SMTP id
 d83-20020a0ddb56000000b005a7b93016a8mr4355746ywe.4.1697594523910; Tue, 17 Oct
 2023 19:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
 <xmqqzg0gx6k9.fsf@gitster.g>
In-Reply-To: <xmqqzg0gx6k9.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Wed, 18 Oct 2023 10:01:52 +0800
Message-ID: <CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
Subject: Re: Is there any interest in localizing term delimiters in git messages?
To: Junio C Hamano <gitster@pobox.com>
Cc: Alexander Shopov <ash@kambanaria.org>, Git List <git@vger.kernel.org>, jmas@softcatala.org, 
	alexhenrie24@gmail.com, ralf.thielow@gmail.com, matthias.ruester@gmail.com, 
	phillip.szelat@gmail.com, vyruss@hellug.gr, christopher.diaz.riv@gmail.com, 
	jn.avila@free.fr, flashcode@flashtux.org, bagasdotme@gmail.com, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	alessandro.menti@alessandromenti.it, elongbug@gmail.com, cwryu@debian.org, 
	uneedsihyeon@gmail.com, arek_koz@o2.pl, dacs.git@brilhante.top, 
	"insolor@gmail.com" <insolor@gmail.com>, peter@softwolves.pp.se, bitigchi@me.com, ark@cho.red, 
	kate@kgthreads.com, "vnwildman@gmail.com" <vnwildman@gmail.com>, pclouds@gmail.com, 
	"dyroneteng@gmail.com" <dyroneteng@gmail.com>, "oldsharp@gmail.com" <oldsharp@gmail.com>, 
	"lilydjwg@gmail.com" <lilydjwg@gmail.com>, me@angyi.io, "pan93412@gmail.com" <pan93412@gmail.com>, 
	"franklin@goodhorse.idv.tw" <franklin@goodhorse.idv.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 5:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Alexander Shopov <ash@kambanaria.org> writes:
>
> > Typical example:
> > ORIGINAL
> > msgid "  (use \"git rm --cached <file>...\" to unstage)"
> >
> > TRANSLATION
> > msgstr ""
> > "  (=D0=B8=D0=B7=D0=BF=D0=BE=D0=BB=D0=B7=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =
=E2=80=9Egit rm --cached %s =D0=A4=D0=90=D0=99=D0=9B=E2=80=A6=E2=80=9C, =D0=
=B7=D0=B0 =D0=B4=D0=B0 =D0=B8=D0=B7=D0=B2=D0=B0=D0=B4=D0=B8=D1=82=D0=B5 =D0=
=A4=D0=90=D0=99=D0=9B=D0=B0 =D0=BE=D1=82 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=
=81=D0=B0)"
> >
> > The important part are the `<' and `>' delimiters of the term "file"
> >
> > Instead of using them - I omit them and capitalize the term. As if `<'
> > and `>' are declared as localizable and then I translate them as `',
> > `'
>
> Is it because it is more common in your target language to omit <>
> around the placeholder word, or is it just your personal preference?
>
> Whichever is the case, I am not sure how it affects ...
>
> > So I am asking - is there any interest from other localizers to have
> > such a feature? Would the additional maintenance be OK for the
> > developers?
>
> ... the maintenance burden for developers.  Perhaps I am not getting
> what you are proposing, but we are not going to change the message
> in "C" locale (the original you see in msgid).  In untranslated Git,
> we will keep the convention to highlight the placeholder word by
> having <> around it, so the "(use \"git rm --cached <file>...\" to
> unstage)" message will be spelled with "<file>".  You can translate
> that to a msgstr without <> markings without asking anybody's
> permission, and I do not think of a reason why it would burden
> developers to do so.

Starting with the release of git 2.34.0 two years ago, we had a new
l10n pipeline and the git-po-helper tool as part of our l10n workflow.
The first version of git-po-helper introduced a validator to protect
git command parameters and variable names in megid. E.g. In pull
request 541 (https://github.com/git-l10n/git-po/pull/541), a
mismatched variable name "new_index" was reported in bg.po as below:

    level=3Dwarning msg=3D"mismatch variable names in msgstr: new_index"
    level=3Dwarning msg=3D">> msgid: unable to write new_index file"
    level=3Dwarning msg=3D">> msgstr: =D0=BD=D0=BE=D0=B2=D0=B8=D1=8F=D1=82 =
=D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =
=D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BD"

And po/bg.po changed as below:

    msgid "unable to write new_index file"
    msgstr "=D0=BD=D0=BE=D0=B2=D0=B8=D1=8F=D1=82 =D0=B8=D0=BD=D0=B4=D0=B5=
=D0=BA=D1=81 (new_index) =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=B0=
 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD"

Later, more validators were introduced into git-po-helper for checking
git config name, place holders, etc. "git-po-helper" used a list of
regular expressions to find git config names, placeholders, and there
are some false positive cases need to be ignored. So I added tweaks in
smarge tables in "dict/*.go" of git-po-helper. E.g. For German
translation, there are two exceptions that need to be ignored:

    "e.g." was translated to "z.B.",
    "you@example.com" was translated to "ihre@emailadresse.de"

In pull request 593 (https://github.com/git-l10n/git-po/pull/593), it
was the first time I know that in Bulgarian translations, markers
around <placeholder> were not suitable for Bulgarian. So I decided to
add more tweaks for Bulgarian by adding more exception rules in
"dict/smudge-bg.go".

I wonder if Bulgarian can use some unique characters to wrap the
placeholders (e.g. Chinese can use wrappers around placeholders
like=E3=80=8Cplaceholder=E3=80=8D=EF=BC=8C=E3=80=90placeholder=E3=80=91=EF=
=BC=8Cetc). It will be much simpler to
define exception rules for Bulgarian. Otherwize, maybe I can add
filters for validators in "po-helper", and Bulgarian can bypass some
validators to suppress warnings in pull requests.

--
Jiang Xin
