Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DB184D
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7V3jqSJ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50edf4f478eso372954e87.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 21:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704949596; x=1705554396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Zq9aoJJknInQF3Ap2SePSlp2/JIlLgiEcppaXKtYhQ=;
        b=D7V3jqSJ6pTUyQ9U2qW3VXMO263IyexB2vF8bzFORuFRYP0fShkoo/7NYScTW753SR
         gZU0q8JehPlEGpY9i4iJXfjNICNT3PDUtDgy30QfnqRh+6ICJsEAK2T0kcTeIsApdHE2
         b4ZSRtU5I6VMuP8naUlNr/SMnj+1I7OFsKEMCxcLEeF1eEuW+dCYr98QGfjt1FlUOx8K
         09fxVkUaoGa65n0UUQ3NvZmUDTLwKkUL/TSPJFkhSBIO+NToue/rdsXPDLQwUdVvCW4F
         jD8QQHIB8pHKQWawgdP+C1AInFeLtVWGZH6idZRkVyyuKvlXiB7bR/fq01aBpWOjJw2W
         x4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704949596; x=1705554396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Zq9aoJJknInQF3Ap2SePSlp2/JIlLgiEcppaXKtYhQ=;
        b=bNa8r5rSFm8Tdg3D6NQr7LWyDTlBFltq23hODKpHBVl2hwX9ZX1Z6GwwTnD2WW+2O/
         076iTTH/2GBxJszbseFrDHzi6k1BP+IGeUltCnBJJnnM0IvL56fMrVYEyWOhyBKhSGpN
         GYO1RVy6QEuwMW9Q2n83TxhHEegPfeECKMQEMbC+j3fP5oLCRyOh53L83jHAyjZkuGOV
         x6XYgtOkqAL2x5NlYdPWnd1kCunYIrVM3VDWNFhq+x+puk3bV953EtcUO0vg+QJdzd6G
         pf9CUSUQttnuDABjvt06o28jqT+n8BJP5OikFQ+4Xpmp7W+qE2TUx6eSfs16Lk+P26Yo
         eoyw==
X-Gm-Message-State: AOJu0YyIA3p1L/sQrHCb1ge4nszSbpzt4KcPdToV6gRlpEJYTohMoLxM
	VjFchQirfImgTuQkWs+LJPAkMkO5TPNTVpLoMld6Q34j
X-Google-Smtp-Source: AGHT+IGH8qnMfNdfLWncUJPh8HcnGpoQl/PI69Qwnretx4hL9bk+0BDTk12m1veIosVdk8XVydaHPLK+FUIxBJSCMpA=
X-Received: by 2002:ac2:5e9b:0:b0:50e:9c5d:35f5 with SMTP id
 b27-20020ac25e9b000000b0050e9c5d35f5mr196006lfq.121.1704949595667; Wed, 10
 Jan 2024 21:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
 <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com>
 <CABPp-BEw_HFL-9u6WdSEe-qr_JfJyQtfU6PP7izEdPChKooc6g@mail.gmail.com>
 <008701da442f$b2dfe420$189fac60$@nexbridge.com> <CABPp-BHx=4HPSN4enkHTL7PPnNBsJ1vGWe4Em5imH7HcOcH2PA@mail.gmail.com>
 <009c01da4439$f70beef0$e523ccd0$@nexbridge.com>
In-Reply-To: <009c01da4439$f70beef0$e523ccd0$@nexbridge.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 10 Jan 2024 21:06:23 -0800
Message-ID: <CABPp-BGmXw0NQ8yBaMiVXHiKr0-Y_jkZWmJB1CG_oc4UGxt_gA@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: rsbecker@nexbridge.com
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 6:57=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Wednesday, January 10, 2024 9:21 PM, Elijah Newren wrote:
> >On Wed, Jan 10, 2024 at 5:44=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >>
> >> On Wednesday, January 10, 2024 7:59 PM, Elijah Newren wrote:
> >[...]
> >> >Would you be okay with the following alternative: requiring that all
> >> >Rust code be optional for now?
> >> >
> >> >(In other words, allow you to build with USE_RUST=3D0, or something
> >> >like that.  And then we have both a Rust and a C implementation of
> >> >anything that is required for backward compatibility, while any new
> >> >Rust-only stuff would not be included in your build.)
> >>
> >> To address the immediate above, I assume this means that platform
> >> maintainers will be responsible for developing non-portable
> >> implementations that duplicate Rust functionality
> >
> >This doesn't at all sound like what I thought I said.  The whole proposa=
l was so that
> >folks like NonStop could continue using Git with no more work than setti=
ng
> >USE_RUST=3D0 at build time.
> >
> >Why do you feel you'd need to duplicate any functionality?
>
> I think I misunderstood. What I took from this is that all new functional=
ity would be in Rust, which would require a custom implementation in C for =
platforms that did not have Rust available - if that is even practical. Did=
 I get that wrong?

I think you somehow missed the word optional?

I did say that new functionality should be allowed to be Rust only
(unlike existing functionality), but I'm not sure how you leaped to
assuming that all new functionality would be in Rust.  Further, I also
don't understand why you jump to assuming that all new functionality
needs to be supported on all platforms.  The point of the word
"optional" in my proposal is that it is not required.  So, say, if
git-replay is in Rust, well you've never had git-replay before in any
release, so you haven't lost any functionality by it being implemented
in Rust.  And existing things (merge, cherry-pick, rebase, etc.)
continue working with C-only code.  But you may have one less optional
addition.

At least that was _my_ proposal -- that Rust be optional for now.  It
does differ from what I think Taylor was originally proposing, but
that's why I brought it up as an alternative proposal.
