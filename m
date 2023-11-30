Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="3KiZOTJq"
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C210DE
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:07:24 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b83ed78a91so814728b6e.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701371243; x=1701976043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRxeBH/55X5Rushdm4dCoNOwRXO2nu1VzFWOwrZZc3U=;
        b=3KiZOTJq2lCCgst5rLo2nTSgEN3bHN4Qtw3tEkpSWHsalDqNGQb+V39jcKt+AqDdld
         3gefpCXPELHHOhqLkSYaRMcy9MONCuq2TxGZe+w9Y8WfJwuxXBrh3Ggjm9yrtDgNPZl0
         QZNRGJMabzB8gcP/voZDx7/vsZI+cnBRjmOyGaDXK8iyHR6Ubqoe7znFAGy+258Wn+16
         /ZBV4hXgpcHfccdnWBieo/Xdyi8J/1oMEnK42EaUGAXHPy+Uhwuw4hu6dFESy1iaDV1E
         jGd0MXcmfzSkui/bUu0IVZKgpHv36lt6RfyptoXTi/ow7ROPuoosASfUQ5Y5WfrrBj5j
         s9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371243; x=1701976043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRxeBH/55X5Rushdm4dCoNOwRXO2nu1VzFWOwrZZc3U=;
        b=Q+XAaDgOqLRGZB7CoKsD9V84ZvRwl7MQLtF1g0c5F8uiZBtI1kpvWByS4Akv0z0Hf7
         Aj4TjPIrsbDQuNJqEZ/Qq2pKr7GIlgCsoJXYr/WJWUeMMW+dY725QyjcM2RwjMUfeYot
         /tDl12GSehdVmjhfeHMrnjIekV7Cih2P2G+Gh4OgxHkbrclecpoqECO8U6mwZItCmusi
         ihuro6UGnOk8sgzVUIAlLWO8LiPpS+O16ISsce53bW61Oo5A3zoIOoXTxFfckKwT3YBu
         esY2QIvxHY1ADy6BLCN3mtobS9ipmi5cc7VWKTUPuHdfQ01qnVt2zOyGdaFYy2M8KLuJ
         +4JQ==
X-Gm-Message-State: AOJu0YxuP0qB2dEGw9gthCwV0cQNaI6/DXA5/+Ipnc4aF41y5pxtpvgH
	dhEDhayhk28Y4HWuHxFWimwQORRHhren5PbZ8gk=
X-Google-Smtp-Source: AGHT+IFk5LKStgFxwId7SaafomrPmsPH+WWIKnUAB3GhsizU3gwlsiPtd5hVQYMOhbDU4VVAzn4Z7w==
X-Received: by 2002:a05:6808:e87:b0:3b5:66af:f8e3 with SMTP id k7-20020a0568080e8700b003b566aff8e3mr644872oil.37.1701371243633;
        Thu, 30 Nov 2023 11:07:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dt55-20020a05620a47b700b00774350813ccsm742215qkb.118.2023.11.30.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:07:23 -0800 (PST)
Date: Thu, 30 Nov 2023 14:07:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jonny Grant <jg@jguk.org>
Cc: git@vger.kernel.org
Subject: Re: Consider dropping the decimal places for KiB/s 52.00 KiB/s
Message-ID: <ZWjdatp3SRb4mN6G@nand.local>
References: <637be919-0b04-4e5c-8f2e-43340521e6d1@jguk.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <637be919-0b04-4e5c-8f2e-43340521e6d1@jguk.org>

On Thu, Nov 30, 2023 at 06:11:57PM +0000, Jonny Grant wrote:
> Hello
>
> May I suggest taking off the .00 KiB/s suffix, has that been
> considered? As the decimal places don't appear to change, they're
> stuck on .00.

I wonder if you have a throttled connection that is locked to 52KiB/s
exactly. The progress code that generates the throughput is in
progress.c::display_throughput(), which computes the rate. It's computed
in bytes/misec, and then passed to throughput_string() (really,
`strbuf_humanise_rate()`), which formats it appropriately.

If you're in the KiB range, it will print the decimal component, which
is:

    ((bytes & ((1<<10)-1)) * 100) >> 10

> $ git clone git://gcc.gnu.org/git/gcc.git git_1
> Cloning into 'git_1'...
> remote: Enumerating objects: 2949348, done.
> remote: Counting objects: 100% (209238/209238), done.
> remote: Compressing objects: 100% (14579/14579), done.
> Receiving objects:   7% (210878/2949348), 76.33 MiB | 52.00 KiB/s

On my machine:

    $ git.compile clone git://gcc.gnu.org/git/gcc.git
    [...]
    Receiving objects:  11% (342176/2949348), 108.09 MiB | 24.01 MiB/s

I suppose we could consider dropping the decimal component if it's a
round number, but I think that it may produce awkward flickering if the
rate oscillates between a round number and a non-round number.

Thanks,
Taylor
