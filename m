Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EB41F403
	for <e@80x24.org>; Tue, 19 Jun 2018 20:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757164AbeFSUkb (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 16:40:31 -0400
Received: from mout.web.de ([212.227.15.3]:54337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755470AbeFSUka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 16:40:30 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPowc-1faLEV00P4-0053eA; Tue, 19
 Jun 2018 22:40:21 +0200
Subject: Re: t5562: gzip -k is not portable
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
 <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
 <CAPig+cT2xkR=LbAJLCdeynGkiPysakbVna61cfrtgO3kKh85+g@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <117d2657-067a-6fe6-3713-de7a5aa75a11@web.de>
Date:   Tue, 19 Jun 2018 22:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT2xkR=LbAJLCdeynGkiPysakbVna61cfrtgO3kKh85+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:ZCeXYgdA/FIGnwDeN43uQ6kASVQ6fEIbMnjCt5b7noF36Y/JTZL
 VlgsAkhj1glakU6Tx36HN09UCNAiesnnM2IMMmuKv17//rJZAdefijjA7ZocMcW1vthNCvS
 g+LISCbL7N2voZZGxsKiULLmoi5fgxZGTc0gDyrAqE52D2a7dSkCAI81oMrMW/ttYCV6wdB
 uR3c6uohJatgzlff9hQSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n/Cjs8WTicI=:jtjODACmZzhSN7Yir7KBim
 EGjGOhUqzZkdnTrjoO0xwN0+afPxYDWj96UErT7l6Pgg+kNHREagsyfxABC3lY3jEXJiGtlEM
 mp84l0A1zliTpbWgLaKfMGzU//m0Y57yC+0V+Nlo/Ap9SVWq1ORKkUOahbR5MGun+1iqSlAFW
 6eJnzh8jVRca9YnN5ZJj8gcM03fudIvMX80A8SWhUO9NpLAtuw6zgLEyye1gddqNBiY/hkJDW
 M6s5MsiekHPOQiFxVlhEoaGMC6ox9GEZCF96fC7wJ6XAie6XQ5eAe27pQRMxz1vhIil02M08T
 RGe4FyNvdwn4N6KR67nFsUQNZn4pULogNufOBGxxrWfjkeVSpK1AmjC9KL+a4Jzplb5JDp04H
 Gj/seJfeQct+cHaLGhxJ1WvnXDjViwvc2nPUle4Kq2amgB1E9diprxDvkevkiMG8DfzFm2YS9
 wBBMltgRy8U3eUBLg1XKYLQb5dYnG6pdcTZdYki2AE6C4L97Dtx5VUmlBlO0ANKwEd7i6V6Oj
 /4exd088JLdQkHeTlRGNnwuB+kJcjhmHCMYgxDZ5zpmNMzrqArajySV1Ll2gLbAHWYZZbNCLD
 WwvX/cLwc7KSDnLKCCY4g7HlllRxM9mo9MO3DkmhG32U725otLzvH0ry9i9lqcqBcQ5o2l03/
 wQh/mlI+pf/kzttN1PwGHWSV00uJzXoti/adyk8n0B4zLBIDBPPnLcdfmcAu4EI49dTmuOySK
 5C6ZBRX7xB+KOOha4EvLz7OX8SNwcxoHLs4twa2u+nrgVsBbJrsJD+lqhiKOmFFR1rq5wAm4j
 U3hbomM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/19/2018 08:22 PM, Eric Sunshine wrote:
> On Tue, Jun 19, 2018 at 2:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Torsten Bögershausen <tboegi@web.de> writes:
>>> t5562 fails here under MacOS:
>>> "gzip -k"  is not portable.
> Very odd. Stock /usr/bin/gzip on my MacOS 10.12.6 _does_ recognize -k,
> and the test does pass.

This is the test box running Mac OS X 10.6 speaking.
The -c seems to need even -f.
But this doesn't work either:

gzip 1.3.12
Copyright (C) 2007 Free Software Foundation, Inc.
Copyright (C) 1993 Jean-loup Gailly.
This is free software.  You may redistribute copies of it under the terms of
the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
There is NO WARRANTY, to the extent permitted by law.

Written by Jean-loup Gailly.
prerequisite GZIP ok
expecting success:
     gzip -f -c fetch_body >fetch_body.gz &&
     test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
     gzip -f -c push_body >push_body,gz &&
     test_copy_bytes 10 <push_body.gz >push_body.gz.trunc

./test-lib.sh: line 632: push_body.gz: No such file or directory
not ok 2 - setup, compression related
#
#        gzip -f -c fetch_body >fetch_body.gz &&
#        test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
#        gzip -f -c push_body >push_body,gz &&
#        test_copy_bytes 10 <push_body.gz >push_body.gz.trunc
#


>> Sigh.  Perhaps -c would help.  Or do BSD implementations also lack -c?
> MacOS and BSD do support -c, so this solution would also work (and is
> "cleaner" the the other proposal).
>
>> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
>> @@ -61,9 +61,9 @@ test_expect_success 'setup' '
>>   test_expect_success GZIP 'setup, compression related' '
>> -       gzip -k fetch_body &&
>> +       gzip -c fetch_body >fetch_body.gz &&
>>          test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
>> -       gzip -k push_body &&
>> +       gzip -c push_body >push_body.gz &&
>>          test_copy_bytes 10 <push_body.gz >push_body.gz.trunc
>>   '

