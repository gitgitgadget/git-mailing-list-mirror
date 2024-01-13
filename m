Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652D1A594
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcpkQ/S9"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc36e501e1so4873117a34.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 17:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705107614; x=1705712414; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvzzU6e75RymtfbTzg+SNbDhoa44SHI8ifuGC+sxwhk=;
        b=AcpkQ/S9KFWOjB9v3F4cCHnGL4A91BQxVXWdZCPOhEYJoPv6+qgLYO8I29QeP3ivjY
         pUzotx8hehb/PX3Oo3lxCCVtWWqC0/un9xsj/fOZ7QygqFDKx/A9D/EkEOBo3u0lDdUy
         se3XdV3Wr+vL68iFdz44xjmwfWKRQkwbOMc1gUdjNWdYaWL//5ujEwlRsQDeWnTBqu3E
         elxyhdfisyZYrFvLCzPJuuZLBcGnrDpz15bks+lxZSlz9BDCABEvvDA3Z/m3rq8+uUxV
         +T3lmtzPI/gNKJYiJkVNtzHAwrqCx6cWBDrir84DKhIBBVe/ZdRg3ovcgBFbFvnHAb8B
         C2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705107614; x=1705712414;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YvzzU6e75RymtfbTzg+SNbDhoa44SHI8ifuGC+sxwhk=;
        b=MX9hv8LFsJhzRq0u4kH7St6JOadBuqS8kBsmkwdXlfPjj7STeKNib8zJZN7zCZ7QJv
         EEIZIFD3q/6dMwZpZc++5l6eVIxinOTyTynvWdm6JqZst868NoZ136C9Y1cb2aNEfrnv
         4Rd1H0tIYr+4hy8kPjA8+fPuOQ9Jhqb8aM+Fyc+S4P4tISZJRQxMihY0JKzkRW5E/8Fu
         FjCer7aFgEZ3fR57ItsifueXfucWU210SaUcDs8y3gYE/bgwxzMdyGPDqng5SQhKkqln
         Ho0JJxEiRlTMhbEak//AnUSyrcN0L+BUVSVyAQU93H+78kCYf5wd9GfaTR4QmOyx2WnW
         +WUA==
X-Gm-Message-State: AOJu0Yye4Ni2HmTBKZXg+JxRz4a60FLoS+gVl18u1e4Pb9fMXH0z6/ZS
	zcU+HvoldsiA4DLXun8mrPs=
X-Google-Smtp-Source: AGHT+IFCn0mF6K++YjcehqhhF1B2UIWVP3R2bm185JhrjFNN+sdosuqU/9gMkzixiT6sBXboNJZunA==
X-Received: by 2002:a9d:4f09:0:b0:6dd:efff:d7db with SMTP id d9-20020a9d4f09000000b006ddefffd7dbmr2710990otl.20.1705107614205;
        Fri, 12 Jan 2024 17:00:14 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id fj15-20020a056a003a0f00b006d9a5a6b059sm3840828pfb.91.2024.01.12.17.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 17:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jan 2024 06:30:10 +0530
Message-Id: <CYD67AE9V26S.YEDQYOHZJV9M@gmail.com>
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>,
 <christian.couder@gmail.com>
Subject: Re: [PATCH v4 1/2] t7501: add tests for --include and --only
X-Mailer: aerc 0.15.2
References: <20240110163622.51182-2-shyamthakkar001@gmail.com>
 <20240112180109.59350-1-shyamthakkar001@gmail.com>
 <20240112180109.59350-2-shyamthakkar001@gmail.com>
 <xmqqbk9q6tcs.fsf@gitster.g>
In-Reply-To: <xmqqbk9q6tcs.fsf@gitster.g>

On Sat Jan 13, 2024 at 4:40 AM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> > @@ -92,6 +92,19 @@ test_expect_success '--long fails with nothing to co=
mmit' '
> >  	test_must_fail git commit -m initial --long
> >  '
> > =20
> > +test_expect_success 'fail to commit untracked file' '
> > +	echo content >baz &&
> > +	test_must_fail git commit -m "baz" baz
> > +'
> > +
> > +test_expect_success '--only also fail to commit untracked file' '
> > +	test_must_fail git commit --only -m "baz" baz
> > +'
> > +
> > +test_expect_success '--include also fail to commit untracked file' '
> > +	test_must_fail git commit --include -m "baz" baz
> > +'
>
> As the latter two depends on the first one's side effect of leaving
> an untracked 'baz' file in the working tree, I do not know if it is
> sensible to split these into three tests.  An obvious alternative is
> to have a single test
>
> 	test_expect_success 'pathspec that do not match any tracked path' '
> 		echo content >baz &&
> 		test_must_fail git commit -m baz baz &&
> 		test_must_fail git commit -o -m baz baz &&
> 		test_must_fail git commit -i -m baz baz
> 	'
>
> By the way, I do not think presence of 'baz' in the working tree
> matters in the failures from these tests all that much, as the
> reason they fail is because the pathspec does not match any tracked
> file, whose contents in the index to be updated before made into a
> commit.

Yes, that is true. However, as per your prior email in which you stated
about --include:

    "Now which behaviour between "error out because there is no path in
    the index that matches pathspec 'baz'" and "add baz to the index and
    commit that addition, together with what is already in the index" we
    would want to take is probably open for discussion.  Such a discussion
    may decide that the current behaviour is fine.  Until then..."

If in such a discussion it is decided that -i should add to index and
commit, then by not having 'baz' in the working tree, the -i test
would still error out regardless of whether its behaviour is to [add
to the index and commit] or [error out]. Therefore, by having 'baz'
we can detect the change between [-i adds to index and commits] or
[errors out].

> Likewise.  An obvious thing to notice is that this cannot use the
> same "contents" text as before, even though it claims to be "same as
> above".  If the final contents of "file" and "baz" does not matter,
> but it matters more that these files have been changed, it often is
> a good idea to append to the file.  That way, you can ensure that
> you will be making them different, no matter what the initial
> condition was, i.e.,
>
> 	for opt in "" "-o" "--only"
> 	do
> 		test_expect_success 'skip over already added change' '
> 			echo more >>file &&
> 			echo more >>baz &&
> 			git add baz &&
> 			git commit $opt -m "file" file &&
>
> 			... ensure that changes to file are committed
> 			... and changes to baz is only in the index
> 		'
> 	done
>
> let's you test all three combinations.

Yeah, that is a more effective approach. I will change it and reroll
quickly.
>
> Thanks.

Thank you for all the help!
