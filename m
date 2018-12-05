Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA7A211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 21:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeLEVQa (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 16:16:30 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:15348 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLEVQa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 16:16:30 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 439BP759HTz5tl9;
        Wed,  5 Dec 2018 22:16:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7392D20A8;
        Wed,  5 Dec 2018 22:16:27 +0100 (CET)
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section
 Behavioral Differences
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
 <20181204231709.13824-1-newren@gmail.com>
 <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
 <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
 <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org>
 <xmqqr2ewbevt.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHzESYnQy5JwXvtXyLHgHR9u3UNVOZF2gU1m_uTMGkyfg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <bd67cd33-dbe8-03a0-e760-c7bb23854084@kdbg.org>
Date:   Wed, 5 Dec 2018 22:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHzESYnQy5JwXvtXyLHgHR9u3UNVOZF2gU1m_uTMGkyfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.18 um 16:37 schrieb Elijah Newren:
> On Tue, Dec 4, 2018 at 11:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Please let me deposit my objection. This paragraph is not the right
>>> place to explain what directory renme detection is and how it works
>>> under the hood. "works fine" in the original text is the right phrase
>>> here; if there is concern that this induces expectations that cannot
>>> be met, throw in the word "heuristics".
>>>
>>> Such as:
>>>     Directory rename heuristics work fine in the merge and interactive
>>>     backends. It does not in the am backend because...
>>
>> OK, good enough, I guess.  Or just s/work fine/is enabled/.
> 
> So...
> 
> Directory rename heuristics are enabled in the merge and interactive
> backends. They are not in the am backend because it operates on
> "fake ancestors" that involve trees containing only the files modified
> in the patch.  Due to the lack of accurate tree information, directory
> rename detection is disabled for the am backend.

OK with me. And also if you drop sentence no.2 and keep just no.1 and no.3.

Thanks,
-- Hannes
