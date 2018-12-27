Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31133211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 14:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeL0Olm (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 09:41:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40478 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeL0Olm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 09:41:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so20290231qtf.7
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 06:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=6XRg1ZLwur1NleXd+aeJg1h+rwMmnnxhx+UpD6zoFjc=;
        b=KuWbZlQTVlAFhNChCKI8XI25+UOmKb81PiPjxSuhHrD6P9DHWrwZIVsiYphfNyTsE0
         Mgdi0Ly0mCWGSHH/wH4pzEFlbC+ILHuAWCtq+K7UxSRNL2AHbdOud0/bGqOSpGhYOCpe
         8kPW+dZEAgYCiL4dzYE+UchyOwjlHlx8eUDZrzGXLu0LkBN1dIQ7pahmv9pYiwOIhGXQ
         eSNCP3j7m+QRNS2DKXQgQoziq7ZC7acnyH+JI1qBn2u60oqPNS7fBzJdPiwT7S1hLE5N
         HD9TFMYXph9wLnjFOS4T6829i70zeTbykASaWsK0HdtFQ1VR0ahQnt1kES7qCaowEwDK
         8Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6XRg1ZLwur1NleXd+aeJg1h+rwMmnnxhx+UpD6zoFjc=;
        b=j4LKqNICW9AIUR17ucWilf1ZR55E87Ok7okm/zLky1SGTCLvGmZRfI15HvLTHdTBLt
         PZ5hnRLoYUa2kmac+VtgUNAMrnD/T6TkkX1EpApE1Oqr/EcGpz9OcfB7MYeEE9Owdujn
         7lQ2FOp/P7ZFqZyLqMBKbcdZEvhplXIj7fSVPECXwKvy48p3yQNRVmdQiTt4cig9iMbq
         fUb99NnxNCstVIATJWpfbAcVZjIYyfPKvblUmROphSYWio4NU7FI/Zwn9j7XfEZwn9xz
         Fp0pWm5U7LYHJ/qzUVbTgB1R+8iWTmItl6fmnPHI/at5m3FDAZEvqTxb70PXjI02p6kP
         +S8w==
X-Gm-Message-State: AJcUukc9qwQ+VykbhIF2NmlXzUJzjkbuwgxsX+KpHesZYYa9nYVCOAwJ
        3rMNoRSvExSBh/amPcfDZWzxXcnK
X-Google-Smtp-Source: ALg8bN4IM/YcnSusx8DPylq8PdUZSK+4kcZIuAKvhf2ep5VPMO6gJqcNQxBKE/kY6qB1DCmC2DHfqg==
X-Received: by 2002:ac8:4611:: with SMTP id p17mr22828867qtn.263.1545921700714;
        Thu, 27 Dec 2018 06:41:40 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id j38sm17631860qtj.72.2018.12.27.06.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 06:41:40 -0800 (PST)
Subject: Re: [PATCH 00/23] sb/more-repo-in-api
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20181215000942.46033-1-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b2ff842d-4d60-0db7-c11d-dcc006dade18@gmail.com>
Date:   Thu, 27 Dec 2018 09:41:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2018 7:09 PM, Stefan Beller wrote:
> I realized next has not been rewound, so I can resend sb/more-repo-in-api,
> which I hereby do. The changes are minimal and address the only comment
> by Jonathan so far.

Sorry I'm very late to look at this, but your series looks good to me. 
I've got some work on the way that will use these arbitrary 
repositories. (Specifically, moving 'generation' out of 'struct commit' 
and into a commit slab to store reachability index values.)

Thanks,

-Stolee

