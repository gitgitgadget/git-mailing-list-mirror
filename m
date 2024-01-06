Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FD6FBE
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMaqyc4t"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so370511b3a.1
        for <git@vger.kernel.org>; Sat, 06 Jan 2024 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704542843; x=1705147643; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqHmc6QVuOGEIDkwn2bRc9/O6+KzSGiHGqmBZGc4lhY=;
        b=lMaqyc4tN7w7cuQ6kVICiAZRAgc+go3Eseyn/5jE3xTuCIUf/inZJ18efj2dmy5IJl
         i2X2QTnCOTgbSaGXCFidk2Ed4ACZRt2P0KEex94ga+/lCFeDjGML/G4l2vR5va+aYZMP
         VQ6ctPLRuHxSsGjycsSBcZeYAoiDO2oA1pZU8/rF7d6rVnbWnWlLj67WxNXpo1YAsW0r
         oPrppFlX2JgGj3xpk0mvOvCNVoRkuyuYEneYS1ldTqqDwXex8ip5D7npPs2bCiQ/Tc3Z
         /4rZ2L38/IkAj7hLsq5Z54s29BCtm76ETgIfAJmeo7Yzghd+Jqzc6hDj6+ckvWhOMLAo
         +C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704542843; x=1705147643;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YqHmc6QVuOGEIDkwn2bRc9/O6+KzSGiHGqmBZGc4lhY=;
        b=Y2P0fWBg3zPWtjn/oFuIrDLLeBZ9iFPRLsQaT7zdzLAu5bvxhtFijFrVivVEPoIgXV
         0rmWor/2WIbAJXXMktvMx05ksio0hclTcA1CLEL2hTngJeWpPypOnyIhfu0kSQIwJBXk
         A+/Yr1F0hxl1Pad81cyb4AfOX+fwiqhej/3bDDHdhTkLTAIYuuy9az/5EsBuERmIYdPk
         vC0RrGvMIemPQ2bLk143kka0jdWqzgvwe+BvRqx0sk5ofy6GqlIi5FkNtgW2o5E39Dc+
         wIuF0WMTto3YdqQuHLy0YvVxvPpeiQPx2m3cTOZ4sYG5nGZV4mllisQSSUlcBy5d+OsD
         OaNg==
X-Gm-Message-State: AOJu0Yxtj6GrLax+UqCpBBBfCSBTknK1nNj9jiEk/eZb1ClBMqbuP4xQ
	VoLv+HW3AXlDjfy0BMeJceY=
X-Google-Smtp-Source: AGHT+IFeo2A1QChyry2Kzq1lM+DIvNGIEo0WacRyOtYo/hQqZE+4hPQmgEDiLKiseTvG5gJA6eiY1w==
X-Received: by 2002:a05:6a00:1acd:b0:6d9:c1d6:c5a0 with SMTP id f13-20020a056a001acd00b006d9c1d6c5a0mr1088042pfv.53.1704542843192;
        Sat, 06 Jan 2024 04:07:23 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id j5-20020a056a00174500b006da8f6650a2sm2917938pfc.155.2024.01.06.04.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 04:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Jan 2024 17:37:18 +0530
Message-Id: <CY7M09XT547N.2OOTI5APX9RIX@gmail.com>
Cc: "Christian Couder" <christian.couder@gmail.com>, <git@vger.kernel.org>,
 <johannes.schindelin@gmx.de>
Subject: Re: [GSOC][RFC] Heed core.bare from template config file when no
 command line override given, as a microproject.
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Elijah Newren" <newren@gmail.com>
X-Mailer: aerc 0.15.2
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
 <CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>
 <CABPp-BH+cPdfsctquE60tw_nD6_LCaWf0JwGusuZ0tvQQuWy4w@mail.gmail.com>
 <xmqqjzonpy9l.fsf@gitster.g>
In-Reply-To: <xmqqjzonpy9l.fsf@gitster.g>

On Fri Jan 5, 2024 at 9:29 PM IST, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > If you look back at the mailing list discussion on the series that
> > introduced this TODO comment you are trying to address, you'll note
> > that both Glen and I dug into the code and attempted to explain it to
> > each other, and we both got it wrong on our first try.
>
> I think you meant 0f7443bd (init-db: document existing bug with
> core.bare in template config, 2023-05-16), where it says:
>
>     The comments in create_default_files() talks about reading config fro=
m
>     the config file in the specified `--templates` directory, which leads=
 to
>     the question of whether core.bare could be set in such a config file =
and
>     thus whether the code is doing the right thing.
>
> But I suspect the all of the above comes from a misunderstanding.
> The comment the above commit log message talks about is:
>
>  /*
>   * First copy the templates -- we might have the default
>   * config file there, in which case we would want to read
>   * from it after installing.
>   *
>   * Before reading that config, we also need to clear out any cached
>   * values (since we've just potentially changed what's available on
>   * disk).
>   */
>
> This primarily comes from my 4f629539 (init-db: check template and
> repository format., 2005-11-25), whose focus was to control the way
> HEAD symref is created, but care was taken to avoid propagating
> values from the configuration variables in the template that do not
> make sense for the repository being initialized.  The most important
> thing being the repository format version, but the intent to avoid
> nonsense combination between the characteristic the new repository
> has and the configuration values copied from the template was not
> limited to the format version.
>
> Specifically, the commit that introduced the comment never wanted to
> honor core.bare in the template.  I do not think I has core.bare in
> mind when I wrote the comment, but I would have described it as the
> same category as the repository format version, i.e. something you
> would not want to copy, if I were pressed to clarify back then.

Then I suppose this warrants updating the TODO comment in
create_default_files(), which currently can be interpreted as this=20
being a unwanted behavior. And also amending the testcases which
currently display this as knwon breakage.

> Besides, create_default_files() is way too late, even if we wanted
> to create a bare repository when the template config file says
> core.bare =3D true, as the caller would already have created before
> passing $DIR (when "git --bare init $DIR" was run) or $DIR/.git
> (when "git init $DIR" was run) to the function.
>
> If somebody wants to always create a bare repository by having
> core.bare=3Dtrue in their template and if we wanted to honor it (which
> I am dubious of the value of, by the way), I would think the right
> place to do so would be way before create_default_files() is called.
> When running "git init [$DIR]", long before calling init_db(), we
> decide if we are about to create a bare repository and either create
> $DIR or $DIR/.git.  What is in the template, if we really wanted to
> do so, should be read before that happens, no?

That is what I proposed in my original email, after which I had a
working solution which passed all the tests. That solution was indeed to
check for core.bare in the template before we set GIT_DIR_ENVIRONMENT,=20
which subsequently creates either $DIR or $DIR/.git as you described=20
above.=20

Regardless, I can send the patch with updated comments to clarify
that ignoring core.bare from template files is the intended behavior and=20
amend the test_expect_failure testcases, with Elijah's consensus.

Thanks.
