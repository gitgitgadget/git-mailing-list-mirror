Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7A22EE7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYE7ylZf"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B59D7A
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:17:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4084de32db5so31879395e9.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698092255; x=1698697055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3S3ZhhyMmo5x/y8oNTerNs7DuCB8EBGdFnO1x45gqX8=;
        b=EYE7ylZf1TlUGD+WTe2cJqKhzyzvzZ21YfHAip+6yaQkNro2ZYwI4QHl4yCyQQEbvT
         Fm7oz8/Qv3dqrBSwddmgaSk947zB/W1OsDFsnRjxCNUaGDb45/y7T8/lRCB5Mytt0o/h
         DdHsImaC1eLwV/Vvd1wcYzYZVfgT53uH+GolP6MAKJZTfKocErmG50nAeW7HikrgMpdh
         RFW4dmUIWzY4MR+63+hLV6Rq9vCuSVacVxfLGuGZmSPlN11O2IbmBCSW+RdQWbKFNoZq
         5O8dhkD7ZqDMvatGJ2uWzjwZTTtMwpvXRNCenc9FGmu/VmNQ8c2+wm35Gv0Z1AHBmrWw
         eNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092255; x=1698697055;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3S3ZhhyMmo5x/y8oNTerNs7DuCB8EBGdFnO1x45gqX8=;
        b=Q+z4skYmlPdLeq8PJ/0LGkAOZLwaNQoNidycw8raGcOig/7UKfu8QOTfxnGdKFzX+k
         ROE0uuY3+/XqXY8kEXeloyEVgWqqcyXsxPPeLVbbmp3P6a9v7WFsc2Fb9O2T3uYSqeuB
         6ioYHml0I4ELdWhhSGo6fkoH3OUwuxOL+rhHrD2o5EhDTWI70qcH00mj/qCEgE0LWTLm
         OgtFv25j+AEM0HVIQG6zQURDbnj4Uv/mXjXTo6HdJ9u4TIE0QDbDhQArII8YLMBOn6+c
         4hF334lGwn8DFaJd/hAnpL4uBGaq22kvL/6Q+t2WbwocSiPncEVpqmRJYC0AVFoIXH/N
         z1RQ==
X-Gm-Message-State: AOJu0YzKsCdVwRQV1iCmU/wzVBEqIfQdab9dncei8Krc0nol4TOZRpr7
	DHkvrpRUY5W2V20bpj8XVnw=
X-Google-Smtp-Source: AGHT+IHODuOr9ZQpS3Vp6iJD4JZn3rap5nkoyDqCyQlpIEDMUmN2q1yhkpndv9CiEWtgFOTHsANO6g==
X-Received: by 2002:a05:600c:1c29:b0:407:5b7c:2f6a with SMTP id j41-20020a05600c1c2900b004075b7c2f6amr7687236wms.0.1698092255373;
        Mon, 23 Oct 2023 13:17:35 -0700 (PDT)
Received: from [192.168.2.52] (150.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.150])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b0040836519dd9sm10214685wmo.25.2023.10.23.13.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 13:17:34 -0700 (PDT)
Message-ID: <14df596a-d0ef-46aa-97c6-3c9f0da1975f@gmail.com>
Date: Mon, 23 Oct 2023 22:17:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] builtin/branch.c: adjust error messages to coding
 guidelines
To: Isoken June Ibizugbe <isokenjune@gmail.com>, git@vger.kernel.org
References: <39fd1327b2ae4f73689d70561a2f738d@manjaro.org>
 <20231023160656.4341-1-isokenjune@gmail.com>
Content-Language: en-US
Cc: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20231023160656.4341-1-isokenjune@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-oct-2023 17:06:56, Isoken June Ibizugbe wrote:

Just for reference, to avoid confusion, this is technically the fourth
version.

> As per the CodingGuidelines document, it is recommended that error messages
> such as die(), error() and warning(), should start with a lowercase letter
> and should not end with a period.
> 
> This patch adjusts tests to match updated messages.
> 
> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> ---

It is often convenient to include here, after this three dash line, a
description of the changes introduced in the new iteration.

In this particular case, a range-diff is very helpful.

This is the range-diff with v2:

1:  a4e8bb1b4c ! 1:  c4ae0c1cce builtin/branch.c: adjust error messages to coding guidelines
    @@ Metadata
      ## Commit message ##
         builtin/branch.c: adjust error messages to coding guidelines
     
    -    As per the CodingGuidelines document, it is recommended that a single-line
    -    message provided to error messages such as die(), error() and warning(),
    -    should start with a lowercase letter and should not end with a period.
    -    Also this patch fixes the tests broken by the changes.
    +    As per the CodingGuidelines document, it is recommended that error messages
    +    such as die(), error() and warning(), should start with a lowercase letter
    +    and should not end with a period.
    +
    +    This patch adjusts tests to match updated messages.
     
         Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>

As we can see, the only difference is in the commit message.

The new wording is better; it avoids the distraction introduced in v2.

And, as Dragan suggested about /the other v3/, the wrapping is correct. 

The rest of the patch is equal to the previous iteration (v2), which
already seemed correct to me.

Thank you.
