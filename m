Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ED42376A
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYYKLEfV"
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F7C0
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:20:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d865854ef96so3590891276.2
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698103220; x=1698708020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy5D7svGj5hkmHNE+GWRU9JSpOO6T1hqL5hdXHq4yRw=;
        b=IYYKLEfVQ9ZzsGGj/JqdXCq8Jw5CHwBHzLFHIsN3Yc8kuFn/tRbyE2Ss2nzpwjqfet
         Q0oP9L3PxQqtuT+YR53XO2HR0VSmUssYaXiFjcPwJBZiVkjFGeXAUnqWb1IeMbd4SDeH
         LpyyhwnRMKXZThuOsK4TSDZ8xxU1SktjpDztphxRO2HPFH+Pdf6Zbkj/uo6XspVkkvdL
         JZAgBPYmq5dbS7rvr8Lsd7xcbU2edeR43nGmGsp4pTAHMYIJyoVNXOA6Ifg/B+Pmydhp
         ZE+0pNgLldyqBdgWgyPNJGC1/gsQi7didrON1Rgm0xFbQYf9y89+kN8nJ++niIozWSbc
         Mw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698103220; x=1698708020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy5D7svGj5hkmHNE+GWRU9JSpOO6T1hqL5hdXHq4yRw=;
        b=g/lt3aOkoIfJlz+k3szSglM98qAOSAl1iEEsqJLQ31VneOBTsv6xYuLVXwixRSxysq
         GYL0Bt9zeBusUftThQR1RENUWwAs31l9GqTOk+3V85rj9PNwd2DeZIOG6LqJ4YWHLGos
         TwcRNQZbBpOSqcDjJ6U8Ozr+mKHkjY3224LBbDMdHt+2X1DOZ1gStNjQOLvNHqKctJ99
         9bufNCCfsMIcA/ImxtbS/zbCe0LAR7m43ZMiM9BU9XNBzQcDMTZnGYNzxQHGeCS40oQm
         FsElDz4rW6q1yzhIrfdvjNzCT9UY/XdmE64Sleu5ZKGpOpHtBS1qk6iLxO0yAt1dQg/v
         0VAQ==
X-Gm-Message-State: AOJu0YxYyjMAXcW8Keghkl1C4xq4MiFvufWYAsMk6iHgW2D0Sl+6W8pu
	pX0lOPNDHPGXoj5TImQ6Ew/ZklpH04QgCtEsP1k=
X-Google-Smtp-Source: AGHT+IEGrihnd38gKJ5V93zUL7dHMsnMhnWUldMFXDO4JZeONaFE9Lov0Ld55qFh/ExHSzXPatvQtDWAKA9Own3xVU0=
X-Received: by 2002:a25:e00b:0:b0:d99:5613:213d with SMTP id
 x11-20020a25e00b000000b00d995613213dmr11933296ybg.61.1698103220285; Mon, 23
 Oct 2023 16:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ZTYue-3gAS1aGXNa@tanuki> <CANYiYbEJ_mHdsPM3-huDPFktSWFhrpoz7Cvf000JSfZM2cco9w@mail.gmail.com>
 <ZTZF3AbNNuGpy38l@tanuki>
In-Reply-To: <ZTZF3AbNNuGpy38l@tanuki>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 24 Oct 2023 07:20:08 +0800
Message-ID: <CANYiYbG0YFc4Hg=e+0db4NBgM2QwOLpjHjfp8WaoObNxR-=euA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: no redundant error message for atomic fetch
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 6:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 23, 2023 at 05:16:20PM +0800, Jiang Xin wrote:
> > On Mon, Oct 23, 2023 at 4:27=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > On Thu, Oct 19, 2023 at 10:34:33PM +0800, Jiang Xin wrote:
> > > > @@ -1775,10 +1775,8 @@ static int do_fetch(struct transport *transp=
ort,
> > > >       }
> > > >
> > > >  cleanup:
> > > > -     if (retcode && transaction) {
> > > > -             ref_transaction_abort(transaction, &err);
> > > > +     if (retcode && transaction && ref_transaction_abort(transacti=
on, &err))
> > > >               error("%s", err.buf);
> > > > -     }
> > >
> > > Right. We already call `error()` in all cases where `err` was populat=
ed
> > > before we `goto cleanup;`, so calling it unconditionally a second tim=
e
> > > here is wrong.
> > >
> > > That being said, `ref_transaction_abort()` will end up calling the
> > > respective backend's implementation of `transaction_abort`, and for t=
he
> > > files backend it actually ignores `err` completely. So if the abort
> > > fails, we would still end up calling `error()` with an empty string.
> >
> > The transaction_abort implementations of the two builtin refs backends
> > will not use "err=E2=80=9C because they never fail (always return 0). S=
ome one
> > may want to implement their own refs backend which may use the "err"
> > variable in their "transaction_abort". So follow the pattern as
> > update-ref.c and files-backend.c to call ref_transaction_abort() is
> > safe.
> >
> > > Furthermore, it can happen that `transaction_commit` fails, writes to
> > > the buffer and then prints the error. If the abort now fails as well,=
 we
> > > would end up printing the error message twice.
> >
> > The abort never fails so error message from transaction_commit() will
> > not reach the code.
>
> With that reasoning we could get rid of the error handling of abort
> completely as it's known not to fail. But only because it does not fail
> right now doesn't mean that it won't in the future, as the infra for it
> to fail is all in place. And in case it ever does the current code will
> run into the bug I described.

If in the future ref_transaction_abort() fails for some reason, the
err variable will be filled with the error message and the previous
error message will be discarded, no duplication will occur. So I think
use this fix is OK.

> So in my opinion, we should either refactor the code to clarify that
> this cannot fail indeed. Or do the right thing and handle the error case
> correctly, which right now we don't.
>
> Patrick
