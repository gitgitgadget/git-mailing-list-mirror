Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDF6D208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 12:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbdH3MwY (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 08:52:24 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34102 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdH3Muz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 08:50:55 -0400
Received: by mail-qk0-f180.google.com with SMTP id a77so27289213qkb.1
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NI3t9byKMFnPeXQKi/MvHjl3wC83nv+w4D3FRYK/qDs=;
        b=iCfD+CTZbC868vC6JjXWq/+QK4XS3TAgFocT+pM245Axtasj/H/04ylbcU3X0BqwmJ
         iNdmj2mHeJXCS0LbbRKDt/v2JLkYcDvXZMRdP6uIKhgyVuRAahTOYg2SxnPPHsWZr6WS
         jhp87GDVQ39sKWztWNCAMkNzIEFHs1pu0g4nvmGEsBtrDzF8KGMha5JT8A2HWx/x+kcn
         2Uv6wk0rTHSwUUYMWW/mi2v87A2fa4QT/GbHCd1GlmAIyOU0dnvLIqy9p1SIDA2CMKLK
         VaRMwj4VzdBcxlFxGOEVJuEBYh8gaFwULX2W7yOdqZXuC1rUlFp+95YHtCvJgVZU1nRV
         9GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NI3t9byKMFnPeXQKi/MvHjl3wC83nv+w4D3FRYK/qDs=;
        b=n+KGN+PrOaXGgK6D2elrUKT5N5bVud5jalVRfU6HRjkPbRdZf1bszzYpmQ8+DTg92W
         ToBLboDvfqrocBLjCpmMb56/f3oMKeT0Z771NZxHLQMQPiZwN7gxrr65IqcTuAwkBINg
         iimtuy48UbrkIiA0JnCjj12m7cQm+MIjLZ/8+xXyPIZnQEs4ARSy/k5l4IQ2Sj3vqhpu
         YhbckuaFfhgAhlFdyrDdrF8PV2injnK4X7/4R81+yH6X11JmoBQTGcNiWIudjTOcplJv
         qcHMSNjlS/2aUheU7B7UnTYG7I4pgMwnhLDp2Bfy0Ys/ZGuXqA11+JCJN1xGBDvmVh0/
         ks3w==
X-Gm-Message-State: AHYfb5ggbFmYqNzJDdvwAqPuFUf/NDo9z+uJBhH5dqPVjxKWILvGu+vp
        67IUgMDbRJc9loq4nN4=
X-Google-Smtp-Source: ADKCNb7harCHbI1ex/VddvSVsFr14WLwCrxkYs1Uk4TAkt2gZkFMmGTCuUnIoih7ymaPcSFiNxVlsA==
X-Received: by 10.55.165.142 with SMTP id o136mr10212315qke.93.1504097454804;
        Wed, 30 Aug 2017 05:50:54 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y27sm3743501qtc.10.2017.08.30.05.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Aug 2017 05:50:53 -0700 (PDT)
Subject: Re: [PATCH v5 35/40] Add Documentation/technical/external-odb.txt
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-36-chriscool@tuxfamily.org>
 <e15513eb-aed9-8bd3-794d-009a91c1d20e@gmail.com>
 <CAP8UFD2VFsJWyP1TWLS15wYz2vQxHd4hG5Bdbo9-B45Q-onG2w@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <dc9b7aed-c781-d0fc-688f-32d665ad61ab@gmail.com>
Date:   Wed, 30 Aug 2017 08:50:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2VFsJWyP1TWLS15wYz2vQxHd4hG5Bdbo9-B45Q-onG2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/29/2017 11:43 AM, Christian Couder wrote:
> On Mon, Aug 28, 2017 at 8:59 PM, Ben Peart <peartben@gmail.com> wrote:
>>
>> On 8/3/2017 5:19 AM, Christian Couder wrote:
>>>
>>> +Helpers
>>> +=======
>>> +
>>> +ODB helpers are commands that have to be registered using either the
>>> +"odb.<odbname>.subprocessCommand" or the "odb.<odbname>.scriptCommand"
>>> +config variables.
>>> +
>>> +Registering such a command tells Git that an external odb called
>>> +<odbname> exists and that the registered command should be used to
>>> +communicate with it.
>>
>> What order are the odb handlers called? Are they called before or after the
>> regular object store code for loose, pack and alternates?  Is the order
>> configurable?
> 
> For get_*_object instructions the regular code is called before the odb helpers.
> (So the odb helper code is at the end of stat_sha1_file() and of
> open_sha1_file() in sha1_file.c.)
> 
> For put_*_object instructions the regular code is called after the odb helpers.
> (So the odb helper code is at the beginning of write_sha1_file() in
> sha1_file.c.)
> 
> And no this order is not configurable, but of course it could be made
> configurable.
> 
>>> + - 'get_direct <sha1>'
>>> +
>>> +This instruction is similar as the other 'get_*' instructions except
>>> +that no object should be sent from the helper to Git. Instead the
>>> +helper should directly write the requested object into a loose object
>>> +file in the ".git/objects" directory.
>>> +
>>> +After the helper has sent the "status=success" packet and the
>>> +following flush packet in process mode, or after it has exited in the
>>> +script mode, Git should lookup again for a loose object file with the
>>> +requested sha1.
>>
>> When will git call get_direct vs one of the other get_* functions?
> 
> It is called just before exiting when git cannot find an object.
> It is not exactly at the same place as other get_* instructions as I
> tried to reuse your code and as it looks like it makes it easier to
> retry the regular code after the odb helper code.
> 
>> Could the
>> functionality of enabling a helper to populate objects into the regular
>> object store be provided by having a ODB helper that returned the object
>> data as requested by get_git_obj or get_raw_obj but also stored it in the
>> regular object store as a loose object (or pack file) for future calls?
> 
> I am not sure I understand what you mean.
> If a helper returns the object data as requested by get_git_obj or
> get_raw_obj, then currently Git will itself store the object locally
> in its regular object store, so it is redundant for the helper to also
> store or try to store the object in the regular object store.
> 

Doesn't this mean that objects will "leak out" into the regular object 
store as they are used?  For example, at checkout, all objects in the 
requested commit would be retrieved from the various object stores and 
if they came from a "large blob" ODB handler, they would get retrieved 
from the ODB handler and then written to the regular object store 
(presumably as a loose object).  From then on, the object would be 
retrieved from the regular object store.

This would seem to defeat the goal of enabling specialized object 
handlers to handle large or other "unusual" objects that git normally 
doesn't deal well with.
