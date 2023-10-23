Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70181B27E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRNdkBEN"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87790D79
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:53:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so6215115a12.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698101608; x=1698706408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Abaq/54uymUdda4PXWdp3kEJjrvYkigjBRICrnDVhU=;
        b=cRNdkBENIPhK+tgBBML8CI9gtKF8hIiEHkyBO+16qIvDptkHFrBjpAAw/tjuaIXLSG
         lgoprrT2uo3aeHja9MV6nxnCzgYBcbwLlBFUZdjqpCwD/83sBJ+N+QcT0ReVvQmagYaA
         j/TN1jyoiyXwDxJONSBWcD6lWUiLgmSFGQ7rJif0eKykwwlRQmuWSLOjMiDNRGC9ggFK
         xQxhToB8eLGYgv/M8GpcmFYsdRGHd5xv/M8KyA9MBXhcWyMnn7NLsIxpty4ehQzAVma+
         JFhJxIMCAMObhe2LbiIG4c4p1ocFUEgw8ankn8PKJJaydGjR9ivMOj2Ag810DJ6fxen9
         Zgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698101608; x=1698706408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Abaq/54uymUdda4PXWdp3kEJjrvYkigjBRICrnDVhU=;
        b=qpYHV5LT7SR+6MIeCXPfh3hyCOOVDD0Sw03pwA93XSX7VYL0PqudClJEse2t/7T3k9
         yjvKyU07Aepgb4cv1giSY7R8Ks5Z07vWj1RmYAGQ0TTI2yehnWL2YY03oICN3jIlWm5N
         jw0IwxCKZPVBO+09dsM+E3UVGZF904cti2rDc7/TjEFK+/FgELoaCCUnYmQhAFWcUyke
         HSGve0Ay1Df1bDlgZaiZ3u67vGjZ5XeXC5emRVHbPEYabK92l5P+S+l+uV3qj8sv5kes
         XztqWLJe76aj3Uixppea5dt3MoOUCQIMqwFbxrfbZjohPpH/B5A0dWHH0jZpvOeAMAwt
         C8lg==
X-Gm-Message-State: AOJu0Yw7p1aYfqFzzxdhtr9UE4XUdeLGOdxA/9NnLLf18BBLs3giyWZd
	QtZRxMrBikwsfCWJlI+hxFTvjkFjKNRg/jtXBcU=
X-Google-Smtp-Source: AGHT+IH9QtqGIuXGQob3QwmAX6UhdReD45JBW1zeJ2Y+NnXZe7xemll+AokaV2FL9F/fhnTSWM5cJJdl/2BkXgsE974=
X-Received: by 2002:a50:bae4:0:b0:53e:5044:e28d with SMTP id
 x91-20020a50bae4000000b0053e5044e28dmr7157672ede.31.1698101607845; Mon, 23
 Oct 2023 15:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
 <pull.1602.v2.git.1698088990478.gitgitgadget@gmail.com> <CAPig+cQuBwzaG7ZssGUY6k8wf8pcGZHAGLnbRy579uTPMKqwKQ@mail.gmail.com>
In-Reply-To: <CAPig+cQuBwzaG7ZssGUY6k8wf8pcGZHAGLnbRy579uTPMKqwKQ@mail.gmail.com>
From: Javier Mora <cousteaulecommandant@gmail.com>
Date: Mon, 23 Oct 2023 23:53:16 +0100
Message-ID: <CAH1-q0hNSKgr1-dtZac=z7Bx15gON0Y-1pyBM57zuXaFPaJJKQ@mail.gmail.com>
Subject: Re: [PATCH v2] doc/git-bisect: clarify `git bisect run` syntax
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: cousteau via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

> the patch subject becomes a bit outdated with this addition.

Right; I wanted to change it to something like "clarify `git bisect
run` syntax and other minor changes" but wanted to keep the title
concise.
I guess I could change it to just "clarify `git bisect` syntax" though
remove the "run").

> the following two lines are already referencing placeholders
> <term-new> and <term-old>

That's why I added it; that `(bad|new|<term-new>)` felt a bit awkward
with no previous explanation of what <term-new> was.

> ...now we have an inconsistency again since this text just uses the
> generic <term>. However, I haven't convinced myself that we need to
> care about this inconsistency.

I thought about that, but in THAT case it wasn't necessary because
<term-new> and <term-old> are never used there (and I wanted to avoid
making -h too long).  But it's true that it feels inconsistent; I may
add it just for the sake of consistency.

Overall, maybe I should leave that change to a separate patch, even if
it's a minor correction.  (This made more sense when I had in mind the
plan to move everything from description to synopsis so I would need
to touch all those lines anyway.)  The changes will be compatible
anyway (they're far away enough to not cause merge conflicts).  What
do you think?
