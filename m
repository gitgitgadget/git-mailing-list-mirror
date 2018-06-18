Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994911F597
	for <e@80x24.org>; Mon, 18 Jun 2018 18:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935927AbeFRSsg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 14:48:36 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:41547 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935677AbeFRSse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 14:48:34 -0400
Received: by mail-wr0-f179.google.com with SMTP id h10-v6so17900888wrq.8
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KeYPqYwtP6kiAzzllVKUnN/ck5Lt5mVPJxgMryFELUc=;
        b=miQ6ynKCTLUDrBQlkaKlq4PnfzHib7PRxSQBoJIQT1kZRqxlFl2ESoL+NZnn9hfI7/
         SS+NcKPHAA2aKrauZ/6WQmJ3eUxvZfz7Xf/WtOKhhvW3mfGIyr+Ailgv3hxfItPZxxJm
         PkGss9fDLI3ZF8yrBAPL7sFEPsgxSn3m1tSV+CU2TJAHwD62crNDyxOKRloHETTz2N5w
         aCA0EvIMi4RmnHp+WDwy2CepllXJVRdyxAoBoxitsB7R//5o+sRquGExwyhy1MADDen8
         U5kLGr6GgtXfXc5Xj43t9EmjSRHxy7ZoA69V6/Vgc0UEzavtyVoZGT48K3gV3kh4y2W5
         zWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KeYPqYwtP6kiAzzllVKUnN/ck5Lt5mVPJxgMryFELUc=;
        b=QXIjPN/iMG6jEYjw38C6PUrk9wPNtYLjg1+qD7xlqBFRgBEFfrJ6N/Sn9Rb17d1nOI
         KJOqrzZmrCNKm7ZZqG9udmo73+iwet1GLUnYfL7Zm9jEdUKsoOZxgcnpW4V2G9A/uZUa
         sC6zfAc2xL18r9I4cme5E7thZRGKDDSF+YEdHfr1T6blezLxbraRufHHnESx8A9Qw+4W
         6LRedTtogAxiNzGCbWw16QKi0DfFvdZnnarVhW95mPO6XU6IWR0ZRA+NGXE3H0guxoGm
         3GyrOU8UR+zDsMkl5VpJFBFx932YKlZNU3Sz3BIePidxNhca84De5/h4Pk9cUiFh5Xzg
         xP5w==
X-Gm-Message-State: APt69E3Vx9ZQtnLjBUGvmiNwNrvK0inZVka50DixU0Nh+zG2Ie0CSxYH
        Rq6+FtCrvgh9ljzxme65GNs=
X-Google-Smtp-Source: ADUXVKLbD7AqWtTmZEA+9B/kU6cd7ybU3w7NrV0wxmndXceTlCziY4mCC1z6GoIiVTuSlLVPcsH4Iw==
X-Received: by 2002:adf:86ae:: with SMTP id 43-v6mr10406628wrx.281.1529347712122;
        Mon, 18 Jun 2018 11:48:32 -0700 (PDT)
Received: from [192.168.0.137] ([79.116.110.59])
        by smtp.gmail.com with ESMTPSA id g4-v6sm13770549wrq.32.2018.06.18.11.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 11:48:31 -0700 (PDT)
Subject: Re: [GSoC] GSoC with git, week 7
To:     Alban Gruin <alban.gruin@gmail.com>, Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
References: <f7cd9f11-c239-15f0-87b8-b1503b1d54fc@gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <c3025418-e98f-6860-c55c-1d6b2d27dddd@gmail.com>
Date:   Mon, 18 Jun 2018 21:48:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f7cd9f11-c239-15f0-87b8-b1503b1d54fc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

On 18.06.2018 20:34, Alban Gruin wrote:
> Hi,
> 
> I published a new blog post here:
> 
>    https://blog.pa1ch.fr/posts/2018/06/18/en/gsoc2018-week-7.html
> 
> It’s shorter than the last one, but feel free to tell me what you think
> about it!  :)
> 
> Cheers,
> Alban
> 

Good job! My blog is also up:

https://ungps.github.io/

Best,
Paul
