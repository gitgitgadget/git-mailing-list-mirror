Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938412E64
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zoHum5z0"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC2DF
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:46:47 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6711dd6595fso9437546d6.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698680806; x=1699285606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEZZcMfQLx4UsOSQw8C4v661PNzUGzsXZzbxy6Ia/bw=;
        b=zoHum5z0mbGCwNxTOw1KlsJelnLCLKuVWi334xZb8Wd93FiuvqtpAvoI5dn4IenSv1
         IRL4PjHZGxKXzZI2Y8GtiImUJPlhQr8hDYsaV1MKfqAgleWtX4B/cE/KHcVbY/x91MDk
         JvAwHkYxvRNN3uaMINhfcbvvT0Z1NAjlaOYXg4XGku/CetYesEAQVXmJyag9sPV6QRzL
         m+IpPOXVbpFaISDvbd/NOFsFA6AgrPu9XAKlsAxQwuxmmTxqga7QJ7WgRp+Qcw09VfrS
         sGdEjB3M510q+joDzBVXhegVtRqlskWj67thd5DrX/5sNd2uski+wV7D/b9dWN6/4Hfh
         lRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680806; x=1699285606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEZZcMfQLx4UsOSQw8C4v661PNzUGzsXZzbxy6Ia/bw=;
        b=Ov0x4Lj7lTwfzVm550wFt8W4qwGSeNMJVIxpJUkbQVi/JswZ6aoL1E3tZ0bL9KcI6M
         CazL0ekNwA9/nzB0bzUxK4NNwhBe3S6axQg5p5+IhZ9k6MHvigAFIuuclNcf9zp6EyOF
         INS5uIBBY3modTGNzaqeOzLlXjvUirIbAR7guNrCe+OAouyHAKJnnd6wazFpCFbcx+rj
         j9sPTLtn6KjIQA1YITWted+h4HJ6x773gnBlzYJR0W9WmEkJOspeE4dpl0Z/bHS6yTXC
         EUqZNIVcmuf+BhLD7PE9qTsf8EtsetV8vlpxQkc0UIOiOL649RF+OMeApipd6kZsAn+3
         gifQ==
X-Gm-Message-State: AOJu0YxrV26OJEkKYBgOcco23Zce01CNBK3DpXoRIIGOD9Ta9hOF6MFf
	5SwcaKHBlXih3YwB9r7rgknaDeeiBi7dOf9kUvbG/Q==
X-Google-Smtp-Source: AGHT+IFVo4IHIezYj0ZG34IhZy0P32emhGHQ1UDAFxr/XxCl3mZQqBBYE/bYH/mCxWY3iRejDWWfPA==
X-Received: by 2002:a05:6214:acb:b0:671:3893:f4df with SMTP id g11-20020a0562140acb00b006713893f4dfmr5221931qvi.10.1698680806071;
        Mon, 30 Oct 2023 08:46:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t10-20020a056214118a00b0066d23395d27sm3508877qvv.123.2023.10.30.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:46:45 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:46:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] ci: add GitLab CI definition
Message-ID: <ZT/P5Bl9lD9V6ID9@nand.local>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>

On Thu, Oct 26, 2023 at 09:59:59AM +0200, Patrick Steinhardt wrote:
> And this is exactly what this patch series does: it adds GitLab-specific
> knowledge to our CI scripts and adds a CI definition that builds on top
> of those scripts. This is rather straight forward, as the scripts
> already know to discern Azure Pipelines and GitHub Actions, and adding
> a third item to this list feels quite natural. And by building on top of
> the preexisting infra, the actual ".gitlab-ci.yml" is really quite
> small.
>
> I acknowledge that the Git project may not be willing to fully support
> GitLab CI, and that's fine with me. If we want to further stress that
> point then I'd also be perfectly happy to move the definitions into the
> "contrib/" directory -- it would still be a huge win for our workflow.
> In any case, I'm happy to keep on maintaining the intgeration with
> GitLab CI, and if things break I'll do my best to fix them fast.

I don't have any strong opinions here, but my preference would probably
be to keep any GitLab-specific CI configuration limited to "contrib", if
it lands in the tree at all.

We already have a rather complicated CI setup on GitHub, which I think
we generally consider authoritative in terms of determining whether "CI"
is green. I know we have some Azure remnants in "ci", but I'm not aware
of any of the details there.

So I have some hesitation about trying to mirror this rather complicated
set of build rules in another CI environment. My primary concern would
be that the two might fall out of sync and a series that is green on
GitHub would be red on GitLab, or vice-versa. Importantly, this can
happen even without changes to the build definitions, since (AFAICT)
both forges distribute new images automatically, so the set of packages
installed in GitHub may not exactly match what's in GitLab (and
vice-versa).

My other concern is that we're doubling the cost of any new changes to
our CI definition. Perhaps this is more of an academic concern, but I
think my fear would be that one or the other would fall behind on in
implementation leading to further divergence between the two.

I think having the new CI definition live in "contrib" somewhat
addresses the "which CI is authoritative?" problem, but that it doesn't
address the "we have two of these" problem.

So my preference would probably to have this live out of Junio's tree,
but I'm curious to hear what others think.

Thanks,
Taylor
