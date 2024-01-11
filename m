Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415037EA
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg1rfhRd"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3689338a12.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704938306; x=1705543106; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GP86SB8CGpOlT4jtt4Cgf7fnSj8oWdqHB3D6lN0Onvw=;
        b=Wg1rfhRdvOeLjVLZQIlojxYKugu9NHneWqtnuFo/vMbtJr4B3JlfZA9ke9Gi/G2q/B
         4lslInbe8Zo2HJvTX+xb2PoMspkGAihXeL8sPYEez3IqGe24+YPh9PsnroktCVOU5Y14
         xp2qfY+YgCkEN1jxpYOWgge18jrXM/3dEjxMtTKnZgE8SmBZ2SqSJpf+Jc00E8Y8MhdJ
         SKSDNeU0j6N193jF1At8qeL6/0ADJt3s0nAjqc63QubRK0Q3r2Co3SbyElOAIIWE/vBA
         hV0q9CDP4uyatilXlRiav+77Yi5m/bEwxSzxu1o9iRFFzhzptMSfTVmWFNkNXNSN8FYs
         ZKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704938306; x=1705543106;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GP86SB8CGpOlT4jtt4Cgf7fnSj8oWdqHB3D6lN0Onvw=;
        b=XM+jzZJIeQym+b/9wOBfM5QJUzaxpvDud+8uhl0J2yKQWzKirUZe59Ew7A9xq8pc15
         coOnrrqZqJJfFjKYaYBklNIt0AgcVolWlJNSG3ohbhZJrC0r1hksM5OihtGuQ5+Y1Vnh
         Dh5YzwjzSqLPzCB4NshXqOX1ZBz0Ltlh1d9Zl4K2hL+DGIef04yHyY+nKOrQ9ZtRU8ip
         mkaX96xLRvnnJCw/xlRTrE+rvXmEU8N709oxmTFl4U900xYqIqWyMV39FPaGR+1ozltF
         EH9cP43wYcRKjrlZB5PdED7htiRNPnxR0WoHI5oCH/KeyZH+NG4LanNCrAW3aFdBYWfs
         qKDA==
X-Gm-Message-State: AOJu0YyutuvcSjn3oPEELifxDaa1fnWhCBAiKWEz3h0BvjZaBvEwV88d
	6WS8salFeAVaj0KZ4fSHXiU=
X-Google-Smtp-Source: AGHT+IGYzQS+BCori1HcJl+aKu6ol7TtIXVoricuA7CLB4OO3PGrGTfuIsjbRY/8kwBKZfuYANRTFg==
X-Received: by 2002:a05:6a21:788e:b0:19a:4981:3578 with SMTP id bf14-20020a056a21788e00b0019a49813578mr398666pzc.16.1704938306328;
        Wed, 10 Jan 2024 17:58:26 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id ph13-20020a17090b3bcd00b0028c94f78c07sm2301709pjb.30.2024.01.10.17.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 17:58:25 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jan 2024 07:28:21 +0530
Message-Id: <CYBI6R7H38H9.2VXJRFAHZNJZ1@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>,
 <christian.couder@gmail.com>
Subject: Re: [PATCH v3 1/2] t7501: add tests for --include and --only
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.15.2
References: <20240109165304.8027-2-shyamthakkar001@gmail.com>
 <20240110163622.51182-4-shyamthakkar001@gmail.com>
 <xmqqil41avcc.fsf@gitster.g>
In-Reply-To: <xmqqil41avcc.fsf@gitster.g>

On Thu Jan 11, 2024 at 12:07 AM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> > -# FIXME: Test the various index usages, -i and -o, test reflog,
> > +# fixme: test the various index usages, test reflog,
> >  # signoff
>
> Why the sudden downcasing?  If this were to turn it to "TODO:"
> (110+) or "NEEDSWORK:" (110+) from less often used "FIXME:" (40-),
> such a change might be defensible, but there is only one instance
> of downcased "fixme:", so I am curious how this happened.

Wow, I must have done it mistakenly. I guess everything on that line
became lowercase. But, I will fix it.

> > +test_expect_success '--include fails with untracked files' '
> > +	echo content >baz &&
> > +	test_must_fail git commit --include -m "initial" baz
> > +'
>
> OK, this is because "--allow-empty" is not passed.  This should fail
> without -i/-o (which should be the same as passing -o), with -i, or
> with -o.
>
> Calling this commit "initial" is highly misleading.  There are bunch
> of commits already, but path "baz" has never been used.

