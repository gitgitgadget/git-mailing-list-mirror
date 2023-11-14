Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC028BE7
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBm3KeWL"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B461A2
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 19:09:07 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079f6efd64so6806439e87.2
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 19:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699931346; x=1700536146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhpNKmbAKqTPAkXRflzl3tGFQyDb+qdFE8hgOe8bkUE=;
        b=HBm3KeWLoZQaNOYEJya56AZbjG5MDsb/TFS0oeYv6vN91960k5qRDVZZV4o2ZaN/pz
         9HedeUs8ireWLc0GCqOj0aY452/XekRWtO99TgHuDL55p/024X1aAvNxPJCuCG8fdwHt
         kqSCwZ3+U6VUAVdNRBtF3+j0MP/YDHEq8oFZbQtk7vdO1ufj5Z9nBF1A0XU6VGSPHKqE
         zGr/JAToaAhvCDdXxz1tYANclQ9toP/hnWUDhOKcROEEM1RlG23gzruYYIzZRJINI562
         RQjKPMk/HYiWhV34tAZn+GblL1RCroqQXwHFMV/UfNN+EhMFn27kCjeSOe7xk6Y32CBE
         q2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699931346; x=1700536146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhpNKmbAKqTPAkXRflzl3tGFQyDb+qdFE8hgOe8bkUE=;
        b=nFtdsIaOuavePTWTHUVAhs8Qr6fJi2ZA/fMPksfWX+2lzUKN6tX8OaCKaN5t8dohsB
         Dp2H+G/CJQcuPokNYTuJ4nzOEoN6RC+lXHhQ+YDHckNt1vAS+MpFeebQrPmHeW5VUoij
         zMmGSVrmn/fAyxuS46AKhmHXqBRfQRdh09KXBlxSQiG7EO8eCjjo6dxNVoEdXILaQ6ke
         K6o5adPScF2v5+wIGlQ3/FhA9j/lkHaT97GZKiP31lTKEHHtSG/r2XM42hucqIUL5WFn
         WLlWBJ98mOvaZu7nZwYTax2gG8OWO8YDfTGnOhWB62dN4/zhUM/e04I8Ag3jH9VSAEc3
         qxUA==
X-Gm-Message-State: AOJu0YwRys3w7sEcgW4LVNU05FJXUl5jPN9iFsRoQBBNwPWUZ1cgEsaV
	CAJ2lE7SOv8jLNGKCtED8yLeUz8XqgXpogGLFQfImMZ7NwY=
X-Google-Smtp-Source: AGHT+IGYwkQT/NuqBgzG1r1aAw0NZy2hJHR1kUDKyZkThqpQEREjXfeHELtR9oqOQ8zp0+QOVEDHr7wNbcvLHzCH+K4=
X-Received: by 2002:a05:6512:3e1e:b0:509:4b8a:b65f with SMTP id
 i30-20020a0565123e1e00b005094b8ab65fmr6909746lfv.60.1699931346061; Mon, 13
 Nov 2023 19:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697736516.git.me@ttaylorr.com> <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <ZU7X3N/rqCK/Y9cj@nand.local> <20231113220546.GB2065691@coredump.intra.peff.net>
In-Reply-To: <20231113220546.GB2065691@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 13 Nov 2023 19:08:52 -0800
Message-ID: <CABPp-BEuqpVUmQZ=zD=EYwBYLKY19pLix04eKsMtZkGu=8OZUA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for `--write-pack`
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	"Eric W. Biederman" <ebiederm@gmail.com>, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 2:05=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 10, 2023 at 08:24:44PM -0500, Taylor Blau wrote:
>
> > > This does mean that for a recursive merge, that you'll get up to 2*N
> > > packfiles, where N is the depth of the recursive merge.
> >
> > We definitely want to avoid that ;-). I think there are a couple of
> > potential directions forward here, but the most promising one I think i=
s
> > due to Johannes who suggests that we write loose objects into a
> > temporary directory with a replace_tmp_objdir() call, and then repack
> > that side directory before migrating a single pack back into the main
> > object store.
>
> I posted an alternative in response to Elijah; the general idea being to
> allow the usual object-lookup code to access the in-progress pack. That
> would keep us limited to a single pack.
>
> It _might_ be a terrible idea. E.g., if you write a non-bulk object that
> references a bulk one, then that non-bulk one is broken from the
> perspective of other processes (until the bulk checkin is flushed). But
> I think we'd always be writing to one or the other here, never
> interleaving?

I think it sounds like a really cool idea, personally.  I also don't
see why any current uses would result in interleaving.

fast-import's created pack has the same kind of restriction...and has
even grown some extensions to work around the need for early access.
In particular, it has a `checkpoint` feature for flushing the current
pack and starting a new one, and also gained the `cat-blob` command
for when folks really wanted to access an object without writing out
the whole packfile.  So, _if_ the need for early access arises, we
have some prior art to look to for ways to provide it.
