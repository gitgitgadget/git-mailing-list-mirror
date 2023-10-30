Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F34918C08
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0ST94eje"
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B760DA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:55:57 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7a80a96dbso48707267b3.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698681357; x=1699286157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fV8b8S8fqml24ODmCl/FwOir2r5c1lBH+hghgKMT4o=;
        b=0ST94ejeGqy9DtBdqVMGhRGBWiyEJUNpHCsCzU36U0fli26LDWMtVF/9tbqjo5BRDT
         mirDhBVYumQIlyQINsYbAdMF3QRBVJw9kDC8KI8mELKUS5Kb2ed9xOTIZaI/N2YzMpob
         7w13T8ixDqSapHwEB6LqkzdjZ0ZUk24FzRu64iV69GNI6+OivNVgzHLg5H3jMmwfNLwN
         4gf04iCW1AMZBYzq2iGrgJctCIYg4yJlPdcmqWWMaNoRXYRxSt4cdOA778g1P+YzgPfr
         vrOOK2GW8VqQE00fRuyBsKT6d/Km4t0uPGsIGpsTxN49gEyza4uGrY3fm1atp64S6D9M
         AEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681357; x=1699286157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fV8b8S8fqml24ODmCl/FwOir2r5c1lBH+hghgKMT4o=;
        b=Pi7izOwVZKVb5tT5FYnKtjNYnatCltwz8mB8DJnKrcvTN67iP3D4frMeOZD3TpO/CQ
         Xn1t869zAZjmE+SAD9cbSRCduo1ctT4Vdsc7C2LwMwha2cavjgpqJe/lkGNVd+wpshj5
         6O4bHPLm8yZ4Hv+1UlBT2AlNbi0vdharbPdkaD3LUPnk9VvGX55P2Yf9JaSMkxaHXcT2
         mpzLeHzVJIDKS3nyEZZtILOUBSDPqZdIj6A7s/HQ3X2UfWgyTZJklEK6+l4ln/rvS6ny
         Aq3bme1HfG8NpDl5WAM0Fs8mZyfzOIVPj+aWfXJTswNB0v+ZOeZKoxQARAtaviIOElD3
         /xGA==
X-Gm-Message-State: AOJu0YwBmNejQzZ6PDIFuI3cuSZnBH5kOvC2zfnRKB1h6e4s9+4hfr7E
	OgB0FHuRSrgE27MSRbtPhqiqpEa/MaN4DBYL3FApOg==
X-Google-Smtp-Source: AGHT+IFGVUO2EgXt0eJmGhRpQFYL7+VXznCIRVJrXb4Ty2pEHAfq0NwtBJCNXBfX/2Cj3tevCcukcw==
X-Received: by 2002:a05:690c:fcf:b0:5a8:1d18:a1a with SMTP id dg15-20020a05690c0fcf00b005a81d180a1amr18684ywb.4.1698681356739;
        Mon, 30 Oct 2023 08:55:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m137-20020a0dca8f000000b005a23a62a25csm4467658ywd.9.2023.10.30.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:55:56 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:55:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Alexander Mills <alexander.d.mills@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <ZT/SC2EPdaWtzjj+@nand.local>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>

Hi Alexander,

On Sun, Oct 29, 2023 at 06:15:35PM -0500, Alexander Mills wrote:
> Having the link in the console saves me tremendous time and is
> extremely effective/efficient. Can we get links in the console plz?

That link is generated at the remote end (in your case, this is on
GitHub) and then sent over the wire before being printed out with the
"remote:" prefix at your terminal.

The Git project does not itself generate these messages, so you may want
to relay your request to GitHub's support address at <support@github.com>.

Thanks,
Taylor
