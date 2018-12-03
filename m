Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68BFA211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 19:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLCTLQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 14:11:16 -0500
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:56224 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbeLCTLP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Dec 2018 14:11:15 -0500
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-06v.sys.comcast.net with ESMTP
        id TnNCgI2hS9BOrTtcfgrmWE; Mon, 03 Dec 2018 19:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1543864273;
        bh=7+1oXZgpy1xeZHXBswaW9lxrhc+11oIpVOcAkj4SMXc=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=XtcFNJJXYUL2ulrnlHLxRdlinp6C7YXCeZz2tHQvIApebK8Y4nY19O0ZbASdWcOLO
         LWrAuod1QUfdA1NsvI9Y4SW750cO6SrW6znX/eCyhqexcf96EIYGwzEB+56XCBcPax
         FNqaEP4mfE36RyD2k5E00PxIx+NXods6b7ggnUch8k5KP6FP82FDmwc0wi/pUf5ADe
         4LfbiwphLyondyHzyA876uh8xk3TncFCHDKUK9J5TnvuDkx1hATx43dgftHjehlWfE
         Ye5x/ACtEq9M5AA6Uy5muSBDY91pZfHn2aGiGEBIfCVVKQQJQHhERzVZL080iSeSvN
         E9OGKBvk4VILw==
Received: from maqtu.svl.corp.google.com ([IPv6:2620:0:100e:913:aa8d:64ee:3bb6:179])
        by resomta-ch2-17v.sys.comcast.net with ESMTPSA
        id TtcHgcxNCse8jTtcMg7SVV; Mon, 03 Dec 2018 19:11:11 +0000
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is
 allowed
To:     Jeff King <peff@peff.net>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com
References: <cover.1540256910.git.matvore@google.com>
 <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
 <20181121164019.GA24621@sigill.intra.peff.net>
 <19c82fb0-e0d6-0b15-06ab-cfba4d699d94@comcast.net>
 <20181201194424.GB28918@sigill.intra.peff.net>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <80a08b99-14cb-e398-e6c2-2aa94a5fdda3@comcast.net>
Date:   Mon, 3 Dec 2018 11:10:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181201194424.GB28918@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOUonDHJN/wKQ9ebAMgeVsRkae7WMUWkB+GMTVRJNbe3qWYH7Y9lszoF96qSImc8be4fuo1POqBTNHMm3C5o0AsiwslW25i7H/tf1N3Ko3uhQrskVP1Y
 0YNhFaZXC1W24CxC48xulF2il96tKeIQNurLoRN1khp5o742VJNeDX7pfu09/1erG5BxoLBkfqoE5bxxdA7kwGU6rfRHCTL+SN3EoawCL33nNzz2kIV7azY7
 2gukPjKhZ5WB0wg60W0utYdK/ZPPqGr4FDe7HjiYmeWiLzfi4GWF1qfKF/gx//fCvRV88UyIE4fdl/+mHmtPhqbddTeOH+DDvGseXVHp787AbSd0BeWtmls1
 tSy65Mnr6uQq4PvdtnMZYTJb1X/1W6GwU12h8cRcOeCyc0cE7C0RD5rMeXwBOcSo/NMo8ffC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01/2018 11:44 AM, Jeff King wrote:
>>   	repo_init_revisions(the_repository, &revs, NULL);
>>   	save_commit_buffer = 0;
>> -	revs.allow_exclude_promisor_objects_opt = 1;
>> -	setup_revisions(ac, av, &revs, NULL);
>> +
>> +	memset(&s_r_opt, 0, sizeof(s_r_opt));
>> +	s_r_opt.allow_exclude_promisor_objects = 1;
>> +	setup_revisions(ac, av, &revs, &s_r_opt);
> 
> I wonder if a static initializer for setup_revision_opt is worth it. It
> would remove the need for this memset. Probably not a big deal either
> way, though.
I think you mean something like this:

static struct setup_revision_opt s_r_opt = {NULL, NULL, NULL, 0, 1, 0};

This is a bit cryptic (I have to read the struct declaration in order to 
know what is being set to 1) and if the struct ever gets a new field 
before allow_exclude_promisor_objects, this initializer has to be updated.

> 
>>   static int handle_revision_opt(struct rev_info *revs, int argc, const char
>> **argv,
>> -			       int *unkc, const char **unkv)
>> +			       int *unkc, const char **unkv,
>> +			       int allow_exclude_promisor_objects)
> 
> Why not pass in the whole setup_revision_opt struct? We don't need
> anything else from it yet, but it seems like the point of that struct is
> to pass around preferences like this.
OK, the code reads better if I do that, so I agree.

> 
> -Peff
> 
