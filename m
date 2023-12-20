Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16D1DA49
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckCiBYQU"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e305530baso138104e87.3
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703104954; x=1703709754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsw7VRsejEWzcc0OZHP/vo4iDvc4o2FWqn5KwvX3gL4=;
        b=ckCiBYQUPINi99AAMEi7+JjeK0jC87dTW9lud2IEdnSH9pL0qqmh1SVESEjqcJSs3C
         tvg41FZw24foSmG0/XCq9GFnvn/E4S65zFAcx/2mByCtZ25d6Cq4qo80+S6vSITXd4bk
         nVABKZ1RLZzhrXD+FVnvkClJGU/+XVyJWJLzdaeDIiAfO5WQ5oD9g3XeuoqUPec7QR1k
         PdKHAJYX0+QppLe3gw3wR9Tci2ki7qwSXpLHgYsxwWNxJcxhH6nXvT6JGZ7mmJ6C3tmZ
         mp4GIXY54JBdTVkqKSz6hHqB80ZWbFySyDX8ZslAj06AMy+TwTCVdygyCpjQamZ73IW6
         holQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703104954; x=1703709754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsw7VRsejEWzcc0OZHP/vo4iDvc4o2FWqn5KwvX3gL4=;
        b=Ul2EEDKU8m1k6TxC8DxpWk5G1Ni6P406jY9H3V3nvz0GYEFj7ZsfnFdrMiaIOuiUdI
         Is9TVa/vWgbE16meckbehlvaspVGCGpZE9DRaGhW4Txn2ncHx85/lIFc4W0lW+ur+wBF
         Fb7iJrdf6cGJSy7resxDb1M/prLDx4+/EhpJlTTnh0RFHKdmkYcBKe+lUTFdYMAf+TOZ
         w1zBXckg4SdF4HUOYl+0XyDrUfMrMhlWX9xVGcPWew+t2xIqYJ57B6533ysa/b1SSbAo
         bGiKuO2BwTRCm9i2x6vQ7EkM92LwqOugy7nAAQBc/dqE2mPlmaEO3r1FlWBngp0WaqmM
         NEsw==
X-Gm-Message-State: AOJu0Yx2w4k0kEOUTlnPt8GwahCF0ctxenEN8G5Vd2RCf+kXDPyDM8Gl
	8ihPWwLCQDv8v6o2FN+MhQc26Bkt1t2nPiED+Tw=
X-Google-Smtp-Source: AGHT+IFF+NNKG0NN/6GsCVrVCPB9wfOvb7gI+Zbo5/dR3utB39/3akbBq7nG5cZYjUftBuXMpWlOoRlVdpvHwLDYShw=
X-Received: by 2002:a05:6512:3b97:b0:50e:3b2b:7912 with SMTP id
 g23-20020a0565123b9700b0050e3b2b7912mr4293028lfv.21.1703104953981; Wed, 20
 Dec 2023 12:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
 <dbfb108214d71ab29c29230eed3c4d40fe4b42b7.1701585682.git.gitgitgadget@gmail.com>
 <xmqq1qc35sx2.fsf@gitster.g> <xmqqedfgsm6u.fsf@gitster.g>
In-Reply-To: <xmqqedfgsm6u.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 20 Dec 2023 12:42:22 -0800
Message-ID: <CABPp-BF-ZN2RyXA6USNP5kubn1bJ76T-MwFfY7Tpf+x35aRdDA@mail.gmail.com>
Subject: Re: [PATCH 02/12] treewide: remove unnecessary includes in source files
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> diff --git a/trace2.c b/trace2.c
> >> index 6dc74dff4c7..d4220af9ae1 100644
> >> --- a/trace2.c
> >> ...
> > An in-flight topic seem to want to see git_env_bool() that is
> > declared in parse.h that is pulled in via inclusion of config.h
> > hence this hunk breaks 'seen'.
> >
> >> diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
> >> index d5ca0046c89..a0032ee3964 100644
> >> --- a/t/helper/test-trace2.c
> >> ...
> > An in-flight topic starts using "struct key_value_info" that is
> > available via the inclusion of "config.h", hence this hunk breaks
> > the build of 'seen'.
>
> It seems that we have gained another topic in flight that gets
> broken by this change.  I can keep piling merge-fixes on top, but it
> does not look like a strategy that would scale well.
>
> Can we get this series thoroughly reviewed quickly to merge it down
> via 'next' to 'master' soonish, so that other topics can be rebased
> on the result, or is that too much to ask during the Winter lull?
>
> Thanks.

The Winter lull is my winter surge, so I can certainly quickly make
whatever changes are required (well, assuming I can shake this
fever...).  But that doesn't help much with reviewing, since that
should be done by someone other than the author.  However, these
particular type of changes are pretty innocuous; there's really not
anything clever going on, it's just a lot of gruntwork, and
does-it-compile is most of the review.

Anyway, I'll reroll, dropping or holding back any changes that
conflict with next or seen, and see if that encourages anyone to chime
in.
