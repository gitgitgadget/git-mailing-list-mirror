Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15B1CF9F
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nTb5f/Ha"
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E67FC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:52:18 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9beb863816so4451573276.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698702737; x=1699307537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQvgjmWVn9aMkwCNcijTu7jw0N5kdorAJViAwFUZGk8=;
        b=nTb5f/HarCXCIQlE0pn6dmJXzWIVxryI08OxzzOHjUCpUcFXe8YJH5joUs6mB4S9ll
         y7DykgUG5WOmRKclQPvvVUeKgAXc82JraEAW13IFlrG6OOcgVkLFM0077konaykGCQmc
         /gEt7ff3JGcTTISxM6F8ew8kZJ+nEyKAQiNkT64gQ68tpib857PTvb3qPqQrMymSz4ko
         zzxbN05nMxHufTnLawNRcfip2P9dAw3v3Yex43dkhYJ92K58zVnpPzyvns5cMZ46CPzw
         UZpBQzWPN8FRFRkGrrTN8mnheVUtqlmJwD4x+LOngWgn9ZQiy8BlxZEdk+Fm7CRI+53m
         Ymlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702737; x=1699307537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQvgjmWVn9aMkwCNcijTu7jw0N5kdorAJViAwFUZGk8=;
        b=twoLGLwZ38MeLZi5puasIQhTPOLpGCm6vTpGdUzna+ll4E+nIB19JrOCggbvCt3z0S
         rTPlLAvkq9LrNwPwyJ2CdZFjPGc15lAd9uf6lnm0d+lpkO9hIK2EIX4uXVlLbvIHDDkq
         m2+R+foSJBP8bMIuH1TSLKH1mzMhPoXAhRzyr4nOGHPKLmXGyBWa662u0HQO+yN2c3Cz
         yGMC0RLpVqeKDgsFi9NmK/J/AGpKAMImdMNKCu4NtYs76F63c4JKUSZue61lXD3Z5i9j
         Q2PrlnW+LCMeNvSpK80I/cPzGxuc3L3XD7Q3fq9F/rigEQs8ExSVyB9R1+21PvoDGhRi
         qjWQ==
X-Gm-Message-State: AOJu0YzGJMn6xJfo8K89iidkbHBQk/RC2/4nt7BJS5WUiNp4CN7Jb3Pn
	TQG/7vBUKPh83bVu4jVjzJuMmID4eeyTvGXa0Gf0Xg==
X-Google-Smtp-Source: AGHT+IHCJLHflD6tZ4TQ6F/IqEKfc1AXG/bvS4GDOoX0jDuvZ16ZkiK6VVHGHZXmbHYLLLz86UssAQ==
X-Received: by 2002:a25:ac47:0:b0:d9b:4f28:4f7a with SMTP id r7-20020a25ac47000000b00d9b4f284f7amr10380734ybd.55.1698702737461;
        Mon, 30 Oct 2023 14:52:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c6-20020a254e06000000b00d0b0bbe574asm34752ybb.44.2023.10.30.14.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:52:17 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:52:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] doc/git-repack: small fixes for geometric repacks
Message-ID: <ZUAlkAUU4qSJG0BL@nand.local>
References: <cover.1697440686.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697440686.git.ps@pks.im>

On Mon, Oct 16, 2023 at 09:19:46AM +0200, Patrick Steinhardt wrote:
> Patrick Steinhardt (2):
>   doc/git-repack: fix syntax for `-g` shorthand option
>   doc/git-repack: don't mention nonexistent "--unpacked" option
>
>  Documentation/git-repack.txt | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Sorry that this one fell off of my queue. These are both looking good to
me, thanks for finding and fixing them!

Thanks,
Taylor
