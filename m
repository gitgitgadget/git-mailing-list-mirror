Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3FA1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 00:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFEA5Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 20:57:16 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:38521 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFEA5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 20:57:16 -0400
Received: by mail-qk1-f169.google.com with SMTP id a27so4134669qkk.5
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 17:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=//hdX5Io/bePfaErHJeA3fs6yTIVsegD4THQKNA4SoE=;
        b=jXgmGp9RhW6kyR5bTPvLaf+lgcQnT3aOuRQct3np5T+6QyRx/NsUzco0f1j06zIviI
         JOCdl1h6MdTbZ1Mkhd7e5BV8I+vLf/Q1taa6Tmm1Ge4Dx4jCHXJZ8eWNTZ8JnpW2A1hO
         aIAozx7EseBeyydo+EejqXT8sFayxkngGp0fklDx2uSicw65Ui09slxH5bi50Kr9zXn/
         60A09aTsjo4XDA36rniZcGfYhoChn3DlHsQTBMzYttqKwmRkrV/bd00DCg7/RcXnl9iP
         2er5p3sR7HIv3omjXfgVNLbBE4Ua1Y6PpjVWsUiHooA8ttRJeElwY4UvYF6hyYRmPMno
         RyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//hdX5Io/bePfaErHJeA3fs6yTIVsegD4THQKNA4SoE=;
        b=sD0C/ZOzKKBnlN0nzhocvU1DnnhTQq2kpB9oNtFtlodQU1ee0RsS7fIqxiulmzwg7/
         m2r2w4LqH4MsKAJlFdaliNaCs/igj0XP/JT8thtHxWK1VMHkC8DH8NQBbQryyfeeobAY
         Emep/PT9cqXOKB/fztwfXmIlVx/OJCKFDPyNwQhhEg8Xa86kBt67KsVfEII4acYVMnNJ
         R61EnwWnCbrCX/1ZeT6hegSpOaE9XgOz8XzFVnuTci5fIO+H3UvEQEFlgGx6m/Iqw9Aa
         95KBlF2pGWzQmZ5tn0H7LKLOIF/gKNpnkrKwK7tRonhXRl2jcIxEuslVzbOQH7+2MoOF
         50OQ==
X-Gm-Message-State: APjAAAXVHNUURg77j0ncll4iicU9UtI2LNRcvvE94xMiNtnacvIjPvjk
        wGI3ifiNq8qW0uUUvqhvPAvgHVKl
X-Google-Smtp-Source: APXvYqwFKOCfhE7979GmtrujAF3C9qwzLXUKDXAA7mfGe2YDxmLF3mdfdrQR4dHg9rcaBsXsl9wQ2A==
X-Received: by 2002:a37:47d4:: with SMTP id u203mr28876543qka.160.1559696235174;
        Tue, 04 Jun 2019 17:57:15 -0700 (PDT)
Received: from [10.0.1.7] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id o22sm5380898qkk.50.2019.06.04.17.57.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 17:57:14 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
To:     Barret Rhoden <brho@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
Cc:     michael@platin.gs, Jonathan Tan <jonathantanmy@google.com>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
 <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
 <b4ce9cbc-71d3-4d7f-1ee2-e4e3fc23b015@google.com>
 <80a23fb8-5ea8-dba3-ce7d-f6f5d4c02310@gmail.com>
 <9ab619bb-9deb-4e57-a3ad-9e996425b783@google.com>
 <09bc8c7a-bab5-7cdb-75dc-f7c45a4dbaf8@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9018d6bb-3bc1-824d-e61e-e37bb1587640@gmail.com>
Date:   Tue, 4 Jun 2019 20:57:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <09bc8c7a-bab5-7cdb-75dc-f7c45a4dbaf8@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2019 4:41 PM, Barret Rhoden wrote:
> Hi -
> 
> On 6/4/19 12:38 PM, Barret Rhoden wrote:
> However, the only thing we are really testing is that git blame didn't crash. 

This would not be enough.

> There is no detectable change to the output.  AFAIK, blame_coalesce() is a performance enhancement.

Thank you for stating that the output didn't change. I
tested this locally, and did see that the behavior was
identical.

I think you should just make the test be complete by
checking a post-condition. Please see the inserted lines
below (which _should_ work, I haven't actually ran this
in the test suite).

> +test_expect_success 'blame coalesce' '
> +    cat >giraffe <<-\EOF &&
> +    ABC
> +    DEF
> +    EOF
> +    git add giraffe &&
> +    git commit -m "original file" &&

oid=$(git rev-parse HEAD) &&

> +   
> +    cat >giraffe <<-\EOF &&
> +    ABC
> +    XXX
> +    DEF
> +    EOF
> +    git add giraffe &&
> +    git commit -m "interior XXX line" &&
> +   
> +    cat >giraffe <<-\EOF &&
> +    ABC
> +    DEF
> +    EOF
> +    git add giraffe &&
> +    git commit -m "same contents as original" &&
> +

cat >expect <<-\EOF &&
^$oid 1) ABC
^$oid 2) DEF
EOF
git -c core.abbrev=40 blame -s giraffe >actual &&
test_cmp expect actual

> +'
> +
>  test_done
> 
