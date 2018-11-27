Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65FD1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 22:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeK1JeH (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 04:34:07 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41747 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeK1JeG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 04:34:06 -0500
Received: by mail-wr1-f52.google.com with SMTP id x10so24347861wrs.8
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/es8yuVckwHKTNkXEOnOnQhhdOIYOdleyagFxVzcemI=;
        b=F/a89W3OrDU/oCt+1E47BfI01oMIUZqAvY2lP+vpb0zn3ji4xXKWZePX1RmTsuwtlO
         4ABgXSi463nCjEgf4qaMTT1AmeQnUNZOT66r27bV8MR8n8jmv98mg0sJbMXVPldnMWcP
         0vEx73iozJI24GekmScUF3JBjyeyYmZdkCiRHwDAYDtdV3Pr5Y1Zhqk4GdAR+8tOMVH6
         nVrscU16v6aEVrSO3Hyiw3RY5rIlROHlWS47i715LMjrIZlyfPyLOWrgZopRhyGYM5Xt
         D75Bm8TC8sJQvgEIZknfPuQs9s/L5GOzvH/ORaqW5JS6bT+46CDxU0OI7UgxJnq9YmW0
         PgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/es8yuVckwHKTNkXEOnOnQhhdOIYOdleyagFxVzcemI=;
        b=MQPhMgI97vKcxYqyZlvgqmK/5GIgM+iUV4ewFFSJrqUCdfzj/8Jv7oUrO+BoO/yPpV
         WlSUZaROG7fj7oKFxB/jRC+WuhIWIYb64/XBK/mxIMhZncxrv4sQMzAtV4TmfHf0r+EE
         jEhjabfEoKiUgj2jqwHwYWcjnylknFSOh1nzVE+0KD2eo9/jV7kglXacMqEzNh7JC2F0
         g0T82zt2ryS24fcFr8/14Mj1X4lkyM6k/I0JTtDyhbIepgnuQgmS73WUeNqMP6wyUGV8
         naPCEbb8B7IYqQfjxGpr94+AVdanDmUcZhQb0PX2SV9am7XKFZC49A+z18GBHwIq+dWS
         TC2w==
X-Gm-Message-State: AA+aEWZiIpCFlNlp5aF3SKcCyuJrpIOXMgSQcGNTS1TjKOdpRFo11zQh
        kupUT642Q2fNMNh657XFAmCrDbwJAdg=
X-Google-Smtp-Source: AFSGD/UIGrqrFFbXu5N+wWtmQEobBVD/qSEiSnrwi2/HyJWbAGWT68K2VPO+BHZRWb9bJ10M8sJ2Dw==
X-Received: by 2002:adf:c888:: with SMTP id k8mr31408489wrh.6.1543358082215;
        Tue, 27 Nov 2018 14:34:42 -0800 (PST)
Received: from [192.168.0.5] (cpc76574-dals22-2-0-cust484.20-2.cable.virginm.net. [82.42.161.229])
        by smtp.gmail.com with ESMTPSA id p74sm1015773wmd.29.2018.11.27.14.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:34:41 -0800 (PST)
From:   Will <william.duclot@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     "Stefan Beller" <sbeller@google.com>
Subject: Re: Git pull confusing output
Date:   Tue, 27 Nov 2018 22:34:40 +0000
X-Mailer: MailMate Trial (1.12.1r5552)
Message-ID: <1A9DD0D0-A1CD-44B8-A44A-35D795DA18D1@gmail.com>
In-Reply-To: <CAGZ79kbDHyzFF-HtDcD=rOLZB+RFRnVqZgXb9uwm=9_m-6E0QA@mail.gmail.com>
References: <758FA299-0842-4462-8CF6-D7210D26A6C7@gmail.com>
 <CAGZ79kbDHyzFF-HtDcD=rOLZB+RFRnVqZgXb9uwm=9_m-6E0QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27 Nov 2018, at 19:24, Stefan Beller wrote:

> The different phases taking each one line takes up precious
> screen real estate, so another approach would be delete the line
> after one phase is finished, such that you'd only see the currently
> active phase (that can be useful for debugging as in "The phase of
> 'Writing objects' takes very long" -> slow network connection).

I like this idea

>>> Pushing to github.com:williamdclt/some-repo.git… done
>>> 1ca9aaa..4320d30  master -> master
>>
>>
>> I’d be more than happy to work on this (`git push` is an example
>> amongst so many other), but want the mailing list’s opinion on it. Am
>> I wrong in thinking that this output is not something users want, am I
>> fighting windmills or maybe just being ignorant?
>
> I think this would be a useful patch, but it could get complicated
> quickly: push uses other low level git commands to prepare the
> packfile to be sent to the server, currently it only needs to pipe
> through the output of the low level command (or even have the
> low level command directly write to the terminal).
>
> The output of those low level commands should not be changed
> when run on their own, I would assume.

Agreed. I didn’t expect it to be so subtle, but I’ll look into it
and see if that’s something within my reach.
