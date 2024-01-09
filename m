Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9339FFB
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daA4ELqr"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-598699c0f1eso861884eaf.2
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 09:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704820224; x=1705425024; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmWebNt0fPkiDS4epbeJOhFmixU6/Q2TCjgbi1x/mII=;
        b=daA4ELqrhm8i/RkV+oNE6hmGxItv6S7WQF9jZ1VjaQ5C+sQ/+QIsM4c7d6VzxQWVQ6
         F80XGxteBJYqjHvQq/w4zDAX6sFp5Zq6MDPwDo7KwUJNL5Jey0dLMtn9v292wNQWH+Q3
         yS5iRssj4lv6G6wivAI8Hf41vlJnDpZqZ65VUrcX2auog69+TyRRzIL9OiZIuFFgXkXJ
         Vk5HYTBXWWHpHE/pdMwE6HQ1iDtS+iHGIXbHyJxx9KPrexzlmVaFRZSLBH7d34Qqn9h4
         76Lje1z5+eyHCu4EYUO6nx/FmElDmIMoDaxx+IohalhHPnW9TbavhjDOqjeVabnGObOz
         3rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704820224; x=1705425024;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rmWebNt0fPkiDS4epbeJOhFmixU6/Q2TCjgbi1x/mII=;
        b=aqIRuNwOpcTsFFf++iArEHOqoH7k/ajNk2gRB/icPDVHEROhhNvl2sOCmFUZSV/lTb
         R0yAu2/1J0P0K0hEZ60fE0AgUcCO+N/kmYkvqyQcPlbviVIkCx4ZvgC+rKsZ56YVauQb
         y1bjqwWZfPFzD+g5oSVkXBafosxBxq8Hw2TA3D+hYvwfGJUXDpwMWsTx4RNAL5KeF714
         WKK9N3imoXlD6gsDRap/8ie+LrZBR/vZXxobcfQJzlesNTwvVggfp8ESHXXDubMDN9ho
         2Wnu1x9jiBTWbKhoXc7CGSAQyJ5auvltCAsqkktPlGDpvSjz9K1uS+nzpBU6RHTfNe9E
         Gvjg==
X-Gm-Message-State: AOJu0YxHPbFv+l3mM7VTAhWuy0LinAPpqne8R+1eh1XB1NbFuDirwJEj
	Qi793+t5tHa6xOqOxbTg+Q1i+JXmC17XIu7H
X-Google-Smtp-Source: AGHT+IGItU6A87ehn+MgBYixNT6g09/LCcVZXEE4GrAl/tNeAb0TEzL4v7cLE2ZLb7YzS//sFu64oQ==
X-Received: by 2002:a05:6359:6297:b0:174:f1b6:d1c3 with SMTP id se23-20020a056359629700b00174f1b6d1c3mr3964696rwb.35.1704820223554;
        Tue, 09 Jan 2024 09:10:23 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id n15-20020a63ee4f000000b005c65e82a0cbsm1869540pgk.17.2024.01.09.09.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jan 2024 22:40:20 +0530
Message-Id: <CYACBX8Y10KJ.3QVLHQN8LLZ86@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] t7501: Add tests for various index usages, -i and
 -o, of commit command.
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
 <20240109060417.1144647-3-shyamthakkar001@gmail.com>
 <CAP8UFD0GJf5+eOTxy6s+zCzpDmCU_FY4BjwtjTE7RvZ5mKettA@mail.gmail.com>
In-Reply-To: <CAP8UFD0GJf5+eOTxy6s+zCzpDmCU_FY4BjwtjTE7RvZ5mKettA@mail.gmail.com>

On Tue Jan 9, 2024 at 2:50 PM IST, Christian Couder wrote:
> First about the commit subject:
>
> "t7501: Add tests for various index usages, -i and -o, of commit command.=
"
>
> it should be shorter, shouldn't end with a "." and "Add" should be "add".
Updated in v2.

> On Tue, Jan 9, 2024 at 7:10=E2=80=AFAM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
> >
> > This commit adds tests for -i and -o flags of the commit command. It
> > includes testing -i with and without staged changes, testing -o with an=
d
> > without staged changes, and testing -i and -o together.
>
> A few suggestions to make things a bit more clear:
>
>   - tell that -i is a synonymous for --include and -o for --only
>   - tell if there are already tests for these options
>   - tell why the tests you add are worth it if tests for an option alread=
y exist

