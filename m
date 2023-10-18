Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFF335C2
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4/UuYYt"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64819109
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:48:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507973f3b65so8452502e87.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697633288; x=1698238088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTAoGher9nXxcZNfEVCyHysSuvp6hqRmAfCNZusln34=;
        b=S4/UuYYtAnxPOzoc9PqvCuT/hsc2L713kV+x/6KLnjO4E6gzNtjTcIpeona3ZUFaz6
         ZY7x1v6hf+mSNacN2aRWFIGZhAGBcWLul30kzvu14huAF2GFLaM56OO6iwFCuWQ/pJjw
         R8ru+MBAbGeQuw74TmwiyQr1V9Hf4wW8RUlH4bq8+eqbVqO7BCel0AE7+LLW+giigqGH
         aPj1BuJ5GH7YRC+eYk7YQf5xv6W/s0jg6Z7ApT+NnUaO/IRzudNATY2tJdMgfCHoQOXt
         r3Gde5fukwsu8mA581eZecLfoKOdBE8alWA+6AMkdhlgP8nARht9Ervr5DZcRYjEf9T/
         CMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697633288; x=1698238088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTAoGher9nXxcZNfEVCyHysSuvp6hqRmAfCNZusln34=;
        b=sbSnZYbyhcYjdvXKwcCpRMWl35oOgmbRlKzI+p4/vG+fnyHYtdBG2xlkJ4sjWmxuzW
         Op/Qw6faJDIvIWXe53lUypMmaJxJjpH6VcDO4C1QK0/1CFBIsLJ4zHJpYVx6qRX9WPBU
         834qYhk9gjTVaVzXqBJhBTVyF9dTSuEx3DMy+WRpCLmdj6R7CAI4AzQElvCYdRVnQrO8
         5K5B1+iwV0ltBCJup6EALS4sWlou4zfAujjqZodKp1nCZ9IQCJrab+D4Pl+vx6o212eU
         Hcl+Ccl4IJ5T83varmuxvVY24KPbDQ2/cYHA9jkHb/IbWFbeyN2sOYuXs1sWVwhQ9Q6d
         M1Mg==
X-Gm-Message-State: AOJu0Yy8SA9J2yg09Hwr/tVRW/8GoeEpwRrFaSo0MY5MMqg1d8YHCTBG
	zA89l7IuUkrWm9kmp0m6vtyHHgRivP2/8FXQyjsNef89CvtplkbF
X-Google-Smtp-Source: AGHT+IGQL8EfpqZN2NwfKFGSK/+AZdoUlRuewS+p5Z4mpSU+wnNn4TSGqJrAbG9D/giIrGtR0ZiVepwEliBxpehqBWI=
X-Received: by 2002:a05:6512:90f:b0:507:9ff7:2ed4 with SMTP id
 e15-20020a056512090f00b005079ff72ed4mr4029658lft.43.1697633288151; Wed, 18
 Oct 2023 05:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLTT8RzcENBx9NKffHReVKJAho89TCO7W2SPBX8sb2tEU84Gw@mail.gmail.com>
 <22688989-1b51-4989-b92d-5a5891ec9265@kdbg.org>
In-Reply-To: <22688989-1b51-4989-b92d-5a5891ec9265@kdbg.org>
From: ZheNing Hu <adlternative@gmail.com>
Date: Wed, 18 Oct 2023 20:47:55 +0800
Message-ID: <CAOLTT8Ti_HMtCKnag0dGk8jdRQ_7mtWys8f9U0gKjP9UzcVyag@mail.gmail.com>
Subject: Re: How to combine multiple commit diffs?
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Johannes Sixt <j6t@kdbg.org> =E4=BA=8E2023=E5=B9=B410=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=BA=94 00:41=E5=86=99=E9=81=93=EF=BC=9A
>
> [For general support questions, please address only the mailing list.
> It's not necessary to bother the maintainer personally. Though, I'll not
> remove him from Cc, yet, as to comply with this ML's etiquette.]
>

OK... I get it.

> Am 12.10.23 um 14:00 schrieb ZheNing Hu:
> > Hi everyone,
> >
> > Our company wants to design a "small-batch" code review feature.
> > Simply put, this "small-batch" means being able to treat multiple
> > related commits within a MergeRequest as an independent "small" code
> > review.
> >
> > Let me give you an example: We have five commits: A1, B, A2, C, A3.
> > Among them, A1, A2, and A3 are multiple commits for the same feature.
> > So when the user selects these commits, the page will return a
> > "combine diff" that combines them together.
> >
> > A1       B A2 A3 C
> > *--------*----*-----*-------* (branch)
> >  \ A1'        \ A2'  \ A3'
> >   *------------*------*------- (small branch code review)
> >
> > This may seem similar to cherry-picking a few commits from a pile of
> > commits, but in fact, we do not expect to actually perform
> > cherry-picking.
> >
> > Do you have any suggestions on how we can merge a few commits together
> > and display the diff? The only reference we have is the non-open
> > source platform, JetBrains Space CodeReview, they support selecting
> > multiple commits for CodeReview. [1], .
>
>
> Take a step back. Then ask: What are the consequences of the review?
> What if the result is: the feature is perfect, we want it merged,
> however, we cannot, because we do not want commit B. What if the result
> is the opposite? You need B, but you can't merge it because the feature
> is not ready, yet?
>

The CodeReview here is only expected to review the Diff changes
 (just like jetbrains Space). If it is truly blocked by B, users should
understand to remove B or cherrypick A1, A2, A3 into a new branch.


> You are looking for a technical workaround for a non-optimal workflow.
> If A1,A2,A3 are a feature on their own, they, and only they, should be
> in their own feature branch.
>

I have to admit that this is addressing the issue for users who are not
very familiar with the git workflow, as they might add 70 commits in a
CodeReview.
My goal is to enable these users to display the diff of multiple commits
that they consider to be related together.

> So, I would say, the best solution is to reorder the commits in a better
> manageable order. You do know about git rebase --interactive, don't you?
>

It would be great if users knew how to do that, and I wouldn't have to
explore such unconventional technical solutions :(

> -- Hannes
>
