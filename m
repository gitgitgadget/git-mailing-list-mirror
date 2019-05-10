Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05DEB1F45F
	for <e@80x24.org>; Fri, 10 May 2019 12:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfEJMUy (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 08:20:54 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34013 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJMUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 08:20:53 -0400
Received: by mail-yw1-f67.google.com with SMTP id n76so4592464ywd.1
        for <git@vger.kernel.org>; Fri, 10 May 2019 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fqpFtP51DdHukmGQcHiOCY9qwKHznLcDj5Dx4nA8zbc=;
        b=jOAWHXj3H302Chm8XbBBrn5+suAhMGuU8UWJCdD3fDFV5CL+y0265WEjucTMk4KCTw
         8e4mOPmRP4nRgm4+atnelyuyi9n+CogU5HG0mx+6Q+JgDF+2fI6s14GfJVfXZb0PBxXu
         rvD1oL5uBpRu9enAiDxMLy7RyEcFUZV49bjDni6D90db/wfSqv7dOJl+WJ9dK+RwKegD
         U/wxytcKL3t6s8UJzUPQx/hhTdEC5yQ9eaOKOX5NS/uUxBC2jo6/xLSkkj8DcQ+6HqEX
         toyKcFHArxYg6NsuS0aUHO9FYbKbBcUjL/1lgzBTNRIs1QsvgTQEHUVJ5wfxEaaHpgxq
         F19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fqpFtP51DdHukmGQcHiOCY9qwKHznLcDj5Dx4nA8zbc=;
        b=efXuXypuqxgbO8J7hj4RlWX0ubwCvEcZur2UouDzrKZsKikLP74ey9dG0Cq93kc/J+
         gj4GGnWIQqyww8jiE/OAstBbQUJHk6jgCYRNEg1C1tsPu0TmlNdDw4hlcXPOIVVNEFbP
         tErm+wXWIJHJxaW2M0mB4xOI8R3CteqFk70yX2BmnN+K/pIUq2US5Z5zkVS3e9HpWlN1
         15EDec/GhVs7lNMvqOi/HHyv07KqPwmMn3qpIiey9G42S5YsacqM4Bdq0iR+P6Y/RZ5k
         M5o5T6fiw0CKbzAV4pfZYyGolPesPJrUpxgMRJwKXoxk/n1gzBqwmh82GD9ubCEYweir
         ZZUQ==
X-Gm-Message-State: APjAAAVIxZeZ7CJSIsUSOkaUwpS9FlB5XSA8l9IfDbNmSbLagEsd7a3t
        QUaXSbtXeXCzBzb66wGVohul4+3fkGY=
X-Google-Smtp-Source: APXvYqz/kGjG05J+BfoJa6fLIkCViE+GjxiulKMAEyocCDtk/lpgX2yx3TZ2wIk09Xirot53eFKilA==
X-Received: by 2002:a81:4888:: with SMTP id v130mr5282245ywa.415.1557490852623;
        Fri, 10 May 2019 05:20:52 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 207sm1417331ywv.9.2019.05.10.05.20.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:20:51 -0700 (PDT)
Subject: Re: [PATCH 0/14] "final" batch of unused parameter cleanups
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190509212558.GA15438@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aaa4a296-ff24-84f6-d67a-19feef200a48@gmail.com>
Date:   Fri, 10 May 2019 08:20:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2019 5:25 PM, Jeff King wrote:
> This is a continuation of my efforts to get us compiling with
> -Wunused-parameter.  This round finishes most of the cleanups and fixes
> I intend to do (though I have a handful of cleanup cases that I'm still
> poking at to make sure they're not in fact bugs). After that, I have
> some patches to annotate unused parameters we can't get rid of (e.g.,
> for cases where we're conforming to a callback interface), and then we
> can finally flip the warning on for developer-mode.

This series looks correct to me. I look forward to having the warning
on in developer mode!

Thanks,
-Stolee
