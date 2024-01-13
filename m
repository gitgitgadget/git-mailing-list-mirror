Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15833D7B
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbId0r3P"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e72bca8f3so131355e9.1
        for <git@vger.kernel.org>; Sat, 13 Jan 2024 10:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705170946; x=1705775746; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qiesfFC3rbFlLy3N9OZCFGglatBF+otDWxCrzlPzORY=;
        b=gbId0r3PamwhdPN9Z21sOpA/p+aU9ZkJhGfUInIomKYmle5Z4pVeH38X8zuw1FqPNi
         5e3lN88EWP6F2f8/yb+G8agzF0H8dn9eFHHwdoRTFXskeU902K/IlOmUSe99ZsR2AsRQ
         6z5R3bb0L+nCMzugWziNE5Hq0go2fSZs4ks1rPOXYpxiWGF6LRAYxNUqf0c/ZazWTDCP
         8fI9usvKqhf7G48md63cxsHa778xgRoWhpaCiC8F9IA9F9is9GR2iXhEXRCF0RJNEF+l
         UG5zs5it3PvY43mBbYWEqjNFFmhzBwXWWustVQxNx4l/ULQfU9KQeVnF0UBe1TrH6jAr
         s+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705170946; x=1705775746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiesfFC3rbFlLy3N9OZCFGglatBF+otDWxCrzlPzORY=;
        b=nlmNU3RPe2OMVd70Vyc4AkBfBdYGhWFTULvYp8BnYey2nWa6ZbIR/gK37TpAKWrDUE
         bq70IqLVQxd7tazSpnrIobmdNE2S0g0gUMwKmIi3e7BGZvo9Kv12C0anw6AqGQzvRvUQ
         +NOwt2Ibr5F7I+E68gQgrsZ05FSTXoy4nyjViWvOCDpWphNMzuXtOVHyNqjEVH8PqxGD
         XuQnn146u+yiHe51fkWG1mS0wodmSL4jNBL335iwNcll+D5oVoPAC3uNOP8C8PcICvnN
         28zMpGg1eEbl5UdBoLUJZRFtODxfNXywluCGB0bKwU7LNp7+C42rTswgwPHvU+tFzQIz
         zPcw==
X-Gm-Message-State: AOJu0YygbY8Mq2SN1ouR3WlZjWyN6cP7w5QyFMK5Z7hmMk3+vhP/gQR9
	FzqDjrsfl/7vpFOJfYFLhrE=
X-Google-Smtp-Source: AGHT+IGow/J5L4hlM/umc71N5BTdmT1cjFcaaWt7VNdWCKc1LuzybsKNHhn57cs/3i1boXwHNp7pWQ==
X-Received: by 2002:a05:600c:3b99:b0:40d:86a8:2fe9 with SMTP id n25-20020a05600c3b9900b0040d86a82fe9mr1249358wms.280.1705170945822;
        Sat, 13 Jan 2024 10:35:45 -0800 (PST)
Received: from localhost (84-236-78-166.pool.digikabel.hu. [84.236.78.166])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e45799541sm14018355wmo.15.2024.01.13.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 10:35:45 -0800 (PST)
Date: Sat, 13 Jan 2024 19:35:44 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <20240113183544.GA3000857@szeder.dev>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <ZZWOtnP2IHNldcy6@nand.local>
 <xmqqa5pm9tnx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa5pm9tnx.fsf@gitster.g>

On Wed, Jan 03, 2024 at 10:08:18AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> * tb/path-filter-fix (2023-10-18) 17 commits
> >>  - bloom: introduce `deinit_bloom_filters()`
> >>  ...
> >>  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
> >>
> >>  The Bloom filter used for path limited history traversal was broken
> >>  on systems whose "char" is unsigned; update the implementation and
> >>  bump the format version to 2.
> >>
> >>  Expecting a reroll.
> >>  cf. <20231023202212.GA5470@szeder.dev>
> >>  source: <cover.1697653929.git.me@ttaylorr.com>
> >
> > I was confused by this one, since I couldn't figure out which tests
> > Gábor was referring to here. I responded in [1], but haven't heard back
> > since the end of October.
> > ...
> > [1]: https://lore.kernel.org/git/ZUARCJ1MmqgXfS4i@nand.local/

I keep referring to the test in:

  https://public-inbox.org/git/20230830200218.GA5147@szeder.dev/

which, rather disappointingly, is still the only test out there
exercising the interaction between split commit graphs and different
modified path Bloom filter versions.  Note that in that message I
mentioned that merging layers with differenet Bloom filter versions
seemed to work, but that, alas, is no longer the case, because it's
now broken in Taylor's recent iterations of the patch series.

At the risk of sounding like a broken record: the interaction of split
commit graphs and different Bloom filter versions should be thoroughly
tested.


