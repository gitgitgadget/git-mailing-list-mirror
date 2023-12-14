Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD99B0
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 19:33:13 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-425fbac8fc7so2979241cf.3
        for <git@vger.kernel.org>; Wed, 13 Dec 2023 19:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702524792; x=1703129592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjAKlPlMxxTpxxbgRnknSsdSmrhHNsEWsVx3CB7evjk=;
        b=dKknMxKUmNGdAaeFmp/6/2PY3i3uv0fX1sese7+3IamsnvrEMa9VWPTejsUckIYKFN
         j20Gzy/G+nml+DKLwabT1Naqfuk+qSwEjD0C1DhvlwQcQbWx38MIVgbHhdMmNCfyWdIK
         UbCkZgWIukdvOmQnUianqZTZRSmJXdy3u4vdaX0sewvocTuE6mc8PU8kwjluNEl7Q0CD
         +I8IgPEleF1v+nx0oT5YK0Dz8+qFv18tb49E7XpxNfh8n9p50pMd+CZ6u/n44kkmyguq
         sosiJO+oey85fSbTI/0K5ic0IgnQ4laEjtmnE7E7/atF6YyNL6VrOByDSv00J5+fU8/g
         yyJw==
X-Gm-Message-State: AOJu0YzdMvDQ+/3quV5IvdsgEePQeHiTjdEwOs+HLj00+wumuG/tXIcY
	h7nrtAuH1jAfXpRkce4f9n44fFxh0LvMONvax1o=
X-Google-Smtp-Source: AGHT+IFVkuqoJ9NEx62PBTFV9Jd+Sclckliqk2a0HhRChXJh7YE+Xbm4xSeeEw+aS9M1ddpbhtct6Ve3IJyA7htRI8c=
X-Received: by 2002:a05:622a:1352:b0:425:89f1:e98f with SMTP id
 w18-20020a05622a135200b0042589f1e98fmr12884252qtk.126.1702524792148; Wed, 13
 Dec 2023 19:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <xmqq8r5zrzg1.fsf@gitster.g> <ZXlbNlG28e1sAYPU@tanuki> <xmqqr0jqnnmn.fsf@gitster.g>
In-Reply-To: <xmqqr0jqnnmn.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 13 Dec 2023 22:33:00 -0500
Message-ID: <CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com>
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> I do not think "prefer host Git" is necessarily a good idea; falling
> >> back to use host Git is perfectly fine, of course.
> >
> > Why is that, though?
>
> Mostly because your "differences in features supported by just-built
> one and what happens to be on $PATH can cause problems" cuts both
> ways [...]

I sent an alternative solution[1] which should sidestep this objection.

As usual, I forgot to use --in-reply-to=3D<this-thread> when sending the
patch, even though I reminded myself to use it only a minute or so
earlier. Sorry.

[1]: https://lore.kernel.org/git/20231214032248.1615-1-ericsunshine@charter=
.net/
