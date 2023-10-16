Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255EF339B3
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdrLtkVy"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562D4A2
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 11:43:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so6859188a12.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697481805; x=1698086605; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k5zVUedsvTcjmWKAtq5GLcmlNz7G86ih5xB2n1tYDvQ=;
        b=JdrLtkVyhZZEROclqQA10tUps5dhYVhLGLpwIimvReKM9eQJZVVuiGQzjgSBd8LzsE
         cyzM7z1cjhA9Si1fjzqct3dM8vtvArgWkS/8F3tGR8bMdB0cPdQOjiI52YnAp0wT3EUe
         HuAtnBUugW6sVyMBYZZaLyTk7oXTnJbPDfpmo1wCh3AWIGeBevR6sIUrAbtVtpZkNxM6
         dGmMoTyrOELqV/BqNK8mnLH40FkiVeyteKGfLU3iMNNKGbuxfe0ByOSqLgqCNmFP/JP/
         SulP6M1QFRoHybKa0ervGebi2d3rx5G5Vugc9bJOGwhrDFVr25k8ONNuAnDDHVInkcdo
         NhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697481805; x=1698086605;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5zVUedsvTcjmWKAtq5GLcmlNz7G86ih5xB2n1tYDvQ=;
        b=cClmkl7438Yp29ViNRtMUCZsgjBzFoBpPlhvfiv5oFlNLlCOJOTMtvL4pX9oRhmQV9
         xpYzFw69mCcc8hOhInr7+awwzxbRQMLmCNzlBaqe56MmcNYnjuFAyFAZgyh9s+4FgASG
         lWTDFsYO0qWA0ti0LZ8c451Ca7D7fdPMi3zgDGcEUG5VnwsbYsVtxVZkG1I91mx6Cxgr
         lNhh1mwa66jkpnQqK9mBiCnkmTWfvPPEyP/5kWzW1gZ5AmGFE6KxrGZKsdTsLRow/wP9
         wTE7EYip0NJ1ZqFyX2HfY/A5FV5fBw4GOLjjziAp5N0VhRT2mcUlY3RQquchJCpIRJf4
         Evtg==
X-Gm-Message-State: AOJu0YwwwX810DP9NtyVbEzb+apxF/PE4Bc7p54t40lMxaysSI6d0eOH
	cwrUx75p5NnMHqPpSUWXDQ==
X-Google-Smtp-Source: AGHT+IF4NDHje3CvecNz5ap4VSE0c7kyhBm8yAoNYZvSpbnLOXEmjcbHWUdcjkazv6udTYkHEcFhww==
X-Received: by 2002:a05:6402:40ce:b0:53e:232b:121c with SMTP id z14-20020a05640240ce00b0053e232b121cmr82240edb.3.1697481804510;
        Mon, 16 Oct 2023 11:43:24 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id u24-20020a50a418000000b0053f0e4e0411sm62214edb.76.2023.10.16.11.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:43:24 -0700 (PDT)
Date: Mon, 16 Oct 2023 21:43:20 +0300
From: Dorcas Litunya <anonolitunya@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org
Message-ID: <ZS2ESFGP2H3CTJSK@dorcaslitunya-virtual-machine>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_SUBJECT,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Bcc: 
Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
Reply-To: 
In-Reply-To: <xmqq1qdumrto.fsf@gitster.g>

On Mon, Oct 16, 2023 at 09:53:55AM -0700, Junio C Hamano wrote:
> Dorcas AnonoLitunya <anonolitunya@gmail.com> writes:
> 
> > Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
> 
> Let's try if we can pack a bit more information.  For example
> 
> Subject: [PATCH] t7601: use "test_path_is_file" etc. instead of "test -f"
> 
> would clarify what kind of modernization is done by this patch.
> 
> > The test script is currently using the command format 'test -f' to
> > check for existence or absence of files.
> 
> "is currently using" -> "uses".
> 
> > Replace it with new helper functions following the format
> > 'test_path_is_file'.
> 
> I am not sure what role "the format" plays in this picture.
> test_path_is_file is not new---it has been around for quite a while.
> 
> > Consequently, the patch also replaces the inverse command '! test -f' or
> > 'test ! -f' with new helper function following the format
> > 'test_path_is_missing'
> 
> A bit more on this later.
>
So should I replace this in the next version or leave this as is?
> > This adjustment using helper functions makes the code more readable and
> > easier to understand.
> 
> Looking good.  If I were writing this, I'll make the whole thing
> more like this, though:
> 
>     t7601: use "test_path_is_file" etc. instead of "test -f"
> 
>     Some tests in t7601 use "test -f" and "test ! -f" to see if a
>     path exists or is missing.  Use test_path_is_file and
>     test_path_is_missing helper functions to clarify these tests a
>     bit better.  This especially matters for the "missing" case,
>     because "test ! -f F" will be happy if "F" exists as a
>     directory, but the intent of the test is that "F" should not
>     exist, even as a directory.
> 
> 
> > diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> > index bd238d89b0..e08767df66 100755
> > --- a/t/t7601-merge-pull-config.sh
> > +++ b/t/t7601-merge-pull-config.sh
> > @@ -349,13 +349,13 @@ test_expect_success 'Cannot rebase with multiple heads' '
> >  
> >  test_expect_success 'merge c1 with c2' '
> >  	git reset --hard c1 &&
> > -	test -f c0.c &&
> > -	test -f c1.c &&
> > -	test ! -f c2.c &&
> > -	test ! -f c3.c &&
> > +	test_path_is_file c0.c &&
> > +	test_path_is_file c1.c &&
> > +	test_path_is_missing c2.c &&
> > +	test_path_is_missing c3.c &&
> 
> The original says "We are happy if c2.c is not a file", so it would
> have been happy if by some mistake "git reset" created a directory
> there.  But the _intent_ of the test is that we do not have anything
> at c2.c, and the updated code expresses it better.
