Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A24CB2C
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EUi3yHj/"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78333a2ed06so70914685a.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 11:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704915836; x=1705520636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2218yfUTOnlx01kWhb/e3y+uePVKwUDL6YwlhKyKwM=;
        b=EUi3yHj/NeTbApiDvaQjaPeoqDo5OUzMWy2uPfF5H6VECH/vRrZ5axOntMQyagPp2A
         n0hWNrXDr7LMQvID1ZqMkiP4/07a4pJlFHon7qxJUYE7BCAGGG3qT1eU++qf2GqmnJ9r
         NQlRda85UD/s1OoYxIaAIxiFk8M7RvzbGXdDdXUgD+tUHGsn/V0UT/L+ulQ409IDdYvn
         ym7I9ydgJ4+mrV/Ak15gB+TBgxV9PW3eXjYqf62BKIBilmW88ZA1oPyg9FfFc7G58q+q
         XoEjjyRTJIIczav7q3KY8/bGCfNwV0hUzJpBe44D5JRwi+jM7BDBVkV+wVkBRlolOw9F
         wWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704915836; x=1705520636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2218yfUTOnlx01kWhb/e3y+uePVKwUDL6YwlhKyKwM=;
        b=m+4oad+/XbROh2Aa8JnrUFuzuovb50R0qd3jz9E/k7jCQEoA933moBf8QDCsr2D2ev
         FAS5qHoDQ253ctbJtDIYePVbO/okMsUQmO83WpHyzAb0ScJNhgiflB0WQYRCGGmh9bQN
         0SzHBmnIT1i4Yd431lFEaShh+eZbalMImpc4tiY7fCcZc51mS7KTel3cgis8disoC0X8
         3AFAFV5b37aexpgJIL0ynRHjN7KPQLaXNBv0clTgyGpko5Wvqk1Pq3kRyunpT40MJQMI
         qwR7AYjuIRcGgQs1ir62biVySioeq2Ge1lwEAtEc6tsyyYyHXxxfpYIYR/NZg+AeWpCP
         8KqA==
X-Gm-Message-State: AOJu0Yxouv7vOdQfaqb6QxWlR39eKTuoqXUHNSfMGvBAJi2nAlnHqCBA
	6TB4onDBYWMsYlFY02EeL9ZqChpG+giyE2Lu3V2CHDDL0rurmA==
X-Google-Smtp-Source: AGHT+IFxysuqoost2bisDC4hfpysCYdqdeZK/ngQZbuUUnuP+0PF9cEu1AtBdDAtfZ9OSM5TYIlRYA==
X-Received: by 2002:a05:620a:10a8:b0:781:ab42:88e7 with SMTP id h8-20020a05620a10a800b00781ab4288e7mr156821qkk.60.1704915836698;
        Wed, 10 Jan 2024 11:43:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h4-20020a37de04000000b007832a7c7fcbsm1825649qkj.108.2024.01.10.11.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:43:56 -0800 (PST)
Date: Wed, 10 Jan 2024 14:43:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Dan Moore <dan@fusionauth.io>
Subject: [ANNOUNCE] git-scm.com updates (was: Conservancy status report
 (2023))
Message-ID: <ZZ7zezSRZfdklS4u@nand.local>
References: <ZRHTWaPthX/TETJz@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRHTWaPthX/TETJz@nand.local>

On Mon, Sep 25, 2023 at 02:37:13PM -0400, Taylor Blau wrote:
> One notable change from last time is that our hosting fees have gone up
> significantly. These are entirely from Heroku's change in policy to no
> longer grant the Git project hosting credits for the git-scm.com
> project. Our costs in the meantime have been supported by a generous
> donation from Dan Moore at FusionAuth. The below email has some more
> details:
>
>   https://lore.kernel.org/git/YkcmtqcFaO7v1jW5@nand.local/
>
> It appears that since the above was written, Heroku has a new (?)
> program for giving credits to open-source projects. The details are
> below:
>
>   https://www.heroku.com/open-source-credit-program
>
> I applied on behalf of the Git project on 2023-09-25, and will follow-up
> on the list if/when we hear back from them.

Out of the blue today I received an email from Heroku saying that our
application to their open-source credit program was accepted. Quoting
from their email:

  [...] We are excited to announce that your project was a fit to
  receive $250 credits/month for one year, totaling $3,000 in credits.
  These credits have been applied to the account submitted on the
  application, and will be valid from January 2024 to December 2024.

$250 per month is more than enough to cover our hosting costs (which
average around ~$140 USD per month), so we should have plenty of room to
host git-scm.com free of charge for this year.

I know that there are some plans in the works to convert git-scm.com to
a static site in [1]. So even though we likely won't be on Heroku
forever, this should tide us over until we're ready to move to GitHub
Pages.

I would like to thank Dan Moore for his generous donation to the Git
project, which has covered our Heroku bill in past years. Now that
Heroku has agreed to cover out costs for this year, we will be able to
use the funds Dan has graciously provided to on behalf of FusionAuth for
other purposes.

Thanks,
Taylor

[1]: https://github.com/git/git-scm.com/pull/1804
