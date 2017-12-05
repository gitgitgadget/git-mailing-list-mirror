Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6A220C13
	for <e@80x24.org>; Tue,  5 Dec 2017 05:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbdLEFUr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 00:20:47 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37527 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdLEFUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 00:20:46 -0500
Received: by mail-it0-f49.google.com with SMTP id d137so12355869itc.2
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 21:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5PC5952XEUZcae3MlUpdjqNZysp2HKFoDSIWhs76wXI=;
        b=OI2wvcolChy1xTr6O3ReA/MIzB0Skpk2CS0SJjvYq1yb6Q8UOj44ESxa/kzfB8tpl6
         yqzbURoRlUIwzug6Vukiv2yFE0+p8LlROeWcex3DdIAKVBVLBfmppFDCvlWnT6W/qvth
         ECvBxTRN+O8X+5SqZCGS8i6/O86DNelvwywmd4vLCRE783a1K+JYa1ENKS3I26n90w1O
         rNJuuxI7mHrTqIBsBTtoDiPiFFCp3ZCgWXQBCmorHFnGUOiHcn1IQyluPR5e6YNQVInt
         2NbS6fuW287HDawMebDh+d3FDQiFDoRNW655BXqKfBu1iGcvusC1QZC0XMQQCxO10LD9
         XIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5PC5952XEUZcae3MlUpdjqNZysp2HKFoDSIWhs76wXI=;
        b=nPSzFjDbitwW28XzwkbCBuxJ1WSABN3Qzs8EBRZ+ci/RNdj2hJxgoydqVHS3Ov7bXH
         tSRXh5YADwVuH/jMGUHvS9krtiChr0TMvrtFFUa5zEirYC2Tc72N+yP2dAQxWRb0Ehrh
         4XJkVOJnfiRy9omSKQWgD511d4Z8D1P990qPqaqeEr4SmaexiEgZP2972ESHXYVoBX7n
         9AIMjwyETs+X7+VFQ9GI/QKC6yxiN+89ZuFvAEk8tdRBewEh3/l4OWkZwNHsSq34rsbE
         GKPH1bh99/fCJp7dlWrEl+cX01Ete56TOTNe1p+inKUOPF5WU95ubEg21Hw9lGNCvQmG
         00Zg==
X-Gm-Message-State: AJaThX7tp14I5gox2PZMP7clAxTCSRa3u5GHwSGKaHdMNdSWr8BBdb2+
        h381GwR0x7RL/DZMI2HjRxWy0Gnt
X-Google-Smtp-Source: AGs4zMa5n7IUxXgTN42FGzhDfnc/hr3RZrk11oEqo7ByBIJmfv4TDZBc7A2U1d0TH6vJ5406xwQtrA==
X-Received: by 10.107.132.19 with SMTP id g19mr25754767iod.47.1512451245533;
        Mon, 04 Dec 2017 21:20:45 -0800 (PST)
Received: from [192.168.206.100] ([117.243.21.132])
        by smtp.gmail.com with ESMTPSA id m123sm4025734iom.71.2017.12.04.21.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 21:20:44 -0800 (PST)
Subject: Re: [PATCH v2 2/2] Doc/check-ref-format: clarify information about
 @{-N} syntax
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
 <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
 <20171127172834.6396-2-kaartic.sivaraam@gmail.com>
 <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
 <1511880237.10193.5.camel@gmail.com>
 <xmqqa7z0lgsd.fsf@gitster.mtv.corp.google.com>
 <1512408328.15792.5.camel@gmail.com>
 <xmqq8teimiz3.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <55d5598e-7c4e-c4ea-53a4-7fece0ea4d38@gmail.com>
Date:   Tue, 5 Dec 2017 10:50:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq8teimiz3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 05 December 2017 12:14 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>>> Stepping back a bit, the mild suspicion above says
>>>
>>>      $ git checkout HEAD^0
>>>      ... do things ...
>>>      $ git checkout -b temp
>>>      ... do more things ...
>>>      $ git checkout -B @{-1}
>>>
>>> that creates a new branch whose name is 40-hex of a commit that
>>> happens to be where we started the whole dance *is* a bug.  No sane
>>> user expects that to happen, and the last step "checkout -B @{-1}"
>>> should result in an error instead [*1*].
>>>
>>> I was wondering if "git check-ref-format --branch @{-1}", when used
>>> in place of "checkout -B @{-1}" in the above sequence,
>>
>> I guess you mean '... "git checkout -B $(git check-ref-format --branch
>> @{-1}", when used in place of "git checkout -B @{-1}" ...' ?
> 
> No you guessed wrong.  I was (and am) wondering if the last step in
> the following sequence should fail.
>>>      $ git checkout HEAD^0
>>>      ... do things ...
>>>      $ git checkout -b temp
>>>      ... do more things ...
>>>      $ git check-ref-format --branch @{-1}
> 

Ok. Now I get what you say.


> And I am leaning towards saying that it is a bug that it does not
> fail; @{-1} is a detached HEAD and not a concrete branch name in
> this case, 

It seems your thought is similar to the following thought that I 
expressed in [1],

-- 8< --
> 
> I thought this the other way round. Rather than letting the callers
> error out when @{-N} didn't expand to a branch name, I thought we
> should not be expanding @{-N} syntax for "check-ref-format --branch" at
> all to make a "stronger guarantee" that the result is "always" a valid
> branch name. Then I thought it might be too restrictive and didn't
> mention it. So, I dunno.

-- >8 --



> so "check-ref-format --branch" should at least notice
> and say that it is a request that may lead to a nonsense next step
> (which is to create a branch with that 40-hex name).
> 

Makes sense, this should at least be noted in the Documentation. Is that 
what you had in mind too or do you expect 'check-ref-format' to do 
something else too?


[1]: https://public-inbox.org/git/1511880237.10193.5.camel@gmail.com/

---
Kaartic
