Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFFFC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 14:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355377AbiBNOxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:53:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiBNOxL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 09:53:11 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF542EE3
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 06:53:02 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id m25so14525170qka.9
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Slgw01OlTA6t2tLws269yGiqB64BwVuDfCVvGYfL8ZY=;
        b=fY8la+2rq8Vl1xnl9ghOuhgiq6qLb0LAiwL075swbxIAt1HjFr8Mhx73WlFd5yuUm5
         7slcDmveNXI3fItbvlEkOJ0QeQP4XtKlMq5EvUenge0VF+fTHtP0aNY8SPtzj+X3y9HE
         8bS5blqed/ih7qkMcdC5quF8eXW7ZisXBVjSbjaw811cYePuGdMNBGuhhLPKqE9T+zsh
         pwNwWhgIi6H/Zaf2lkwkZzVXsJAZo2f83aEP3kGkaQiYpNj+YhihCLngNOKOEjyLl8bY
         vEH3IHTsCLVpYeWAZgnyGXdImGBImdogjg7OLcIrhbvqqdGuhNlqyRR9/fuiC1cCCRvH
         X1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Slgw01OlTA6t2tLws269yGiqB64BwVuDfCVvGYfL8ZY=;
        b=tbePGNjvtaPkcrZcImNpKCbwZELwiqLt63xu+9pCCCMR5dAoDhwORotGEbtJic9+UY
         jZBPsDhik7j53k20QUP1WcdTwddrzJryZFMLStVPc3nFSpXRjrXz+fq/dAC5r3TnBF1c
         K915PMGUCDdP3xQNdrUE0IIzftsmiq25NTrHUsepbf2PwELfHfCEczm5ltkNwBSWwbPo
         B9zpABofPEcUaJts94sNuJkiqWmAG9TKzXmfJTSLDUMnCz0o9YaylA2fjkfC9h5GfX2R
         7eGA736g8dBLMnaivWLRzu8Ihy0Jzrg0KZvH8fSDW7i5U1whgQlGWnwRIGti5b2yQfp2
         05Wg==
X-Gm-Message-State: AOAM533TU9c6Z+ZhNgWA0pOHfkZU2w9I4NrDskXdzIDxcsGxOxKxfAB8
        E2K5eQDCnalz+LgqZ28RnNV/
X-Google-Smtp-Source: ABdhPJwiPFfVrrPwJ2QbLoIn6+4At1a8kB8AbhxdlsO2eauO7tgYBLtqh2DlnpVZDSr1KrsZZnmUxg==
X-Received: by 2002:a05:620a:665:: with SMTP id a5mr7173354qkh.500.1644850381601;
        Mon, 14 Feb 2022 06:53:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:eccf:bfbc:c638:47f4? ([2600:1700:e72:80a0:eccf:bfbc:c638:47f4])
        by smtp.gmail.com with ESMTPSA id v3sm17982929qtw.50.2022.02.14.06.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 06:53:01 -0800 (PST)
Message-ID: <d4d4a72c-3bf2-410e-773f-118a1834a386@github.com>
Date:   Mon, 14 Feb 2022 09:52:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes
 eol
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220214020827.1508706-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/13/2022 9:08 PM, brian m. carlson wrote:
> I was answering a question on StackOverflow recently about the
> interaction between text=auto and eol, and someone pointed out to me
> that what I had written, which was based on the documentation, was not
> correct as of Git 2.10 (and more specifically 6523728499 ("convert:
> unify the "auto" handling of CRLF", 2016-06-28)).
> 
> When I set out to document the behavior correctly, I ran into the fact
> that the tests, where I looked for examples of how this behaves, didn't
> have any tests for some of these cases, and so I had some trouble
> documenting this clearly and accurately.  So this series basically just
> adds some tests for existing behavior so we don't change it (and so I
> could figure out how it works) and then updates the documentation
> accordingly.

Thanks for these updates. They look good as-is.

-Stolee

