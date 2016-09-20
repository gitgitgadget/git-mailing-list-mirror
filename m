Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B3D1FCA9
	for <e@80x24.org>; Tue, 20 Sep 2016 06:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932525AbcITGdr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 02:33:47 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59892 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932357AbcITGdq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Sep 2016 02:33:46 -0400
X-AuditID: 12074412-1afff70000000931-a8-57e0d8474f0b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id ED.BE.02353.748D0E75; Tue, 20 Sep 2016 02:33:44 -0400 (EDT)
Received: from [192.168.69.190] (p579067D1.dip0.t-ipconnect.de [87.144.103.209])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u8K6Xejm012143
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 20 Sep 2016 02:33:41 -0400
Subject: Re: [PATCH v3 0/8] Better heuristics make prettier diffs
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
 <xmqqr38vjns0.fsf@gitster.mtv.corp.google.com>
 <c381d458-4c81-f46c-592a-98957b3a177c@alum.mit.edu>
 <xmqqd1jzho2l.fsf@gitster.mtv.corp.google.com>
 <xmqqintrg5pq.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <e0ceef8e-1809-1503-eb85-ab0f2c678e6d@alum.mit.edu>
Date:   Tue, 20 Sep 2016 08:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqintrg5pq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqOtx40G4wdwzKhZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4GsHy09zBYzr1pbbN7czuLA4bFz1l12jwWbSj2e9e5h9Lh4Sdlj/9Jt
        bB6fN8l53H62jSWAPYrLJiU1J7MstUjfLoEr4+30C0wFvzkr2ievZmpgfMzexcjJISFgIvG2
        /SZzFyMXh5DAVkaJJadPQzkXmCRmnn3IBlIlLOAo8XzeeSYQW0RATWJi2yEWiKIGJomFjVfB
        OpgF1jNJ3G75zwxSxSagK7Gopxmsg1fAXuJByyswm0VAVWLV0ltgU0UFQiTal62HqhGUODnz
        CQuIzSlgLXHqxzWwGmYBPYkd13+xQtjyEtvfzmGewMg/C0nLLCRls5CULWBkXsUol5hTmqub
        m5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREvxCOxjXn5Q7xCjAwajEw7vi8f1wIdbEsuLK
        3EOMkhxMSqK8cnwPwoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8JpcB8rxpiRWVqUW5cOkpDlY
        lMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnw1oE0ChalpqdWpGXmlCCkmTg4QYbzAA1PABte
        XJCYW5yZDpE/xagoJc679BpQQgAkkVGaB9cLS06vGMWBXhHmZQVp5wEmNrjuV0CDmYAGM/bc
        BxlckoiQkmpgdK1wrmBM+Cl+/gVL4aFw8+TOCdW31zKm6esXcQuxR34Tm3L+STOfjUWGkVXi
        6Q9Wyg/vnK6U/fC5si/l8Na/fNYBl+5I2N/V8a7iPKir8XzJqz9xEYfkjP8whlWyVqdI8ay6
        3mk2K+3FPLNHCzKPP5vNJaE/f0PYyqQlHx49iH2WuDX97sItSizFGYmGWsxFxYkAwGnwdikD
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/19/2016 07:27 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> On 09/08/2016 01:25 AM, Junio C Hamano wrote:
>>>> I'd move it temporarily to t4061 with a separate SQUASH??? at the
>>>> tip for now, as I am running out of time today.
>>>
>>> I didn't realize you were waiting for an ACK. Yes, it's totally OK to
>>> rename the test.
>>
>> I actually wasn't asking for an Ack.
>>
>> As the issue was in the one that is buried a few commits from the
>> tip, and there is a later one that adds more tests to it, I didn't
>> find enough energy to rename the new file in a buried commit and
>> then adjust the patch later updates it, I was hoping that you'd
>> reroll to save me effort, rather than forcing me to do the rebase
>> myself ;-).
> 
> Now I did, so no need to resend (unless you have changes other than
> the renaming of the test script, that is).

Thanks for taking care of this.

> Let's move it down to 'next' soonish.

Yes, it would be good to get feedback early enough in the cycle that we
can make a final decision about which diff heuristics should be used by
default and whether/what UI to implement for switching between them.

Michael

