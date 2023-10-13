Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD2241E4
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT94/wPZ"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA37BB
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:30:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40651a726acso23937175e9.1
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697221837; x=1697826637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfRWe53XyIdee8462do2BEOCZjAEIdWCPFJhNTpILOk=;
        b=LT94/wPZM0Cr/ut1quZn48c4l4z32oQvRRkiNrj7ghi3jiDmhQtnW89GWXRIO/XpXx
         EN+Ea2+YRgYoI/YJw5UShBGlgpuLyFJQ53DyLaj3ofMLd4wZWLYHUzN6cHwLD5peE/r7
         M0Z7Guvpxj20WjYGNW8SqnVJp4mPEuw/PQAy2hqLkXkY5/k9THq8RFn75e2kLTT2Qz1K
         QPOVHjeu+PDwpuygJcEIP/dhmDUghvsxXQlJcYpLel9GSWey8LeTauVC+YTzT/w3t8iT
         qYRPhg5/SQs00hgOUGFKerI+XEU9BWTEb05dUzaZQVYcDvJhgMR+b3m6YdlqBcifIcm4
         NdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697221837; x=1697826637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfRWe53XyIdee8462do2BEOCZjAEIdWCPFJhNTpILOk=;
        b=VMqmmM/sECQzVEw+/ir14R5cmTh35qh+jSnuzCbPKI2omMtoqH/rF9vNlrBTg7xk31
         PItN1rJTCnQhRuFhrLJEArLhkIBxE/lY5Ouw7M7hWH6H4qhxXqWUCsnb9izmhP/IVXgY
         JjISq8KG04YFJ6tzSnh5JbOvOAPho9yhwvDmLepNh3jSQ4Bx5K2nL/a91YLqcoeroCYU
         eleNdcgKzN/VsvWRzIGuSPwXJ848VYD0uXD9MQIzgWlQXu1qbBq2l3GvOe21EtTfbc2n
         08zaHt+k9qPmON/z7bEVzwiZny2WJR6RepuQVGXavH+UaPyX9wcxgC9CxHrvz39Nzcll
         zPog==
X-Gm-Message-State: AOJu0Yy4QjZh3xCjONL24Z6QeReZ6Hai69aCZUsn8p7LQdWhhlxIKtpG
	uWV8y3z8Bv1uHCrQ1A3WcVercsUMTH8=
X-Google-Smtp-Source: AGHT+IFCOAPo7utxxVQfux4qGXRlzTXEZTAYlty8IMeoOITPlVZLF5pm2e2tuk3ilAGwmFCRqXp/aQ==
X-Received: by 2002:a05:600c:1d8f:b0:407:3630:f35 with SMTP id p15-20020a05600c1d8f00b0040736300f35mr18905026wms.9.1697221836816;
        Fri, 13 Oct 2023 11:30:36 -0700 (PDT)
Received: from [192.168.2.52] (93.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.93])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b004076f522058sm877924wmq.0.2023.10.13.11.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 11:30:36 -0700 (PDT)
Message-ID: <aed9523e-0ce9-49f6-bdda-90fd1e275691@gmail.com>
Date: Fri, 13 Oct 2023 20:30:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [Outreachy][PATCH v2] branch.c: adjust error messages
 to coding guidelines
Content-Language: en-US
To: Isoken June Ibizugbe via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Isoken June Ibizugbe <isokenjune@gmail.com>
References: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13-oct-2023 15:33:45, Isoken June Ibizugbe via GitGitGadget wrote:

> As per the CodingGuidelines document, it is recommended that a single-line
> message provided to error messages such as die(), error() and warning(),
> should start with a lowercase letter and should not end with a period.
> 
> Signed-off-by: Isoken June Ibizugbe isokenjune@gmail.com
> 
> Isoken June Ibizugbe (2):
>   branch.c: ammend error messages for die()
>   branch.c: adjust error messages to coding guidelines

I don't understand why two commits.  Maybe it was unintentional and you
want to merge all changes into one commit, using git rebase.

> 
>  builtin/branch.c | 66 ++++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

You still need to adjust the tests.  Take a look at:

https://github.com/git/git/actions/runs/6509642887/job/17681596358
