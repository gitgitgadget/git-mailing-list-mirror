Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A70C20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdJAV3b (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 17:29:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:60940 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbdJAV3a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 17:29:30 -0400
Received: from [192.168.178.43] ([92.76.241.219]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpKrt-1dM7Bw152D-00f71G; Sun, 01
 Oct 2017 23:29:25 +0200
Subject: Re: [PATCH v2] Add a comment to .clang-format about the meaning of
 the file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
 <20171001154425.5568-1-s-beyer@gmx.net>
 <xmqq3772vce4.fsf@gitster.mtv.corp.google.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <5b7dabe3-fbc4-40fe-9d51-2c68c292f11d@gmx.net>
Date:   Sun, 1 Oct 2017 23:29:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq3772vce4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:XOjb1FrHh6O3XS7ZZhbnIhQuju1pzfn/UOVtKONDMpLr+Z6Wl05
 PBW5/qeNAo0xSETO88VJjHguXnNSWzlIOwRPDWcCrhIkPAvA3SL34ckWBbFllUMnzta7dbP
 1olqkR+FElzlzI6ykso7zw5u6XpY96CutM6FDdeb7jTgdntw4Rf4c7XsiLhuJ650ZqPLuoN
 nyXnmwj9EbX4C5kjGQpMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b/Cx0inTVxo=:G7zZoYWBnaEjmBe2db8OuC
 GxrpBoq0k+FvP4ZD1/SI0PHoet4CEyW1mZ0dWYLCX7Si+HEo63rBg3kb+/OD9D5as8noBLFU1
 pP/Pj4IJZ6m53khnwk4ra7zuvqQ/vkP1CK1aKCeJpqTxbJS+kdXu1VY0f5exzmIiChSTrAplD
 GNJVeSNx3xg0vvWSUVtgWVS1dInG98s4RXh8U3f5bSyNnO/pxsiJpkTLqbum7HHZu2VZt4Loh
 pjVU4YRnJ64BmstviLcx5QSJL6AszgHwJ845Myqbrqsr86MgemtH1fYE9BBkdPB6lJ50hZdsA
 BH3/mA53phben1hvqYFTaeOren7beK5iUnS7L3XnnoxZyo8050ZHcsSuIvbvg3Ux3Gx07uz7m
 GAB5VNhCtG4/rNkE2MjWqSlZ2vSr2Jud0/quMu0T2QvhdkkPNEx6y5rSxtmmpR+YXtKSxiWKN
 L7BWngkHRahnx1QN1zny4XM6vygm3Ruuvhkn1+DH0TSOE7TO44zmBrJg56eq36MOw1nY2b+38
 uPZ3znsTsoXwfvrTJawhUSs8RAyLgCk+e+gJuPPdH7el0K3wduVKtQAOdJbBLcnTvz5rv6eTC
 npxcwbsRSNAJb7GgKvUKjG/PPPNfpslZrLdmMsC7q+noAkCeydPOFduBp5vSUHgQEnc6RZ4A/
 2M3I2BmvHuj7Pe9QXxN6VTsZTuIBKOC9Hp6kpny6N1fXTpflPJHJWgYsaHAWegFCgFnFfh8N1
 soKppM7asoUvJrw9gLQxwgePjEuU3bV5DA0orDEWVggsnParrEHALt4+bUTMAi/7JPBG+Zdkk
 37954NaKCgKOskIoi+YtdAj9W8nV76Lx+KkmnJfqGwXGOER/zk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/01/2017 10:30 PM, Junio C Hamano wrote:
> I think we do want the endgame to be that .clang-format defines how
> the code should look like.  It's that we are not there yet, and I
> think that is what we should say in this comment.
> 
> 	Note that this style definition does not yet quite reflect
> 	how we want our code to look like, and adjusting the rules
> 	to match our style is still work in progress.  Do not
> 	blindly adjust the style of _existing_ code, without
> 	checking if the code is styled incorrectly, or the style
> 	definition in this file is still wrong.
> 
> is what I should have suggested when writing my response.
Pretty long but okay. I tried to be shorter and more implicit (also
because the CodingGuidelines are already pretty verbose on not changing
existing code style) and you're heading in the direction that there will
be some clang-format definition that matches the desired coding style (I
doubt that at least for the current clang-format versions, but that's
another topic).

Erm, so you're going to replace the comment? Or is it my task now to
make a v3 patch with your text? (The latter doesn't look useful to me...)

Stephan
