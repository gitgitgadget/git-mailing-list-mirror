Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9882036B
	for <e@80x24.org>; Thu,  5 Oct 2017 11:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdJEL7G (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 07:59:06 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:23578 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbdJEL7G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 07:59:06 -0400
Received: from [172.27.0.114] (unknown [92.154.11.170])
        (Authenticated sender: slash.tmp)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 0ADCA5FFAF;
        Thu,  5 Oct 2017 13:58:58 +0200 (CEST)
Subject: Re: Quoted-printable support in git am
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
References: <165c9648-e7f0-66de-b3b9-023c48c49d95@free.fr>
 <20171005093052.3uefgby6a57udoqy@sigill.intra.peff.net>
 <CAPc5daX+N_Z6v-NxOb5cHh1V3Ctu7uQ+QFHzN9ATTQ22pVAfQw@mail.gmail.com>
From:   Mason <slash.tmp@free.fr>
Message-ID: <683bd77f-ecf2-33e9-8f45-24545a2785eb@free.fr>
Date:   Thu, 5 Oct 2017 13:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.1
MIME-Version: 1.0
In-Reply-To: <CAPc5daX+N_Z6v-NxOb5cHh1V3Ctu7uQ+QFHzN9ATTQ22pVAfQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10/2017 11:43, Junio C Hamano wrote:

> On Thu, Oct 5, 2017 at 6:30 PM, Jeff King wrote:
> 
>> Mason wrote:
>>
>>> The patch header contains:
>>>
>>> Content-Type: text/plain; charset=UTF-8; format=flowed
>>> Content-Transfer-Encoding: quoted-printable
>>
>> That looks right. Though I wouldn't be surprised if whatever generated
>> the "flowed" also screwed up patch whitespace.
>> ...
>> If it does have the qp bits decoded, then I'd suspect that maybe there's
>> whitespace damage caused by the MUA.
> 
> I would be surprised if MUA that says format=flawed did _not_ mangle the patch.

format=flawed  :-) Did you write that on purpose?

Anyway, it turns out that I had somehow managed to generate an invalid patch
(with a spurious leading space in the 3+3 context lines); the quoted-printable
mangling was, in fact, a red-herring. Doh!

Sorry for the noise.
