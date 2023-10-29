Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD353A4
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2ErF/zl"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC20CF
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:44:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507e85ebf50so4778180e87.1
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698561855; x=1699166655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QGv+6tw1foJKJOFWfLRPZrCXcTxii9aA2DotA2a2fY=;
        b=d2ErF/zlKvJq4IYxeayFBKOEz+qVlpuD61qqDBfPYJyCjrxfAjsYmL6VFnrUSrl5Qf
         EJs4UZiSjyYf47M96JTHOsPSVIvffCZ815Cbe8xWqNU/9gpOHzIA9qmojEXM7hEvybdk
         /3nRuBENWtZLopg12s7uO7klNb+rBPqtCDC0IEMflERLdJHhIspE6wsT3jQoBSp2lX4z
         inmXdNiZMx+tos8DTYOdzTSQB11MnmZzl0ZsiAO4TsmAsMUsOo56Mg36dYPcfOd2PR+j
         bSXLDOTW0GThXau96sBRXCB22XiBt6C1IXgowHghvTwIf/p3ChddTjeLXo0t/fSBnk8L
         jEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698561855; x=1699166655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QGv+6tw1foJKJOFWfLRPZrCXcTxii9aA2DotA2a2fY=;
        b=XNqOgtsLS6J0G9wXYdt1X/v1srBKamva3yGYyVnzKBJdkIZJaSFPa29hlRSMN39yxn
         E1tk4mAhgdocwc/8L11+b+lNrGlgyp4ES9TYsMHHTxwJq5Pcbk9/81LAN2nfuraamB33
         YTcah/8hh+Z/rpHA1sVBhuFnrmJc510PTuID5OdppCjp2n1SGE6yotyPZtQnf6dnCAsG
         uSGAgv27aTtK8ePgOifLv2Lj3oVePNdbKlv9hRJvppdsBtffJ2RppuWg2FYWHEiG+jZc
         btxKizAfl47GKnotqvEG0dDOzALYxjTqPhn65F9zi2LSC1FupM6nTBt9QwhCs/erEsVL
         PS5g==
X-Gm-Message-State: AOJu0Yx12dYbiLpNjbriAXijRwmieNYXLt5MoyWvShFLdibgd7m2g6I6
	Uq7Zix2/XR6Ikmh3vYPUW+SCAhRrYO7zN/OwVXI=
X-Google-Smtp-Source: AGHT+IHa8pkElIuZxDmBJD7qpAF+hHbA4NseIlrRhrNLFEjRQ3nRvHHiYSobyr4cU65Ya9vwyzZnUSafVNZu1yYl80k=
X-Received: by 2002:a05:6512:401b:b0:509:e5e:232a with SMTP id
 br27-20020a056512401b00b005090e5e232amr2542977lfb.42.1698561854731; Sat, 28
 Oct 2023 23:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g> <ZSouSI_zPusOefsv@localhost> <CABPp-BEg6vxiUpcJAG_=KB_sTrVgCF19JZh-+ZGCTPXdbo9ekg@mail.gmail.com>
 <B088FC28-BE30-424D-9CDD-7A53EDFC1710@icloud.com> <xmqqmswjsv8c.fsf@gitster.g>
 <918D0772-CDEE-4892-828E-BD8A06C3F1F4@icloud.com>
In-Reply-To: <918D0772-CDEE-4892-828E-BD8A06C3F1F4@icloud.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 28 Oct 2023 23:44:02 -0700
Message-ID: <CABPp-BGZHUQz5Bnd1oUptKC_j680Vz0zykEGgXw+89W3Tv6hmw@mail.gmail.com>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
To: Sebastian Thiel <sebastian.thiel@icloud.com>
Cc: Junio C Hamano <gitster@pobox.com>, Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Mon, Oct 23, 2023 at 12:15=E2=80=AFAM Sebastian Thiel
<sebastian.thiel@icloud.com> wrote:
>
> On 16 Oct 2023, at 8:02, Sebastian Thiel wrote:
>
> > I don't know if this time will be different as I can only offer to impl=
ement
> > the syntax adjustment, whatever that might be (possibly after validatin=
g
> > the candidate against a corpus of repositories), along with the update
> > to `git clean` so it leaves precious files alone by default and a new f=
lag
> > to also remove precious files.
>
> I am happy to announce this feature can now be contributed in full by me =
once
> you give it a go. This would mean that the entirety of `git` would become
> aware of precious files over time.
>
> To my mind, and probably out of ignorance, it seems that once the syntax =
is
> decided on it's possible for the implementation to start. From there I co=
uld
> use Elijah's analysis to know which parts of git to make aware of preciou=
s files
> in addition to `git clean`.
>
> I am definitely looking forward to hearing from you :).

So, we typically don't pre-approve patches/features.  Junio described
this recently at [1].

However, starting things out with an RFC, as you've done, is certainly
a good first step to gauge whether folks think a feature is useful.

Occasionally, when the feature is bigger or touches lots of areas of
the code, people will even write up a design document, and first get a
review on the document, which then streamlines later reviews since we
have some of the high-level aspects agreed to.  Some examples:
  * Documentation/technical/hash-function-transition.txt
  * Documentation/technical/sparse-checkout.txt
  * Documentation/technical/sparse-index.txt
Each of which are in various stages between "these are ideas we think
are good and our plans to get there" to "most of this document has
since been implemented".  There are others in that directory too,
though not everything in that directory is a planning document; some
of the files are simply documentation of what already exists.

Anyway, creating a similar planning document and covering the various
cases I mentioned would likely be a very useful next step here.  I did
note that multiple ideas have been presented in this thread about the
syntax for specifying precious files, and it'd be good to nail one
down.  It would also be nice to see proposed answers to the several
cases I brought up (some of which Junio answered, others of which I
also have potential answers for so I could potentially help you craft
this document, and a few others that someone else would need to fill
in).  Sometimes we also want to cover pros/cons of the approaches we
have decided upon, in part because others may come along later and if
they discover a new pro or con that we haven't thought of, then we may
need to rethink the plan.

Hope that helps,
Elijah

[1] https://lore.kernel.org/git/xmqq8r9ommyt.fsf@gitster.g/
