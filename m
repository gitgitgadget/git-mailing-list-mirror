Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2406524A4
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="HeQmTHQC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d54b765414so31782515ad.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1704992090; x=1705596890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IoQj7NQ3tLSZgWiYl/gLdkMRSL2sbCJWrKw2OkTafyo=;
        b=HeQmTHQC3HlsDYVC2qo5XzJUvy8hwIqx3Ft5bH6E2rwpCmaKaelhs4IZCc0lv0HZgu
         mdL2BqAQ2OlErw8bPIGaNLS6nOQpQ2hcJWrZtnw2SMAmCglbhV19pdKJf+SOhotp1K8T
         x/sLugDD/zb4mDTw3FhzGIeynTCRitw6SV5ztPyoVflmOKHfZ5Bxp6q/EwHtJChowi+l
         f59OwgkHpV2VWOGXKmd2NXrPq6hED8kBV4iCWRjU9Q9f9XXD2YUzxyRzOmXDhqslRbxB
         3e1zxCiMhliJkDdk+oIsvu08XzQz21KFFFLbJwVYMFUWMZP1ewniJnpVw8HPeM3SNDhK
         bquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992090; x=1705596890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoQj7NQ3tLSZgWiYl/gLdkMRSL2sbCJWrKw2OkTafyo=;
        b=RRFVSmHzlXVZSFcAJo5gv1VX97CcPbGrnc0PqC7ocJNOfyPJGA75qrdSEvvKAC/1QW
         +74any38dlL2TQPW5orNuImzqwa5ZP7XSD8LQB/U3rIleHJTHXN2Uvh5uwrUNL6ll4yy
         6PX/xgLaOWXyGdLYQljUN0z3YIiN1JyLAxi6lMCw1XaNPLBxgHpPvIshUBMVHfutGyL8
         aWtl0mT1+RqXY4PWR6ym8nnjszj5TZdAfxcKVsSidFF4CgHnlVwZ5r0VCSeeSNOdb6x0
         arkRuoEOsQYkPR0MAkjdtAyOHhAoJaWdzaYkuJYeZ/ooBWAXRjI1LNX0vhth+ywIH8AB
         hvnw==
X-Gm-Message-State: AOJu0YzaBBG/9IzPScW3HWRJVFMWJ8Di5L7IvG06gmVQXncirz437r3W
	GJdoKn4qrENgtX9rfT2fQazj2koskYh5sF1y2Fw8LbsO
X-Google-Smtp-Source: AGHT+IHtkw0PIDBt9kFnQCLQnDWUXXXp8cv+96ApdKrluZmPw8/PUG854x8G/Kmc7OSC2qIGwB0usw==
X-Received: by 2002:a17:902:a601:b0:1d4:bd03:ab13 with SMTP id u1-20020a170902a60100b001d4bd03ab13mr1418449plq.69.1704992090013;
        Thu, 11 Jan 2024 08:54:50 -0800 (PST)
Received: from [192.168.50.41] (172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id ko12-20020a17090307cc00b001ce5b859a59sm1382048plb.305.2024.01.11.08.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:54:49 -0800 (PST)
Message-ID: <d852ad72-32c4-4b0f-8f34-e8b38b7f71ad@github.com>
Date: Thu, 11 Jan 2024 08:54:47 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t7450: test submodule urls
To: Jeff King <peff@peff.net>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <cf7848edffca27931aad02c0652adf2715320d35.1704822817.git.gitgitgadget@gmail.com>
 <20240110103812.GB16674@coredump.intra.peff.net>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <20240110103812.GB16674@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jeff King wrote:
> On Tue, Jan 09, 2024 at 05:53:36PM +0000, Victoria Dye via GitGitGadget wrote:
> 
>> +#define TEST_TOOL_CHECK_URL_USAGE \
>> +	"test-tool submodule check-url <url>"
> 
> I don't think this command-line "<url>" mode works at all. Your
> underlying function can handle either stdin or arguments:

...

> All of this is inherited from the existing check_name() code, which I
> think has all of the same bugs. The test scripts all just use the stdin
> mode, so they don't notice. It's not too hard to fix, but maybe it's
> worth just ripping out the unreachable code.

Thanks for pointing out those issues, I think removing the command line
input mode is the way to go. The description of the 'check_name()' mentions
that the stdin mode was "primarily intended for testing". But as 85321a346b5
(submodule--helper: move "check-name" to a test-tool, 2022-09-01) pointed
out, 'check_name()' was never used outside of tests anyway, so whatever use
case was imagined for the command line mode never seemed to have existed. 

Combine that with the fact that the command line mode is so different from
the stdin mode (non-zero exit code for invalid names, prints nothing vs.
zero exit code, prints valid names), there don't seem to be any real
downsides to removing the unused code.

> 
> -Peff

