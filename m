Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1213FE0
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMPwVUHy"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336c9acec03so2677820f8f.2
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 02:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704796513; x=1705401313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCylP3JwzShOktDxPXVQTWLXFCpZQhdNza9M66sgemI=;
        b=KMPwVUHyMwbWahuNgt8cHE+AeVF7zhCI8yB1S3ybBAC8+wucqiHTmEzfMZqLtpmCRr
         emVCYCoTP0y7wq+1DQMhDiDMKIjG+8EKRXdQ1FBp/hwvFGvidqZSGNXVZmlwyhKs0wPi
         UYCyPlllk6OjZz/5266HGvx38Tb8ZAiS40pBzPiLyGOh9J0mk0ZzRFc/beM20yoxFkm6
         09E1mVjXOKquWOV6vTXeTVBBslI70KIBxZv2yhFN/0pS63SYzr2FKeXC+FFJ1IsQE+2D
         GusIiiW8Ev57hyPeEDLtdtYc7l1tRgZ3WwOj6nT223/xQoX90hNn65GEEEhsh2PZ7e/s
         NyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704796513; x=1705401313;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCylP3JwzShOktDxPXVQTWLXFCpZQhdNza9M66sgemI=;
        b=lxxYghoM5D2k6QrcTSZBfFrv6wn38jezJmQFTaapAWGoHJWRIN8y+oLlcbjU9iUnTY
         juqg6cktQXTtHQ0nKsga7ShN5WJZ95tWTDeFiV5H5T61xRpccgJ4TauCg0uRvrMd4Uv0
         H4jNPWXeouP0CRvo1xtZ4RL0KE8QWybOIZpXD7vwhIinsiWdWfFl9fI5DiMex38aJvHA
         yBSGUxywxfOX1mOHr1H9FhmTcPzGxwFI9ua7PW/N50FNOM3SkxGx+BnGOtTwkTMGuZjB
         GZkJ64gnqQdcQVsrOZm01glFy5052S/L+XPDrY01K3Uoxes03/r7Eg4uVwDW+gwg16d/
         +39g==
X-Gm-Message-State: AOJu0YzDTHJxGy9L2zRTWZb7XOAjqtf093SeUs1UOzlzWSNOnGoAcfMC
	ts1EJOJhjah8wpPT3ygdNGg=
X-Google-Smtp-Source: AGHT+IExf8b0k/JGWYlU8/hSVz11iUMqXU4EBmPCQTMoHHdhTdFgUSoSC4ETyahef65RVr4AOIDjng==
X-Received: by 2002:a05:600c:5117:b0:40e:52d5:4df7 with SMTP id o23-20020a05600c511700b0040e52d54df7mr31083wms.179.1704796512836;
        Tue, 09 Jan 2024 02:35:12 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id je6-20020a05600c1f8600b0040b3d8907fesm3009387wmb.29.2024.01.09.02.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 02:35:12 -0800 (PST)
Message-ID: <33c81610-0958-49da-b702-ba8d96ecf1d3@gmail.com>
Date: Tue, 9 Jan 2024 10:35:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy][PATCH v4] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
To: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, chriscool@tuxfamily.org, christian.couder@gmail.com,
 l.s.r@web.de, phillip.wood@dunelm.org.uk, steadmon@google.com,
 me@ttaylorr.com
References: <20240101104017.9452-2-ach.lumap@gmail.com>
 <20240105161413.10422-1-ach.lumap@gmail.com>
Content-Language: en-US
In-Reply-To: <20240105161413.10422-1-ach.lumap@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Achu

On 05/01/2024 16:14, Achu Luma wrote:
> In the recent codebase update (8bf6fbd00d (Merge branch
> 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> merged, providing a standardized approach for testing C code. Prior to
> this update, some unit tests relied on the test helper mechanism,
> lacking a dedicated unit testing framework. It's more natural to perform
> these unit tests using the new unit test framework.
> 
> This commit migrates the unit tests for C character classification
> functions (isdigit(), isspace(), etc) from the legacy approach
> using the test-tool command `test-tool ctype` in t/helper/test-ctype.c
> to the new unit testing framework (t/unit-tests/test-lib.h).
> 
> The migration involves refactoring the tests to utilize the testing
> macros provided by the framework (TEST() and check_*()).
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Helped-by: René Scharfe <l.s.r@web.de>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Achu Luma <ach.lumap@gmail.com>
> ---
>   The changes between version 3 and version 4 are the following:
> 
>   - Some duplication has been reduced using a new TEST_CHAR_CLASS() macro.
>   - A "0x"prefix has been added to avoid confusion between decimal and
>     hexadecimal codes printed by test_msg().
>   - The "Mentored-by:..." trailer has been restored.
>   - "works as expected" has been reduced to just "works" as suggested by Taylor.
>   - Some "Helped-by: ..." trailers have been added.
>   - Some whitespace fixes have been made.

Thanks for the re-roll, the changes look good, there is one issue that I 
spotted below

> -#define TEST_CLASS(t,s) {			\
> -	int i;					\
> -	for (i = 0; i < 256; i++) {		\
> -		if (is_in(s, i) != t(i))	\
> -			report_error(#t, i);	\
> -	}					\
> -	if (t(EOF))				\
> -		report_error(#t, EOF);		\
> -}

In the old version we test EOF in addition to each character between 0-255

> +/* Macro to test a character type */
> +#define TEST_CTYPE_FUNC(func, string) \
> +static void test_ctype_##func(void) { \
> +	for (int i = 0; i < 256; i++) { \
> +		if (!check_int(func(i), ==, is_in(string, i))) \
> +			test_msg("       i: 0x%02x", i); \
> +	} \
> +}

In the new version we only test the characters 0-255, not EOF. If there 
is a good reason for removing the EOF tests then it should be explained 
in the commit message. If not it would be good to add those tests back.

Best Wishes

Phillip
