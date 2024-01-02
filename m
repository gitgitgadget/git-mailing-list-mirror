Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0B16410
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PuasZFz8"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc076e9e59so3158956a34.2
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704227782; x=1704832582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Or5xKPlHJ1jnUdF3X5w16ul2J5ic4bsV8Gurwy23T6M=;
        b=PuasZFz8nXWVaQa7zgFgVethGLtPMaoYSEHGuvQe9KmM6zauz22m2DjRXKCyEgTzFn
         ALz+FTu5+nxLBdxC58duu/9cP3VhnKkcaHZ8oZVxGY1KAQQeXjUVIzS7CBlB4taYu6Uf
         y8SPj/end77lbu3Wm22nlD4J5ieF8IfCSv7/qkLxE5+Hmom5rr/t1ecRtI8FdaVVhJeY
         Snv6PZlMazlcEWATdrqPEpqiQBJAyHa58Y//TfhEFtwgcckP0uf6/DESdI2BxqxPTmAy
         eroP0c2ZCR4R2fUxBdGmShMzb75gXcu7Xl4GBRKSigUkX1bDQkGLyp/BYhrWQqa4RrEh
         FL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704227782; x=1704832582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or5xKPlHJ1jnUdF3X5w16ul2J5ic4bsV8Gurwy23T6M=;
        b=wcx9o4hBDLaamArMOnuA4wAO2R9qocbBYSH4uF7Qf4gRdwjaj8VPDAbm5G83+rE14A
         EXSe7aCu6m8xCndXkRJlDAeL4GiteMeOCR5x7BQzhV7WyHXB6waeOkTDazBUfFuTRK4t
         uKGtjP8MCMlOg5/hR5C17hhbehJ1rIFuarqIsH4DKcJs+1guBwqyl6WWNhQzJaNn7bbO
         /cMiz966t0G/ZXwJn13JTLjBghZRskrQ2tkje46qsySMSiZQ03y7htCPJAoYtoX5BC7o
         IuQ9O6detWcY/QZ09+/cN1EdYSpXNE+A43NlPyH/XoyiO9YotORfEC7cQlPfGpSBKAAG
         Cv8g==
X-Gm-Message-State: AOJu0YynchxXLePa3+zWWFknRBE0cKNETbvjBM1OE7HeznSQbTyLZAXt
	5DaaGxG1h868wy/X8TvgPIKvVOisuSm7rPTLUDDWq0kD4g0jbA==
X-Google-Smtp-Source: AGHT+IEPfO4UbsTNlTTvUBSUJHCII7IEZpUsioSqoMo2BDG02TBQBcOWI7xfp7FYMaHVKQN5zbUQnw==
X-Received: by 2002:a05:6830:1e66:b0:6dc:2da9:90be with SMTP id m6-20020a0568301e6600b006dc2da990bemr4867358otr.67.1704227782403;
        Tue, 02 Jan 2024 12:36:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z9-20020a9d65c9000000b006ce2c31dd9bsm4145201oth.20.2024.01.02.12.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 12:36:22 -0800 (PST)
Date: Tue, 2 Jan 2024 15:36:21 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jakub Wilk <jwilk@jwilk.net>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-clone.txt: document -4 and -6
Message-ID: <ZZRzxZNb2Aq+2feW@nand.local>
References: <20230527123849.5990-1-jwilk@jwilk.net>
 <xmqq1qivd8d0.fsf@gitster.g>
 <ZZRqgmDycyAXCrGZ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZRqgmDycyAXCrGZ@nand.local>

On Tue, Jan 02, 2024 at 02:56:50PM -0500, Taylor Blau wrote:
> It turned up the following results:
>
>     -a
>     --depth
>     --shallow-since
>     --shallow-exclude
>     --no-tags
>     --recurse-submodules
>     -j, --jobs
>     -u, --upload-pack
>     -q, --quiet
>     -v, --verbose
>     --progress
>     -o, --server-option

Hmm. I think the story is a little more complicated. Just looking at the
ones that we agree on:

  * -j, --jobs
  * -u, --upload-pack
  * --progress
  * -o, --server-option
  * --[ipv]4
  * --[ipv]6

Note that the 'clone' and 'fetch' versions for many of these options
have different wording. For example, in Documentation/git-clone.txt we
have:

    -j::
    --jobs=<n>::
           Number of parallel children to be used for all forms of fetching.

Whereas the description in the original fetch-options.txt is more
verbose.

In fact, the story is even more complicated than that, since even though
the 'push' builtin would benefit from having a shared source of
documentation for the --ipv4 and --ipv6 options, 'push' does not have a
--jobs option.

'clone', 'fetch', and 'pull' all share an '--upload-pack' option as you
note, though 'push' naturally doesn't (so we would need another ifdef
there, too). But the instances in 'clone', 'fetch', and 'pull' all
differ in their wording (e.g., the 'clone' documentation says "the
repository to clone from ..." but the others say "the repository to
fetch from ...").

--progress could be shared, as could --server-option, and the two
--ipv4/6 options. But the number of nested ifdefs necessary to share the
other options probably dose not justify the effort to do so.

Thanks,
Taylor
