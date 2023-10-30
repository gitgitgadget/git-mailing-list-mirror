Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E119440
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NSsSLDl7"
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363FA9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:56:35 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7afd45199so44401577b3.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698684994; x=1699289794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXouChhvt513HFvRiWXBJ4hJm6rj3ztWKni+GHGSZ9A=;
        b=NSsSLDl789DW7ra0Wze9MsGvsXHC2uw/fcVW7twcO2+j8AtAUwnu/eZynQ0hn6HwNh
         nQ9rBTceCjHOledlcRGYit+g5cvpv7HjnUyb1agujSHGrof9Ds4n0VVAyE8ljoKtkRQR
         LPGpwE6TGXmJbgC3nBLKzPyHc7SYeLn19W1yb4I09qZVEH8Orv25Gudf4lFg0wHUeQWR
         65MmGBiW5bWZ3gEAqXGH4E4j0GJEYbc7bGrzrB83TvKjQNIR2LgZa5U4HhklL79zgZFR
         IITWFzK+7Bg+Eel7B1gdDpGRaq63yD8yftbyobMk+y/fFAdGz46O6IKB6LhcBMlcmDlp
         6PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698684994; x=1699289794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXouChhvt513HFvRiWXBJ4hJm6rj3ztWKni+GHGSZ9A=;
        b=VVsr6cIhRcFsMQYKpPWWKDobzhj8FP9J/er6iHvaz0jKo2RrBATlST3pFWZ7XaS1uQ
         VepUq+eLI4RoSTJ7feXJBDibVb5deLjc6XYDAmJEUScb0LiRb8HsWKoOtRK6111PrVFD
         3xlJwoHimuAKKr+4RDqmVMQbMzSMB9ABDEj0D5KB1khrPFe9+fIwQGv0Thi9V1VjU/vH
         HLxntTeo9wxWTKmnnuE+1n6g+iOwZftaxYtrS3WYySo67yypoJktJozcJwwxYvSzE/YH
         PKeI/DbpWkix48XRsdHLwGC1mykYEhJtBVsQAzGIllFn+CyfcvNggbZX/Kvh1Gn6Uvzi
         tlLA==
X-Gm-Message-State: AOJu0YwjuFykbonV0hOhqfMNJCVjD9/J6C6dtf2xElaKoc+Jz702YvcA
	bgnUZcv2R9yqcAesAm2WKWAaSg==
X-Google-Smtp-Source: AGHT+IFohlT4hAAFnc0uTKmn+I1R5CXqA8+woRPMBNrODzYYg7xgtWuGagRC+v/Ghq+jw8mlRiOrPw==
X-Received: by 2002:a81:9b16:0:b0:5a7:aa7b:cb9f with SMTP id s22-20020a819b16000000b005a7aa7bcb9fmr11157075ywg.14.1698684994457;
        Mon, 30 Oct 2023 09:56:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l2-20020ad44242000000b00671248b9cfcsm2267483qvq.67.2023.10.30.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 09:56:34 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:56:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Aditya Neelamraju via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Aditya Neelamraju <adityanv97@gmail.com>
Subject: Re: [PATCH] chore: fix typo in .clang-format comment
Message-ID: <ZT/gQZlVKfgn/+BZ@nand.local>
References: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>

On Sun, Oct 29, 2023 at 08:23:07PM +0000, Aditya Neelamraju via GitGitGadget wrote:
> From: Aditya Neelamraju <adityanv97@gmail.com>

We typically prefix commit messages with the subject area they're
working in, not with "chore", or "feat" like some Git workflows
recommend.

That said, the contents of this patch look obviously correct to me.
Thanks for noticing and fixing!

Thanks,
Taylor
