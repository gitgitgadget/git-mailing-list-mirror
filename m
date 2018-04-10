Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57611F424
	for <e@80x24.org>; Tue, 10 Apr 2018 09:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeDJJiQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 05:38:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeDJJiP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 05:38:15 -0400
Received: from arbeitsviech ([141.201.13.56]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MDl1u-1fGKvk3mpy-00H35Y; Tue, 10 Apr 2018 11:38:11 +0200
Date:   Tue, 10 Apr 2018 11:37:49 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180410093749.GA8706@arbeitsviech>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8t9w591b.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:t0KXdYVt3zi2ab62m/kZjV/Dt8F80DxiP2urM/krSbHigFVHE02
 O+i0ob68zgvvHgK4QFlMuVoYbI4+i/hFCsJHRtDXPL3nAPoS6BHj0R+ctg0AqbBSKqhm7Lk
 XqaIsPB2JhVLGiQ+EJ7HMYSJ62hghdx1XCYa4kssmZnER0ngf6su0z9pmYRUnZ546p0Lzm1
 Z7caBehKqhrpfTpmLC+wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FxiJYpSDv/I=:WXx0n5kLT2vF1CjYWkkDIn
 nJLLMjnbZQvWjOQPaBQ+P9BkGCJ3+c/dIPQumWXyiLF3iEBxTOAjLngpdf/QO0yXb3+COWneJ
 /h3x2qLVdNNZO9Bv/ntH4kzR2Uj+f3vbnbyxuHrqsQzF9GCF/u4xE1XnAzur4RYSAGVFhoYKe
 oWp7j8G3mztvMqx0wMyrc+uvEUgueLT1+EgQFZuzKV4mmo2uWXkc45Q6m3E696RPk4bmPF5NX
 xBNwuxJ9b3YZ+FUmtLdWX2whWRFoI7F2V0b5b9YU1p55k0RnSaepMARNjIAuQ2G1VppH0TclE
 fZALYu/ebnTKg8Ls2AgFr/Rk0BjPh1GmaR1h8D/IYqPbc2pSznl9IkD5ogLO8gKK1oL9/IoP3
 QC30H47ZGhLsJg9ABoV/Pd309kazRF3ibkpfgzXq2P4wqJtgW3X6nJ+9mENzWdpAmZDgWP4Cz
 AxZ+BMwOh2v7fjaYCGeJDv08HkpX1zOZrmP2gWIGDgP40IurD70tSKrvWqJS9bO9Cmy00pGKJ
 MTfHk8ijoRigFxTxDC0lad7R81XsoBX0rENwE3ps4jR7KN6wWs3OIKQNzaK2Uc8ObsqUOccwP
 TgWRi6XMb1RRkFM7+kr51+eGia3ZW9hpQ0y9yriDG9UoNTYE9wk6Oiki7YjIz8jZeAaSdevLu
 tn6qgx1pb3PaWrsfhKk+djdk5W0x5oNFOHYpgWfL+vfsW/uvx37qSwYh7MiE2wwsIEp1xfQFr
 KFjwgYNNBmI7CAJDe9ZAMlRXrgRI7RxngibZrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-10 07:06, Junio C Hamano wrote:
> Florian Gamböck <mail@floga.de> writes:
>> Does my reasoning make sense?
>
> Not at all.

:-( That actually hurt a bit.

> But ...
>
>> I mean, the result will be exactly the same, we are clearly only 
>> talking about readability here.
>
> ... I agree, and I also think the "readability" is not absolute 
> anyway.
>
> FWIW, personally I'd find "if $completion_func does not yet exist and 
> a way to dynload stuff exists, then use that way to load it from an 
> external file" the most natural way to express what you are doing.

Then let's go with that. Maybe I am overthinking things here and 
re-wording doesn't hurt.

I'll send a new patch version later this day, including the commit 
message re-wording suggestion from Stefan.

Thank you for your feedback!

-- 
Regards

Florian
