Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A348A1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030362AbeFSR4I (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:56:08 -0400
Received: from mout.web.de ([217.72.192.78]:38055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030228AbeFSR4H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:56:07 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MaJro-1fkfln2Nvk-00JveC; Tue, 19
 Jun 2018 19:50:55 +0200
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, avarab@gmail.com,
        gitster@pobox.com
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
 <20180619174452.GA47272@syl.attlocal.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <838caafd-9172-3320-7d4c-b8e53eb3ea01@web.de>
Date:   Tue, 19 Jun 2018 19:50:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619174452.GA47272@syl.attlocal.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nw4FWEAIGcKLKaE+tDq356qSEXXIsNBYagUqDSG/N4OTzXNF5XN
 HUo7AyDWfE3AjOiRKcjM5U/JNFxN5qNE3Ue03gW1JzvZKatpAnx43jiHxfdjhG3BXGJaDNw
 zHm68DiPJASfXrvXay/FVN1uVJUL6KwvdnTnJX5s9FM70hKigldd8rhFJ4wLZ3YZ7oB3WAA
 BsQCR/OOe00edwyaMudkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VC9cGmFfp0U=:pkhtEmP6fJQX7tza/TP2x3
 8H4dP7WSCbRcErwz9rwztnYwaUtzGdwHO6P9vBJ4RLAdJ+duKAQCT5/Yrfxnbm7h75NbXGnXb
 nWpict2CqnV/NGxG6/Vjs68t+Fq9dAszhF2ULsy1eNFqQDlHNWKZAYD7YCrSZRfzdN+izzKoR
 e53gXkk9kw49euUlWPE7Qe1E7u3UkKvZjQxfxSzk1MfQ7M214x0UoFOJm7W3Gdelzog/Iub6P
 53DDssTrvVC9QlBWqKvArLUjtAeKCyMxXhN1zlKVBy975RTi3LHn4uWuaRkDipJkoLmfD9AYp
 IQD2siFByDYImkmb2OlIWQcrR0cu1FekNPDPGsTEuK1An3Sl+9HG18Hxb9WyFvJBMIzaOBTSe
 9Ff82rORUkpa24HzmhW+lpbF8oQbI4MqEZ4As8E3FblNrcrN+8W3xKd+mmQnTMWukG+RcAOD7
 /zgMdWky4cJGSn5NwAhMq5EFiz8PS+7ygbNjeWRKDSsOPzHhqxq/E8rvxO0YUK/12TjBFC/XW
 1V0VlSAxRbVaHu9cFhms3vcwHtolHnz5vhdVf+jua+sk0TAWpxlxXsD9urzDjfblnx+uGmGba
 skGodwRPso1nR4ZM14Gr6d2+GkipdCmABXB3+x2wMWcrQyOwBVKzpnPiDk9EJOTt4YBUG6jy3
 QYPs8/ucHv4LF9UK9r5qpsCSyIptAWMKvH/BA9//W4JcPui1ZHFVucH5NFHuGhToHhmIRTKcQ
 Ti9V/Zweb//q828S2Ovbw6FFmUSZzpdmwPTmUXtRaXo4FUsYSeMMxmYllPS4tgDQ8bk9ZYRFe
 ypHZ/Ke
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.2018 um 19:44 schrieb Taylor Blau:
> On Tue, Jun 19, 2018 at 07:33:39PM +0200, René Scharfe wrote:
>> Am 19.06.2018 um 18:35 schrieb Jeff King:
>>> On Mon, Jun 18, 2018 at 06:43:01PM -0500, Taylor Blau wrote:
>> We could add an optimizer pass to reduce the number of regular
>> expressions in certain cases if that is really too slow.  E.g. this:
>>
>> 	$ git grep -e b -e a
>>
>> ... is equivalent to:
>>
>> 	$ git grep -e '\(b\)\|\(a\)'
>>
>> In that example the optimizer should use a single kwset instead of a
>> regex, but you get the idea, namely to leave the short-circuiting to the
>> regex engine or kwset, which probably do a good job of it.
> 
> I think that--while this pushes that decision to the appropriate level
> of indirection--that it is out of scope for this series, and that the
> above patch should do a sufficient job at not surprising users.

Definitely.  I'm not even convinced that performance problem is real --
otherwise someone would have added such an optimization already, right?
:)

René
