Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329EC18E23
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTEvgOXl"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466BDD7A
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 07:48:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a98517f3so4677049e87.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698072481; x=1698677281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPVrnpNpiOblV3Uw3lRo4m6/ic2m9xyL5/1sjC2HLMw=;
        b=OTEvgOXlIEgfWkgDmGo9XzPNUn3L3DOeHMFUuccUPNMcFPX1O9tw/0Bf4Wo+mE9e6F
         vKfE6p+du9k+e6qtEloqU1weLL/jkBRmqmXYO3WRPYminB5SZO1RtgwHA1tr4nuy0gpZ
         PDbtTbFd0+fUNa61ghHUysZYa/VhPwIm5U9nb4xZptd0g3zdhPxwo2fXn+EIvWD01xQc
         DemMKnRCB3ndQfMqsydcooW6t4pjz+IkMD30RH2PB3xQzED8Pzfnny/yL50npgr+RjOH
         fLA/wIYVjwpE0g2QYD2OcyCJ+uM6GZ9NswOAxbe5fTMMrVNMuDiq8QNKTkMZsFyZ/5v3
         C2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072481; x=1698677281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPVrnpNpiOblV3Uw3lRo4m6/ic2m9xyL5/1sjC2HLMw=;
        b=Edt1bPUE9kENjuG2N9R1pE4Yu+MwF7UNXnqkP0Od3zSeoiP3xYrQ2KfGC9UHOJz9uz
         hR+VAetrTHqTqUfNrWNNuik4OveZ6SwzYCGVqMoz6/Keo5OstxoJkPM/SalGFCX6e/Tj
         gjtrp+xAKSruTvmI67VcVDJkdvt7g3/42P2PDDmk1RNMfiW1dYTCU/Ww4A/5sr8OdVtq
         RxJFP5ElUUbMxcUf8Ss9vGCEXBJYUwzLpDlX2OQGCtFF6s3q3vDtDq2Y6NhWzwoNShBK
         o3qYCTuktqVD1OYFiQqTSlzwFOV0sW+hX4suudnizy4i5pJ47Jvr6cZUZtpzuii+A155
         3yew==
X-Gm-Message-State: AOJu0YxYkC3gekAtLQx8Qyn1FYYfza5Oy8ea+4f5OykOeRIi1m/9b75f
	2nAiNwt5OK/s81dCx2/jjA9cieV8estrpkEE+yy502K0krBF5g==
X-Google-Smtp-Source: AGHT+IFzvd0TgUegEAxos4hmCXTRJOJd6x4MuMe05KUynXQj7lDgGRVDcdi4FL93i5p6acmGZOGkrojcGft9RF7UM2s=
X-Received: by 2002:ac2:5311:0:b0:507:a1e0:22f4 with SMTP id
 c17-20020ac25311000000b00507a1e022f4mr5933317lfh.29.1698072481117; Mon, 23
 Oct 2023 07:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACS=G2zPH4+R6L8bQ8w=b8u1i6Zsj6xwMibghPKzPX7oGko_tw@mail.gmail.com>
In-Reply-To: <CACS=G2zPH4+R6L8bQ8w=b8u1i6Zsj6xwMibghPKzPX7oGko_tw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Oct 2023 16:47:49 +0200
Message-ID: <CAP8UFD2EXVmHb88rch0zsyA0v7vkitYVcONzJzGVc-DAVBvgyA@mail.gmail.com>
Subject: Re: Outreachy Internship Project Timeline
To: Naomi Ibe <naomi.ibeh69@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 7:17=E2=80=AFPM Naomi Ibe <naomi.ibeh69@gmail.com> =
wrote:
>
> On the Outreachy website under the "Final application section", this
> statement appears:
> "Please work with your mentor to provide a timeline of the work you
> plan to accomplish on the project and what tasks you will finish at
> each step. Make sure take into account any time commitments you have
> during the Outreachy internship round. If you are still working on
> your contributions and need more time, you can leave this blank and
> edit your application later."
> Is there a link to where I can access the project timeline and
> subsequently edit it?

We don't provide a timeline. Providing one is part of writing an
application for the project and I am Ok to work with you on your
application by reviewing it.

I recently reviewed Isoken's application, see the thread starting with:

https://lore.kernel.org/git/CAJHH8bEfM8KmwhHX_Fmcb0A2zpr8L75vgNhfvZy-uitpSX=
NUvQ@mail.gmail.com/

and Luma's application, see the thread starting with:

https://lore.kernel.org/git/CAFR+8Dz717pcc2Lm_J29xxiBt-kUrMP4JAUbm=3D3XaJuJ=
PYseHg@mail.gmail.com/

Hopefully my comments on these applications can help you get a better
idea of what we would like to see in your application.

See also https://git.github.io/General-Application-Information/,
especially the "Application (required)" section, about what should or
could be in your application.

Best,
Christian.
