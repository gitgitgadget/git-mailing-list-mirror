Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA65256
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUEiDexV"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-555f95cc2e4so4428774a12.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 03:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704886425; x=1705491225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk1mwDA4MucoOuI0CUOoHy7SMp7QPBSsd/KaJ/tAmiM=;
        b=nUEiDexVtManT5ql8ml+p/t2uQsIW0b/c6tyS26YIl2yRZwKHzruQNnWhoWrSlYXoS
         vipxp4DectxCIbRTV5hMNuiuIlIldesEqMbDnyZfGJzLMddlRlSBQB2gXtFVit6QaK6o
         40z+eAhQmpqLVrZqEMQvd7sKq6dti1CxVK6n1HeTBTbjJykl+KZOTAcPkXN+XJGDgxGS
         aYWruZcHp5Bpk6DJYU1D5MFGimU19nYWrhfo47991a/wcIorx6Qz1evAqbQaxiX3nbQk
         zzll+ejrG3zFmtGpAwGwsXHlvqEgpPDv34j3FZ73Yqda4HfXJ8XE96oDMeaLMUyU5JwZ
         QEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704886425; x=1705491225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk1mwDA4MucoOuI0CUOoHy7SMp7QPBSsd/KaJ/tAmiM=;
        b=le+2Z8mGhpuhlEh1DvZoFGpbQtEod81NFckWfmuSWedBi57Z9bgUdY/fUj9Molxx1q
         Yin2EDP5KAcl129T1bGHyGcYYeSscKrqVfKP6BtqH+eB5+Ngnn3L4bMZfhXSKGmcYoT/
         rTVG4De9pUJAicxSp7XSKiTB16N8keQrlv/UpWPN4mvdMPvANAIp9y8CJB60Mw6+nMjr
         zEpWOu6n2Cqxnww4Wcm0aDx/fuSMrKzt8V+sQqUlpvHVT6ZxsM2isGDinj5XV/+CpRS9
         8hf8gWsXF0Zxrj4gS+JvEwmU+PRwaqmxrzL1WbNtMHSk6mQe7M635J/fnTdLJVsxpr12
         vjfQ==
X-Gm-Message-State: AOJu0YxkSJbPm3RdvyZp/7OMg8pXsU8PhsR2viH4p4Fn5cD3HpKFfbYf
	xygynB3EiF4468Huw6iTox/EmfK6GeeGzosDrePj/wC/Olk=
X-Google-Smtp-Source: AGHT+IGoZwA860q7xmNn4bs6Zf2NF7WYJZmfJZidgdrzJ9eOP2e1KLBti2ZPA5Yv4Hgmq9AzYUa8tIjyiw5lxhhe5E0=
X-Received: by 2002:a50:bac9:0:b0:557:c95:1362 with SMTP id
 x67-20020a50bac9000000b005570c951362mr371963ede.34.1704886424795; Wed, 10 Jan
 2024 03:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAnif95ux=vCNCKbVw0q_vYamQRkbFqSa9_-u6xRvK6r+2a+Q@mail.gmail.com>
In-Reply-To: <CANAnif95ux=vCNCKbVw0q_vYamQRkbFqSa9_-u6xRvK6r+2a+Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 10 Jan 2024 12:33:32 +0100
Message-ID: <CAP8UFD30h7D7D42Eiq3sk97v_ef8hi=K1qdy2wRczQ18JM++LA@mail.gmail.com>
Subject: Re: [GSOC][RFC] Add more builtin patterns for userdiff, as Mircroproject.
To: Sergius Nyah <sergiusnyah@gmail.com>
Cc: git@vger.kernel.org, "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergius,

On Tue, Jan 9, 2024 at 8:59=E2=80=AFPM Sergius Nyah <sergiusnyah@gmail.com>=
 wrote:
>
> Hello everyone,
> I'm Sergius, a Computer Science undergraduate student, and I want to
> begin Contributing to the Git project. So far, I've gone through
> Matheus' tutorial on First steps Contributing to Git, and I found it
> very helpful. I've also read the Contribution guidelines keenly and
> built Git from source.

Thanks for your interest in contributing to Git!

> In accordance to the contributor guidelines, I came across this
> Mircoproject idea from: https://git.github.io/SoC-2022-Microprojects/

s/Mircoproject/microproject/

There is a similar typo in the subject of your email too.

> which I'm willing to work on. It talked about enhancing Git's
> "userdiff" feature in "userdiff.c" which is crucial for identifying
> function names in various programming languages, thereby improving the
> readability of "git diff" outputs.
>
> From my understanding, the project involves extending the `userdiff`
> feature to support additional programming languages that are currently
> not covered such as Shell, Swift, Go and the others.

As far as I can see in userdiff.c, Golang and Bash seem to be supported.

> Here is a sample of how a language is defined in `userdiff.c`:
>
> > #define PATTERNS(lang, rx, wrx) { \
> > .name =3D lang, \
> > .binary =3D -1, \
> > .funcname =3D { \
> > .pattern =3D rx, \
> > .cflags =3D REG_EXTENDED, \
> > }, \
> > .word_regex =3D wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
> > .word_regex_multi_byte =3D wrx "|[^[:space:]]", \
> > }
>
> In this code, `lang` is the name of the language, `rx` is the regular
> expression for identifying function names, and `wrx` is the word
> regex.
>
> Approach: I Identified the Programming Languages that are not
> currently supported by the userdiff feature by reviewing the existing
> patterns in userdiff.c and comparing them with some popular
> programming languages.
> For each supported language, I would define a regular expression that
> could help identify function names in that language. This could
> include researching each language's syntax and testing their
> expressions to ensure that they work well.

In your microproject, you only need to add support for ONE language
that is not supported yet. Please don't try to do more than that.

> Also, I'd add a new IPATTERN definition for each language to the
> "userdiff.c" file, then rebuild Git and test the changes by creating a
> repo with files in the newly supported languages then run "git diff"
> to ensure the line @@ ... @@ produces their correct function names.
> Then submit a patch.

Except for my comments above, this looks like a good plan. Thanks.
