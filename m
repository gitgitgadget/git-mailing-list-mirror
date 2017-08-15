Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF2E208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 14:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbdHOOoB (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 10:44:01 -0400
Received: from mout.web.de ([212.227.15.3]:52867 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbdHOOoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 10:44:00 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK2JZ-1diSYG1yXV-001UsZ; Tue, 15
 Aug 2017 16:43:53 +0200
Subject: Re: [PATCH] t1002: stop using sum(1)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Benoit Lecocq <benoit@openbsd.org>,
        Junio C Hamano <gitster@pobox.com>
References: <9f6e13d3-07ff-1eaa-9453-05ca26a3c1ff@web.de>
 <20170815004546.GA78174@aiede.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5c9752cb-3c47-19f0-42b2-591bd29134f9@web.de>
Date:   Tue, 15 Aug 2017 16:43:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170815004546.GA78174@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:luHgwlNU74nLdLX2o56UDnu08L23VZUDkpMXtZXsdL+AbpOpuT4
 HcXH7bAHM4QOhYR1hHmrjSnwdrc4mgI4FWYFuOSa3Wq2ORhV2VOL8WzZoVzShpUXBZ8m5Fd
 vzCaLAPzclMeYnMl6+cRKNCYednfoVIJZ64QOU937JUZ/fN5VdwDpLImwbdDUDzpK/ye3v5
 16IOhJIrVqT0ODy74qgCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yTrN9KGXCbo=:xg6i5+sA3lWfW8ZnIpWwjo
 2H2f6MW56K1l6C3Qr/jhfiMLNZml/I9QWcQSmRVIkJXXG0Reis8OKnmmNpXc5HGe4ybZsvz+N
 gjg9ZCZY+8ABmftf/tVnosBEh40YIByhPy2x/cTsGCxsCXXXUxh3y1tb+O6XcpMmSF04yb73T
 eIl75nXAP5Iccd5jqpitRUjZ/dQtq8+Qs6D0bAa7xhmmSBF6OjxflJUKZEUC08IbDetr2m1rZ
 S4sq3d8rvvpNB603uKp0jkNYYZcOCkNVahYcdoCquYiOSt7lHvNTE8wHNf7IwVCSfv5Of1tiY
 08NfoiyVVyo0neyqF9Pahc52rYaCSADc4lLhUEChqGqdxsgbiauinEVosWGo7+eJjBnZOl298
 pmpPT+jQ69xv74S+jBbpLa9OOQ/YlaSr3vp3uJ6lpLCr5BXufh27X6oYJM0bwPEHWHTqTJn42
 7Y82jwJJEZvKUZvwFrrFLS/8RSvCHlMRwH052W4krFOfKOH38vRvUxEBj/W1JRjoU4e07gdBy
 UUOnjQ6sB+F7PCpHDPrgzIACKzjqnp0VTD13Q8eyN3BArkeLKOPYQRWnGt7Tmnw7c+7Fd511H
 4HzY/QzU+NWFEKhZ08lOE9kV5HstEZtdMrH61h0yykApVzTAAk3jKf5JQvDY0Leot5fX9J6Ph
 HFHGT+D/mLFYCchLVyuDnx4g22cA0R1FIYUF6Rj8MD5pZoo/8ZjwRmpHbiNtSlcjsO0n3W8/J
 V71xrwLrkr/7Mv45gYNIpPD48omtGXigmkn6oTZ2i1NqGVh42bPiTnvP3KD9LiNikULbITNMn
 VCmlrkfTZy8AvSx/XQdRLamhk1dAldQgD+1LXKOZLbDOZkJ6bk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.08.2017 um 02:46 schrieb Jonathan Nieder:
> Hi,
> 
> René Scharfe wrote:

>> We already compare changed files with their expected new contents using
>> diff(1), so we don't need to check with "test_must_fail test_cmp" if
>> they differ from their original state.  A later patch could convert the
>> direct diff(1) calls to test_cmp as well.

Let's call that paragraph "A".

> Nicely analyzed.  May we forge your sign-off?

Oops, yes, thanks for reminding me, handed it in late now.

> 
> [...]
>> --- a/t/t1002-read-tree-m-u-2way.sh
>> +++ b/t/t1002-read-tree-m-u-2way.sh
> [...]
>> @@ -132,8 +138,8 @@ test_expect_success \
>>        git ls-files --stage >7.out &&
>>        test_cmp M.out 7.out &&
>>        check_cache_at frotz dirty &&
>> -     sum bozbar frotz nitfol >actual7.sum &&
>> -     if cmp M.sum actual7.sum; then false; else :; fi &&
>> +     test_cmp bozbar.M bozbar &&
>> +     test_cmp nitfol.M nitfol &&
> 
> This one is strange.  What is that '! cmp' trying to check for?
> Does the replacement capture the same thing?
> 
> E.g., does it need a '! test_cmp frotz.M frotz &&' line?
> 
> I haven't looked at the context closely --- another option could be a
> note in the commit message about how that '! cmp' line was not testing
> anything useful in the first place.

That's what paragraph A refers to.  And as Johannes mentioned: We
already check for equality in the lines following the context you
cited (it's in my original email), so there is no need to check
for inequality as well.  That's true for all the cases you spotted.

René
