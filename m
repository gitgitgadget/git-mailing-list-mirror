Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1C81FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 17:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdA3Rge (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 12:36:34 -0500
Received: from mout.web.de ([217.72.192.78]:57938 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbdA3Rgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 12:36:33 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPpQU-1cc5M71jE2-0053gM; Mon, 30
 Jan 2017 18:18:37 +0100
Subject: Re: [PATCH 3/5] use SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <187c2b39-40cf-7e07-b489-d40cdf5f9145@web.de>
 <alpine.DEB.2.20.1701301702120.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <65b00711-bea1-a4e6-290b-1975319911c4@web.de>
Date:   Mon, 30 Jan 2017 18:18:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701301702120.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:mg7yPlObrQMSmyWZA23EMIlhQTE7SY+QieWMPC5e18mB5wjgHDD
 b/uZ99vY3XfX0g3nkULTcjPB7Txb7Yi8lLY8TPo3H2DxgCdLGcA96Zv9B/hkuw+fUTif1Fb
 Ydle3iwtw1ECRF3mI2mIveaHidQ01oxpcTLJNE+8FwcoaMHDC77gG/I/zQ98FjP+53qLnur
 XBuNfw+3LKLdsf23G8BoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XDtjvnvytOE=:3yJarkqbgcYU68HWxDkZx1
 tSFZZQ0znWk3zwCDvNqXgBfJtLQ0cKNG2K6RR+Of8z9PBuw3MV0F89R0sYjc1umaMyu2tJkbf
 nKrTcsPw7lLk3wZI1MLYyAOdgMm9TXHkA+6ckjAS1LuqD5pD+p9+AU74AhhplYlDlpwEb9oM2
 gFmpXGPwa1OU1+78ZWQLYi4t0tHeksEaG7PrcCZMoT4oaRy7YpILTucjmlmK8n3NDX9DhjHji
 Di0Y7cNVhtFOi6mHi+/TA01JE7Ex6uZJ3J7KIDWa1y0JN+GwjwTgCgIfCPj5gc4Om5wX6WKdM
 8gET2b4gIBdkLwPYJ1cYGz48ijJncLOJT4ERAl4H9/AmyMTVVzTbd153H1M1Xc+JMEBr3CBEK
 Cp/w2WYYiMjHiFijltwBQvkfkcO4y9kYDlVwYkVUsQKhyESYsTDJ4a9w3UUJvELNXyeLPJ0cp
 1zRk2GLaEUgpeGdp2C67+JhH/Sy3Pgs8XTOvsheRRyf429cXHtTenO4eCHjRvq9Yfn/t6z39O
 HceMeEkhn/ddvaJ2z93GcH8Syxcmiu6dg7sLXjcAjBY+3Tz0OIt19pUE0Ue6UYKwkJ+CmzvTo
 ipI+Hf67p0PW09NX/4u1lSa3f4+xu5Dgj00OvM2/04yXhcnV/tlgcchhiQsPCEWWgeTkxBH9h
 gs7FSB3BrV44THCQv33pdLZxsHri5GRNKj1jBCgKHdViLodmqSV0dB6rkq1kyImSPgJFXjeYH
 q6qG9jLh/ftjmPxnFNO4gC/ca0AV26gxe8TfEMr0KGba7bogIQ6/53BcvijhBYuGeAYMWNPZQ
 m6jcwXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 17:03 schrieb Johannes Schindelin:
> Hi René,
>
> On Sat, 28 Jan 2017, René Scharfe wrote:
>
>> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
>> index 806dd7a885..8ce00480cd 100644
>> --- a/builtin/diff-tree.c
>> +++ b/builtin/diff-tree.c
>> @@ -147,9 +147,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>>  		tree1 = opt->pending.objects[0].item;
>>  		tree2 = opt->pending.objects[1].item;
>>  		if (tree2->flags & UNINTERESTING) {
>> -			struct object *tmp = tree2;
>> -			tree2 = tree1;
>> -			tree1 = tmp;
>> +			SWAP(tree2, tree1);
>>  		}
>
> Is there a way to transform away the curly braces for blocks that become
> single-line blocks, too?

Interesting question.  I guess this can be done by using a Python script 
(see contrib/coccinelle/strbuf.cocci for an example).  I'll leave this 
as homework for readers interested in Coccinelle, at least for a while. :)

René
