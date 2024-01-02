Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A616401
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HgSZDTQJ"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbc649c275so2616643b6e.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704225411; x=1704830211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TgNLpyThFHWPYNBW+n3lZuq7dJmJdn70KIi8AGrNaU=;
        b=HgSZDTQJm115x9n6T+xQhc0spmOqH8fXLY0ikD6L1mIbxx9aWcaXrDvL+jkLGGcSNr
         OI/9d9wwNK5vsN7gedQdQz+10hoFMf3ZbxL81hE8Ay9IWohMzT4k6VEwiHe5nZ077Vsm
         rB7h9iOVNNomNOJBKMQdxzYr5Bmmuq6/yk2pPXyj/HAYrJp5WlFRq28egGBitiJEzhRX
         3aQ6ocJG0polzx4qMKkEEVDz1BGoNYEyxws4daqpDe+LxQ8qsn1lO3JYN7u0ofzg7juC
         YaL/9pCUXhJYNnWa5EZ9fPKV+BUyiSvXg7l/EylvgJsVn/qsiNoQn++nv5WlMOc6DjRQ
         FJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704225411; x=1704830211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TgNLpyThFHWPYNBW+n3lZuq7dJmJdn70KIi8AGrNaU=;
        b=RpWDQluICWPZ1C7ZDji7e0MS6r0dLSI+1rPPrf04566vWCaDj83ZFhH0SUB7cbhGkt
         isEiV0ADhhLWDcl1/msTgeCXNr+Kmwaz79SOv5VVZJqGGxPnKzZABOIBH85GAMto3nel
         j53cJc8DOlnzxQEbevlz0rEqhFM9Yy5RqrWeSO0jAdSmMz/fF50DMiLBQ/G5G5UsP8DR
         Elnq7mbBs62IKtl0ZDlVWt7sY/HiVewe2BEXyTh0/hi0rU4h47uHIxTwPriHmhjZ6vqC
         GOSTc5zuSVD3c6+EcTfcRAjRhrra39VgnvATLaVvu2qL+wcTCM1ElFEGj++VzObCJAKF
         9Uvw==
X-Gm-Message-State: AOJu0YyehY12rZFVAPatZwN/ikEF2qn1H59CqzW02bjUVkF4rIgMB1yA
	4FpVHg2AZpbkCw2RrVaa/F9D0BpVb76fKyAbsQ8OaPiGxPCmuA==
X-Google-Smtp-Source: AGHT+IGylkVFOAAR82YUU027hJ3RpdKA+jU2plzpXvbUtVDFu4ieHntqgfVjvyukNBoaafzgQGW7Ow==
X-Received: by 2002:a05:6808:152c:b0:3b8:b063:8938 with SMTP id u44-20020a056808152c00b003b8b0638938mr9053551oiw.70.1704225411699;
        Tue, 02 Jan 2024 11:56:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y16-20020a056808061000b003bbc235c5d0sm1953581oih.24.2024.01.02.11.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:56:51 -0800 (PST)
Date: Tue, 2 Jan 2024 14:56:50 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jakub Wilk <jwilk@jwilk.net>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-clone.txt: document -4 and -6
Message-ID: <ZZRqgmDycyAXCrGZ@nand.local>
References: <20230527123849.5990-1-jwilk@jwilk.net>
 <xmqq1qivd8d0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qivd8d0.fsf@gitster.g>

On Thu, Jun 01, 2023 at 03:06:35PM +0900, Junio C Hamano wrote:
> Jakub Wilk <jwilk@jwilk.net> writes:
>
> > These options were added in c915f11eb4 ("connect & http: support -4 and
> > -6 switches for remote operations").
> >
> > Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
> > ---
> >  Documentation/git-clone.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> The patch is not _wrong_ per-se, but there are other options that
> are common among the "fetch" family of commands.  I counted at least
> these should be shared between "fetch" and "clone", by splitting
> them out of "fetch-options.txt" into a new file, and including that
> new file from "fetch-options.txt" and "git-clone.txt".  Those marked
> with (?) are described in different phrasing between "clone" and
> "fetch", and may fall into the "let's keep them separate, because
> they mean different things" category (later):
>
>  * --jobs
>  * --upload-pack
>  * --quiet (?)
>  * --verbose (?)
>  * --progress
>  * --server-option
>  * --ipv[46]
>
> Note that these happen to share the same name, but to "clone" and
> "fetch" they different things, so leaving them separate is the right
> thing to do.
>
>  * --no-tags
>  * --recurse-submodules

I wrote this ugly shell incantation to find an exhaustive list of
potentially shareable options:

    $ grep '^-.*::$' <Documentation/fetch-options.txt |
      tr -d ':' | sed -e 's/\[=/=[/' -e 's/<[^>]*>//' |
      grep -Eo '^[^=]+' | awk -F] '
        /\[no-\]/ { print "--" $2; print "--no-" $2; next }
        { print $0 }
      ' |
    while read arg
    do
      if grep -Fwq -- $arg Documentation/fetch-options.txt &&
         grep -Fwq -- $arg Documentation/git-clone.txt
      then
        echo $arg;
      fi
    done

It turned up the following results:

    -a
    --depth
    --shallow-since
    --shallow-exclude
    --no-tags
    --recurse-submodules
    -j, --jobs
    -u, --upload-pack
    -q, --quiet
    -v, --verbose
    --progress
    -o, --server-option

-a is a false-positive (it comes from "you can simply run `git repack
-a`", which is in the clone documentation).

Even though depth, and the shallow options are shared by both fetch and
clone, they have different wording in each context, so they should be
kept separate.

I agree with your thinking that `--no-tags` and `--recurse-submodules`
should be kept separate.

That makes our two lists equal (modulo the --ipv[46] options, which were
previously not documented in git-clone(1) until this patch).

Thanks,
Taylor
