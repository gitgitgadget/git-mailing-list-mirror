Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8770101D3
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbwvS+kS"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E8F122
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 10:54:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso102660b3a.3
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861279; x=1699466079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N3etgKns4YwERc1U9nh4/K3mYDojPhdwJlcf7PU/ZU=;
        b=BbwvS+kSBzzgYYplJkCiG4P1fZO+171EJVm1F1nA0BsS9bMOklej36uvi+1vPF9RQ8
         x8F/aps0aD3ISiWpwD8M5XYesWNdQGkkBaieRFl76ZnRm1KDV1MqqWN+eFnABhUCumXA
         8oJby0N7/g/KNla0X0hLP0IW/d1cLD9J1eW1WSCPg2xYGD3a8+aP6VC3zMv0rokQDYMx
         650UJ7tC+OoqYUKnmyS7m1ORurGiM/GOF9HiuYDrM9vd6RGUF852VDlizw+WZQW1DQ3Y
         JlRaOMszAt9zpkrxij56YI3QNlkqBaD3UEjw3PqkWIStXA1frt1U9TGeDF8lASsR9s8d
         T3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861279; x=1699466079;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2N3etgKns4YwERc1U9nh4/K3mYDojPhdwJlcf7PU/ZU=;
        b=f7Kw1DAqIAr8cWwJH7bIZJ70PeEUXICXZVPnS+rsUTiUrtPRCTA2y2kcHv+9H6808j
         7BwAiOA/Fd8YT19KLzgm/Q7r6nFjXsKdJlFajD4PQlhN73pKSxl3qoTho+VjzVlrnw1D
         cdM3adJ/c9AQbMdudXW1To+D2uL+fRIbgn5q6RksLc87NI1msCd5hKN/2iP9B5bKVDNv
         siB+HroIGuZnphuJhHD2VnTqRs4EHvvvviLfyZSdhu5saA55pgBaX7H2/5O9tadACB/A
         68OJ2SCmYGuKNoRBWzm/FWi0UGLG7O1uX7631XF1MtN9v7qfIoADf9m4DRvnhJrx6DGi
         djCw==
X-Gm-Message-State: AOJu0YxsfCPFnHhzh5vTKaxSoCbNYG6krgngkz9dIhJ9GdJTZ7DZCAJo
	QShiadZu5LMoczPabjkOpfpZAg==
X-Google-Smtp-Source: AGHT+IG4zc03wd2x59NQHhqsvEVLLBlq5DrIUd08nZCSPsPGhbf6bap6B+rogvQzatToAGO4AZs2yQ==
X-Received: by 2002:a05:6a21:3395:b0:17a:cfce:5a30 with SMTP id yy21-20020a056a21339500b0017acfce5a30mr15843552pzb.16.1698861278836;
        Wed, 01 Nov 2023 10:54:38 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:22ea:81ca:f3ec:8bce])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902db0800b001b9dab0397bsm1598795plx.29.2023.11.01.10.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:54:38 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:54:33 -0700
From: Josh Steadmon <steadmon@google.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: calvinwan@google.com, git@vger.kernel.org, gitster@pobox.com,
	linusa@google.com, phillip.wood123@gmail.com,
	rsbecker@nexbridge.com
Subject: Re: [PATCH v8 2.5/3] fixup! unit tests: add TAP unit test framework
Message-ID: <ZUKQ2eYmfMEhc_gH@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, calvinwan@google.com,
	git@vger.kernel.org, gitster@pobox.com, linusa@google.com,
	phillip.wood123@gmail.com, rsbecker@nexbridge.com
References: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
 <20231016134421.21659-1-phillip.wood123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016134421.21659-1-phillip.wood123@gmail.com>

On 2023.10.16 14:43, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Here are a couple of cleanups for the unit test framework that I
> noticed.
> 
> Update the documentation of the example custom check to reflect the
> change in return value of test_assert() and mention that
> checks should be careful when dereferencing pointer arguments.
> 
> Also avoid evaluating macro augments twice in check_int() and
> friends. The global variable test__tmp was introduced to avoid
> evaluating the arguments to these macros more than once but the macros
> failed to use it when passing the values being compared to
> check_int_loc().
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/unit-tests/test-lib.h | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Applied in v9, thanks!
