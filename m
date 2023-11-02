Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B611713
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKFnpHa1"
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69651133
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 02:29:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28028f92709so613798a91.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698917374; x=1699522174; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA/E2i+Ma/zs7hTGUQgxU+16cmFggthc6jA3MYA8DS8=;
        b=CKFnpHa1NxkGnot3wJLGs5THGUQ81EEsbKmyRDnr+H5RQ29JX3rCj0fBsf/bTud2a7
         Io9BwQtcfFgQjES1eF8696VSNRDqDjY8iroHU33UAuPdxDsTMOQIwhQK1Pxn/acKHgnm
         UiE4TGy0xMrlyTjqPN7Mnw64xbgkNaXePRn8Q7g7/ptCmMPwAJMGM+IxIo5jve3b2j9b
         nt7U88VrfJYJma+hmlle5MlXZqr6Oat5TU1pqnezdDtlYH/F9EMtyA0GTpbLP/31Y3MS
         8aBhu+N7Ys6ghpyB4fLcwYNCi5S/r0t8oT4WduXIaIcWWwNuKsCYotg0WaP6X9GHBF3u
         T9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698917374; x=1699522174;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA/E2i+Ma/zs7hTGUQgxU+16cmFggthc6jA3MYA8DS8=;
        b=Llt+9z8JcDH4CX6zR9hqg2ZDoZbbtQNd5zJ66Ad3N6/gPJjPnpV14IPOfQk6FuW/Je
         Wxq4NkNKc4Hc58n93dw6knPaie+JMlNlzRBp3d9ucyqM2i6WMTIuYI8ptFRVOd1WpKNx
         Hn02E655CDdO/MfX4MTuJxm4BZLggsDEEG0vyW0DhBy/iLpac7V0Nwv7hcuQkE+p8btI
         9dr6FeMILwLeByaF3th6XO//zAyx8Fy3axVAMZjBCh8g7WXMj9+EqG/xbnbrq3P8grKo
         cngvlwczOT04XkmiZb5sTGvMNGqsGPWFsCLWPUPwP7FGTlo3oxClj8SN1HufN15y1v4R
         uv3g==
X-Gm-Message-State: AOJu0YymyvqP3ernRJr4cAHFc2Xv6E4rFYudTXGF5BvC55KVbpv672VO
	G/DEBtle9anmj+3/mq15emgvRQeOPkPfiJKE0hk=
X-Google-Smtp-Source: AGHT+IEhCgsPOu13+myWYcaM+8LzvXmE+39+IKRj21JtMd7IJ17jk4NcSdZtchzYk5pQ+F0u+womtI9W/8BV+yV8uV8=
X-Received: by 2002:a17:90b:1d8e:b0:280:4af4:1a41 with SMTP id
 pf14-20020a17090b1d8e00b002804af41a41mr7570444pjb.15.1698917373894; Thu, 02
 Nov 2023 02:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231101192419.794162-1-sandals@crustytoothpaste.net> <20231101192419.794162-2-sandals@crustytoothpaste.net>
 <xmqq8r7howsq.fsf@gitster.g> <CAN0heSrv7MPcEwkq4uEtv9uBbqm4FLKQLE3gdsEbqKkxPXOj5A@mail.gmail.com>
 <ZUNpVyQYUT8TA6An@tapette.crustytoothpaste.net>
In-Reply-To: <ZUNpVyQYUT8TA6An@tapette.crustytoothpaste.net>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 2 Nov 2023 10:29:22 +0100
Message-ID: <CAN0heSot6a5fabjh7NPdWhCBoUcDDpNmV0ovJ0bby1mpw8M7YA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] git-merge-file doc: drop "-file" from argument placeholders
To: "brian m. carlson" <sandals@crustytoothpaste.net>, =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Nov 2023 at 10:18, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-11-02 at 08:53:36, Martin =C3=85gren wrote:

> > Hmm, yeah. Or just "three non-filename arguments". I do wonder: doesn't
> > this mean that the second patch could/should possibly move away from th=
e
> > notion of "object ID"/`--object-id`? (That's not trying to shift any
> > blame from one patch to the other, that's my honest reaction.)
>
> Not specifying an option would make this ambiguous.  What if I have a
> file named "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"?  Is that the
> empty blob, or is it that file?  Normally we have ways to disambiguate
> this, but those don't work here because of the positional arguments.

I didn't intend to suggest dropping the new option altogether, sorry for
being unclear. I meant moving from `--object-id` to something else, such
as `--blob` that you mention. Completely agreed that something explicit
is needed here and that heuristics aren't possible.

> I think the name is fine.  We don't typically use the phrase "blob ID"
> anywhere, but we do say "object ID".  We'd need to say "--blob", but
> I'm not sure that's an improvement, and I fear it may be less
> understandable.

Agreed. Thanks.

Martin
