Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA021F731
	for <e@80x24.org>; Wed,  7 Aug 2019 05:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfHGFOX (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 01:14:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62227 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfHGFOX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 01:14:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D86015D395;
        Wed,  7 Aug 2019 01:14:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkoYdgA7C+mThyRvybuMYCzzDc4=; b=a76ENJ
        lA8MKdvEezaaKaXX1d79ACDYfRB08kuu1PRawTQ33MeJOvJ5zNPDpBQUAx1pftie
        p1Jz/AqD64O8wmw4iFKjXMg3Uc3mLoSu3jezk9Mda3t0QE90bwkDcC/d8FW8Cm8P
        SZyNtoGRz5nRrJU2J9btG31wd7db0/2jucyfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NMOiNfKt6ts6i1ghspxMC/pYM4EZ1KJd
        CnORVAwArfDEDqOOTjMbfWLjwpewSV3mrZ7lE/dMuhUqUBhX6V89OrF3RLjhAKve
        PI9vcaWJyWLGdlSx7T+O2Bl7aZOAe6f8gfmp/d/fg9wlIwXjBAa7wD74DNoVKEf7
        AfnCdleXXFE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2629B15D394;
        Wed,  7 Aug 2019 01:14:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B20C15D393;
        Wed,  7 Aug 2019 01:14:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2019, #03; Tue, 6)
References: <xmqqv9vahs6p.fsf@gitster-ct.c.googlers.com>
        <20190807010516.9667-1-rohit.ashiwal265@gmail.com>
Date:   Tue, 06 Aug 2019 22:14:19 -0700
In-Reply-To: <20190807010516.9667-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Wed, 7 Aug 2019 06:35:16 +0530")
Message-ID: <xmqqr25ximl0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3657385A-B8D2-11E9-9531-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> On Tue, 06 Aug 2019 14:58:38 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>>
>> [...]
>> * ra/rebase-i-more-options (2019-07-23) 4 commits
>> ...
>>  Needs a bit of fixups, at least.
>> [...]
>
> This patch series was re-sent as a new topic, available here[1].

Thanks for a pointer. 

During the pre-release freeze, topics that are not yet ready for the
upcoming release are backburnered and processed as "time available"
basis.  It may take a bit more than usual before getting picked up,
because not picking up a reroll immediately up would save me effort
and time if public comments the topic receives in a few days results
in a yet another version.

