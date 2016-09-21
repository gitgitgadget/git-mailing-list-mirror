Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759D11F935
	for <e@80x24.org>; Wed, 21 Sep 2016 19:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934727AbcIUTN0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 15:13:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34835 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932771AbcIUTNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 15:13:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id 133so10260444wmq.2
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QePSOi6EbolHrkc/bWBnbI82FqvhMQ3um1lko+lX8DU=;
        b=seDGopIKj+bBwZVdXRES0QA8l9WlLRDM83EVywlFSt4uR8kAFDyJudb5JydIMSuPcV
         gLcpttsqtYCTmo0mKyeQH6ZoV54exd34izYc1A1kJj0B5qbdoDDGkZb4lN9BjF0lfueV
         9G44aafCmB76+SW5FMtL14Pdu5U4b27B8Sv+/XeW4sqZVcLupAkZebUNiEBhUQmKIwOi
         w6frE7VKUAyjkXMJcaXpiA2SA2kHx35YhaJgZW1u+w7OG+OWOjfCVhDSDfSE0zUR1Y9u
         Bv3URIcnqWAkD59KFPDQDQYFXYMMaqNBRFQN4NMLtFUYzD8JwLM7OHjbpp7k5PEVIOO4
         8KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QePSOi6EbolHrkc/bWBnbI82FqvhMQ3um1lko+lX8DU=;
        b=S+ZIY5CqcUczDXvJGIl/jejf7ps9We+Q9PNBh+ta+6c+psRgY+LXTQf1zs8ZuBujNE
         iH1sStOhMQVzrEgLXXe0086s1fRaKxQOjlVNmFAVY5K/Y7u4I5aigcBJfjTFL/QUUKgC
         dwuSTspk3Fa7C1WiarW1o7ChWh0YEFbh+cRAB3pbMPtnIufjUyMdklzINWB14pGBwNCW
         HZ0VUQ7e7jLdVSFs7rpjwtIrh6vCz6WjkIVe7UkekU8qWSrbZ0r24qi4SSCd8pRPBb2y
         dQ4cM0XZn0vfJvvifB7wTU2gfunrTkReFuIujCdMdUvsmzFy/uxSaI7MsHq/9TT7DevV
         YVJQ==
X-Gm-Message-State: AE9vXwP/7h0NnzVSdBnGiEOwMzP1a3d67AmE7bjCwyFpEkpCrniUKP7Qk4gispDQ4MbDgw==
X-Received: by 10.194.238.170 with SMTP id vl10mr36705854wjc.18.1474485204007;
        Wed, 21 Sep 2016 12:13:24 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id uw3sm35017856wjb.21.2016.09.21.12.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 12:13:22 -0700 (PDT)
Subject: Re: [PATCH 3/3] gitweb: Link to "git describe"'d commits in log
 messages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com>
 <20160921114428.28664-3-avarab@gmail.com>
 <fadd75f3-3737-1eaf-30f3-46a2ef132b27@gmail.com>
 <CACBZZX5QF7FztmU-mqOEx40kC-PpQ9SqcL8+3HtuntcRZ1tWzA@mail.gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f6cceb0a-9224-70ef-4592-ce34fe8704fd@gmail.com>
Date:   Wed, 21 Sep 2016 21:13:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX5QF7FztmU-mqOEx40kC-PpQ9SqcL8+3HtuntcRZ1tWzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 19:58, Ævar Arnfjörð Bjarmason pisze:
> On Wed, Sep 21, 2016 at 7:09 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 21.09.2016 o 13:44, Ævar Arnfjörð Bjarmason napisał:

>>> +            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
>>> +            [A-Za-z0-9.-]+
>>> +            (?!\.) # refs can't end with ".", see check_refname_format()
>>
>> If we can assume that tag name is at least two characters (instead of
>> at least one character), we could get rid of those extended regexp
>> lookaround assertions:
>>
>>   (?<!pattern) - zero-width negative lookbehind assertion
>>   (?!pattern)  - zero-width negative lookahead  assertion
>>
>> That is:
>>
>>   +            [A-Za-z0-9.]   # see strbuf_check_tag_ref(). Tags can't start with -
>>   +            [A-Za-z0-9.-]*
>>   +            [A-Za-z0-9-]   # refs can't end with ".", see check_refname_format()
> 
> Why get rid of them? I'm all for improving the regex, there's bound to
> be lots of bugs in it, but since it's perl we can freely use its
> extended features.

Ah, all right. I was wondering how zero width assertions / patterns
interact with each other, but zero-width negative lookaround assertions
are really quite simple.

> 
>> Also, the canonical documentation for what is allowed in refnames
>> is git-check-ref-format(1)... though it does not look like it includes
>> "tags cannot start with '-'".
> 
> Yeah, looks like that manpage needs to be patched.

Right.

> 
>> Anyway, perhaps 'is it valid refname' could be passed to a subroutine,
>> or a named regexp (which might be more involved, like disallowing two
>> consecutive dots, e.g. "(?!.*\.{2})" at beginning).

I wonder if rules for valid tag name can be described in extended
regexp, and if it is, how readable would it be.

Regards,
-- 
Jakub Narębski

