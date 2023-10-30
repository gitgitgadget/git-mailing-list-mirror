Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283B1CF9E
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MXc24V9I"
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8910B
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:51:51 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5ac376d311aso48038127b3.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698702710; x=1699307510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPpeLU/CqmPoSbOhWCh9fvYBWIS21wLMJiL7JP3XSDQ=;
        b=MXc24V9IFSEhXIrrmGu0J0Wdj3h53t1+jcvH8QbqXEnvOFx0g0SECQKEXM1fmGGovS
         Ymj5887IEta+0xzaU3xoqUUz38bigbYsAK46qmma0P8gLZxpq4mty7WCwnKXcRoKIWWB
         e/yWk06nNLBBVNJW3idYsLbNpoJVDuCpPWH+WYK8K37mYY9JLYztlmEcLIOS82Tstr5M
         C0agYymhM4TGY9GZBg6NanNITvNghD96d6/PNrLLt/GUkTe9uBl+4mAEmW321kUx+aiP
         LBQYWGqxOhNrJa/mWRxwKt3gXOpoyNaQMAJ94mPIassb4kQHIYv1A5zF55i3rn9RC11U
         /+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702710; x=1699307510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPpeLU/CqmPoSbOhWCh9fvYBWIS21wLMJiL7JP3XSDQ=;
        b=J9TWGQtmh4or7bOjk55Y93GKCX5UA/plvCPj+bCZTtXnvd+MIHXzYaIvyJppwxBwPQ
         g1kPMn3c92uYQel2RETBSJaNiaH1KskaS+DcLnu5I8mlHM8o9yeYRY/BcjtRU5YIT5R+
         q5Ymme5OoZp+0D+R+42Du6WF9mglhmziB3/XmFKVlPinKgN2ytCOBUN3M+odjHqcZmix
         t5pRd+Fu/p3AL8CM87aHX4m9toDjyEHm69KWy+mlF3utxcRBo6wVyZMWYL1P/FHcPO+l
         0HnHaO1O5TzlmANemx/LS4u/nZf5V9QABxo81Yyr8Bxkbe5VkHkDIJ/RJTLoxdv2Wt97
         9Neg==
X-Gm-Message-State: AOJu0YyFsUp4RmJsBwe2yxe5DxSwo7I7H4sz+ZbnUvK+YQvP05sID0Hv
	nmbZWfKaPQ66mjV7gWBNcWId9QxaL9s+wMiYPfuDKQ==
X-Google-Smtp-Source: AGHT+IGTzhIKVVOGXzI0qxxO83kNhgNIX3LNQ0m7x4K9hEErc0kw7R20/5ePBtoY0FgitQ44LKSznA==
X-Received: by 2002:a81:b643:0:b0:5a7:d997:cc7b with SMTP id h3-20020a81b643000000b005a7d997cc7bmr12391638ywk.23.1698702710325;
        Mon, 30 Oct 2023 14:51:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a81df01000000b00592548b2c47sm191536ywn.80.2023.10.30.14.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:51:50 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:51:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/git-repack: don't mention nonexistent
 "--unpacked" option
Message-ID: <ZUAldFRSj/HLGjOQ@nand.local>
References: <cover.1697440686.git.ps@pks.im>
 <aa0b4fef4d8397983676394472ff86e468bfc687.1697440686.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa0b4fef4d8397983676394472ff86e468bfc687.1697440686.git.ps@pks.im>

On Mon, Oct 16, 2023 at 09:19:56AM +0200, Patrick Steinhardt wrote:
> The documentation for geometric repacking mentions a "--unpacked" option
> that supposedly changes how loose objects are rolled up. This option has
> never existed, and the implied behaviour, namely to include all unpacked
> objects into the resulting packfile, is in fact the default behaviour.
>
> Correct the documentation to not mention this option.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-repack.txt | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index dfd2a59c50..d61078b697 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -226,11 +226,8 @@ uniquely by the set of packs being "rolled-up"; in other words, the
>  packs determined to need to be combined in order to restore a geometric
>  progression.
>  +
> -When `--unpacked` is specified, loose objects are implicitly included in
> -this "roll-up", without respect to their reachability. This is subject
> -to change in the future. This option (implying a drastically different
> -repack mode) is not guaranteed to work with all other combinations of
> -option to `git repack`.
> +Loose objects are implicitly included in this "roll-up", without respect to
> +their reachability. This is subject to change in the future.
>  +

Oops. This refers to the "--unpacked" option that pack-objects takes,
not repack. I agree that mentioning "--unpacked" is too low-level a
detail for this user-facing documentation, so even something like:

    When `repack` passes `--unpacked` down to `pack-objects` (which is
    the default) ...

would be too much detail for this man page.

I am very happy with the patch here as an alternative.

Thanks,
Taylor
