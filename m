Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7663C0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 05:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjG1FLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjG1FLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 01:11:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D32D7E
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 22:10:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BB061A29DA;
        Fri, 28 Jul 2023 01:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZMl/Lq60ux4a7HdQU9Wnu4DOdyox+lblxSvVTu
        JV9a0=; b=h7mwDaERm99YjpedEMxgeQzvITrDHbTb1JdcvAdQvmeF8zXA3B5Bim
        kpjoNhIlKozHIGAobpWhOtcXOLCkF+XiRxqCOa0Axvl5WC7ay3nN1EF3ylN9NtiS
        zVG36mqVuwNMsNHV4fYQBdD/G0L7y+IV+rf57HwPWw7KPuvudk2Qs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63DBA1A29D9;
        Fri, 28 Jul 2023 01:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C58571A29D8;
        Fri, 28 Jul 2023 01:10:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4] MyFirstContribution: refrain from self-iterating too
 much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g>
        <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
        <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com>
        <xmqq7cqkanm9.fsf@gitster.g> <xmqqmszg987u.fsf_-_@gitster.g>
        <owly8rb0g53d.fsf@fine.c.googlers.com>
Date:   Thu, 27 Jul 2023 22:10:40 -0700
In-Reply-To: <owly8rb0g53d.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Thu, 27 Jul 2023 19:08:54 -0700")
Message-ID: <xmqq35188vu7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19566702-2D05-11EE-A0D7-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...
>>
>> The inter/range-diff with my v3 was totally useless, but here is to
>> show three minor edits I made to Linus's version I am responding to.
>>
>>  * Simplify parenthesized "because it may be the case that".
>>
>>  * As if you were "a" reviewer, as we do not designate "the
>>    reviewer(s)" to a patch.  Anybody can (volunteer to) be a
>>    reviewer for a patch, and you can be, too.
>>
>>  * Stress that a single polished patch that comes later (because it
>>    took time to polish) is vastly preferred than flurry of "oops
>>    this is better" updates.
>
> All very reasonable and sensible. LGTM, thanks!

Thanks.
