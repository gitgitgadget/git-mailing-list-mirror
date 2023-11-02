Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27406AAC
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScUI8paY"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA612F
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 07:44:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so1692180a12.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698936283; x=1699541083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pB463uIFQ579HicIKyJPKCEPkXshB/g8Ws9BJ+6Xao=;
        b=ScUI8paYoa7j22POXAIj7pZVG9AMVXEL6fGGMoKPZOx702XezPcE5DtOAV1ST8VFpi
         QCHxkYMlyMz1GZP1HX2DOjHhz2Ezr9A132Vt3oZdE1h0Nzg+XruhGn7MoZuWVPOvjcqn
         TSUoFevlHTXWWM6Hc+qHreUBR8unRUTehoHUaoX24rhX460YgkbHWta92jDcK9yYq54T
         JuOf1WWreL6U7YJnSK6RUt8QUIz8TlA6y0o+xXm9AWVOogKEOncXHuvop0QyRuWac75i
         ATyC1G0PSSXz0l11biMieCoab678jOgmcq72g4PYdBhlyHUXwleb7/j5eSrsyf6VvA0S
         /E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936283; x=1699541083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pB463uIFQ579HicIKyJPKCEPkXshB/g8Ws9BJ+6Xao=;
        b=XQJkewceAQk8zP6I4+xxR47HWe2x8gD6ULkqwAJOue3imIBaQdXcaynVgyY5TzIn4v
         a+5WEpqfHJnnWyXH3JefOCHhOQ8JMbIoLLy2lZi2p9ms+jGnlNxn8PVXWNUaBW6JECbP
         MrIFmwkb+7JudYyMY2vuCVxBCfVlcreF8BNbHQtIG43/fRHbyG63zUeocOdGABFBPEx5
         mtc/unyylYsVMUCVfy89L+E1D7g/Y3qDOFejx7N9sxiF9lZFL6lCS1bQ/eRIF7qNvWTN
         orJfnITo22MYkayg66N3ypk3HOGgsHNXpyBN13ifdTUhNEdJWx55yjgR9xGCjnDoDeGh
         5W5w==
X-Gm-Message-State: AOJu0Yxnoa91nq40EHEMP9WIJldzof+WdmBwqJK6mRsPiKJ8o/pHy0Ln
	b1aDUKQTdNAIabtf2c0fsQUsvGR+6TWNwi1JZqE=
X-Google-Smtp-Source: AGHT+IFqSSWUw4sL3qqjYacO6P2cV3qtTGvGuaIVsB7dDWu3YXxanERU5vsOM4GvNh2ACtfS7AnKlxbFdFyWhiy2B+w=
X-Received: by 2002:a05:6402:299:b0:53f:731a:e513 with SMTP id
 l25-20020a056402029900b0053f731ae513mr14074423edv.25.1698936282780; Thu, 02
 Nov 2023 07:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com> <CABPp-BGCzxL-kpOvZzWRTJcx2v18QHm5ev8bFv7bm0dyNqhKug@mail.gmail.com>
 <e04cfbdc-fd28-c645-8f5d-132f7ceec6be@gmx.de> <CABPp-BGfsda-8CK7_YPJfhGMfpLqdDeB8X6wnqPAGmhiY4KjDA@mail.gmail.com>
In-Reply-To: <CABPp-BGfsda-8CK7_YPJfhGMfpLqdDeB8X6wnqPAGmhiY4KjDA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Nov 2023 15:44:29 +0100
Message-ID: <CAP8UFD0iS2za20Mzy2Dy7XLnhHTwN-_=8gV-NCzxzxcfaF-TMQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
To: Elijah Newren <newren@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Calvin Wan <calvinwan@google.com>, 
	Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elijah and Dscho,

On Mon, Oct 30, 2023 at 6:18=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
> On Sun, Oct 29, 2023 at 7:14=E2=80=AFAM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 28 Oct 2023, Elijah Newren wrote:

> > > I can see why this might sometimes be useful for exclusively linear
> > > history, but it seems to open a can of worms and possibly unfixable
> > > corner cases for non-linear history.  I'd rather not do this, or at
> > > least pull it out of this series and let us discuss it in some follow
> > > up series.  There are some other alternatives that might handle such
> > > usecases better.
> >
> > I find myself wishing for an easy way to reverse commits, if only to
> > switch around the latest two commits while stopped during a rebase.
> >
> > So it would have been nice for me if there had been an easy, worktree-l=
ess
> > way to make that happen.
>
> Seems reasonable; we'll definitely want to keep this in mind.
>
> > I guess this would be going in the direction of reordering commits,
> > though, something we deliberately left for later?
>
> Yes, I think that's a good framing for it.

Ok, in the v6 I just sent, a warning() is emitted when `--reverse` is
passed and the option has no effect.

I agree that handling such options in a better way should be left for
later patch series.

Thanks both!
