Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D300C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 23:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B70260E8F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 23:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhGVWeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 18:34:15 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12976 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232445AbhGVWeO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 18:34:14 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m6htu-0007ip-G4; Fri, 23 Jul 2021 00:14:47 +0100
Subject: Re: [PATCH v6 3/3] bundle doc: elaborate on rev<->ref restriction
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
 <patch-3.3-6d66d4480ff-20210720T141611Z-avarab@gmail.com>
 <xmqqo8awhh5z.fsf@gitster.g> <68ea4cc0-b9d3-a7fb-7c22-fa828f9dc52f@iee.email>
 <xmqqim13eh9z.fsf@gitster.g> <27ad38c9-699e-0a9b-1bef-3c5d2950cd02@iee.email>
 <87v952tvrz.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <697ca0f3-a897-a20b-48e4-bf439697afb5@iee.email>
Date:   Fri, 23 Jul 2021 00:14:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87v952tvrz.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/2021 12:46, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jul 22 2021, Philip Oakley wrote:
>
>> On 21/07/2021 17:57, Junio C Hamano wrote:
>>> Philip Oakley <philipoakley@iee.email> writes:
>>>
>>>> Should the `list-heads` option be mentioned for investigating existing
>>>> bundles?
>>> I think 'list-heads' has been listed in the options section.  
>> True, it's why I was suggesting pointing at that route for the extra
>> details that are beyond just a set of refs.
>>
>>> I
>>> however may encourage people to use "git ls-remote one.bndl" over
>>> "git bundle list-heads one.bndl"---they do the same thing, no?
>> It is good to provide both directions to the user. The formats may be
>> different but the content is essentially the same, and redirecting users
>> to the more core command is useful.
>>
> I'll work those suggestions into a future update of the docs I have
> queued, but for now I think talking about list-heads v.s. ls-remote
> doesn't have much directly to do with this particular series, correct?
True.

However I'm still not really clear about the distinction between the
'basis' and the `header references` (that is, the text doesn't make it
clear).

for the future updates, it would also be good if the `--all` and
`--branches --tags` text was also shown in the examples - I continue to
get StackOverflow points for my Q&A on that ;-)

Philip
