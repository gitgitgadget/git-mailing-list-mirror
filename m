Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF521C2B0
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oN0p2+l4"
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD5EED
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:49:31 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-778a108ae49so487828785a.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698702570; x=1699307370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b6kdlA9wVmrCeYOhb/a65ATp1GotjcNKQrJ2C014Elg=;
        b=oN0p2+l45RCU3crl72ecquvwHDNqSbGDQVA5wnT9wLP4fPQo0DZNuGbgpRhuosnUyW
         EAsT4zoFAUArKVkh9FcdHw4K16VyDn5vgHd06QEIwYR1YdYK05f7fO4Ev2IqTDSv+61P
         /qwowBK+XsE3Ea2PGByCxkAyG2pUpcdWP4SbhIOEblXGSzMsUnkhterh5DcDPe6haNyU
         OqpDTAurDd1z1boz+E86yRZq/kWnMyRm/Z7b4S6sEp7NriKwm/ppLeEj9pmwn3UIfWjF
         JnZqstuMnYAJYkA9WTNJXlqC37DO/8+HeRzQBRulp3U6JTHx8UXZWn/cs7s+j4xb8yhl
         43Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702570; x=1699307370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6kdlA9wVmrCeYOhb/a65ATp1GotjcNKQrJ2C014Elg=;
        b=KfwTBj+QoZfjCqRMBqorLvgG1KmJPuaMtystuNCLvMYN+0dEO7KwYIzPaSumjU2Roh
         y6tdpmAW2pqii7V2Unzmw9PrEGkNDJcRfyq5qrBlaE63u0e/99cNaJe7jnLR3rvalMR9
         CXWwEKmEs7njPFXfBp7iSKCD1dA7TvKBSAspvyvVsKYoMNJI2Aj4WS4cbz7vpB4DZPfm
         9+Zn+mZHGVukqt3eHXGmPm6tXYKdDXwmyXhiLG/0NZKJ3RIkKQCgaZLtDOH9uS5N0klO
         YvliNzfBOehkKuCpK35amFHZiVYvaH1+aDBJm36gKdz86Hv8U0fe85e9/3R/F4Cvm+ut
         1swg==
X-Gm-Message-State: AOJu0YxUE/5KXC0NI4Jl7cKwhyRHPXiQ+PbtjpQJQeBEHedbZU0Ig2Ob
	Z2OxRKKRdJVxefKJCprLeoRwig==
X-Google-Smtp-Source: AGHT+IGwN5om+5rJ1FYYq+ayydlY80ZdZgdLwdgzNrq+Lma/MB9hUrlmqc10vtvjrG6bYtJdKIrcmg==
X-Received: by 2002:a05:620a:4247:b0:76c:a952:c70f with SMTP id w7-20020a05620a424700b0076ca952c70fmr1654472qko.35.1698702570400;
        Mon, 30 Oct 2023 14:49:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b007742ad3047asm3660882qky.54.2023.10.30.14.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:49:30 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:49:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Hongyi Zhao <hongyi.zhao@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git List <git@vger.kernel.org>
Subject: Re: Method for Calculating Statistics of Developer Contribution to a
 Specified Branch.
Message-ID: <ZUAk6dPJyhfb7UBM@nand.local>
References: <CAGP6POKg4mSFv-Z+dD1aXDFDbxH9Xu1WCdCA5TGfCAM3NUUQLw@mail.gmail.com>
 <ZS2qZtYDvItovjqg@tapette.crustytoothpaste.net>
 <CAGP6PO+SeZPzD21nErX=Vq=+d6oy-kg+diu=irot3enOhpQNMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGP6PO+SeZPzD21nErX=Vq=+d6oy-kg+diu=irot3enOhpQNMg@mail.gmail.com>

On Tue, Oct 17, 2023 at 07:37:46PM +0800, Hongyi Zhao wrote:
> I want to calculate a certain developer's contribution based on
> different standards of code line count and the importance of the code.

I agree with brian that "number of lines added/removed" is not a perfect
measure of productivity ;-).

But I think that there is a slightly cleaner way to compute the result
you're after, like so:

    git rev-list --author="$who" origin/main |
    git diff-tree --stdin -r --numstat --no-commit-id |
    awk '{ s += $1 + $2 } END { print s }'

Thanks,
Taylor
