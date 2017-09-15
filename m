Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75ED120281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdIOUtL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 16:49:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58900 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751556AbdIOUtK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:49:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4303BAD1E8;
        Fri, 15 Sep 2017 16:49:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xWmwWHCxiTU8cwuPp+S7xk3EQUc=; b=Ka2OMa
        PUTeNYKvFxOjzum7Jfn4JwKxeWCTVGTMCiZiBmejerJikXB0VUOI9c9dyaMHrmaH
        PJIBmeQlr3KtPU7ncioeUgw2eFCRzyeTBssP6yC4a/Iiw5Pb6HZXTKBGdO0LCKUE
        hXvqlBBgGW++tQm4ksgQQ2kSLa9pvsrbSECYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uLPg/a74P9zukJgUakHoetz040ndD5NM
        4Vgvv/+6MeXQHdM4j9+kqCdBlHt5+OcLJMdk6Xog84wLr9NX4vRauWM0HymHSCmi
        4FjRm6B+aJHYLyru0rS7myoV1c7dxyizMN6ZVFXcBnejoBQ4/TkxRWhmoZG+sZyc
        nNVAmvTI1AE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C295AD1E7;
        Fri, 15 Sep 2017 16:49:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CB36AD1E6;
        Fri, 15 Sep 2017 16:49:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709152122360.219280@virtualbox>
Date:   Sat, 16 Sep 2017 05:49:08 +0900
In-Reply-To: <alpine.DEB.2.21.1.1709152122360.219280@virtualbox> (Johannes
        Schindelin's message of "Fri, 15 Sep 2017 21:23:45 +0200 (CEST)")
Message-ID: <xmqqfubnwuuz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 529781BE-9A57-11E7-994F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 15 Sep 2017, Junio C Hamano wrote:
>
>> --------------------------------------------------
>> [Cooking]
>> 
>> [...]
>> 
>> * mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
>>  ...
>>  Dropped, as it was rerolled for review as part of a larger series.
>>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
>> 
>> [...]
>> 
>> * mk/use-size-t-in-zlib (2017-08-10) 1 commit
>>  ...
>>  Dropped, as it was rerolled for review as part of a larger series.
>>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
>> 
>> 
>> * mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
>>  ...
>>  Dropped, as it was rerolled for review as part of a larger series.
>>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
>> 
>> 
>> --------------------------------------------------
>> [Discarded]
>> 
>> [...]
>
> These three topics are still in the wrong category. Please fix.

Hmph, but did the larger series these refer to actually land?  If I
recall correctly they were too invasive to get merged cleanly to
'next' and 'pu' without disrupting topics in flight and that is why
it is not even listed there.

The only two reasons a topic with a good goal and approach gets
thrown into the Discarded bin are either because it is tentatively
retracted to avoid disrupting other topics in flight (with the
expectation to be redone later) or what it wants to solve is
addressed by another topic and becomes unnecessary.

These three attempt to do good things and I have been hoping that
others can help moving them forward by e.g. reporting that they
still cleanly merge and stand on their own as improvements at a
smaller scale than the larger one that was attempted but was not
queued, or if nobody volunteers, I was guessing that I might end up
doing that myself.  Before that happens, I'd prefer to keep them
listed and topics kept in my tree, even if they are not part of
'pu'.

On the other hand, because many topics have graduated to master
recently, the larger one (possibly in the updated form---I do not
recall what conflicts it had with what other topics) may be able to
cook peacefully together with topics we have that are still in
flight.  If that is the case, then that larger topic will be queued
and these three will truly become material for the Discarded bin.
