Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DD1201CF
	for <e@80x24.org>; Fri, 19 May 2017 03:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756621AbdESDnC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 23:43:02 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51217 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756415AbdESDlE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 May 2017 23:41:04 -0400
X-AuditID: 1207440f-701ff700000004e5-c7-591e6899c78f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 19.10.01253.9986E195; Thu, 18 May 2017 23:38:03 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCC1C.dip0.t-ipconnect.de [87.188.204.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4J3bvNk023912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 18 May 2017 23:37:59 -0400
Subject: Re: [PATCH 01/23] t3600: clean up permissions test properly
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <bb244c72ec6e6ab56171d82f7379a75c4eb5481f.1495014840.git.mhagger@alum.mit.edu>
 <xmqqa86avm8j.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <2003333a-4a33-b023-078f-07a481df7b63@alum.mit.edu>
Date:   Fri, 19 May 2017 05:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa86avm8j.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1J2dIRdpsKCF2WLtsztMFl1Xupks
        GnqvMFssefia2aJ7yltGix8tPcwWmze3sziwe+ycdZfdY8GmUo+u9iNsHs969zB6XLyk7PF5
        k1wAWxSXTUpqTmZZapG+XQJXxuGzt5kKFnBVbF72jqmBsYuji5GTQ0LARGL1rf+sXYxcHEIC
        O5gkHl4+zgbhnGeSuL/rKCNIlbCAi0Tr9YNsILaIgJrExLZDLBBFOxklzn+fzgTiMAssYJLY
        sWEJK0gVm4CuxKKeZiYQm1fAXuLkkt9gNouAqsSpo73sILaoQITEw85d7BA1ghInZz5hAbE5
        Bawllq6bBGYzC+hJ7Lj+ixXClpfY/nYO8wRG/llIWmYhKZuFpGwBI/MqRrnEnNJc3dzEzJzi
        1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJBQ59/B2LVe5hCjAAejEg/vgxWykUKsiWXFlbmHGCU5
        mJREeWcEyEUK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuEVFwPK8aYkVlalFuXDpKQ5WJTEedWX
        qPsJCaQnlqRmp6YWpBbBZGU4OJQkeO3SgRoFi1LTUyvSMnNKENJMHJwgw3mAhgeC1PAWFyTm
        FmemQ+RPMSpKifPapQElBEASGaV5cL2wVPSKURzoFWFeOZB2HmAag+t+BTSYCWhw8wNpkMEl
        iQgpqQbGYr9DCUc+zlKKVGpQVJmkls/nFflI7Wty0p5p/2LXzTz8Sl7E6eqzyu1iD/JX6VQy
        BHtW9qzxXjr9ieqU5+HN7548eqGs3ez9TDKmMuJPUvP5rgstPwM31b8piix4t9rtxMvDMSuP
        5ruuaxN+of3M3T5YdseK8g2RN0PCLGe1dJSadhzcyOusxFKckWioxVxUnAgAqaYgDyADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/18/2017 06:10 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The test of failing `git rm -f` removes the write permissions on the
>> test directory, but fails to restore them if the test fails. This
>> means that the test temporary directory cannot be cleaned up, which
>> means that subsequent attempts to run the test fail mysteriously.
>>
>> Instead, do the cleanup in a `test_must_fail` block so that it can't
>> be skipped.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  t/t3600-rm.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
>> index 5f9913ba33..4a35c378c8 100755
>> --- a/t/t3600-rm.sh
>> +++ b/t/t3600-rm.sh
>> @@ -98,8 +98,8 @@ embedded'"
>>  
>>  test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
>>  	chmod a-w . &&
>> -	test_must_fail git rm -f baz &&
>> -	chmod 775 .
>> +	test_when_finished "chmod 775 ." &&
>> +	test_must_fail git rm -f baz
>>  '
> 
> Obviously a good idea.
> 
> In this case it would not matter very much, but I think it is a
> better style to have when-finished _before_ "chmod a-w ." that
> introduces the state we want to revert out of.

OK, I'll change this in v2.

Michael

