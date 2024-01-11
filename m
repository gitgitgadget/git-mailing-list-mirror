Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC040BE8
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+3D6ycM"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so173398366b.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704985912; x=1705590712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35xnVALZiiZBHBhgp+GRGjZJ/fFp0bZxmI8uVaweTOE=;
        b=i+3D6ycMfSo3izQGJZzA7r0rF6lrRS2db6Yf8qmP0dYUuOAJHY/5h66PBvmLOKlRdk
         e4Qbc58Nxz5/uaz/foahGiLaAqejeQWgnJx2OcK6m4G2/uEkxiFvyvCgesTL1EofNsLV
         GsuKULTx4y0crz6irIu460142VsH6hBkL4qm3lN0e9UdMBcTEJ8JcZFy00A7NMFCuurC
         MbfhUL967D3Ief7wrYnpYA4k1A6JbGzrJiYyuY4JG+gg9Vl0Xd46+W108Q4vKNOVgRb8
         WFtdKZzH1XZrz1sS4ffMa8CxeotTth109fV/XN1rHBZpsIX8xfQEGlws82HmVTQuDz8P
         Xujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704985912; x=1705590712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35xnVALZiiZBHBhgp+GRGjZJ/fFp0bZxmI8uVaweTOE=;
        b=CGrOZqNGLKQwzgKzrbT2edwA1To8c8uLtYVugIZ4QWBXgf39r1ictOSoKrqJt5CzXB
         xiDUb8uswqQUo9juEHec/G/vtn8Scmz4TSJrBG0X9UHwx62gdq0Mby7FdQcihccWi9QA
         9L0GC3D4l0UZ5MFVHVKHKcd8Z/LyBqYQZwFdbj8GhtRSdDEMxfHT0dQVJrxT0xAjW6+g
         praJpLnJhfKqEo9nGcpEqtHmZJgqlKr9pnLTHYSbmPdlVsnMqNN/jStnz9r4dUX/joot
         PLqNtjhQcH8ZAoYL45kTZhUO/i97NWiQqS9J5tjzMFigmrIknwyNhpdIk3YRQU61XWuW
         sg4w==
X-Gm-Message-State: AOJu0YxokBzTiubAslWri9jOrd5Uh4EnSDdg8U57amanxf517gYSHo8L
	J86TWLP9QH8zzEbOt8zSQ8VniUoFZmMzE2JnfJ0il/Lrk0Q=
X-Google-Smtp-Source: AGHT+IELGFfDNmzFgjM2y2ukX9CY39XeTRKpdsfF7br7El54w2xbEEhP5gqPWrgsz9YJQ8+btf6FBZIUxB5SEaFbH8Q=
X-Received: by 2002:a17:906:fe01:b0:a27:aebf:32af with SMTP id
 wy1-20020a170906fe0100b00a27aebf32afmr931038ejb.8.1704985911811; Thu, 11 Jan
 2024 07:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAnif95ux=vCNCKbVw0q_vYamQRkbFqSa9_-u6xRvK6r+2a+Q@mail.gmail.com>
 <CAP8UFD30h7D7D42Eiq3sk97v_ef8hi=K1qdy2wRczQ18JM++LA@mail.gmail.com>
 <CANAnif90Bqp2pWCn_71t-Fss6wspo+==vMdYsX+Wt5m=4Ocpng@mail.gmail.com>
 <CAP8UFD0ELy2WegVYdxi_O5UpHS4MyOPp4tuAQK+XvvNmABc2ZA@mail.gmail.com>
 <CAP8UFD3e=Zv2wkx5tswCz05Vwn3vD68Vw-TD6SoENWK+norYsw@mail.gmail.com> <CANAnif-hWovPnRmSy0pnEJnA274vwiSAkRexstGQdQJ4u-5+pw@mail.gmail.com>
In-Reply-To: <CANAnif-hWovPnRmSy0pnEJnA274vwiSAkRexstGQdQJ4u-5+pw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 11 Jan 2024 16:11:39 +0100
Message-ID: <CAP8UFD0YicYXrYgHdvcrWps+cMa=Dp9Ob7SfYLMXQKLp7-B+7w@mail.gmail.com>
Subject: Re: [GSOC][RFC] Add more builtin patterns for userdiff, as Mircroproject.
To: Sergius Nyah <sergiusnyah@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 3:23=E2=80=AFPM Sergius Nyah <sergiusnyah@gmail.com=
> wrote:
>
> ---------- Forwarded message ---------
> From: Christian Couder <christian.couder@gmail.com>
> Date: Thu, Jan 11, 2024 at 11:51=E2=80=AFAM
> Subject: Re: [GSOC][RFC] Add more builtin patterns for userdiff, as
> Mircroproject.
> To: Sergius Nyah <sergiusnyah@gmail.com>
>
>
> On Thu, Jan 11, 2024 at 11:48=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Wed, Jan 10, 2024 at 9:10=E2=80=AFPM Sergius Nyah <sergiusnyah@gmail=
.com> wrote:
>
> > > > Okay then. I will add support for shell, as it was primarily sugges=
ted
> > > > in the idea itself.
> >
> > As Bash is a shell and is already supported, I am not sure which kind
> > of shell you want to support. There are other shells or kinds of shell
> > with different syntax that might be worth supporting, but then you
> > might want to tell us which shell or which new kind of shell.
> >
> > Thanks!
>
> I've definitely learned one more thing. Thank you!
> Also, after taking another keen look at the Patterns defined in userdiff.=
c,
> In accordance with what you've said, I realized that Kotlin isn't
> supported yet.

It is actually already supported too:

$ grep -i -n kotlin userdiff.c
186:PATTERNS("kotlin",

To help you a bit, you can get the list of already supported languages usin=
g:

$ perl -ne 'print "$1\n" if m/PATTERNS\(\"(\w+)\"/ or
m/IPATTERN\(\"(\w+)\"/' <userdiff.c
ada
bash
bibtex
cpp
csharp
css
dts
elixir
fortran
fountain
golang
html
java
kotlin
markdown
matlab
objc
pascal
perl
php
python
ruby
rust
scheme
tex
