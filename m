Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1B21F404
	for <e@80x24.org>; Sat, 21 Apr 2018 05:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbeDUFh0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 01:37:26 -0400
Received: from mout.web.de ([212.227.15.4]:51859 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbeDUFh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 01:37:26 -0400
Received: from [192.168.178.36] ([91.20.52.220]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LeLmv-1ee2LS3DuH-00qEVE; Sat, 21
 Apr 2018 07:36:39 +0200
Subject: Re: [PATCH 5/6] builtin/grep.c: show column numbers via
 --column-number
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <cover.1524281843.git.me@ttaylorr.com>
 <20180421034540.GF24606@syl.local>
 <xmqq8t9hb3sm.fsf@gitster-ct.c.googlers.com>
 <xmqq4lk5b3ht.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cef29224-718f-21e9-0242-8bcd8e9c20a6@web.de>
Date:   Sat, 21 Apr 2018 07:36:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lk5b3ht.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wvFWhWhASFZGGgezmTbBrzTAglxQ9w/KEiHgBs7NjQTNCWepaAs
 Kekn/Eg9/FioVOiikc53bMTwPRxYSbAe+9gB2f9gKRd5c0rOox+7Sl5vcvfuqqjHctzjxjS
 3MhW6DH7NPnERfkVQiAiBvll4MJo97SaytcajJtm6lq/JdAxxypYKRV19j8vjloey93uEhg
 v5/qL2igsVCdxADwJkFXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zbmb+tm4ipg=:R2cbE9NNi14k4o0bdBnOSf
 NcKjkNwib76VaMCJcmns0l/K9IAu83xPQ1VKtkb6HmEuqh+g3H9siwpVrdW3K7dbRiUo1Xszg
 O1usNLCyiv7ojQl34+ZvhP7TlVkQI4jswkmnwDOa7tA2Towbh0X7mWmCrmri7pENOnnijYpPi
 Syh6h181TLFfdqO3ZHuPaF33KbEwAlsxCFWnjimhvmd52BEdrrH+JzTjydY4QPbLbqqg7PzfR
 8FL+U3WXxuff3g+CyltRjDnID8v1N793IG+nxZHlQpimX4S/b22MMMsrcITzwhEz8HhIw652B
 zpb04oF5LOq7x+oG4UNdx6gfDXMO+9WTRV6I0pBSr7wol1zlkiqPlMr34bd/IUKZOcmegfsQN
 xls7Zn43VppyAhGemLcZLQa+DBujYrKCUn17T2y4f8X75yt5oVnabchyzRggqqEzQKke66iVn
 VEB+5YCL2rn5+qB7n97qtiuna368XHK6ayhUubin6drjdDiDYGxqWvk4IAl2v+Z2L89PW3tnw
 fc1MoUSctLJPa1QDxCaO6GF3jj8YMTAUEUKtgcV9Kpo52U8eOu6VyfMkiWd18ofxYguvvUoxy
 H2qftStD6kGj49hOVn1C9tGT1IqPleOJbOwJSGzu5CwEJMz9X3AYDUD1/eUOnSamD8q9JYMec
 0xY3pyeiT9PoLOh5oojcEijmC3TweEMAcOhbiTp0Bxp0NYsVomkIChGdsg3nXR8xfQ8v4m93r
 1RowsMnGZG3QRFXbnyTXXHJIqbhDvJtICrslfxCQM5jizinTREQx5T/RMuFitQfqz9HqV6k4c
 CSj/RDTSAUG5PnF+lXp/clHMNWI06XtZlnx9h+0+RH8Z7cLjKk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.04.2018 um 06:14 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>>> This commit teaches 'git-grep(1)' a new option, '--column-number'. This
>>> ...
>>> +`columnnumber`;;
>>> +	column number prefix (when using `-m`)
>>
>> Is there other people's tool (preferrably some variant of "grep")
>> that has an option to tell it to show the column number of the hit?
>> What is the option called there?  Does that tool let the option
>> squat on short-and-sweet '-m'?
>>
>> Thanks.
> 
> I still do not know if we have a good existing model system to take
> the longer optoin name from, but at least, GNU grep seems to use -m
> to mean a completely different thing, so I'd think that we would not
> assign '-m' to this new feature.

https://beyondgrep.com/feature-comparison/ is a good resource for such
considerations.

ack and ripgrep use --column and no short option.  If git grep got
--column-number, then users could abbreviate it to --column (until it
gets some other option that makes it ambiguous).

-m seems to be used for --max-count across the board ("Stop searching
in each file after NUM matches") .

René
