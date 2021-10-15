Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE6C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EF761151
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhJOT1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:27:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60043 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbhJOT1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:27:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77834EB10B;
        Fri, 15 Oct 2021 15:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=86HKds6Oz45PUlZbnb2VoMB/fvFukB52Tz3q0T
        cR3iA=; b=k6VorefrwSdveX0MEWTtTq67ODAe4OeB+Wg+7KnohwXx027k5cQ2pd
        Pfly6QDGXhmfVDE/ACoEygZkxxnb88atvnvRh9YsUFsqYpGyioHIEOswPbgcYhkQ
        i76TU9uAjOJ2rN1jC/h6iP7XwzqiocR+iDJavcAI5mLDXAymM77N8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DC5BEB105;
        Fri, 15 Oct 2021 15:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D879EEB104;
        Fri, 15 Oct 2021 15:25:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, gitscale@google.com
Subject: Re: Submodules UX overhaul update
References: <xmqqwnmf9lnv.fsf@gitster.g> <YWnO4T2QkSm1bIRU@google.com>
Date:   Fri, 15 Oct 2021 12:25:33 -0700
In-Reply-To: <YWnO4T2QkSm1bIRU@google.com> (Emily Shaffer's message of "Fri,
        15 Oct 2021 11:56:33 -0700")
Message-ID: <xmqqo87q5bv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB79E078-2DED-11EC-B4C3-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> * es/superproject-aware-submodules (2021-10-14) 4 commits
>>  - submodule: record superproject gitdir during 'update'
>>  - submodule: record superproject gitdir during absorbgitdirs
>>  - introduce submodule.superprojectGitDir record
>>  - t7400-submodule-basic: modernize inspect() helper
>> 
>>  A configuration variable in a submodule points at the location of
>>  the superproject it is bound to (RFC).
>> 
>>  Brought back to 'seen' to see if it still plays well with the rest
>>  of 'seen', without the conflicting ar/submodule-update topic.
>
> See above; a reroll happened.

See above (especially the date of the queuing); it is listing the
reroll ;-).

