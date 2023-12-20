Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F033FB33
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBI+rj5d"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so902991e87.0
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 07:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703086837; x=1703691637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efmlZqUOdCJ/aFHOhpgtJ7dCnZ1bEujkOAguAmzkAhM=;
        b=SBI+rj5dcxyEoBI0kwHgwUorNl0eS0QoLNVFnY80kl0uSkWAhnL2NXVGfja6lItBvu
         Y34701Y7g/98iZRQThO08tpVlGDHXiniMXPuFZtJkIm5EnlBUMFtoLYoIQhXpzL6eEPK
         F+eHje8lxY1E9YGGYh9aB/V7E4FoCSYUudSPiIKKYQy4j3Amlf1QiExqeHDzwmbeBPFJ
         WybKlgFz73COAoSgOGAg2mbkr6HIRxwcZ5mJt8FypuSz2Oy7FfR9BJIYij2Y1t6bLABv
         vdn3zUvypxhbe1RzW89HHzlzABE73ZeueYAWd7Nuxw7tvfI2ddbqduoSEV9ZJTw8gBTk
         lH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086837; x=1703691637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efmlZqUOdCJ/aFHOhpgtJ7dCnZ1bEujkOAguAmzkAhM=;
        b=jHSwiUS0Ntm/ONTFoceiWTuV6eKRRI7XX9vV0j/D3j0l0fcGa/iwStNrlPMwlSHeCI
         kACJNMGhnMKjIQQk5Uk/qEvAgUCZc8/YvRT3VqClGrmG3h83nW1DIjmdkEpVF+syNoXr
         igBbZ0YHnbsKEOwiR+HyXms9ImavFekEyELP88YsJ9GiXPLY7RXKASpDJGQnfCWyhJQD
         DpGJUcncU35CX/uZCXXaOzMQpFUrs+/8RwuPOy6g9DmClPJjWgEpkWucMSgZbGUvJYuf
         6DFElIixpXVHxWL3V83A3cnMaYvw0HxrmBde08Bb+KibH689HpGVfA4IlS6bhil5JU5V
         9UPw==
X-Gm-Message-State: AOJu0YyezN2xmuAFHd9mo/SNF7G4Q5zq2Pxl+b2lh02cB4650XI/PamZ
	4i6GtpZDcWEVTVq0dFRqGNVEEcElwsio8WdpAKM=
X-Google-Smtp-Source: AGHT+IEC6A6MILHBF69N3sw7LZUd4nCL+VGmQWuqDQ/Ai39NMidh+6sMH5hhP2vgV437VCGJlJCwtYfSUIPkErE3gjA=
X-Received: by 2002:ac2:4ed1:0:b0:50e:4b80:da01 with SMTP id
 p17-20020ac24ed1000000b0050e4b80da01mr1549128lfr.28.1703086837361; Wed, 20
 Dec 2023 07:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <043d2a24202d39c5564e4a4369c86ae4648dd721.1702975320.git.gitgitgadget@gmail.com>
 <e788cf7b-56c7-48c2-ad4f-65d9c9e73ad5@web.de>
In-Reply-To: <e788cf7b-56c7-48c2-ad4f-65d9c9e73ad5@web.de>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 20 Dec 2023 07:40:25 -0800
Message-ID: <CABPp-BFU+4Xy8tVrU5qV3GX7Mr3-nOEtSgix3MSne5VVW2hz2Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] SubmittingPatches: clarify GitHub visual
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 6:44=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Am 19.12.23 um 09:41 schrieb Josh Soref via GitGitGadget:
> > From: Josh Soref <jsoref@gmail.com>
> >
> > Some people would expect a cross to be upright, and potentially have
> > unequal lengths...
>
> There are lots of types of crosses.  And while looking them up on
> Wikipedia I learned today that an x-cross is called "saltire" in
> English.  I only knew it as St. Andrew's cross before.
>
> > GitHub uses a white x overlaying a solid red circle to indicate failure=
.
>
> They call it "x-circle-fill"
> (https://primer.github.io/octicons/x-circle-fill-16).
>
> >
> > Signed-off-by: Josh Soref <jsoref@gmail.com>
> > ---
> >  Documentation/SubmittingPatches | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
> > index d7a84f59478..8e19c7f82e4 100644
> > --- a/Documentation/SubmittingPatches
> > +++ b/Documentation/SubmittingPatches
> > @@ -604,7 +604,7 @@ to your fork of Git on GitHub.  You can monitor the=
 test state of all your
> >  branches here: `https://github.com/<Your GitHub handle>/git/actions/wo=
rkflows/main.yml`
> >
> >  If a branch did not pass all test cases then it is marked with a red
> > -cross. In that case you can click on the failing job and navigate to
> > ++x+. In that case you can click on the failing job and navigate to
>
> In the commit message you say the x is white, here it's red, so what is
> it?  IIUC the circle is red and the x-cross inside is the same color as
> the background, i.e. white in light mode and black in dark mode.  No
> idea how to express that in one word.  Perhaps "red circle containing
> and x-cross"?

There's an "and" vs "an" typo there, I think.  I'm tempted to just
oversimplify ("...marked with red."), but am slightly concerned about
red/green color-blind folks.  I suspect they'd figure it out anyway by
comparing the checkmarks (within green) to the x's (within red), but
if we want to be more detailed, perhaps we drop the "cross" altogether
and just describe it literally: "...marked with a red circle
containing a white x."?
