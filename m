Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A344666B
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbkoHgfw"
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA5810F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 22:08:22 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a86b6391e9so53451707b3.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697692102; x=1698296902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzVr0j/Sq+SIDOtH3sLxZe7ESpT/L4a6CdNZDaeMeVI=;
        b=SbkoHgfwaDTdHT8KRcIg9eov6hSLFsWK+Rw8BnoKoR7WVNzzlrVJ95SgoMLKfFIADO
         8uG+Uj+ym7J5ZfDs0QISsVgYEd477pZU8i3ea8hiWY7zGnxZeLZoncnrN2G/ndmB6RcO
         o7IEm0BQydZH6OYw27iDWu6rAQYGLVVMMUz8F+F65++SiG+Aj+5bmtnUzoBD4mcUQSXh
         n6p8C1OcbpF5+i7izJim0Ox0NRYFlT3s0PnT71HZ/3EZYUtcDZjv7AXjZ3GviDxNk2lE
         pjqekV8cSSQJmYq4SIAePqC45aN51X40hYNTqBrrftRKS6hxKpcX8onbY5nlNV5dWlsM
         ExOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697692102; x=1698296902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzVr0j/Sq+SIDOtH3sLxZe7ESpT/L4a6CdNZDaeMeVI=;
        b=g/M5qi9xjSonkwzp5Nu98/5LUyUa6fhPjZQhcbxyh0AINx7fl0nWFzL/EdBmyXC8WY
         YbJH0gxdI8CEA1rV1GyIxmSWbYWPRXEMMIGVBSaGNQ/5gdnOjHZi7MVpvwF6CcoAxLyo
         FDN4eLTGYxlA0o8KbWXlPfvaOYQg7lFclo0yq29QSi9LPZo9fn2AfVmr+pQxVcpTZce2
         sDcJlO1pMApP74uxLdtFQl7jJKjWUZqRnFPA14fe7GHG5g2gmiSNNhOkFXGMZYwaOt5R
         Ct2eaJB0PR2TG8y1Fk+ZL4hBRuGdxCJc0nn2dq8HaGPoUFfhS6zTNV7axV0hhkSdklTb
         6ijA==
X-Gm-Message-State: AOJu0YxUS/1/zTDAj8Z0IOHoswmxfKw6MjC7hFetIzSnGVvwjpweEEwY
	Mw46PkxrgPKEIKruLr7zE5HZzId+olwUNTaoluo=
X-Google-Smtp-Source: AGHT+IHkiVq9MES0ykz1LYY4rTWankJ2SYWDSS77tm1ZzvxLIO7KUYHCXGgHwwVt3Z7d5hFs663eXKmTuIznZv4yF18=
X-Received: by 2002:a0d:d5d6:0:b0:5a7:a81b:d9af with SMTP id
 x205-20020a0dd5d6000000b005a7a81bd9afmr1168481ywd.7.1697692101989; Wed, 18
 Oct 2023 22:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
 <xmqqzg0gx6k9.fsf@gitster.g> <CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
 <xmqqwmvkve83.fsf@gitster.g>
In-Reply-To: <xmqqwmvkve83.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 19 Oct 2023 13:08:10 +0800
Message-ID: <CANYiYbEqTH975j9E0GTbSbexrw3MLhKwBCw7mibfnWbxZ+-_yw@mail.gmail.com>
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

On Wed, Oct 18, 2023 at 10:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > Starting with the release of git 2.34.0 two years ago, we had a new
> > l10n pipeline and the git-po-helper tool as part of our l10n workflow.
> > The first version of git-po-helper introduced a validator to protect
> > git command parameters and variable names in megid.
>
> Ahh, that is the piece I was missing.  I didn't know you guys are
> doing extra checks that could trigger false positives.
>
> > E.g. In pull
> > request 541 (https://github.com/git-l10n/git-po/pull/541), a
> > mismatched variable name "new_index" was reported in bg.po as below:
> >
> >     level=3Dwarning msg=3D"mismatch variable names in msgstr: new_index=
"
> >     level=3Dwarning msg=3D">> msgid: unable to write new_index file"
> >     level=3Dwarning msg=3D">> msgstr: =D0=BD=D0=BE=D0=B2=D0=B8=D1=8F=D1=
=82 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=
=B5 =D0=B4=D0=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BD"
> >
> > And po/bg.po changed as below:
> >
> >     msgid "unable to write new_index file"
> >     msgstr "=D0=BD=D0=BE=D0=B2=D0=B8=D1=8F=D1=82 =D0=B8=D0=BD=D0=B4=D0=
=B5=D0=BA=D1=81 (new_index) =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5 =D0=B4=D0=
=B0 =D0=B1=D1=8A=D0=B4=D0=B5 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD"
>
> Wait.  Is this supposed to be a good example of validator working
> well?  We use this exact message three times in builtin/commit.c; is
> the validator insisting on the translated message to have verbatim
> string "new_index" in it so that the end-users will see it?
>
> I may still be confused, but if that is what is going on, I think it
> is a wrong validation in this particular case.  I can understand if
> we were creating say .git/new_index file and it helps the end users
> to diagnose a troubled repository by running "ls .git" to see if a
> file called "new_index" exists and getting in the way, but I do not
> think it is the case.  A new file ".git/index.lock" is created via
> repo_hold_locked_index() and I do not think it helps the end-user to
> know that we may be calling it "new_index" internally among the
> developers' circle.  If the message were about "index.lock", it
> might be a different story, but such an error would probably have
> been issued long before write_locked_index() gets called.
>
> I'd suggest doing s/new_index/new index/ to msgid string for these
> anyway.

I tried to find similar patterns in `po/bg.po` using:

    $ git  grep -h -B5 '([a-zA-Z_\.]*_[a-zA-Z_\.]\+)' po/bg.po

And find other translated variable names in Bulgarian as follows:

 * cookie_result in builtin/fsmonitor--daemon.c:

   error(_("fsmonitor: cookie_result '%d' !=3D SEEN"),

 * run_command in builtin/submodule--helper.c:

    die(_("run_command returned non-zero status for %s\n."),
    die(_("run_command returned non-zero status while "

 * crlf_action in convert.c:

    warning(_("illegal crlf_action %d"), (int)crlf_action);

 * lazy_dir in name-hash.c:

    die(_("unable to create lazy_dir thread: %s"),

 * lazy_name in name-hash.c:

    die(_("unable to create lazy_name thread: %s"),
    die(_("unable to join lazy_name thread: %s"),

 * load_cache_entries in read-cache.c:

    die(_("unable to create load_cache_entries thread: %s"),
    die(_("unable to join load_cache_entries thread: %s"),

 * load_index_extensions in read-cache.c:

    die(_("unable to create load_index_extensions thread: %s"),
    die(_("unable to join load_index_extensions thread: %s"),

Apart from "new_index", it seems that none of the above sentences can
be rewritten simply by removing the underscores in variable names
without breaking the grammar, and I suppose it would be better to keep
those variable names unchanged.
