Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347E10F8
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="3YPxz5XH"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E30CC
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 22:52:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2116709b3a.2
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 22:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697953937; x=1698558737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qqgBIglCCfjOU+pz1KnvAqMwU3k0rVRv1wssW/o8kQ=;
        b=3YPxz5XHLTehLkYwQ61BR1/0a+StHo6oDXIf8hSQKZ45qf1MXes3I19b3JBLZBYiXM
         EcOhO55PNzsmtC2+7kLxPr6C3TVd9fox7dgZWFnI1rxDWW39lvWOhRt5lVIZRR+nDCnk
         /owbHUpUok59CXQ7CLf/PQ+rTGPDUpMzEjh9mDt8PDVA8GMtfs9/0q/15s0osPSXRrvS
         I2E8UmbdfCTJNkmlDslbgmvmZc39DYvmnbbYtlwA6QCwaHUTs6AOZcUj/QL91D/dtn9j
         6EwmbaTyGtKTvRkWXB0Iw3t4gwDHURrlXevsYymBE0tWrlXz0V5DE2hN6PN/JjH8ZuGG
         4S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697953937; x=1698558737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qqgBIglCCfjOU+pz1KnvAqMwU3k0rVRv1wssW/o8kQ=;
        b=D560xyRyzGH6iJRas1oefSsEQTUJe94H9dx0pqJivzlM5c/0c7Hup9uFgZr5DO4zvn
         yPN+YkXq4UB0+08CkAYwInz1Q9q5FnrsVgEEVv8nwNKoXcewe/H+/tJ22t/GF561ngPt
         v/PUrnZIpCMKir2PttAE2bVTClhJvHHDbSylsTFeQvqD+u2lSUmmZ5AkhhxyCdOWV45m
         kFBn5rH9JFKNcum3j/t0Q2Hf8KG41zvRepkMwg5Gw78pflEUU0f7iUke7ZHoL5KrrvcJ
         XtpbxUi1blEPOHcRjgS1n6e4HiLRfBdr/r/NDmVIHbtX4SD7Iq+ovHl6KHB2VN0CqPpP
         HoAg==
X-Gm-Message-State: AOJu0YzQDAfXzZjdHJXUOjTfutYUaAod5hQnn48kTMuEEEKY5OnrITn2
	chwGxM7iOcDVoHm9kdy/W20Aoii7uZQ5Xy51Zdx+EA==
X-Google-Smtp-Source: AGHT+IGDazxoHSx8qpAwXeGtDVvjDjv1h11LiO2ywAMCNKpbcZj1bbF8Nw5jmkTKbmegR2RLIMmEnw==
X-Received: by 2002:a05:6a00:998:b0:6bd:2c0a:e7d with SMTP id u24-20020a056a00099800b006bd2c0a0e7dmr7109120pfg.19.1697953936893;
        Sat, 21 Oct 2023 22:52:16 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-47-162.mycingular.net. [166.170.47.162])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7956b000000b006baa1cf561dsm4075504pfq.0.2023.10.21.22.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 22:52:16 -0700 (PDT)
Date: Sat, 21 Oct 2023 22:52:13 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>

> Frankly, based on my rather broad experience, there are two primary
> categories of the beginners in the world of version control software (VCS),
> be it git or any other product:
> 
> 1) People who are forced to use some VCS at work, and they actually don't
> give a damn about it.
> 2) True enthusiasts who love what they do, and who love expanding their
> knowledge.
>
> For the first category, nothing helps.  

Interesting categorization I didn't think of splitting users that way. I
guess for group 1 that's true, if they are shown a GUI and can run 3
commands that can do what they need, that's all they will ever use.

> For the second category, a nicely
> written tutorial is all they needed to start with, aided later with the man
> pages, Stack Exchange, and perhaps some textbook.

This is the exact way I learned Git and became comfortable and eventually
confident using it. Reflecting on that, I really only started to become
truly confident after understanding the core underlying concepts (maybe
this is obvious / true for anything). And it's always easy once you get it.

However, there is one main benefit of a feature like this, that none of
the other options (man pages, stack exchange, a textbook) can provide:

Since the tool (Git) has access to and knows the exact state of your local
environment, it can provide instant feedback that takes into account that
context. That is immeasurably more helpful than trying to figure out how
to best ask Google your question, and then piecing together your problem
with a similar one some lost soul ran into 10 years ago.

> Please don't get me wrong, I understand your reasoning, but again, it all
> comes down to the two categories described above.  IMHO, the second category
> will likely start turning off the default hints sooner than turning the
> table formatting on.  The first category will choose some GUI anyway.

The default hints are an intersting consideration. I've found them handy
for commands that I use infrequently, and also when I find myself in a
scenario that is not a part of my usual workflow.

And the hint feature does show that Git has some "helper" features to
hold the user's hand at least a little bit.

> No pain, no gain.  That's the ancient mantra, but IMHO it still applies very
> well to many things, and of course not to the first category mentioned
> above.  Nothing applies to that category.

Somehow I do feel some sense of satisfaction at the countless times I've
I've been stuck on some menial issue only to find out it had a stupid
solution I overlooked. It's also just kind of funny in hindsight.

Regardless of a table formatting feature in Git, there is still plenty of
sweet sweet pain to be had with software dev in general.

But in the moment I always do appreciate being able to get past a
roadblock as quickly as possible. I would want a tool I design to be
known for avoiding pain rather than causing it.

> As I already assumed above, the targeted audience will likely start turning
> the default hints off, rather than turning the table formatting on.  Maybe
> I'm wrong there, who knows.

Even if the hints are off (presumably because the user felt confident
enough or annoyed enough to turn them off), sometimes people just run
into a situation they need an extra bit of clarification on.