I have updated the commit messages in v2 to address these points.

> > Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> > ---
> >  t/t7501-commit-basic-functionality.sh | 90 +++++++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >
> > diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-bas=
ic-functionality.sh
> > index 3d8500a52e..71dc52ce3a 100755
> > --- a/t/t7501-commit-basic-functionality.sh
> > +++ b/t/t7501-commit-basic-functionality.sh
> > @@ -76,6 +76,96 @@ test_expect_success 'nothing to commit' '
> >         test_must_fail git commit -m initial
> >  '
> >
> > +test_expect_success 'commit with -i fails with untracked files' '
> > +       test_when_finished "rm -rf testdir" &&
> > +       git init testdir &&
> > +       echo content >testdir/file.txt &&
> > +       test_must_fail git -C testdir commit -i file.txt -m initial
> > +'
>
> Existing tests didn't need a repo, so I am not sure it's worth
> creating a testdir repo just for this test.

Yes, I just wanted to make sure the files were not tracked. However, I
have updated these instaces to use the existing repo and use unique
non-generic names for generating untracked files.

> Also I am not sure this is the best place in the test script to add -i
> and -o related tests. Here we are between a 'nothing to commit' test
> and a '--dry-run fails with nothing to commit' and then more 'nothing
> to commit' related tests. I think it would be better if all those
> 'nothing to commit' related tests could stay together.

I have moved these tests above the "--amend" related tests, which do not
break the flow of the tests.

> > +test_expect_success 'commit with -i' '
> > +       echo content >bar &&
> > +       git add bar &&
> > +       git commit -m "bar" &&
>
> Why is the above needed for this test?
This was to make sure that the file is tracked, however, I realised that
committing is not necessary, so I have updated this test to use existing
files in repo and to not generate a new one.
>
> > +       echo content2 >bar &&
> > +       git commit -i bar -m "bar second"
> > +'
> > +
> > +test_expect_success 'commit with -i multiple files' '
> > +       test_when_finished "git reset --hard" &&
> > +       echo content >bar &&
> > +       echo content >baz &&
> > +       echo content >saz &&
> > +       git add bar baz saz &&
> > +       git commit -m "bar baz saz" &&
>
> Not sure why the above is needed here too.
Similar to above, I have updated this test to use existing files in repo
and to not generate a new one.
>
> > +       echo content2 >bar &&
> > +       echo content2 >baz &&
> > +       echo content2 >saz &&
> > +       git commit -i bar saz -m "bar" &&
> > +       git diff --name-only >remaining &&
> > +       test_grep "baz" remaining
> > +'
> > +
> > +test_expect_success 'commit with -i includes staged changes' '
> > +       test_when_finished "git reset --hard" &&
> > +       echo content >bar &&
> > +       git add bar &&
> > +       git commit -m "bar" &&
> > +
> > +       echo content2 >bar &&
> > +       echo content2 >baz &&
> > +       git add baz &&
> > +       git commit -i bar -m "bar baz" &&
> > +       git diff --name-only >remaining &&
> > +       test_must_be_empty remaining &&
> > +       git diff --name-only --staged >remaining &&
> > +       test_must_be_empty remaining
> > +'
> > +
> > +test_expect_success 'commit with -o' '
> > +       echo content >bar &&
> > +       git add bar &&
> > +       git commit -m "bar" &&
> > +       echo content2 >bar &&
> > +       git commit -o bar -m "bar again"
> > +'
> > +
> > +test_expect_success 'commit with -o fails with untracked files' '
> > +       test_when_finished "rm -rf testdir" &&
> > +       git init testdir &&
> > +       echo content >testdir/bar &&
> > +       test_must_fail git -C testdir commit -o bar -m "bar"
> > +'
> > +
> > +test_expect_success 'commit with -o exludes staged changes' '
>
> s/exludes/excludes/
Done.
>
> > +       test_when_finished "git reset --hard" &&
> > +       echo content >bar &&
> > +       echo content >baz &&
> > +       git add . &&
> > +       git commit -m "bar baz" &&
> > +
> > +       echo content2 >bar &&
> > +       echo content2 >baz &&
> > +       git add baz &&
> > +       git commit -o bar -m "bar" &&
> > +       git diff --name-only --staged >actual &&
> > +       test_grep "baz" actual
> > +'
>
> Thanks.

Thanks for the review!
