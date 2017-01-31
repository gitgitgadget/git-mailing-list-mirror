Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63861F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdAaVD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 16:03:29 -0500
Received: from mout.web.de ([212.227.15.4]:50720 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdAaVDN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 16:03:13 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lkm1c-1c0RDw3Ws8-00aRCu; Tue, 31
 Jan 2017 22:03:04 +0100
Subject: Re: [PATCH 3/5] use SWAP macro
To:     Junio C Hamano <gitster@pobox.com>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <187c2b39-40cf-7e07-b489-d40cdf5f9145@web.de>
 <xmqqr33ktch9.fsf@gitster.mtv.corp.google.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <47dca1ce-14db-cba0-bbe0-9873fc0000b5@web.de>
Date:   Tue, 31 Jan 2017 22:02:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqr33ktch9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3NNSdbrUAZclEq93xvHyOoaRmyABTClZc79wlPAQhTa/DSapruM
 OUyceh6kLjzfmlarQgQvHOModWFk5ANOcHDOoM9ym7hKAQeFmH4YiMS/xz1Gk9aNa5fYw5f
 /eo88+oB0yUSQzAcHEvLR4JkNWtBalJ0IWmw6g+rYptrd6KrOpc59qYvz1DQGluajqoDBez
 PKqS5A/ogjpKr6QFvQoMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u2BBnAd7h3U=:aaTlX+fA++8psg5GqR165k
 l8m8D2FooOgCPIoFKSkhT/FhhIyhJQDeKi6eWPeqX6Q+1G3YDQzoA8wBtQmy8q/1uqgwqCJiF
 IBnMr4ZW+5KvsfU63RY72mHKZzbAU04UHA3sDAdsM9b0uSVUsrrqOsNVyhl9nkzW3MtLeCs01
 REfBARH3hRQbaavkmGsHpMVhWG/+Y8Os9EBnBLWcb3wnBQpjVKKZGO02shZHTt1LSVSiqGnDM
 hX5CXRpmcPgP2ZGw1spynrvkebZFw2vZAdN3T+/Fk9MrFVEtk/RWCbk3ZFQ8obHwAzRNROwL+
 qnIokv4dDfan4oJgT+y4twNY9G/3PhtvdClf6wMi/Qh02I14dnqhzs3cBV7LhkrmANXgeMA4S
 CEtTOV+kVDsqqP9RtepuBoA6BwQ9PQ7rclId50xmvoeLV0WGfVJNZ8twW9GoX+Hve66DV1sTp
 QWB8MKtzFNx9EiB2CzN5ODmgSf3WrLYo28JnIYEz/DpCCNz6cCOoNXuNIehtu8bNH8BgmmCQ/
 otPAzCa1prlWpyObc7DDwRpnfvAUEaQsX5u61N3us3nuUnGr4ZCucMh0+/jYO2UFNqgEvpyp/
 phR3OaYCo1/O9x8QKKREv/K0zNoNcFzNb8HHkc/XNPd73eFhoOqw0k0HLcjDD3GstBhwy8IF+
 TiCK5lfhNpgnfm2x0/LE555jMNc6nYW/OFCyKdriSgTj614lPml3iy79ofAKXiKHT+R1WQwao
 +KWK6KSzspFCkdQAaPlQ3aYG5hz04StOiEBnx4p++BSM0v9cV5/2IcpPE+dqhrYHnWdpEFdTi
 j9SG0es
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 23:22 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
>
>>  		if (tree2->flags & UNINTERESTING) {
>> -			struct object *tmp = tree2;
>> -			tree2 = tree1;
>> -			tree1 = tmp;
>> +			SWAP(tree2, tree1);
>
> A human would have written this SWAP(tree1, tree2).
>
> Not that I think such a manual fix-up should be made in _this_
> patch, which may end up mixing mechanical conversion (which we may
> want to keep reproducible) and hand tweaks.  But this swapped swap
> reads somewhat silly.

Well, a human wrote "tmp = tree2" -- sometimes one likes to count down 
instead of up, I guess.

We can make Coccinelle order the parameters alphabetically, but I don't 
know how to do so without duplicating most of the semantic patch.  And 
thats would result in e.g. SWAP(new_tree, old_tree), which might be odd 
as well.

I'd just leave them in whatever order they were, but that's probably 
because I'm lazy.

René
