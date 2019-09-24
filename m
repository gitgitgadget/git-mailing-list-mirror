Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036B61F463
	for <e@80x24.org>; Tue, 24 Sep 2019 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404702AbfIXQxl (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 12:53:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46786 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393530AbfIXQxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 12:53:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so2946611qtq.13
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BJ3oGcF6sTiv01ymSf6O7PB0wr/tFZAUuLLqzZD0Hxc=;
        b=kpnpLl2gTefkyFwlsKQXGq3Hly0lRHfgx5txuYwal1LIn5Icg83hwShKWIq5f7/U83
         fu/jialTUyBLtCJAHIWOIxG08pXfvUd7wO/BEQgWBp5thy9gLymk4Z+WwkRhKXoV9QwI
         IQegV7gVkwllPTbq3ouC7APqzFaDWuu8Xzzzcv+cjST8oFJ74j96jTfYBkdCC5MjCWs2
         txp70FaMc4bx8+v9/q4TLLBm4HAn9n4VfWxHx8kRxc+QQ4uhJh6EIrSrMNnra1vQ5EzR
         TRnzFSUcDcQtMXi0TrF/btOojkMYWkcfKsfS4bRLA2tkdjvuOVzWT/tc1D38WfOlERzO
         v0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJ3oGcF6sTiv01ymSf6O7PB0wr/tFZAUuLLqzZD0Hxc=;
        b=mxviMXATAowl5Uwc7ekGffzLQLt89J68ZTbxzl8a2hEKYLqnPtmYMDKnzG9k+2G3rn
         Vyo3ThkaT3MkOVFJ0gDo159cjR7BYXo0QLlEWUqrtrHvMGBgPCs2qm6RAoCPBqLcpU5l
         Mm3ZIOIcHAjGtd21VpHfCXzzJ0r/7NLrdromNtx0pXXRik6q5LtxpENOvoCPNf8SKqqq
         /wHyIO1/7u6irlWqh2ri2tZ0ArttlFqQkOARzJl6/HapOeYX+mzspNQ/mo+7njgZ1JOe
         MrAeeIi5D1+Pz5OH6n1hIc1NGe+iUG+VCbuMHRjoaJI1NUy2ycJDCz4bIgTNGYubv2eb
         Ojdg==
X-Gm-Message-State: APjAAAVCwOTGXG4WfNJE9ymVqGLR0CgcCqF9vhAklBbh104y1J2FjYbG
        MXg8LyJgwUtdId1nEfIv3qU=
X-Google-Smtp-Source: APXvYqw95zAqXSlABtmf2Z3qidbJ+D+apx13PQ1BEp0eOPKsQoo7FPfB1dJm/DCs8jWo7QgkNyjnQw==
X-Received: by 2002:aed:3e8d:: with SMTP id n13mr4017924qtf.116.1569344018842;
        Tue, 24 Sep 2019 09:53:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13f:d464:acdb:33b3:245d? ([2001:4898:a800:1010:859b:acdb:33b3:245d])
        by smtp.gmail.com with ESMTPSA id 131sm1443751qkg.1.2019.09.24.09.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 09:53:38 -0700 (PDT)
Subject: Re: [PATCH] add a Code of Conduct document
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190924064454.GA30419@sigill.intra.peff.net>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <133b46b2-b2e1-4673-820b-5a5ca6ec0269@gmail.com>
Date:   Tue, 24 Sep 2019 12:53:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2019 2:44 AM, Jeff King wrote:
> 
> If people are on board with this direction, it might be fun to pick up a
> bunch of "Acked-by" trailers from people in the community who agree with
> it. It might give it more weight if many members have publicly endorsed
> it.
> 
> I've cc'd git@sfconservancy.org here, because I think it's important for
> all of the project committee members to endorse it (and because the
> document puts us on the hook for enforcing it!).
> 

I think this looks really good. I appreciate how it gets the point across for
people to empower each other and welcome new members without being too wordy.
It gets my wholehearted ACK. Thanks for putting it together. 

Cheers,
Garima G Singh
