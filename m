Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27CE30F82
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgSRRD+A"
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF09E
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:00:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9adca291f99so1286480566b.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697734804; x=1698339604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dqEFKc8JDNA1J3eZuXg9xS33nz6t+OV3ExVcXq/cDp0=;
        b=hgSRRD+AP6cvb/7ZPxa6Fm/LBYenXpr1nTAcmeGhLBFKnPIYul8RzH62XGSReEfeD+
         5Nh7kV5VmncGXP0wF5Ug6jU9o/0x9XyxdAttMgR+i0yBuUjLDh2v1NYYUyXgfCrQAkk3
         MiovUC3QQC1nehfuCSG5AiMZP4q/HyhIIzBoeOhXgN7+SbntWFfKtcHilRgGhGHxaD2k
         Pm8rQgTyrXM4kVUBkq7ZHTZjlS665w5e+ECwhQdTq/NSIp2//xJAUzRzndoGIV/EZoae
         ZWtTLC7/6SpiN500m+D1btzKAJbxKkhf4GIe7FsXyv5bRTJp9pI0ro3hTIQst7DNMDHJ
         U3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697734804; x=1698339604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqEFKc8JDNA1J3eZuXg9xS33nz6t+OV3ExVcXq/cDp0=;
        b=NI3tK30eW1gwNCVusth5FizL3UmzsBUidBYgz4KOjM18EjWco/r6/RwFUu4/6kZ7ne
         0Sy8LohAoIoWex23r398IMdKmk/DqhIEECZIbPcK6fxtK1l5YyxICKw3iWlngXQm07Dp
         UPOSBa5rrcJ+eE5SFEKsyI2zJdSkAKM5vXRVyd8FD4tiGQKghqiyaSNA81cbr4exWYIN
         ulvhcZ0e0tPBGiDlmcgl1PpbulHCzx03kIxaA8o0EQnKqQx2oI+GCjqLe0bMiQhjjo1O
         LSp4KaQacEjHW4iY1r/e/beodeLXlfEhAa55QLAie9veglwnk/+VFFQiGI7a2hnLhTHb
         KJBA==
X-Gm-Message-State: AOJu0YyAhYPXYoCqNbNw9ZOn4MVmccuTKWCVcvlgcS1SdSq3SeYy3ZOz
	jHnT8ddzh9XiX4bFuyMCaRc=
X-Google-Smtp-Source: AGHT+IHK0HIbPs/HlVCtJHMk+J39VxcYHefv4Hlv6nEXToKIcGrDW6vCZ8qJAm0aJ1xN6gPI1wpVjg==
X-Received: by 2002:a17:907:986:b0:9c3:607b:52c2 with SMTP id bf6-20020a170907098600b009c3607b52c2mr2565148ejc.30.1697734804109;
        Thu, 19 Oct 2023 10:00:04 -0700 (PDT)
Received: from localhost (94-21-146-154.pool.digikabel.hu. [94.21.146.154])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090626cb00b0098f33157e7dsm3832504ejc.82.2023.10.19.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:00:03 -0700 (PDT)
Date: Thu, 19 Oct 2023 19:00:02 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #04; Tue, 10)
Message-ID: <20231019170002.GA9904@szeder.dev>
References: <xmqqwmvuosf3.fsf@gitster.g>
 <ZSb292VxDQoeSu2o@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSb292VxDQoeSu2o@nand.local>

On Wed, Oct 11, 2023 at 03:26:47PM -0400, Taylor Blau wrote:
> On Tue, Oct 10, 2023 at 06:32:16PM -0700, Junio C Hamano wrote:
> > * tb/path-filter-fix (2023-08-30) 15 commits
> >  - bloom: introduce `deinit_bloom_filters()`
> >  - commit-graph: reuse existing Bloom filters where possible
> >  - object.h: fix mis-aligned flag bits table
> >  - commit-graph: drop unnecessary `graph_read_bloom_data_context`
> >  - commit-graph.c: unconditionally load Bloom filters
> >  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
> >  - bloom: prepare to discard incompatible Bloom filters
> >  - bloom: annotate filters with hash version
> >  - commit-graph: new filter ver. that fixes murmur3
> >  - repo-settings: introduce commitgraph.changedPathsVersion
> >  - t4216: test changed path filters with high bit paths
> >  - t/helper/test-read-graph: implement `bloom-filters` mode
> >  - bloom.h: make `load_bloom_filter_from_graph()` public
> >  - t/helper/test-read-graph.c: extract `dump_graph_info()`
> >  - gitformat-commit-graph: describe version 2 of BDAT
> >
> >  The Bloom filter used for path limited history traversal was broken
> >  on systems whose "char" is unsigned; update the implementation and
> >  bump the format version to 2.
> >
> >  Reroll exists, not picked up yet.
> >  cf. <20230830200218.GA5147@szeder.dev>
> >  cf. <20230901205616.3572722-1-jonathantanmy@google.com>
> >  cf. <20230924195900.GA1156862@szeder.dev>
> >  cf. <20231008143523.GA18858@szeder.dev>
> >  source: <cover.1693413637.git.jonathantanmy@google.com>
> 
> Great, thanks for noting that you saw it ;-). I think that this one is
> ready to go, but I'm obviously biased and I'd feel better if Jonathan or
> Gábor (both CC'd) would take a look before you merge this down.

The test I posted in 20230830200218.GA5147@szeder.dev checking
different Bloom filter versions in different commit-graph layers still
fails in current seen.

