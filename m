Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019A91F516
	for <e@80x24.org>; Fri, 22 Jun 2018 00:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933788AbeFVARm (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 20:17:42 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42430 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932397AbeFVARl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 20:17:41 -0400
Received: by mail-qt0-f194.google.com with SMTP id y31-v6so4557972qty.9
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TxEy2Yd1MD2gshqGxIMsAVgDgB8oJMkXgy98jaBcHKQ=;
        b=CbFUxAFaFQy6bIboTKPK3vvMZbmyB2CSaSfclaj3oTjiFqfaxT4zHhMLv9LeFzUQF/
         GfZ4JtwKZQBtvmcTj7wSPA5J8tQLJF9tWOwadAjnWYp2CRiJwVaAnEXiVgPgcuUwIJwB
         bblbtw4nMTGwbGQLWp95/DX10z8U3uNe288fa/MhnO9H2i6xHFceBxMtI5m1dhJcWzge
         yPYfNKuoS0/cKgzIISbbIJf1FxxhrhhJ2JLuV8u/u4b2V/GP8gBPWiWAK3jVXFIe8roJ
         wPddlR3b9raPGEnRQLFacRMSyHjQuqYH5tODkHltWNBfRHrTqFU+L6516GXMSl6YJ6Ws
         vmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TxEy2Yd1MD2gshqGxIMsAVgDgB8oJMkXgy98jaBcHKQ=;
        b=oHrmlRPLx7Ae7KEOqYKLQT2y9ToxkAUcDezb1LgI+wUHmWEAg/Ez1zEmiEOX5c9d18
         2wr2ceQUrb4xpvYOHrRGUfctcl4pGfCrx9NpMqYc7GEKu/wYG8+ebxxsCIcL0gkTwY7x
         j16Ty4AcU+EztcltNwU5U+5msqTmfCYKJf0nYQ4KtprxB9HqLW7OfWFTnu2pLvH6NiJt
         5BFS4oJFcO+itxgBp6xvFq8Sgo9nGS1ndXlxDpmgSS4pyqMV3+Liv+bESJZchFnlmr7u
         VRfM6cLghbwQsnByfGHbhtQemtfG9KhcLzrwrfxDap/sv9QTh38CXPhtHMVQoi0ijFWB
         dfYA==
X-Gm-Message-State: APt69E25JjsmA4kmOZ+CzUIWnrZ6tpUnYLfOV/UzdW79x9gJSzTYaabd
        xGrutOnfykrIcWbeLRRCweUHmabH
X-Google-Smtp-Source: ADUXVKJj8uto0/s/ceMA+9Z4t+qP8ur5LfFQDR2gA7/qetcegYFFZyv3rXapiQWQhhTH7XbSdMCtCQ==
X-Received: by 2002:ac8:247c:: with SMTP id d57-v6mr25210839qtd.155.1529626660278;
        Thu, 21 Jun 2018 17:17:40 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b14-v6sm3853866qtp.26.2018.06.21.17.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 17:17:39 -0700 (PDT)
Subject: Re: [PATCH 2/5] commit-graph: add missing forward declaration
To:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Cc:     git@vger.kernel.org
References: <CAGZ79kbC0e1ujAebTUexDXH4+cFOpek3a0VTrdRUfx6Z=cpBVw@mail.gmail.com>
 <20180621223942.81451-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <316b6a43-a5d0-d10f-f995-94b3165ac325@gmail.com>
Date:   Thu, 21 Jun 2018 20:17:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180621223942.81451-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2018 6:39 PM, Jonathan Tan wrote:
>> Both this and the previous patch look good to me;
>> you seem to have better (stricter) checking for
>> missing includes/forward declarations, am I missing
>> a compile option? (I have DEVELOPER=1 in config.mak)
> Thanks. No I don't - I discovered that these were missing as I was
> including these header files in other files.

I discovered similar missing headers in object-store.h while reworking 
the MIDX patch series. Thanks for fixing them here!

