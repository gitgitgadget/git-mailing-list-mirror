Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E12358B4
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USF46KL7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a29a4f610b1so281777566b.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 01:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704792068; x=1705396868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=medVtSVuYcpKk8uFDQLrHbpGueNWk03wbMuZOanUJR0=;
        b=USF46KL7DKnFtLvgVhFkanF34wGlMQJi8X9ZZNU3o6dzA6v6eejv576DUEZmKbNDYL
         FMv7cHq2kVGFeKW3JYGxgaSiPU++aA67IBpb28D6n7qw31w9aI2fOIv9J7ZWSBCawoRH
         wBIpXiea9ERHIMDmbsyDAcgnHrHhO36AERSXgFmehvrP5ATsAt/cc21RKQkT7iwF8+Uc
         +KCxsATgjMSF3HF3D6AmXyKD82ksDcfIWeZVivhziOQjkflG8fkRETjIWBHPzoqRj8zD
         brTA/mn6GFGcxycJCOXl9ux+M4b//3H9z2zmvRREOu5lvaMCypoie7xdtf57J9KPZQBf
         Hdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792068; x=1705396868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=medVtSVuYcpKk8uFDQLrHbpGueNWk03wbMuZOanUJR0=;
        b=NRX7I89B5YStIdt/afGPQJyH5THU9HhjBiwlbR1jZ2m57znjUuVudh1l/xStakg4+5
         vtOiK6FWRgXp2J32LrjYRu6M3OYoLcalZxYDZL7pXMaxnLCra8OQikq20TsqgQSksgdM
         tCpQ46d8vUIjku8zTyN/SerX2kLJU2wKBu8HV5TH5SHpwFeazVQ83+l8WRue3GgZBPPz
         XfjgfmjjclFxISZCWBWyFRM2W3d4usbALFtQdEph5QgQ6oCP6UGrz7hPdlPqaM97e5xA
         7JfKdDpjrXKhnXj0oqNRiuo39/3PkUXmuT/1EXyitYqeP+EjbnWsp8khGYnh4dlBfMKt
         WDsA==
X-Gm-Message-State: AOJu0YwiWWKE4VowxdR6Xg2Ei+z5PsSl9clvVVeknzE9Kmrt3r09IzSL
	OpGTkDCZcyvlftu69rgsnhsQ4fnMS7lvYhgkvuY3By0gd5w=
X-Google-Smtp-Source: AGHT+IFbUBSyHH451qYBQ4JjoH3l43f5sS1xwCm67Nz2EhLpwAU4HWiHyIxAMjJbO0ekfTf/H90AX3MuyVrM1fWGhjs=
X-Received: by 2002:a17:907:2dab:b0:a29:7d7f:83a with SMTP id
 gt43-20020a1709072dab00b00a297d7f083amr443159ejc.13.1704792067911; Tue, 09
 Jan 2024 01:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com> <20240109060417.1144647-3-shyamthakkar001@gmail.com>
In-Reply-To: <20240109060417.1144647-3-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 9 Jan 2024 10:20:55 +0100
Message-ID: <CAP8UFD0GJf5+eOTxy6s+zCzpDmCU_FY4BjwtjTE7RvZ5mKettA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7501: Add tests for various index usages, -i and -o,
 of commit command.
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First about the commit subject:

"t7501: Add tests for various index usages, -i and -o, of commit command."

it should be shorter, shouldn't end with a "." and "Add" should be "add".

On Tue, Jan 9, 2024 at 7:10=E2=80=AFAM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> This commit adds tests for -i and -o flags of the commit command. It
> includes testing -i with and without staged changes, testing -o with and
> without staged changes, and testing -i and -o together.

A few suggestions to make things a bit more clear:

  - tell that -i is a synonymous for --include and -o for --only
  - tell if there are already tests for these options
  - tell why the tests you add are worth it if tests for an option already =
exist

> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>  t/t7501-commit-basic-functionality.sh | 90 +++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic=
-functionality.sh
> index 3d8500a52e..71dc52ce3a 100755
> --- a/t/t7501-commit-basic-functionality.sh
> +++ b/t/t7501-commit-basic-functionality.sh
> @@ -76,6 +76,96 @@ test_expect_success 'nothing to commit' '
>         test_must_fail git commit -m initial
>  '
>
> +test_expect_success 'commit with -i fails with untracked files' '
> +       test_when_finished "rm -rf testdir" &&
> +       git init testdir &&
> +       echo content >testdir/file.txt &&
> +       test_must_fail git -C testdir commit -i file.txt -m initial
> +'

Existing tests didn't need a repo, so I am not sure it's worth
creating a testdir repo just for this test.

Also I am not sure this is the best place in the test script to add -i
and -o related tests. Here we are between a 'nothing to commit' test
and a '--dry-run fails with nothing to commit' and then more 'nothing
to commit' related tests. I think it would be better if all those
'nothing to commit' related tests could stay together.

> +test_expect_success 'commit with -i' '
> +       echo content >bar &&
> +       git add bar &&
> +       git commit -m "bar" &&

Why is the above needed for this test?

> +       echo content2 >bar &&
> +       git commit -i bar -m "bar second"
> +'
> +
> +test_expect_success 'commit with -i multiple files' '
> +       test_when_finished "git reset --hard" &&
> +       echo content >bar &&
> +       echo content >baz &&
> +       echo content >saz &&
> +       git add bar baz saz &&
> +       git commit -m "bar baz saz" &&

Not sure why the above is needed here too.

> +       echo content2 >bar &&
> +       echo content2 >baz &&
> +       echo content2 >saz &&
> +       git commit -i bar saz -m "bar" &&
> +       git diff --name-only >remaining &&
> +       test_grep "baz" remaining
> +'
> +
> +test_expect_success 'commit with -i includes staged changes' '
> +       test_when_finished "git reset --hard" &&
> +       echo content >bar &&
> +       git add bar &&
> +       git commit -m "bar" &&
> +
> +       echo content2 >bar &&
> +       echo content2 >baz &&
> +       git add baz &&
> +       git commit -i bar -m "bar baz" &&
> +       git diff --name-only >remaining &&
> +       test_must_be_empty remaining &&
> +       git diff --name-only --staged >remaining &&
> +       test_must_be_empty remaining
> +'
> +
> +test_expect_success 'commit with -o' '
> +       echo content >bar &&
> +       git add bar &&
> +       git commit -m "bar" &&
> +       echo content2 >bar &&
> +       git commit -o bar -m "bar again"
> +'
> +
> +test_expect_success 'commit with -o fails with untracked files' '
> +       test_when_finished "rm -rf testdir" &&
> +       git init testdir &&
> +       echo content >testdir/bar &&
> +       test_must_fail git -C testdir commit -o bar -m "bar"
> +'
> +
> +test_expect_success 'commit with -o exludes staged changes' '

s/exludes/excludes/

> +       test_when_finished "git reset --hard" &&
> +       echo content >bar &&
> +       echo content >baz &&
> +       git add . &&
> +       git commit -m "bar baz" &&
> +
> +       echo content2 >bar &&
> +       echo content2 >baz &&
> +       git add baz &&
> +       git commit -o bar -m "bar" &&
> +       git diff --name-only --staged >actual &&
> +       test_grep "baz" actual
> +'

Thanks.
