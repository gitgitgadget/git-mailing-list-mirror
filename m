Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD69A1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 14:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeCEOaJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 09:30:09 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:37974 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeCEOaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 09:30:03 -0500
Received: by mail-qk0-f175.google.com with SMTP id s198so20785508qke.5
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=M0DMzU6bhXb0dkiUBIKedIsXAMyGpx62gvnBNWEwXic=;
        b=io50XXQUrF6DOUTlyZee+EAr2o8l8WKg92rr4LqfeujP77Vq1Z/cZsma3Y6oOCg4WV
         ttHERw3g+ggUfh0pBk6VFrwLCPCdY/zDt/FLEWFpdUKBNMOKmxMA5u6t3K1HJXizH8ob
         3XOCvboteFI98vhDI3vKjy95gu7orBZqTcFYje91Jp7i2GymRqWpxSYDe/zLxIicI9uY
         5A6b81XFihBdwyckuIve6kE2c2ojvWfS2rd9gRuIyDyvvQivuZ8t0ug2Xp3mD5tbGa4y
         3sAlva1FhZqV4/XNMYSqy8i+60/GH1GjN/7czGlu4WpHKcgPwHWir7ThpNeaQLDoCXbu
         z9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M0DMzU6bhXb0dkiUBIKedIsXAMyGpx62gvnBNWEwXic=;
        b=bQ6Zx2OH9AAQyb/anbaNz10Px+OP5QBJJUBz8H6dsw5q1TojzNTzLrqJcw2qD3QfME
         wPPGdCgr/goy+GHz3cy0aBKen8Oms2PIzZe01T+3LR8uRABPm60rc/HvYCCI+EbcqLQA
         doUj/cq3J7un+hgcsw3jDYYCSkgg1k4QxHm8P4NAqRpXDmizynFBRLvFjHjUduR89ZpB
         X2nji2J8SPq3VfJt1evJN0ss+wfv6u1MLt2pT4z2/qeVelk2R25Sl11viqsaW2wQiEce
         qMDZkGIl+kJUGE0b5FYzVflQBC2OiARouc0a7LX8MMeoqkyllUxf3/hVHF6bZuc70XjP
         jlmA==
X-Gm-Message-State: AElRT7H8I74JmybiIod7eBvQAc9NBXvAfVg8YCxRn7eelNF+QvSZ08sE
        d7dQSGpU6CnZad9Cu0gPD4X1pX5j
X-Google-Smtp-Source: AG47ELuJ5aQeSfDwSl807WasJ30OlaRpIIFLxaxRG3ZvYVo+w3Qlos7KspOFgQHeMKFp0HerGWrS1g==
X-Received: by 10.55.120.5 with SMTP id t5mr21100399qkc.14.1520260201775;
        Mon, 05 Mar 2018 06:30:01 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id y58sm9172339qtb.92.2018.03.05.06.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 06:30:00 -0800 (PST)
Subject: Re: Contributor Summit planning
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20180303103010.GA21068@sigill.intra.peff.net>
 <20180303103957.GA24498@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0eadcee9-1247-0439-c2c3-8ff73df17239@gmail.com>
Date:   Mon, 5 Mar 2018 09:29:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303103957.GA24498@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/2018 5:39 AM, Jeff King wrote:
> On Sat, Mar 03, 2018 at 05:30:10AM -0500, Jeff King wrote:
>
>> As in past years, I plan to run it like an unconference. Attendees are
>> expected to bring topics for group discussion. Short presentations are
>> also welcome. We'll put the topics on a whiteboard in the morning, and
>> pick whichever ones people are interested in.
>>
>> Feel free to reply to this thread if you want to make plans or discuss
>> any proposed topics before the summit. Input or questions from
>> non-attendees is welcome here.
> I'll plan to offer two topics:
>
>   - a round-up of the current state and past year's activities of Git as
>     a member project of Software Freedom Conservancy
>
>   - some updates on the state of the git-scm.com since my report last
>     year
>
> As with last year, I'll try to send a written report to the list for
> those who aren't at the summit in person.
>
> -Peff

Thanks for putting this together, Peff.

I'll be ready to talk about the serialized commit graph [1], generation 
numbers, and other commit-walk optimizations.

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/1519698787-190494-1-git-send-email-dstolee@microsoft.com/T/#u
