Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB3120FFD
	for <e@80x24.org>; Sun, 15 Jan 2017 16:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbdAOQ54 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 11:57:56 -0500
Received: from mout.web.de ([212.227.17.11]:60722 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbdAOQ5z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 11:57:55 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lp6xk-1cyads12ZQ-00eqGM; Sun, 15
 Jan 2017 17:57:48 +0100
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty
 lines in context
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
 <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
 <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
 <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
 <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com>
 <xmqqbmvaecpl.fsf@gitster.mtv.corp.google.com>
 <48bdfd94-2fd4-bd55-d78b-2877e195fb82@web.de>
 <xmqqy3ydcaia.fsf@gitster.mtv.corp.google.com>
 <0c761135-2696-4b3d-0a4f-3d90edf5da2e@oracle.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2668771d-249b-659d-3a2c-a788d7d5ebd6@web.de>
Date:   Sun, 15 Jan 2017 17:57:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <0c761135-2696-4b3d-0a4f-3d90edf5da2e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:18NvfQMjb1BnCtWaSt1S6wJVzAie87l4NrpdzBDWIS6vl9Jcjc/
 iXkMlxHOdvzKOWc1DM6ttHrzIEIfUKYb7SxSd+OkMgLuBfdOUjhcvaiEj3WLRPvaZleKdMd
 vhQgbKetgm5EzhUSsQcH4ubzFABdKw+MzK8PhJQInSCtQrVlT/+7T2+njK6Qag6bnwmlcYm
 gRCsHiIf5xLND4Nk7k+yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bx3gr3CNIyo=:PVctdVlCb/zufuhWfSwhuy
 i9YyWS1deQ6y8TUpIT2xbqKjbgJJfWAbnKec7jAd2/8PGo4wmynidL5CiPpRdQei75y+c48bL
 IZloDLgpMvI/2tWPSWdnb52MmWNts+u4hWeUTbXyok4VNHEg/tDtnTyhH3TTavE3prlTv1N1l
 0fiIJ6/lqUeumoSzJ4fX/Tuk/Fvm13HueGhssXM0LhsllsX95vsT2e5noCsj46KfL4OoXGKkz
 cGN/cpAr+gV+860ECoSkZiOena0CpLNZuPtmY/S0IQBGa/8lA87/Ux++yUGGh2RA3geMNU3V3
 T6hAEdWHwoU/tE7kH88U4kdJmSYFz6ByFjx+35BjYJTit0A1qWGXT1jgfNTotkp9Ipq6WU2qS
 2DT2nguI+wmcSSV0gfKQsKfgi0MxUi0gDIAfNio5yZChG9cB01X3hkGiyT3I2yPZ/AZdD5e8d
 k4FkRFy51ajOnx1zt+Q/cIxu+WtIeEnD0Ox08TD4GqrabwRQmy1U3YJY41AYw+MAIavnF+4HY
 IzhaUY01+p9MOMpQbXbTJ6Huzr3zRckLTCse7BIvmg84ORzU00e/6pA/YwSLjB7ps42tAKe0L
 g7ZBS6tnIRHwkQhV84siRRFMDbtGsf1BBNeAMOdowf6grFOUuof+aSpncJXj+6scMTX3vI3B8
 aW7eGre1P1RkgqZYIA2b9MPMeTg74seVZ+80bkMs7S4X22rrZrNu6QXi5VSC3jHZvQlFlbElX
 oaiv8SOPq9eW+GJnZXAJJzK+dQl9qn8e94YSH+rGnc8MbUcPjkQx2jHk8d6OLk9WqCqkJ6uEQ
 oN6cQxr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.01.2017 um 11:06 schrieb Vegard Nossum:
> On 15/01/2017 03:39, Junio C Hamano wrote:
>> René Scharfe <l.s.r@web.de> writes:
>>> How about extending the context upward only up to and excluding a line
>>> that is either empty *or* a function line?  That would limit the extra
>>> context to a single function in the worst case.
>>>
>>> Reducing context at the bottom with the aim to remove comments for the
>>> next section is more tricky as it could remove part of the function
>>> that we'd like to show if we get the boundary wrong.  How bad would it
>>> be to keep the southern border unchanged?
>>
>> I personally do not think there is any robust heuristic other than
>> Vegard's "a blank line may be a signal enough that lines before that
>> are not part of the beginning of the function", and I think your
>> "hence we look for a blank line but if there is a line that matches
>> the function header, stop there as we know we came too far back"
>> will be a good-enough safety measure.
>>
>> I also agree with you that we probably do not want to futz with the
>> southern border.
>
> You are right, trying to change the southern border in this way is not
> quite reliable if there are no empty lines whatsoever and can
> erroneously cause the function context to not include the bottom of the
> function being changed.
>
> I'm splitting the function boundary detection logic into separate
> functions and trying to solve the above case without breaking the tests
> (and adding a new test for the above case too).
>
> I'll see if I can additionally provide some toggles (flags or config
> variables) to control the new behaviour, what I had in mind was:
>
>   -W[=preamble,=no-preamble]
>   --function-context[=preamble,=no-preamble]
>   diff.functionContextPreamble = <bool>
>
> (where the new logic is controlled by the new config variable and
> overridden by the presence of =preamble or =no-preamble).

Adding comments before a function is useful, removing comments after a 
function sounds to me as only nice to have (under the assumption that 
they belong to the next function[*]).  How bad would it be to only 
implement the first part (as in the patch I just sent) without adding 
new config settings or parameters?

Thanks,
René


[*] Silly counter-example (the #endif line):
#ifdef SOMETHING
int f(...) {
	// implementation for SOMETHING
}
#else
inf f(...) {
	// implementation without SOMETHING
}
#endif /* SOMETHING */

