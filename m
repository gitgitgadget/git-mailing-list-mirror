Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325D720954
	for <e@80x24.org>; Tue, 21 Nov 2017 11:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdKULAD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 06:00:03 -0500
Received: from avasout01.plus.net ([84.93.230.227]:51148 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdKULAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 06:00:03 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Nov 2017 06:00:02 EST
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id H6AHeV6c5Vlc3H6AIeeYm4; Tue, 21 Nov 2017 10:52:31 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GJx4KqFK c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=AqNt_tT_8H-R8RRjTrgA:9 a=QEXdDO2ut3YA:10
 a=t8EmEut40mcA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] sequencer: make sign_off_header a file local symbol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     vmiklos@suse.cz, GIT Mailing-list <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cc945f53-9452-9165-96c2-ab7f5f46c146@ramsayjones.plus.com>
 <xmqqy3n0jv98.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d9d05477-5d2f-04fc-adee-10d18bc0947d@ramsayjones.plus.com>
Date:   Tue, 21 Nov 2017 10:52:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3n0jv98.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAVn6xqCHwaKjsnxebfVa2SahkeBLemd8zNlmymV9GJ3T4Q5l4z5Pcfme7oS6dTVs/23Lf4/WFQY7B2gkVOmdpTBBknDXS2waUvJDgKc2MPg8mgoyTCm
 7rUKJKUF6Zas8tEuFts/9NYDV+VFMqlBsKQ24bjnrD+VWtitNH+HdLt5XPBmOflG92Ev++aQ+EbOeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/11/17 01:06, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Miklos,
>>
>> If you need to re-roll your 'mv/cherry-pick-s' branch, could you
>> please squash this into the relevant patch (commit 5ed75e2a3f,
>> "cherry-pick: don't forget -s on failure", 14-09-2017).
> 
> What automated procedure are you using to produce these comments?

Err, no automated procedure, hence the idiocy ... :(

> The commit is from 14-09-2012, not from a few months ago, and is
> part of Git 1.8.0 and upwards, which won't be rerolled.  Please add
> a check to see if the culprit is already in 'next' or something.

Yes, sorry, I wasn't paying attention. The actual commit which caused
the 'static-check.pl' script to bark, was d0aaa46fd3 ("commit: move empty
message checks to libgit", 10-11-2017) in the 'pu' branch. This commit
removes the last use of 'sign_off_header' outside of sequencer.c (from
builtin/commit.c).

> Will queue as _your_ fix, not a potential squash into another
> commit.

The above commit is in the 'pw/sequencer-in-process-commit' branch.
Sorry for the confusion. (Sorry Miklos).

> Thanks, as always, for your attention to detail.

Ahem. :D

ATB,
Ramsay Jones


