Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C42C683
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnZGAWCj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e779f0273so8288175e9.2
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 03:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705318664; x=1705923464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4EE+yY2QV/0/ifopMb5Kg6JXHBl6rIW/rQ5EZu9cQFY=;
        b=AnZGAWCj+WN2H070KPAvO0LSxBKIXPQikm0m1+IgzL9r47EzL+Q9PlwNHJjP+/JEck
         cqKItFjHPUKdga0kiA5o7CUajHIxUdn0FrcDtV6rYsBjcnA5Dr0HfadfmCJxm1hrExWK
         JJWGRL0PbTrZMdi4kOngeSlPzrXzKK7vErJ99Ppjv+UnnUvXMZAs0D5bd8vcTUFZga9k
         ybrCKIn2Wc2W+2VfOHdSoh70zbarub43J4PEolPPdBOMDxuNS8ebKmPfw3y/kjA9FhfH
         u0OxMHLMOi5zUsvaDy5Q3ggHeKVri6ZT2tal/WqfaaLh1ug3m3M0ZKMm+efg0zZ3wuvs
         gxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705318664; x=1705923464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EE+yY2QV/0/ifopMb5Kg6JXHBl6rIW/rQ5EZu9cQFY=;
        b=fx5tusU7ekjNrFbd3qBWFF3qzRSg5Tsxkp1DrWwFo+fTfjlqn5EhD95I6sIX4MnCJZ
         Fnqm5cM7OgYESyh6VpBcoGCxUwUWsdzlrd+vggIa8L5hbYQQdkZd59QWuHcMPp9DtuDY
         hJjuxKuCkY773TZ/VyoGMBqgdHdx9SIrgXfh07oV9Mf3sVTSq6t583/PO9wqo6SnIAWj
         lV6/N+UaVqafvaUUV1zBFIe+K1IbvBBBbExcAkeC2htyIg4yNV8tqs9gFReP81vJMI63
         AwrRmYifDdCViazJHbwGXJ0AysgNnbk8+LcwB803hXRtEsRV8SbGa9mjF3qPWYlo57VF
         0qzQ==
X-Gm-Message-State: AOJu0YxoMAOP1ktMsJjDX0feTdm9e4KQhUHk258pPN9E4oaLvzC2XMAJ
	cncpfCTznMKUghzZJ2C7D2M=
X-Google-Smtp-Source: AGHT+IE27hnMbnyLjGOLLMQCcbF39WMvjThRNA8qhwtZIKSSrd1WrBiPycVGfb4d2a/fBq3J1bmrCw==
X-Received: by 2002:a05:600c:a381:b0:40e:4654:7d1e with SMTP id hn1-20020a05600ca38100b0040e46547d1emr2816328wmb.68.1705318664042;
        Mon, 15 Jan 2024 03:37:44 -0800 (PST)
Received: from gmail.com (195.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.195])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0040d53588d94sm19640838wmq.46.2024.01.15.03.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 03:37:43 -0800 (PST)
Message-ID: <93468f5c-5f62-4f22-85ce-b60621852430@gmail.com>
Date: Mon, 15 Jan 2024 12:37:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH] Port helper/test-advise.c to
 unit-tests/t-advise.c
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 Christian Couder <chriscool@tuxfamily.org>
References: <20240112102122.1422-1-ach.lumap@gmail.com>
 <xmqqmsta6uju.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqmsta6uju.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12-ene-2024 14:44:37, Junio C Hamano wrote:
> Achu Luma <ach.lumap@gmail.com> writes:
> 
> > In the recent codebase update (8bf6fbd00d (Merge branch
> > 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> > merged, providing a standardized approach for testing C code. Prior to
> > this update, some unit tests relied on the test helper mechanism,
> > lacking a dedicated unit testing framework. It's more natural to perform
> > these unit tests using the new unit test framework.
> >
> > This commit migrates the unit tests for advise_if_enabled functionality
> > from the legacy approach using the test-tool command `test-tool advise`
> > in t/helper/test-advise.c to the new unit testing framework
> > (t/unit-tests/test-lib.h).
> >
> > The migration involves refactoring the tests to utilize the testing
> > macros provided by the framework (TEST() and check_*()).
> 
> In the light of the presense of work like this one
> 
>   https://lore.kernel.org/git/c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com/
> 
> I am not sure if moving this to unit-test framework is a good thing,
> at least right at this moment.
> 
> To test the effect of setting one configuration variable, and ensure
> it results in a slightly different advice message output to the
> standard error stream, "test-tool advice" needs only a single line
> of patch, but if we started with this version, how much work does it
> take to run the equivalent test in the other patch if it were to be
> rebased on top of this change?  It won't be just the matter of
> adding a new TEST(check_advise_if_enabled()) call to cmd_main(),
> will it?

Maybe something like this will do the trick:

diff --git a/t/unit-tests/t-advise.c b/t/unit-tests/t-advise.c
index 15df29c955..ac7d2620ef 100644
--- a/t/unit-tests/t-advise.c
+++ b/t/unit-tests/t-advise.c
@@ -6,6 +6,7 @@

 static const char expect_advice_msg[] = "hint: This is a piece of advice\n"
                                        "hint: Disable this message with \"git config advice.nestedTag false\"\n";
+static const char expect_advice_msg_without_disable_hint[] = "hint: This is a piece of advice\n";
 static const char advice_msg[] = "This is a piece of advice";
 static const char out_file[] = "./output.txt";

@@ -44,7 +45,7 @@ int cmd_main(int argc, const char **argv) {

        TEST(check_advise_if_enabled(advice_msg, NULL, expect_advice_msg),
                "advice should be printed when config variable is unset");
-       TEST(check_advise_if_enabled(advice_msg, "true", expect_advice_msg),
+       TEST(check_advise_if_enabled(advice_msg, "true", expect_advice_msg_without_disable_hint),
                "advice should be printed when config variable is set to true");
        TEST(check_advise_if_enabled(advice_msg, "false", ""),
                "advice should not be printed when config variable is set to false");

> 
> I doubt the issue is not about "picking the right moment" to
> transition from the test-tool to unit testing framework in this
> particular case.  Is "check-advice-if-enabled" a bit too high level
> a feature to be a good match to "unit" testing, I have to wonder?

I don't have a formed opinion on the change, but I don't see it making
things worse.  I share your doubts, though.

Thanks.
