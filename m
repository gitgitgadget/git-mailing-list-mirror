Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D43201F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 21:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbcI1VKF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 17:10:05 -0400
Received: from avasout02.plus.net ([212.159.14.17]:40751 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbcI1VKD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 17:10:03 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id p99z1t0060zhorE019A0Un; Wed, 28 Sep 2016 22:10:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=N659UExz7-8A:10 a=cCri8_SAAAAA:8 a=GwUem0DFAAAA:8 a=w7IfRzkso0XrNWMlF_0A:9
 a=pILNOxqGKmIA:10 a=WZACsi0_zXwA:10 a=4_ic8YOe6kIA:10
 a=sbRuPzbSW-bVi6QwGVni:22 a=r0dl5i_q2XGqDZkti5dn:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] gpg-interface: use more status letters
To:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
 <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
 <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Alex <agrambot@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <24ecc903-3e5a-47f6-f073-00a1c709d5e8@ramsayjones.plus.com>
Date:   Wed, 28 Sep 2016 22:09:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/09/16 20:59, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
 
>> +  "X" for a good expired signature, or good signature made by an expired key,
> 
> As an attempt to clarify that we cover both EXPSIG and EXPKEYSIG
> cases, I think this is good enough.  I may have phrased the former
> slightly differently, though: "a good signature that has expired".
> 
> I have no strong opinion if we want to stress that we cover both
> cases, though, which is I think what Ramsay's comment was about.

Kinda! ;-)

I'm not sure that it is a good idea to mash both EXPSIG and EXPKEYSIG
into one status letter, but I was also fishing for some information
about EXPSIG. I was only vaguely aware that a signature could expire
_independently_ of the key used to do the signing. Also, according to
https://www.gnupg.org/documentation/manuals/gnupg/Automated-signature-checking.html
for the EXPSIG case 'Note, that this case is currently not implemented.'

Hmm, I guess these are so closely related that a single status letter
is OK, but I think I would prefer your phrasing; namely:

 "X" for a good signature that has expired, or a good signature made with an expired key,

[Although that is still a bit cumbersome.]

ATB,
Ramsay Jones


