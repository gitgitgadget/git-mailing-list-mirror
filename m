Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F963C47D
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK1hSfzV"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbdb12203b4so4326982276.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704983015; x=1705587815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX+CaAgbYtqusZWRIiSPKF962kz+mLoqHvPmaYoln/o=;
        b=DK1hSfzVKWqDpsvbDejnHEIbtMbIrly+YI5mkY+EuWFEiEizpjMtBeTTqcCiwJ81Oy
         LxCiAe0kV0PhUwkLc8X5nkMCnSaWZ39ypZWMDW71M2Wm0iXoE6QHXpYR8jGcyzLCWfpZ
         fbl6guJUgK07wsD1mXzTbvi+LNpiLdHraeVEpEoLgfcnHdkXTzN82s8ouNgo5k+YWLII
         KMJk97tM2583bdckHSI8gQLgJ1qWzRvBzdRfuXrNbRFE/NiI7U7sh3LtX7bzv7h9qS4o
         SB7/FUdwImVxGoS93BfecAuax8mAIiiSOF6IENQqE3d0Br6eJHuUUO6P77TO1tvW9AiE
         1fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704983015; x=1705587815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX+CaAgbYtqusZWRIiSPKF962kz+mLoqHvPmaYoln/o=;
        b=FvBf0dh16BVa/uCtM8EBKAuFJCbWRdAd8lwVJHBD2Re8otX6M+Q19Ow6Uh+ekbjSEF
         PApNhtZu9eqexNfv0xafqRtU01UApQn43gBcJSsJPhWys67xghHjAG8eSUizyPRu82Gq
         FSyGUl1MJ6jnWuntx+wwxlb8ARRMDayeFePGYcWtLXvnE/bM5Gh1hsKVLaXHlWOVFlcS
         BYiyKRzP+MqV1YluatkJwVNOEzHgxIzN0qcd6l464XLR14Ybzc2BPCIgDISBRV7VYbQZ
         /pS/JrCDYJfRb69FRbZtfe9t3eONvnU2XkIThpyUnMecxFntsC7U62IGYS2JP+JXA/Ox
         dLVQ==
X-Gm-Message-State: AOJu0Yz8KKbs0LPgiF8tBwaphvvFvOhQk0Q90AZ+XotXHbNwAnwsoHAm
	/+uujX5lhJA7pP0grUUICEMNdXWsQSkbI7gI7EUoZMtuips0jA==
X-Google-Smtp-Source: AGHT+IFcNYVP8xoif86kKNG9vYtHGNVbE1XvQ5ySB0GbUpwoWUKElh/MBuoY59UFCkUr1W4SO+uxcb//i20rzQXwmOQ=
X-Received: by 2002:a25:aa01:0:b0:dbd:9887:e185 with SMTP id
 s1-20020a25aa01000000b00dbd9887e185mr1171906ybi.90.1704983014856; Thu, 11 Jan
 2024 06:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAnif95ux=vCNCKbVw0q_vYamQRkbFqSa9_-u6xRvK6r+2a+Q@mail.gmail.com>
 <CAP8UFD30h7D7D42Eiq3sk97v_ef8hi=K1qdy2wRczQ18JM++LA@mail.gmail.com>
 <CANAnif90Bqp2pWCn_71t-Fss6wspo+==vMdYsX+Wt5m=4Ocpng@mail.gmail.com>
 <CAP8UFD0ELy2WegVYdxi_O5UpHS4MyOPp4tuAQK+XvvNmABc2ZA@mail.gmail.com> <CAP8UFD3e=Zv2wkx5tswCz05Vwn3vD68Vw-TD6SoENWK+norYsw@mail.gmail.com>
In-Reply-To: <CAP8UFD3e=Zv2wkx5tswCz05Vwn3vD68Vw-TD6SoENWK+norYsw@mail.gmail.com>
From: Sergius Nyah <sergiusnyah@gmail.com>
Date: Thu, 11 Jan 2024 15:23:22 +0100
Message-ID: <CANAnif-hWovPnRmSy0pnEJnA274vwiSAkRexstGQdQJ4u-5+pw@mail.gmail.com>
Subject: Fwd: [GSOC][RFC] Add more builtin patterns for userdiff, as Mircroproject.
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, Jan 11, 2024 at 11:51=E2=80=AFAM
Subject: Re: [GSOC][RFC] Add more builtin patterns for userdiff, as
Mircroproject.
To: Sergius Nyah <sergiusnyah@gmail.com>


On Thu, Jan 11, 2024 at 11:48=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jan 10, 2024 at 9:10=E2=80=AFPM Sergius Nyah <sergiusnyah@gmail.c=
om> wrote:

> > > Okay then. I will add support for shell, as it was primarily suggeste=
d
> > > in the idea itself.
>
> As Bash is a shell and is already supported, I am not sure which kind
> of shell you want to support. There are other shells or kinds of shell
> with different syntax that might be worth supporting, but then you
> might want to tell us which shell or which new kind of shell.
>
> Thanks!

I've definitely learned one more thing. Thank you!
Also, after taking another keen look at the Patterns defined in userdiff.c,
In accordance with what you've said, I realized that Kotlin isn't
supported yet.
So, I'd begin working on it.
Thanks!

By the way I realized that you replied privately to me instead of
keeping the mailing list in Cc: This made me reply privately to you.

Thank you for the correction Christian. Noted!

I think it would be better if the discussions were all public as this
way others could give you their opinion on this.

Definitely True.
