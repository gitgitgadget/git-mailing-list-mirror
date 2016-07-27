Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4BED203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 12:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbcG0MgK (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 08:36:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36418 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbcG0MgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 08:36:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so6246784wma.3
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 05:36:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=fMDypt4gGOmHz2SBq2ZNtjsuyspHp5bXaotz8CPHDng=;
        b=v6WOeqnJi7IbLyaitFI/wBJETsVZWS3G7N1Mc9uX4mg9KuYrru21FVwwX1WOk58Qvw
         VjHJ9SIbao+owLqfhFPHxPre7lUgLb50KNbeEGF+mbs9mZZqQeUv6UM94FhClvBXiNWM
         EmM0JvYxUMGN4nxN/rV1S1SRqbwBGUb4Ayiylflm8TQEc+dbT9zUNcceq/qhCcMzXafr
         80Mu2WiJt9g3AtwrJtu68vPbIGMPM2qDdVFEpsKATTRSJQ3DBI975VYSwZIuMosut8uQ
         xaFdnaW4IJ01HJpYITwYgoxGL6s2yfdBVxGH2UQ3dIDo3JvY5v0VZeLCZ6o/oRlTmxCh
         5YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=fMDypt4gGOmHz2SBq2ZNtjsuyspHp5bXaotz8CPHDng=;
        b=bDqUAJmRMSwisYvme98vkVfiWRG6eptKtv36BNGREQXMgt4ASU6VjH5or9aP8giqto
         tUoFDf7Iw28YLoonzjpYHrTlvL30js7qN4Jgk1Qg1/8iiNIu8C8PjWlBXmHGVL7JsD5r
         DR6aLRVfBq+kx/FjeW6fzEaJq5A+wPnXx7wuUWjF7JpdFqODJuc41/wsaTXDYF9nGvRZ
         Fma3bj/pjDyLGwHOLxKNqbHiqJiix5xL+6itmNOXudtEnfADIW9NYwkeYJC80ZyvbW/1
         vAVMFPS8jnWLIwN0jlgRJyA9cNa+XSj7xBm+TwkIx86eP4LlOu+BPbmm908UkANWQi0X
         rNHQ==
X-Gm-Message-State: ALyK8tI2Aie8xPwsJlm36L+QL65U1Kw5L9Ma8Nff6dy0Xx4xLTkcu/G27r+deuD0YXgLyw==
X-Received: by 10.28.24.5 with SMTP id 5mr52972316wmy.6.1469622966345;
        Wed, 27 Jul 2016 05:36:06 -0700 (PDT)
Received: from [192.168.1.26] (eps206.neoplus.adsl.tpnet.pl. [83.20.60.206])
        by smtp.googlemail.com with ESMTPSA id q137sm38160330wmd.19.2016.07.27.05.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 05:36:05 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] date: document and test "raw-local" mode
To:	Jeff King <peff@peff.net>
References: <20160722195105.GA19542@sigill.intra.peff.net>
 <20160722195144.GE19648@sigill.intra.peff.net> <579343C9.1040902@gmail.com>
 <20160726184746.GA678@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5798AA7C.6050107@gmail.com>
Date:	Wed, 27 Jul 2016 14:35:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160726184746.GA678@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-26 o 20:47, Jeff King pisze:
> On Sat, Jul 23, 2016 at 12:15:37PM +0200, Jakub Narębski wrote:
> 
>>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>>> index 5d1de06..3ec75d4 100644
>>> --- a/Documentation/rev-list-options.txt
>>> +++ b/Documentation/rev-list-options.txt
>>> @@ -725,8 +725,8 @@ include::pretty-options.txt[]
>>>  	`iso-local`), the user's local time zone is used instead.
>>>  +
>>>  `--date=relative` shows dates relative to the current time,
>>> -e.g. ``2 hours ago''. The `-local` option cannot be used with
>>> -`--raw` or `--relative`.
>>> +e.g. ``2 hours ago''. The `-local` option has no effect for
>>> +`--relative`.
>>
>> Do I understand it correctly: --relative is a short form for more
>> generic --date=relative (which probably should be spelled 
>> --date-format=relative), and that --date=relative-local is the
>> same as --date=relative, that is *-local suffix does not change
>> how date is formatted?
>>
>> Because I don't think you can say --relative-local ("The `-local`
>> option has no effect on `--relative`"), can you?
> 
> All correct. There is no --relative-local because "--relative" is a
> historical artifact. We could support --foo for every --date=foo, but I
> don't think there is a reason to do so (and reasons not to, like
> avoiding cluttering the option space).

So shouldn't the last sentence 

  "The `-local` option has no effect for `--relative`." 

be rather

 "The `-local` option has no effect for `--date=relative`."

Though this might be just me being overly nitpicky...

-- 
Jakub Narębski

