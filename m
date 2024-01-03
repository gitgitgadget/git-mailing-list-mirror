Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722B1C284
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Rst8hevD"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78104f6f692so48239285a.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704302235; x=1704907035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5x5hschxpKyDBOTmty2R1sJopVA0oMeMifvDFFgtNzA=;
        b=Rst8hevDFQcvsrEuw6c5P5QGLftBxW4sOqVbjYjE7aRhYwi8VKrWJEnPO/pxlyr1OJ
         aCVFjxRpQkf3BCkM3YhiRkAnReGHe3JW6VkKcvOLB1UTBn1TJ+QPDdLiUymkRo2weDRo
         QAp8buV6P/eVfe+1vlsCqL6hzFNZ3iwuaEBqycpusqBN6JdWLSveZGVA4ooVHelGbZCZ
         8RrSMhoYuHA+sKMLEKg4Mh+7zrn/YL03yVigYu9SqZkohLTm0ShT+owSTwa/hyjw3iBe
         m0z5DuhdPZcH8gnUH8EJr9eGdSPnZ+xF7L0tvZWsHeisXfYwYvd8ZuCGC0AvYOJ2LzJb
         14Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704302235; x=1704907035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x5hschxpKyDBOTmty2R1sJopVA0oMeMifvDFFgtNzA=;
        b=IatbIyrElzWwDczhbTbvFA+cMeHsdIj9jVO2prO+uGkOimDUvvT/KW2CgHiI/YRm/a
         pOkkpO7SFzhVL7w+KRjgR/PvNpEfdsqOICx1Q2yF9pUHDyeG13y2ywwzXwvg6vQpKKfG
         UNPlLH8qB9qIuJeyAAsVuWyPVFxumN0vMyRJzyTEozrCe/sVx/JW4FPQgnMU0Is1IgSf
         f0Z60NOZlWaB58sixBEyvKWfiuuNBmatJkHMWvqnYYn2xJwiVqe3pL0qG/c4hssWqKBa
         Hm7vBchIOrnrVO+upmKRfkvybx5nfxKDmnT2ldRs5uSiS+mBOfPTdeA7QVHpbV4wyBDM
         iKxA==
X-Gm-Message-State: AOJu0YxeV61OyhWBZEwCYZiVLNqHw9vBlq2UhthjTQVZ578VxG7cQRK1
	Qvk7yK2grFJVDX+TWZ7Kee9DiE5zfdk82TipjfddrP6HSMDJ2g==
X-Google-Smtp-Source: AGHT+IHZ+zgI0cv4uRItxAcwOOgvdNuLCSgO9HlW/6cRZiRXiCeFEm2GKyPPuXub+2xs7WTbUYcpfA==
X-Received: by 2002:a05:620a:4001:b0:781:6e53:2d48 with SMTP id h1-20020a05620a400100b007816e532d48mr1835058qko.66.1704302234936;
        Wed, 03 Jan 2024 09:17:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f4-20020ae9ea04000000b007816c8b457asm5262476qkg.114.2024.01.03.09.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 09:17:14 -0800 (PST)
Date: Wed, 3 Jan 2024 12:17:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] doc: bisect: change plural paths to singular
 pathspec
Message-ID: <ZZWWmXHa8ebtkZQ8@nand.local>
References: <a5a8c257-8550-492e-a6fa-e88ee59d4d66@smtp-relay.sendinblue.com>
 <6bcbd017-968e-4ac8-a56b-164b163c76d4@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bcbd017-968e-4ac8-a56b-164b163c76d4@smtp-relay.sendinblue.com>

On Tue, Jan 02, 2024 at 07:02:05PM -0900, Britton Leo Kerin wrote:
> Britton Leo Kerin (2):
>   doc: use singular form of repeatable path arg
>   doc: refer to pathspec instead of path
>
>  Documentation/git-bisect.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Range-diff against v1:
> 1:  90c081dcab ! 1:  da40e4736b doc: use singular form of repeatable path arg
>     @@ Commit message
>          later document text mentions 'path' arguments, while it doesn't mention
>          'paths'.
>
>     -    Signed-off-by: Britton L Kerin <britton.kergin@gmail.com>
>     +    Signed-off-by: Britton Leo Kerin <britton.kergin@gmail.com>
>
>       ## Documentation/git-bisect.txt ##
>      @@ Documentation/git-bisect.txt: The command takes various subcommands, and different options depending
> -:  ---------- > 2:  d932b6d501 doc: refer to pathspec instead of path
> --
> 2.43.0

Hmm. The end-state of these two patches looks good to me, but I probably
would have written this change as a single change from "paths" ->
"pathspec", not "paths" -> "path" -> "pathspec".

Thanks,
Taylor
