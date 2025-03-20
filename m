Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687161E47B3
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499238; cv=none; b=IRf16g4R5Ib74WwhxSVFpsaU4VRdla+Cw3X/GuiOoSmRW7wM1rG9uQ6Johj9dyvkpv3ylPLtaEKoSE6CP+EKg9rR2BUkkMNBUAKUqGbBF96/SEBtLse8VXVEzwAUjhnmk3jEMZIh5iixr+PABW7oY2cn7f+dY16qPOaYOcTXjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499238; c=relaxed/simple;
	bh=BLxg5Kdt3VyQOhUfaqQLllwESJSqT+IUwm2ftOCsT7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmzUzPIS0NnaUs6CiqddrYDozn4NfikApaq3P9k8J3LZ0QknN54szDd/2hQ9waWR9HaMkX9Z7YSHg+e6VVHhayxZ6fURRc0fL891kRDwG9+iYGTp9A+6pUV18oVffs+39Dj+34rq/URJqjCyz3TADgy61hnz5DAQbeUJsrawPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5a3334fddso27348185a.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 12:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499235; x=1743104035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Kc9pktwXbagwxvJP1fdtRWC1hAs7EjNEDmcDt0MMhQ=;
        b=M6bG5xoP2GYYbe1X66wQdW2FoCIzmQqluHDt6lvc0y5DAB7ibgHK89fSvY2Mcb3eKL
         hRV/7X57JLSJK32e8fe3i/cKNLkhKdl87BkiooYL/tBsRwZqLXcDR76w6Q12KrTE6wtq
         a3rqXZ8GyO65c0uGxNTTzJiXWaVKJtuIMdvPtQlKKr9Ej2qzgsi2VTGTVUq0CX9HHOZw
         VIk4pmU5jYfYtvO1PGUtGePm2RtpNeZfmExFn2Isw5CHll15/tHQ3L99/00LJtwZT3jD
         KDJFTNL3CokDLoSTmhWyDG5fJ/U1RfRwTk0YYR5C9fctC3VWmtt9jmhF8CW7hUT8Uk2f
         gsjg==
X-Gm-Message-State: AOJu0YwvMRs5eKIMAMPjNhwU81QWtShiRaBbFda1frYMtBUM1q+V5dGp
	o3J2fUPDfx3nnMWYd9BH+0tBLvc822l/idpYqQ5MHl0k/SfHRI2DVOzMzFi/8xfuH/7tXK3pXcV
	foPCcwm7Oh0Hiq9GCT5bN//k+/g0=
X-Gm-Gg: ASbGncupPCfTviU7YWubOhYNE0gQoptUmnHPPKPUzuni0pw4CBoK7fX1Fkj2SFH4H7F
	sz1/3J53Kxw8hCnE2Z6VEn2c3hcB6cA52lIh90bC0THP8VxLCLTED34zE0lKHfwX25lgYg4+bzM
	hLL8p6NYttpUcn4GTq5z7d0PS8
X-Google-Smtp-Source: AGHT+IEe2u5xjeK8QOz4twB176Y9GP8smBp6iz1RUjiG+Y8WV03FW5fxdilT3OeUIw88p1hJU38ypxrbG47K2gEhyV0=
X-Received: by 2002:ad4:5cc4:0:b0:6e8:af1b:e70e with SMTP id
 6a1803df08f44-6eb3f347687mr3369116d6.8.1742499235164; Thu, 20 Mar 2025
 12:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250320-b4-pks-t-perlless-v1-12-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-12-b1eefe27ac55@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 20 Mar 2025 15:33:44 -0400
X-Gm-Features: AQ5f1Jot93lKAsuXWbEEyRbtvzpY8vOhztI_8uwaRC9jWZzJzAiW5Oqm0R9egEs
Message-ID: <CAPig+cSC3zdur1fCsa7RMNZDcgUK4pUGKb22tpgdANxR6OxNMA@mail.gmail.com>
Subject: Re: [PATCH 12/20] t: refactor tests depending on Perl to print data
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:36=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> A bunch of tests rely on Perl to print data in various different ways.
> These usages fall into the following categories:
>
>   - Print data conditionally by matching patterns. These usecases can be
>     converted to use awk(1) rather easily.
>
>   - Print data repeatedly. These usecases can typically be converted to
>     use a combination of `test-tool genzeros` and sed(1).
>
>   - Print data in reverse. These usecases can be converted to use
>     awk(1).
>
> Refactor the tests accordingly so that we can drop a couple of
> PERL_TEST_HELPERS prerequisites.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> @@ -643,12 +643,11 @@ test_expect_success 'basic: commit and list refs' '
> -test_expect_success PERL_TEST_HELPERS 'basic: can write large commit mes=
sage' '
> +test_expect_success 'basic: can write large commit message' '
>         test_when_finished "rm -rf repo" &&
>         git init repo &&
> -       perl -e "
> -               print \"this is a long commit message\" x 50000
> -       " >commit-msg &&
> +
> +       awk "BEGIN { for (i =3D 0; i < 50000; i++) print \"this is a long=
 commit message\" }" >commit-msg &&
>         git -C repo commit --allow-empty --file=3D../commit-msg
>  '

The original Perl version emitted the entire message as a single-line,
whereas the awk replacement emits 50,000 lines. Was the intent of the
original specifically to check whether it handled an extremely long
line correctly, or was it merely checking whether an overall very
lengthy content was handled correctly? If the former, then this
semantic change is inconsistent with what this test wants to be
checking; if the latter, then this semantic change is harmless.

Also, it is possible to do this entirely in shell without running an
external program (assuming `test` and `printf` are builtins):

  i=3D0 &&
  while test $i -lt 50000
  do
    echo "this is a long commit message" &&
    i=3D$(($i+1)) ||
    return 1
  done &&

> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> @@ -228,7 +228,10 @@ test_expect_success PERL_TEST_HELPERS 'ignore very l=
arge set of prefixes' '
>                 echo object-format=3D$(test_oid algo) &&
>                 echo 0001 &&
> -               perl -le "print \"ref-prefix refs/heads/\$_\" for (1..655=
36)" &&
> +               awk "{
> +                       for (i =3D 1; i <=3D 65536; i++)
> +                               print \"ref-prefix refs/heads/\", \$i
> +               }" &&
>                 echo 0000

In this one, the Perl version emitted 65,536 lines, so the awk version
is consistent with that. Okay.

This could also be done purely in shell without using awk.
