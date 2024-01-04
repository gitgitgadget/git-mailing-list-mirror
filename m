Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BC2C18C
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sLt/9wW8"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4283f7d53f2so4180751cf.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 11:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704395600; x=1705000400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VU8vUAv2h6So0DL9oXnNxOZI0BbXvkCyx0qXNM/D5Q0=;
        b=sLt/9wW8i+uwv8sdVFsFxYwJVfTAW3bA1JrLLnMaZ3LGgade4iGC05c8JYoPOcXWz/
         +qGLxHaGD0AE5scS4uCMp0H29M0qnf4N2OCosgtXoxIqiN4tfO7NnQWvVQRVICftKjX/
         Bu4CYynWlPvrt2pftXxH8UM4/vsgTwCoz9lmtdnTfAYcsiz34BHUviBJbNQyRryRA+qU
         p/+uzmGk1D4FLZtVT8FiswwPVG/vSyuLcmRKcAoQT5anyglwr95fKhKnDGtBJaIWxqL7
         +Vnemu5kxrkxbPmx2kUvDdj4iyiOJdbAYm2nRYKWLSek7WvJxMSLc3LkLwgEXKG7R3GR
         x1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395600; x=1705000400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU8vUAv2h6So0DL9oXnNxOZI0BbXvkCyx0qXNM/D5Q0=;
        b=h3IBsk6bxrsJ3yoT7WyFt+ikiEwJ0yqtT3MT35VGG708FUdwvRxBkpnWqIcc7XUoyT
         OOkcLt0e6K9OPw+ISY+vwgx7zZuF14paZiwbxRMbKXxFKnoD7+YRtwVoQwO3Bb2fOG0X
         Bi+JLr5mFEBVQv4j8XqbKCSFe3r9YJ0ksC3oBBEdThq2TI7ZVVudIS5EIcRO7FA0TYYm
         J0PEgx+bIMNAGVvdJBNhZnTCGXbZu9gB3pcCgdFyvaF3wVPYgp+IIcrkH2L/o851InPg
         k9SmCYbTZ4tZ7oPMvf8FGWRpul9dgDqmKNJrEFF6QycfaESPadTY6U/OAENcjLnApwH3
         3UKA==
X-Gm-Message-State: AOJu0YzrIovAc8MJpyqLzTrvOgIZqXYb2ezmDGJ92Bdt2J1RllmmRvTp
	/in3imKGsIIb2D81tyWP8zfM6kwXTXJZWw==
X-Google-Smtp-Source: AGHT+IFnlxIC+b+mhxU0oAkW98Sfsy7eRoF649xSHFGXxYiwzoiUABxQuGEgnKH+PGxYj2k7cL4uNg==
X-Received: by 2002:ac8:5a13:0:b0:428:40d8:b129 with SMTP id n19-20020ac85a13000000b0042840d8b129mr1148659qta.67.1704395600428;
        Thu, 04 Jan 2024 11:13:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j26-20020ac84c9a000000b00427cd0b90c8sm51261qtv.53.2024.01.04.11.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:13:20 -0800 (PST)
Date: Thu, 4 Jan 2024 14:13:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Tamino Bauknecht <dev@tb6.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fetch: add new config option fetch.all
Message-ID: <ZZcDT3R0NavkyNYh@nand.local>
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
 <20240104143656.615117-1-dev@tb6.eu>
 <ZZbr4yAJe0dnHRcO@nand.local>
 <88407aeb-bff7-4899-af7b-e7cb671d991a@tb6.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88407aeb-bff7-4899-af7b-e7cb671d991a@tb6.eu>

On Thu, Jan 04, 2024 at 07:32:03PM +0100, Tamino Bauknecht wrote:
> > I don't feel particularly strongly about whether or not you reorganize
> > these if-statements, but we should change "argc == 0" to "!argc", which
> > matches the conventions of the rest of the project.
>
> Are you sure that I shouldn't use "argc == 0" here instead since it's also
> used in the next "else if" condition? Or is the goal to gradually transition
> to "!argc" in the entire code base?
> I agree with keeping the diff minimal, will change that to your suggestion.

See Documentation/CodingGuidelines.txt for more information about the
Git project's style guidelines, but in short: yes, any x == 0 should be
replaced with !x instead within if-statements.

> > This should be `cat >expect <<-\EOF` (without the space between the
> > redirect and heredoc, as well as indicating that the heredoc does not
> > need any shell expansions).
>
> Will do so, thanks.
> I tried to match the existing test cases as closely as possible, but if they
> are outdated, it might be better to use the more recent structure.

Junio notes in the thread further up that it is OK to imitate the
existing style of tests. I don't disagree, but I personally think it's
OK to introduce new tests in a better style without touching the
existing ones in the same patch (or requiring a preparatory patch to the
same effect).

> > It looks like these tests match the existing style of the test suite,
> > but they are somewhat out of date with respect to our more modern
> > standards. I would probably write this like:
> >
> >      test_expect_success 'git fetch --all (works with fetch.all = true)' '
> >        git clone one test10 &&
> >        test_config -C test10 fetch.all true &&
> >        for r in one two three
> >        do
> >          git -C test10 remote add $r ../$r || return 1
> >        done &&
> >        git -C test10 fetch --all &&
> >        git -C test10 branch -r >actual &&
> >        test_cmp expect actual
> >      '
>
> I think I'd prefer having the "actual" (and maybe also "expected") output in
> the repository so that it won't be overwritten by the next test case.

Very reasonable.

> Thanks for the great review, will send an updated patch later.

Thanks for working on this!

Thanks,
Taylor
