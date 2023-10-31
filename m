Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB961DFDE
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Ey0pVcz0"
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC1A6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:22:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4801785a12.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1698776545; x=1699381345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95t4zqGGRVbL1AM5qIZbEF+JqMlseOvMK7Zn9DAKQMI=;
        b=Ey0pVcz0J3KvjJu8DFb4za/PXT4hIvsoiwqRLbfS7ZDRSa0Llf+VxMxirhZjYL3f4j
         Lk+0U6lKgNUKb4sb4jk8i90vCWKRfMiYVaXiGltVaJaOsguPAd3Aer/4DVEPQRAZth8I
         ZQYe+2BVJUA5z++DMRuFHTDFY2x4Ln1alW3oFZhxnh72346/B5IHUIF8rHdIZqrpJacF
         FZkGNYbsViMX1epKBqVwyMzpXRx4Wl0/VAZhQr3e6eCzlAB/zQ63tJ0CqHlrsvpEDJAs
         jEGF8g+6oPo4sUF5/xnxtX0Pme9A56aUCcpB6iVN1JHvC60jD64x1jcoJCuIlz6ah8fV
         lPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698776545; x=1699381345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95t4zqGGRVbL1AM5qIZbEF+JqMlseOvMK7Zn9DAKQMI=;
        b=FB/K2cd/6t6d3kGN3hCI6y4Y7sUCn5Xxrfim1r6I8JvFFqAwct9Goyu6gFkfgpGXNf
         m4yspnoS+vmfV7gxtRWtINcMpJECnnU3/p5imf+PTdE3Sx5hREr/rO+GiRPBC53vXgqd
         ncNgQnFEGbEpt7aycxt/7s0v5kYR8gXScPvIG7hf8P2Ti35kxEYPuSmEAl49Jk30wytQ
         TFkPNCfxeGkrfEbb9mFRf3MyqB8nxOeabs2/zn0QeUn5/Ih27ev2leLmJPKHpkwQ3zhs
         4o1f8efnnOWcFQZhZG0NaMFSjVUfagnRJG1qtiNL9wwCgR9fbkKKnoqbroW1rVYOmYrD
         c20A==
X-Gm-Message-State: AOJu0Yxys2seWhRXplflbkqBa5N9o2mk1cIpmaEpWfjPIiyiyHsTEfIe
	T3rbDFMmTMRlewFkiBL3s2NU
X-Google-Smtp-Source: AGHT+IGfL0OQZ2eKGfQvJQ9OObZbLbR40ly+OHfc8/jEuw/RD6H7jhht65xBweZZvHQ/sCyjlaZH5w==
X-Received: by 2002:a05:6a21:6d9c:b0:162:4f45:b415 with SMTP id wl28-20020a056a216d9c00b001624f45b415mr17977143pzb.51.1698776545266;
        Tue, 31 Oct 2023 11:22:25 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id c17-20020aa781d1000000b0068790c41ca2sm1544353pfn.27.2023.10.31.11.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 11:22:24 -0700 (PDT)
Message-ID: <8e4d111f-3982-4989-90b5-08377fe9c5fd@github.com>
Date: Tue, 31 Oct 2023 11:22:23 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] ci: add GitLab CI definition
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698742590.git.ps@pks.im>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <cover.1698742590.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> Hi,
> 
> this is the fourth version of my patch series that introduces support
> for GitLab CI.
> 
> Changes compared to v3:
> 
>     - Stopped using nproc(1) to figure out the number of builds jobs for
>       GitHub Actions and Azure Pipelines. Instead, we now continue to
>       use the hardcoded 10 jobs there, whereas on GitLab CI we now use
>       nproc. We can adapt GitHub/Azure at a later point as required, but
>       I don't feel comfortable doing changes there.
> 
>     - Improved the linux-musl job. Namely, we now also install all
>       required Apache modules, which makes the Apache-based test setup
>       work. There is a packaging issue with the WebDAV module though, so
>       we now skip tests that depend on it on Alpine Linux.
> 
> I still didn't move `.gitlab-ci.yml` to `contrib/`. As Taylor argued
> (and I don't disagree), moving it to `contrib/` would convey the spirit
> that this is _not_ an authoritative CI pipeline setup. But I wanted to
> hear other opinions first before moving it into `contrib/`.

I've read through some of the earlier discussion on this (as well as your
original cover letter [1]), so I'll throw in my 2c.

The majority of the changes in this patch series aren't conditioned on
anything that says "gitlab", they just improve the flexibility of our CI
scripts. I personally didn't notice anything too cumbersome added in the
series, so I'm happy with all of that (essentially, patches 1-7 & parts of
8).

As for adding the GitLab-specific stuff, I'm not opposed to having it in the
main tree. For one, there doesn't seem to be a clean way to "move it into
`contrib/`" - '.gitlab-ci.yml' must be at the root of the project [2], and
moving the $GITLAB_CI conditions out of the 'ci/*.sh' files into dedicated
scripts would likely result in a lot of duplicated code (which doesn't solve
the maintenance burden issue this series intends to address).

More generally, there are lots of open source projects that include CI
configurations across different forges, _especially_ those that are
officially mirrored across a bunch of them. As long as there are
contributors with a vested interest in keeping the GitLab CI definition
stable (and your cover letter indicates that there are), and the GitLab
stuff doesn't negatively impact any other CI configurations, I think it
warrants the same treatment as e.g. GitHub CI.

[1] https://lore.kernel.org/git/cover.1698305961.git.ps@pks.im/
[2] https://docs.gitlab.com/ee/ci/index.html#the-gitlab-ciyml-file

> 
> Patrick
> 
