Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB581C6AE
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB+U4+RA"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68483AC
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:07:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so3740835f8f.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697450824; x=1698055624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T9SdJqtNVnpzow1mwaIshhCEd26f+cG+6mOlF2abQdA=;
        b=eB+U4+RAhq2Oc+64yGZFHb6KvqVhyDwJsaAI575kuz3Nlc1bAv6QJMjuJYX+mcplkI
         D2D82vg8akEw0M8f1OoXS8w73c5AZLPYZKywP1gtKtHJZB3AHW8XVWtWjW2W0GVCfLdA
         UTNP1wtlz4PoBkwZg/eurKVoXd7r4/dLu614g/LCTpAL3PEcx+0fQa/1PIpaUknalTIy
         LWbqNy6jyBLLFPBj8Og7o6n6/kyNT3kvz+BFGBHAhzohULgUXVVxXdBHAq8xebznZ2o9
         bLG7ZZQs40+Mjs3dJiKzYTC6FDCSkM3UPPdwp6C0NNcA1tXnDIkK4feUTYb3rSU1saBS
         iMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450824; x=1698055624;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9SdJqtNVnpzow1mwaIshhCEd26f+cG+6mOlF2abQdA=;
        b=g7FYAGMm2Vak7YD/waDL2jGhZsDVNGUFEyk9x7bi8M4JFkEbzITzDukmnagGWJTQjI
         0aRlhcG7ECi1asJy1yTFSljrBB5cTSYANWus+kOvt232U8JgO0IwF8q6UV8QMugckKxA
         5xm8CYgObyOSLPsIKZgddUYpc6Uj2TPBuB9gpOsJjqfWXNRx39OmUvYm1Aa8dz4g70Fv
         3MP/uJedtaVNf7yE8rElhCNtIBxguHg5K5WUC/pZ8tu5qVZ3Ty9DA2rOo4RZASthjc4K
         OBe+zbZx/ffrQaNqM6zrPoYDJ9aXC3xm2136YdimGxpvT4qT/1h2aftynfdAFfpw0QAc
         KD+A==
X-Gm-Message-State: AOJu0YzMRq3ZxE+dfLJ4q1MGCZJiXH+I41qKeg86oX+JAPTgK1QxAUhl
	iSmRR/MJfLzqdTlgQFQxQ3Y=
X-Google-Smtp-Source: AGHT+IEx1mUtQD9qrsiSMYWXuLvBuGPEGwxddV2XCQE/kQQ5joWIRAftfP2Sm+jyG8r5PlOi8s0bQA==
X-Received: by 2002:adf:fa90:0:b0:32d:aa11:221d with SMTP id h16-20020adffa90000000b0032daa11221dmr3313979wrr.27.1697450823541;
        Mon, 16 Oct 2023 03:07:03 -0700 (PDT)
Received: from [192.168.1.12] (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id k7-20020adfb347000000b0032d8913f3dasm12693754wrd.97.2023.10.16.03.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 03:07:03 -0700 (PDT)
Message-ID: <93a18989-bf05-4318-8d85-cf23c0f32170@gmail.com>
Date: Mon, 16 Oct 2023 11:07:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 0/3] Add unit test framework and project plan
Content-Language: en-US
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc: linusa@google.com, calvinwan@google.com, gitster@pobox.com,
 rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
In-Reply-To: <cover.1696889529.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Josh

Thanks for the update

On 09/10/2023 23:21, Josh Steadmon wrote:
> In addition to reviewing the patches in this series, reviewers can help
> this series progress by chiming in on these remaining TODOs:
> - Figure out if we should split t-basic.c into multiple meta-tests, to
>    avoid merge conflicts and changes to expected text in
>    t0080-unit-test-output.sh.

I think it depends on how many new tests we think we're going to want to 
add here. I can see us adding a few more check_* macros (comparing 
object ids and arrays of bytes spring to mind) and wanting to test them 
here, but (perhaps naïvely) I don't expect huge amounts of churn here.

> - Figure out if we should de-duplicate assertions in t-strbuf.c at the
>    cost of making tests less self-contained and diagnostic output less
>    helpful.

In principle we could pass the location information along to any helper 
function, I'm not sure how easy that is at the moment. We can get 
reasonable error messages by using the check*() macros in the helper and 
wrapping the call to the helper with check() as well. For example

static int assert_sane_strbuf(struct strbuf *buf)
{
	/* Initialized strbufs should always have a non-NULL buffer */
	if (!check(!!buf->buf))
		return 0;
	/* Buffers should always be NUL-terminated */
	if (!check_char(buf->buf[buf->len], ==, '\0'))
		return 0;
	/*
	 * Freshly-initialized strbufs may not have a dynamically allocated
	 * buffer
	 */
	if (buf->len == 0 && buf->alloc == 0)
		return 1;
	/* alloc must be at least one byte larger than len */
	return check_uint(buf->len, <, buf->alloc);
}

and in the test function call it as

	check(assert_sane_strbuf(buf));

which gives error messages like

# check "buf->len < buf->alloc" failed at t/unit-tests/t-strbuf.c:43
#    left: 5
#   right: 0
# check "assert_sane_strbuf(&buf)" failed at t/unit-tests/t-strbuf.c:60

So we can see where assert_sane_strbuf() was called and which assertion 
in assert_sane_strbuf() failed.

> - Figure out if we should collect unit tests statistics similar to the
>    "counts" files for shell tests

Unless someone has an immediate need for that I'd be tempted to leave it 
wait until someone requests that data.

> - Decide if it's OK to wait on sharding unit tests across "sliced" CI
>    instances

Hopefully the unit tests will run fast enough that we don't need to 
worry about that in the early stages.

> - Provide guidelines for writing new unit tests

This is not a comprehensive list but we should recommend that

- tests avoid leaking resources so the leak sanitizer see if the code
   being tested has a resource leak.

- tests check that pointers are not NULL before deferencing them to
   avoid the whole program being taken down with SIGSEGV.

- tests are written with easy debugging in mind - i.e. good diagnostic
   messages. Hopefully the check* macros make that easy to do.

> Changes in v8:
> - Flipped return values for TEST, TEST_TODO, and check_* macros &
>    functions. This makes it easier to reason about control flow for
>    patterns like:
>      if (check(some_condition)) { ... } > - Moved unit test binaries to t/unit-tests/bin to simplify .gitignore
>    patterns.

Thanks for the updates to the test library, the range diff looks good to me.

 > - Removed testing of some strbuf implementation details in t-strbuf.c

I agree that makes sense. I think it would be good to update 
assert_sane_strbuf() to use the check* macros as suggest above.

Best Wishes

Phillip
