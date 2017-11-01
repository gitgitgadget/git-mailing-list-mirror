Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4B220450
	for <e@80x24.org>; Wed,  1 Nov 2017 01:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdKABGb (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 21:06:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44423 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdKABGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 21:06:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id x7so662308pfa.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 18:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MC8XL5wSj5kd7tI0+M3ohRwAH6CtlRFjfCT+6OFUFT8=;
        b=PBQU1QstS7G03fAjap9sFQO5g0JmtDTXcRq979XwPXsQZahKQZQ56Se4CcJbPhJgJu
         iAc4zILaTbqZrB8sT0OjCAKhiywoRO4un2vnGZb1R/5qWsH0Bf9wxd+vqCS901k32xkr
         S9xkA0XEyH0lyqp8T7BtvcANBWlu5N8eZrI5dPKuok726ff7qRj74zmB0B95q0KZYQOI
         BuwKr1Kk53r3aOocToNFJ4BH1KJwCQ4LY5pQAo0S0NmR69gBBNj/N19sQJGNnqI3G7fd
         3sp52EkqC7kmACDfM2FVwiIXfTP4HJT0ss22ZcA+cNkeB8Je7vnFaD2ayBOJp23+8Cov
         zrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MC8XL5wSj5kd7tI0+M3ohRwAH6CtlRFjfCT+6OFUFT8=;
        b=PRIg6+FcnEgVA20Sbyry5LikQLjboINxi0MWHN+w+r5ZvcieLAh0Cfrwlt7+8eqAjz
         0Gv0wb23mIDB7YipcAc+zNTgrAt9P5yyTJApaSRe/z4nLIxHokMxfb8nl6qzq3va0pni
         9Z3Bq8Mc9m7ujCdDdncTm2j0Z+v91T6JbfYJHtQXQ0DlwckPJVGI2S4U5GCYZl2Dv3Ol
         eInJ88r9NcpL5+1wbGbI+NVTbXnDsv94KUgWNNu1ZD34mRz1nk2NPoymShHQGdTcGqXL
         rakPoz0VVcuPArkoxY0OhGJkKDtftuLynLYI48NLFzXEYfrYrv56AmnnZ4mnwGpfFR3a
         VcLg==
X-Gm-Message-State: AMCzsaW2HlUVPuosxXr1xCqz9wYKBL+vNxzTChqwr/3w2oinnUer7ffS
        GW4Hi58mG6O0EPxNcj7y2w==
X-Google-Smtp-Source: ABhQp+RzWXur52qClu/XGZHsPxB7c1BO/GKNIAoAu4ejzU4qcWAlQttHM6zBtEvupvvGNK+Zdn2LFg==
X-Received: by 10.98.200.85 with SMTP id z82mr4186225pff.313.1509498389953;
        Tue, 31 Oct 2017 18:06:29 -0700 (PDT)
Received: from [127.0.0.1] ([144.48.7.118])
        by smtp.gmail.com with ESMTPSA id a17sm5837126pfk.173.2017.10.31.18.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Oct 2017 18:06:28 -0700 (PDT)
Subject: Re: Meaning of two commit-ish hash in git diff
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <ab9b5c63-ca38-6157-6732-78aa5d5f291f@gmail.com>
 <xmqqd1542b5r.fsf@gitster.mtv.corp.google.com>
 <2A1B66E868594FC984FED8F0EDEAF900@PhilipOakley>
From:   Yubin Ruan <ablacktshirt@gmail.com>
Message-ID: <127f7748-4b5d-f6be-2c64-fa4ee079b871@gmail.com>
Date:   Wed, 1 Nov 2017 09:07:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <2A1B66E868594FC984FED8F0EDEAF900@PhilipOakley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Philip,

On 11/01/2017 08:27 AM, Philip Oakley wrote:
> Yubin ,
> 
> From: "Junio C Hamano" <gitster@pobox.com>
>> Yubin Ruan <ablacktshirt@gmail.com> writes:
>>
>>> diff --git a/path/somefile b/path/somefile
>>> index f8886b4..a1c96df 100644
>>> --- a/path/somefile
>>> +++ b/path/somefile
>>> <snip>
>>>
>>> This is output by a `git diff` between two adjacent commits but they are
>>> not any commit hash. I grep through the whole $(git log) but still cannot
>>> find those hash.
>>
>> The f8886b4 you see on the left is the name of the blob object on
>> the left hand side of the comparison that produced this output;
>> similarly a1c96df is the name of the blob object on the right hand
>> side of the comparison.
>>
>> IOW, if you have the contents of the blob whose object name is
>> f8886b4, by applying this patch, you will get a blob whose object
>> name is a1c96df.
>>
>> The information is used by "git am -3" when the patch does not apply
>> cleanly to fall back to the 3-way merge.
> 
> The ability to 'git describe` those blob object IDs is currently the subject of a patch series
> https://public-inbox.org/git/20171031211852.13001-1-sbeller@google.com/
> 
> Maybe see if would have helped ;-)

What would be other use case of the blob object / blob name ?

Yubin

