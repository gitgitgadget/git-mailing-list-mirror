Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EDF211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 22:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeLEWqr (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 17:46:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56238 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEWqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 17:46:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1640A2BCBD;
        Wed,  5 Dec 2018 17:46:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yD2UhSsPuF61/7OuuR1LYBsLaWU=; b=i/j1FY
        er1wbFgSBeeDbEi9+OdhAhUzH1OMtxOXTvPN0e+pwAJXLjQODycpyzMXg9XYGrCJ
        dEgXA5GGgr+JH2kQ2p8rF83ZUjqxHVYnLCT2RkrjLab0dhdEAiniwlvZSM2n8Vpo
        BH487CgSjRTNl6GuYj/1sAb5nxax7yOyYYUG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PmsYSXn/Ky9oy8M6zZHuxiYffySzlzn3
        90/Cx1IXWhvV6EbJkOi8GS3AlVP9T0qiieESwjWP+ddBJ2l1NOGdpMCPspshFzMH
        4te6Kcz7lx6B328dm4TNrJLvUhiQKMoNx72o/aTlSNDpAU1496sp9ZNflHY929YQ
        18ritzUovMs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F6B92BCBB;
        Wed,  5 Dec 2018 17:46:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 271FC2BCBA;
        Wed,  5 Dec 2018 17:46:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section Behavioral Differences
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
        <20181204231709.13824-1-newren@gmail.com>
        <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
        <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
        <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org>
        <xmqqr2ewbevt.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHzESYnQy5JwXvtXyLHgHR9u3UNVOZF2gU1m_uTMGkyfg@mail.gmail.com>
        <bd67cd33-dbe8-03a0-e760-c7bb23854084@kdbg.org>
Date:   Thu, 06 Dec 2018 07:46:41 +0900
In-Reply-To: <bd67cd33-dbe8-03a0-e760-c7bb23854084@kdbg.org> (Johannes Sixt's
        message of "Wed, 5 Dec 2018 22:16:27 +0100")
Message-ID: <xmqqmupjbnhq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3A5C9DE-F8DF-11E8-A3B0-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 05.12.18 um 16:37 schrieb Elijah Newren:
>> On Tue, Dec 4, 2018 at 11:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Johannes Sixt <j6t@kdbg.org> writes:
>>>
>>>> Please let me deposit my objection. This paragraph is not the right
>>>> place to explain what directory renme detection is and how it works
>>>> under the hood. "works fine" in the original text is the right phrase
>>>> here; if there is concern that this induces expectations that cannot
>>>> be met, throw in the word "heuristics".
>>>>
>>>> Such as:
>>>>     Directory rename heuristics work fine in the merge and interactive
>>>>     backends. It does not in the am backend because...
>>>
>>> OK, good enough, I guess.  Or just s/work fine/is enabled/.
>>
>> So...
>>
>> Directory rename heuristics are enabled in the merge and interactive
>> backends. They are not in the am backend because it operates on
>> "fake ancestors" that involve trees containing only the files modified
>> in the patch.  Due to the lack of accurate tree information, directory
>> rename detection is disabled for the am backend.
>
> OK with me. And also if you drop sentence no.2 and keep just no.1 and no.3.

Yeah, that shorter version may be sufficient to explain why we do
not use the heuristics in the "am" backend.
