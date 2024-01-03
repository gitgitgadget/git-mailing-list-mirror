Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BF1BDCE
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="juIymQ0m"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbe583e04so3398086b6e.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 08:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704300215; x=1704905015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Xk/HM4Y26mzn96jJ8xs5DXboYOA+NrwZ7D3Bo4HJeA=;
        b=juIymQ0mMMelGsgQBUzQxUu00oRyUi00D8OKcWCCGHku5rlFbPIpUuEsYekUp/Zik/
         1zc9JHOlqwWr628XidF/2tuH+YulesEg/GDycJqe5QlRIO8pNSt6fPYpYFYJiRsGZTHS
         qn6N4Ou4vRow7QyPwv7B+ONn1XodVNOHUqA7lBKrwJ26ezgnBKbjN1pKeEfd2X092wBi
         RU4tltSZMELisB/+Mt27WPzOG1I51MckwiHWeaxHcfcZnRzBFsD7mmVb9ooC8A4CWCon
         81BEdRGOrCDZbOsI6uV/ObVHHOqjwO1OaY4j3O/YRs2s0+ZFF0c46meEHAh06qvff30C
         nPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300215; x=1704905015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xk/HM4Y26mzn96jJ8xs5DXboYOA+NrwZ7D3Bo4HJeA=;
        b=eEz7TUDZ1lQTrahqtNlnnTIZXNIZu4J7HA9KLbEDisGevT7FWLyzEpfPFAFc7rNx7A
         cgn0g5OzzGQ3+eeVWBcSxcKq16lN7IbrAOakGHoIf2BYsfC5Pl2d+7atuQzb3KadFQC5
         YoJuvFySvZGvfOJAFlKmeea/PiTG6iXjwUECmDsvD7fU8dHSndVqBBYw3GiAafKm+V+2
         xiUdXMqYKTcO6ia6sxtfqBtw1y4CDUoVlfbYBB8Qw2xHo0P0WhWCqJkrTimsswcRCPI9
         YkQOi25TJpkIoSH+LqNmnKkoOORxN/mQ1cGhIZyel1iv6FCt36X1S/46XyuNKwejttnz
         +b2w==
X-Gm-Message-State: AOJu0Ywj6T4yeHKp6G0nM/GwX+WH6Fam5tmhTWkB5e4vOeHGWhAw96uB
	Kb/zbXf5WLvVJJLZnuWUqx3W1ziA3HVaaZ2ex0u4ecQO4h4w9A==
X-Google-Smtp-Source: AGHT+IE4UpxhO25KUq6sIdMLZSOxiXn1sdlrBClSxDlhfTsSGu4RdEUbuVhISmY1QonP0Nab5YUshQ==
X-Received: by 2002:a05:6870:418c:b0:203:ebf4:2c52 with SMTP id y12-20020a056870418c00b00203ebf42c52mr9274654oac.47.1704300215475;
        Wed, 03 Jan 2024 08:43:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pa37-20020a05620a832500b00781a8946c52sm3296827qkn.84.2024.01.03.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:43:35 -0800 (PST)
Date: Wed, 3 Jan 2024 11:43:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <ZZWOtnP2IHNldcy6@nand.local>
References: <xmqq5y0bcjpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5y0bcjpw.fsf@gitster.g>

On Tue, Jan 02, 2024 at 05:02:35PM -0800, Junio C Hamano wrote:
> * tb/merge-tree-write-pack (2023-10-23) 5 commits
>  - builtin/merge-tree.c: implement support for `--write-pack`
>  - bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
>  - bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
>  - bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
>  - bulk-checkin: extract abstract `bulk_checkin_source`
>
>  "git merge-tree" learned "--write-pack" to record its result
>  without creating loose objects.
>
>  Broken when an object created during a merge is needed to continue merge
>  cf. <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
>  source: <cover.1698101088.git.me@ttaylorr.com>

Let's drop this one.

> * tb/pair-chunk-expect (2023-11-10) 8 commits
>  - midx: read `OOFF` chunk with `pair_chunk_expect()`
>  - midx: read `OIDL` chunk with `pair_chunk_expect()`
>  - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
>  - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
>  - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
>  - commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
>  - chunk-format: introduce `pair_chunk_expect()` helper
>  - Merge branch 'jk/chunk-bounds-more' into HEAD
>
>  Further code clean-up.
>
>  Needs review.
>  source: <cover.1699569246.git.me@ttaylorr.com>

This one is on my list of things to look at, but probably not something
that I'll get to urgently before I've had a chance to clear my holiday
backlog. If you don't mind keeping it, that's fine, but I won't be upset
if it's easier to drop from 'seen' in the meantime.

> * tb/path-filter-fix (2023-10-18) 17 commits
>  - bloom: introduce `deinit_bloom_filters()`
>  - commit-graph: reuse existing Bloom filters where possible
>  - object.h: fix mis-aligned flag bits table
>  - commit-graph: drop unnecessary `graph_read_bloom_data_context`
>  - commit-graph.c: unconditionally load Bloom filters
>  - bloom: prepare to discard incompatible Bloom filters
>  - bloom: annotate filters with hash version
>  - commit-graph: new filter ver. that fixes murmur3
>  - repo-settings: introduce commitgraph.changedPathsVersion
>  - t4216: test changed path filters with high bit paths
>  - t/helper/test-read-graph: implement `bloom-filters` mode
>  - bloom.h: make `load_bloom_filter_from_graph()` public
>  - t/helper/test-read-graph.c: extract `dump_graph_info()`
>  - gitformat-commit-graph: describe version 2 of BDAT
>  - commit-graph: ensure Bloom filters are read with consistent settings
>  - revision.c: consult Bloom filters for root commits
>  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
>
>  The Bloom filter used for path limited history traversal was broken
>  on systems whose "char" is unsigned; update the implementation and
>  bump the format version to 2.
>
>  Expecting a reroll.
>  cf. <20231023202212.GA5470@szeder.dev>
>  source: <cover.1697653929.git.me@ttaylorr.com>

I was confused by this one, since I couldn't figure out which tests
Gábor was referring to here. I responded in [1], but haven't heard back
since the end of October.

I personally think that this is ready to go, and it would be nice to get
it out of the perpetual "cooking" state that it's in. So if Gábor is
around to reply and I'm indeed missing something, that would be great.
But in the meantime, I think that this is ready to go.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZUARCJ1MmqgXfS4i@nand.local/