I will fix this.

> > +test_expect_success '--include with staged changes' '
> > +	echo newcontent >baz &&
> > +	echo newcontent >file &&
> > +	git add file &&
> > +	git commit --include -m "file baz" baz  &&
>
> I suspect that you found a bug whose behaviour we do not want to
> carve into stone with this test.  When this test begins, because the
> previous step failed to create the initial commit, we are creating
> the root commit, without --allow-empty, with contents in the index
> for path "file".  At this point
>
>     $ git commit -m "file baz" baz
>
> (or with "-o", which is the same thing) does error out with
>
>     error: pathspec 'baz' did not match any file(s) known to git
>
> because the "only" thing is to take the changes between HEAD and the
> index and limit them further to those paths that match "baz", but
> there is no path that matches "baz".


> This command
>
>     $ git commit -m "file baz" -i baz
>
> should either error out the same way, or behave more or less[*] like
>
>     $ git add baz && git commit -m "file baz"
>
> and record changes to both "file" and "baz".
>
>     Side note: The "more or less" is we should do "git rm baz"
>                instead, if you removed the path.
>
> But it seems that the current code simply ignores the unmatching
> pathspec "baz" that is on the command line, hence recording only the
> change to the contents of "file".
>
yeah, it seems like if there is anything staged, even if we provide
--include with untracked files, it will commit the staged files
(excluding the untracked files) and will not error out like --only.

Also in v1 there was another test before this one which added the
baz file to the index. That test was removed due to duplication and
while cleaning up the v1 for v2, due to --include not giving an error,
I did not notice that 'baz' was being left out. Will fix the tests.
Apologies for such mistakes.

> > +	git diff --name-only >remaining &&
> > +	test_must_be_empty remaining &&
> > +	git diff --name-only --staged >remaining &&
> > +	test_must_be_empty remaining
>
> These two tests to see if the working tree is clean and if the index
> is clean are not wrong per-se, but is insufficient.  Judging from
> the commit message you used, I think you expected this commit to
> contain both changes to 'file' and 'baz'.  That needs to be also
> checked with something like "git diff --name-only HEAD^ HEAD".

Yeah, the "git diff --name-only HEAD^ HEAD" is more definitive.
I will add that in v4.

> Now which behaviour between "error out because there is no path in
> the index that matches pathspec 'baz'" and "add baz to the index and
> commit that addition, together with what is already in the index" we
> would want to take is probably open for discussion.  Such a discussion
> may decide that the current behaviour is fine.  Until then...
>
> > +test_expect_success '--only fails with untracked files' '
> > +	echo content >newfile &&
> > +	test_must_fail git commit --only -m "newfile" newfile
> > +'
>
> And this should fail the same way without "-o".  Don't we have such
> a test that we can just sneak "with -o the same thing happens" test
> next to it?

Well, I could not find any test which specifically for untracked
files. I will keep looking for it and if not found, perhaps, I can add
both "-i and -o with untracked files" tests after "nothing to commit"
tests in t7501 which are similar in nature.

> > +	git commit --only -m "file" file &&
>
> This should behave exactly the same way without "-o".

That is true, however, I could not find any tests in the t75-- series
that test without -o and which provide pathspec in the commit command
also. So, should I drop -o option in this test? or add a test without
-o?

>
> > +	git diff --name-only >actual &&
> > +	test_must_be_empty actual &&
> > +	git diff --name-only --staged >actual &&
> > +	test_grep "baz" actual
> > +'
> > +
> > +test_expect_success '--include and --only do not mix' '
> > +	test_when_finished "git reset --hard" &&
> > +	echo new >file &&
> > +	echo new >baz &&
> > +	test_must_fail git commit --include --only -m "bar" bar baz
>
> OK.  If you grep for 'cannot be used together' in t/ directory,
> there are many tests that make sure how an invocation like this
> should fail, i.e. with an error message that mentions incompatible
> options.  Don't we want to do the same?

I did it like this because in t7501, there are couple of existing=20
"do not mix" tests similar to this one, which only check if the command
fails. However, the approach you mentioned is obviously better, so, I
will update it in v4.

> Thanks.

Thank you for the review!
