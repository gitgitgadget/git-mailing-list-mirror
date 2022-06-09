Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED85AC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 11:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiFILZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiFILZP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 07:25:15 -0400
Received: from nmsh6.e.nsc.no (nmsh6.e.nsc.no [148.123.160.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990D46C8F
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 04:25:12 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh6.e.nsc.no (smtp.online.no) with ESMTPSA id D7C821D41E1;
        Thu,  9 Jun 2022 13:25:10 +0200 (CEST)
Message-ID: <cd3f62a1-5dee-f482-948f-870fc8e5d441@online.no>
Date:   Thu, 9 Jun 2022 13:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] git-prompt: make colourization consistent
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220604161333.54627-1-joak-pet@online.no>
 <20220604192606.176023-1-joak-pet@online.no>
 <466ec54a-825b-c3e6-e9f2-a7007af71b6d@gmail.com> <xmqq4k0w1mu7.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqq4k0w1mu7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/06/2022 18:04, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> On 6/5/22 02:26, Joakim Petersen wrote:
>>> If the user is in a sparse checkout, the sparsity state indicator
>>> follows a similar pattern to the short upstream state indicator.
>>> However, clearing colour of the colourized indicators changes how the
>>> sparsity state indicator is colourized , as it currently inherits (and
>>> before the change referenced also inherited) the colour of the last
>>> short state indicator before it. Reading the commit message of the
>>> change that introduced the sparsity state indicator, afda36dbf3b
>>> (git-prompt: include sparsity state as well, 2020-06-21), it appears
>>> this colourization also was unintended, so clearing the colour for said
>>> indicator further increases consistency.
>>>
>>
>> colourization? I have never heared that. Did you mean "colorization" (en-US)
>> or "colourisation" (en-UK)? I assumed the former.
> 
> ;-)
> 
> Either way, that word is a mouthful.  Using verb "to color" and
> "coloring" might be easier to read, perhaps?
> 

I went with "colourization" as that is what the process is referred to
in the code, however, I do agree it is a mouthful compared to "colour".
Since I'm already submitting a v8 for other reasons, I'll make this
change in the message as well.

Since the comment about the choice of suffix spelling got picked up,
I'll repeat what I told Bagas off list: "-ize" being American English
is a misconception; most uses of "z" instead of "s" are AE, but the verb
suffix is closer to its origin in Greek with "z", and is preferred by
Oxford for this reason.
