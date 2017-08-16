Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1331F667
	for <e@80x24.org>; Wed, 16 Aug 2017 19:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdHPT2n (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 15:28:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52406 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751678AbdHPT2m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 15:28:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B8C2A5600;
        Wed, 16 Aug 2017 15:28:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uTejNm8H2plIgWpEtddhA++l+Xs=; b=HqvQi2
        pC9cS9F3wlIL+APhFk38SptpcW+qKfz0WLywL72emKjtSdNxmcWwLWg/yTMcsRvD
        2cO7ktxqI85l3F4WyFszQTNuS30NZ+8GrOC0k3FwE8Ha9LuY5Db+K5PgApP9i+Pe
        dHwWcVNy72kcSmZEYjTCHi36LBva9DXmI+uzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yO8r5GWtP4xT/L0P2QFX0zgsczhnG7JX
        PIikKvZT0tIKm8pmlE3APsgVabXJjU5WSqTRSvy/Gq07S7E6ec1kB2Av2CJoLz42
        c/8FZK0qNxltLepkApkOGTPIXHl0D8n/vzzCiNR9kGHtsuB2WrlZQK1ESCIOVDZa
        7bQpuLmWh84=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4418BA55FF;
        Wed, 16 Aug 2017 15:28:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A50EAA55FB;
        Wed, 16 Aug 2017 15:28:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #03; Mon, 14)
References: <xmqqr2wdso3k.fsf@gitster.mtv.corp.google.com>
        <943ad6c6-a5fb-cbb0-9eca-ac1c3e51fa15@gmail.com>
Date:   Wed, 16 Aug 2017 12:28:33 -0700
In-Reply-To: <943ad6c6-a5fb-cbb0-9eca-ac1c3e51fa15@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 16 Aug 2017 23:55:29 +0530")
Message-ID: <xmqqvalnjori.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18552F98-82B9-11E7-A05A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> It's been around 4 or 5 issues of 'What's cooking in git.git' and I haven't
> heard about the patches found at,
>
> http://public-inbox.org/git/<20170730111705.12444-1-kaarticsivaraam91196@gmail.com>
>
> and
>
> https://public-inbox.org/git/<20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
>
> What has happened to them?

Nothing has.  Neither thread seems to have any comment from anybody
but you, and I took it as an indication that people do not think it
is a good change.

I do not find the s/branch/parameter/ too bad (although I would have
said "arguments" instead).  

For the other one, I personally think split sentences and lines make
output look worse, but this is obviously subjective (just like the
patch itself).

