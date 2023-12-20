Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3646431
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDllX/8b"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso7419052e87.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703089520; x=1703694320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX9AaqWpMbBCaaMi/8cvCj1TFJn+L+R5w2JpZoYTDJY=;
        b=NDllX/8bxM7VcLiNGbki56wYh9Kf6K6FJot/H5DHllG5Juvuy5kmeR3VNf/VPgbadA
         k87Clf5KtFtP6DXfQDlLAF05cODMs+xFa59buRhbQ4NZ2DK7lJ0BbmsO7Qz/13kQX9wc
         2un4nqjn1Cqo3kxy61MRLaNno+8GO+Dgx3XDbDLSeSA9cwu1PlhELD7YPEj23CdetHuX
         iG+/WlJmXQWGuRFNWje3HS7W92BkYELwYhRtyI2TQ9vqPkNxzVvecyPdabUl5Yx/SuQc
         6ylY6vqBoT7hxxsrJZxltQLv2IYDTDcSE8rJUAZjUo3iotvAKzahvk8RkLHn/8REgnAo
         lq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703089520; x=1703694320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eX9AaqWpMbBCaaMi/8cvCj1TFJn+L+R5w2JpZoYTDJY=;
        b=fLXfT94jsPnw46eZEp+hpLtEYybhOcQ0MhkKGP/Sol1K1XslqlBqm5JFt5K1bwcHQt
         aBLj6WJT0Qv+ElTkHZRkMSHq31mOKCRkVcZBsH1A/u/UJLV1nSA8u1jCahugeWq39L9o
         en1Dh7Q+52Pi69lvHUJtjBAN8A7X0YcXCNvNB0vIKRBEh8WSmtSRNKlaFav3JkhMt8F8
         7Rt17LaCRjhys+c/Fv9nZjViLgmM5IlCixMfFynOARj1CsKPld7lUTdbvZo8t5XFzmW0
         AG2QQ2xzLifultUqQg8gH/ecsEJzS3o1eLFL1tJYSEn//9jduQWu8tO6hjj9LZ7+ioBX
         mAHw==
X-Gm-Message-State: AOJu0Yz1LFpJaMZql82QJQScbocfxpLyX0KiYzbtv22yyiirr/XGWeo5
	km8N0t160eSMoZKMCSwq1jZfmdHxfPAZMIAWL0T5++2W8TY=
X-Google-Smtp-Source: AGHT+IF29fS84XP9M7rTQxw5nZZrbyAheDfhMoewMXwKnk7HcEGQmIJR7wD9yLJlh+vlfgMb4RedlUiohVt0LuBBeBY=
X-Received: by 2002:ac2:4e07:0:b0:50e:1943:e8e5 with SMTP id
 e7-20020ac24e07000000b0050e1943e8e5mr6439712lfr.136.1703089520148; Wed, 20
 Dec 2023 08:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <043d2a24202d39c5564e4a4369c86ae4648dd721.1702975320.git.gitgitgadget@gmail.com>
 <e788cf7b-56c7-48c2-ad4f-65d9c9e73ad5@web.de> <CABPp-BFU+4Xy8tVrU5qV3GX7Mr3-nOEtSgix3MSne5VVW2hz2Q@mail.gmail.com>
In-Reply-To: <CABPp-BFU+4Xy8tVrU5qV3GX7Mr3-nOEtSgix3MSne5VVW2hz2Q@mail.gmail.com>
From: Josh Soref <jsoref@gmail.com>
Date: Wed, 20 Dec 2023 11:25:08 -0500
Message-ID: <CACZqfqCM88M+saToOYVC7iXqFZdrivuq=KGLmh-Scx3H0ZSWrw@mail.gmail.com>
Subject: Re: [PATCH 6/8] SubmittingPatches: clarify GitHub visual
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> wrote:
> On Tue, Dec 19, 2023 at 6:44=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> =
wrote:
> > Am 19.12.23 um 09:41 schrieb Josh Soref via GitGitGadget:
> > > From: Josh Soref <jsoref@gmail.com>
> > > Some people would expect a cross to be upright, and potentially have
> > > unequal lengths...
> > There are lots of types of crosses.  And while looking them up on
> > Wikipedia I learned today that an x-cross is called "saltire" in
> > English.  I only knew it as St. Andrew's cross before.
> >
> > > GitHub uses a white x overlaying a solid red circle to indicate failu=
re.
> >
> > They call it "x-circle-fill"
> > (https://primer.github.io/octicons/x-circle-fill-16).

> > > diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
> > > @@ -604,7 +604,7 @@ to your fork of Git on GitHub.  You can monitor t=
he test state of all your
> > >  branches here: `https://github.com/<Your GitHub handle>/git/actions/=
workflows/main.yml`
> > >
> > >  If a branch did not pass all test cases then it is marked with a red
> > > -cross. In that case you can click on the failing job and navigate to
> > > ++x+. In that case you can click on the failing job and navigate to
> >
> > In the commit message you say the x is white, here it's red, so what is
> > it?  IIUC the circle is red and the x-cross inside is the same color as
> > the background, i.e. white in light mode and black in dark mode.  No
> > idea how to express that in one word.  Perhaps "red circle containing
> > and x-cross"?

This was an oversimplification, which I deeply regret.

It uses a simple red x (=E2=9D=8C) in some views, e.g.:
https://github.com/gitgitgadget/git/pull/1620

And in other views it uses a red circle with what's actually a
transparent x (white at the top if using light mode, gray fill if you
select linux-leaks on the left, and dark gray fill in the log view):
https://github.com/gitgitgadget/git/actions/runs/7265353611/job/19794849212=
?pr=3D1620

> There's an "and" vs "an" typo there, I think.  I'm tempted to just
> oversimplify ("...marked with red."), but am slightly concerned about
> red/green color-blind folks.  I suspect they'd figure it out anyway by
> comparing the checkmarks (within green) to the x's (within red), but
> if we want to be more detailed, perhaps we drop the "cross" altogether
> and just describe it literally: "...marked with a red circle
> containing a white x."?

Your text aligns with what I drafted as a response but didn't send:

I think it's simplest to say an `x`, or maybe "red color and an x".
