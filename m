Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277B62047F
	for <e@80x24.org>; Mon, 18 Sep 2017 13:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754875AbdIRNiG (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 09:38:06 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33957 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbdIRNiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 09:38:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id u18so141743pgo.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E15lqp3QrmvvTXr4cHQ2IbTRV9ke0w/jKL5C/yH4/X8=;
        b=Kc2mWYzwhs4TLlFUMyVKbdFO8M77KQjwf8vEJKT0ms46Vbub8XUm5NlqUbTrkjAl+n
         fBU0wmZdONxEiuIeQUYBMDSWOYmzvF7FBbRHIMqEpCnJ9c+vPOx3IojqcbMasYKosv8G
         nQJnv2U4TNrRB86fhSmG8OYAlhGaf31rf7WE62Zensq+mUw5hFQS5Ded2ai8VUbq7y8Y
         1dixh3EuO8tHhnzyoO4V0cm2/OAwrVWbwqO/60yUpcvfGbabiF5ne7hrZ479at4e6AEI
         ZTo7zXgWQuq1B4B1X3cY5mV+jcHAzLrAqolnAglJXfwzPz+wM30eAMHSXJP8nz/AsfXx
         5H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E15lqp3QrmvvTXr4cHQ2IbTRV9ke0w/jKL5C/yH4/X8=;
        b=EDGY8BLi3GkoSkfjDgzITW1Ox9/9ylMXt4yfm464V8wtlaFJvZN5hHaFbiubxBh8Zf
         NiX/kCyaSFRJEAh/xr9D09uwuOTphFySxD3GMFY7hM6nZHt6HWWmcR9CSW7lmc72Foj5
         ZNNeo46hh+tG/M7jJ1lSD1LFNG85qbFN2LK1hrmTycO/gWZlDJw+64z6GzQxBqNPut4o
         8i+QFu0+oPRxTsBuz8UyD+6nfZcZXmd5peEI9T1EAQIa31S9Q7Kq6iVpdYf8uydT0a3Z
         A4gNX6NMumFxnPTCoW0tGM4q7WirmnG4EEtSW4TfDfYv/sY81JrlZNtK+KiZic9Vy74x
         XIBw==
X-Gm-Message-State: AHPjjUiwihg4rIG658P1wS/KaxMw6zFWK7rJAH+iH4DtFXL1I+AqHnEf
        jqhZyplCwQ2fefxg/2Y=
X-Google-Smtp-Source: ADKCNb4t05VGIGWjnDssftIJYiyqUA5/5yWiw0Qf1ijg9ZxvAwuMRTfU4qFvQ1zpBGTT5WjpM71vTA==
X-Received: by 10.99.3.15 with SMTP id 15mr31718649pgd.403.1505741883344;
        Mon, 18 Sep 2017 06:38:03 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id k73sm15693049pfg.81.2017.09.18.06.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 06:38:02 -0700 (PDT)
Subject: Re: [PATCH] t2018: remove unwanted empty line
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
References: <0102015e8f599df4-6e3b45f3-b3ea-4483-ad62-08119e29b1cd-000000@eu-west-1.amazonses.com>
 <20170917192227.GD21499@alpha.vpn.ikke.info>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <e7fd5df4-4496-09a2-5f67-7ae6868bb3e8@gmail.com>
Date:   Mon, 18 Sep 2017 19:07:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170917192227.GD21499@alpha.vpn.ikke.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 18 September 2017 12:52 AM, Kevin Daudt wrote:
> Why is this empty line unwanted? This kind of whitespace can help
> separate logical sections, just like paragraphs would.
>
You're right. I seem to have sent a fix precariously because I haven't 
such separation
before (forgetting the fact that git has contributors whose way of 
writing test vary diversly).
Should better stop back and think the next time rather than spamming the 
list. Sorry, for this.

---
Kaartic
