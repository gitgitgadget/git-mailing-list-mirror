Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91EA1F609
	for <e@80x24.org>; Fri, 24 May 2019 23:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbfEXXJG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 19:09:06 -0400
Received: from avasout01.plus.net ([84.93.230.227]:37435 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfEXXJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 19:09:06 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id UJJ5hpm51mVenUJJ6hAdec; Sat, 25 May 2019 00:09:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1558739345; bh=FopSffgoBH/QjGBtIHqK70SLF35/cSHPnZ1ewMRFmIo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bYJrWbgelG5abzxb+nZMGYm84pwvKfaK1w4HnMKYGuDTpZX56y3CaFzAMg83qjQk/
         VyunYKHeUO1npzExxNhr0TEIYblRltus7b0/E4muPwdRn4f1sXPrD+exu9CMKoGgAy
         cts3RiMEc96IFkaettwNpXM2hxUCDzNemQh2fCUiqYN6z2h/zxlmfnljgtdphvzR9i
         HmjwNVB3t0JmKPvfnzNhKwZycay6FEhGiAw1P3UhTdlPP1PS0ju4sZKOtvP/oGLNjU
         LM8fq942klRS63RussJoJ/47XqCTdf50UQl64jj7EveBM89qke9R3hdWLmqPEDtaQ5
         dwF0lgYp7CwoQ==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=I5Ubu+og c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=lOG31t4wB7GyIkdNFlYA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 00/52] fix some -Wmissing-field-initializer warnings
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <cf0b720e-ad29-79e7-17d5-b69d50e7007e@ramsayjones.plus.com>
 <87a7fbfptk.fsf@evledraar.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <fa9f98b0-5f8f-1d0e-9a87-70fed69520c1@ramsayjones.plus.com>
Date:   Sat, 25 May 2019 00:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87a7fbfptk.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBw2t8PTerz8+bS+ecs9I0l9yus5ZGaKgi3MyqamRfT5g6bbZpZigPEdkgAKfjjtHFTcEqbvo359LTCmxe6Pz9RX5HaJ10n6NG2+pMmZdlhN1O1JjfJ/
 clKoPK0p6SfqrcP9JpEfxzvdWqW/99NRZegUl0KUSucWx8WO0sdZnTVs9r0bw6UirnvcAC2BnaHEEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/05/2019 23:30, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, May 24 2019, Ramsay Jones wrote:
> 
>> [No, I won't be sending 52 patches to the list!]
>> [...]
>> This series does not fix any problems or add any new features, so it
>> is not important (hence the tendency to 'slip'). I don't want to
>> flood the mailing list with patches that nobody wants, so: is there
>> any interest in these kinds of patches? If not, I will stop now!
>> (I have a 2-3 year old branch that addressed the '-Wsign-compare'
>> warnings, but that is probably beyond salvaging by now :( ).
>>
>> This series is available from: git://repo.or.cz/git/raj.git with the
>> branch name 'warn-master'. A trial merge to current 'next' and 'pu'
>> branches can be found at 'warn-next' and 'warn-pu' branches. (The
>> merge to 'next' went without problem, and 'pu' only required a fixup
>> to the builtin/commit patch).
>> [...]
>> What do you think?
> 
> I think just send it to the list. We've seen worse, and it's easier to
> review than needing to get out of the normal E-Mail workflow.

I forgot to mention that this series has a long tail. The first
ten patches (in addition to all pedantic warnings) removes 1246
warnings. The next 10 removes another 70 and the final 32 patches
only removes 55 warnings (the last 18 patches remove only one
warning each).

Hmm, so maybe I should only send the first few out? 

I will give it some thought (while waiting for some more comments).

Thanks.

ATB,
Ramsay Jones


