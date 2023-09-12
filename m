Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F0CA0ED2
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjILRLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbjILRLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:11:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01721702
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:11:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D4713F312;
        Tue, 12 Sep 2023 13:11:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=cJbcCO8JmeCQOfiCmsuS7QPosmIvoV6BmlZArY
        V5QOs=; b=q2KVwEWCwqmEVOv10qi0JOD+B++0+KztDdeJMF6JqI+us8Qvxf8Mo8
        nDdM+RTqbLtW2CxPiyveYNr5anzAI79NGoYuNKZobzX6bqtPlPsWynBRiJecOqyK
        WW/30io5s6MwaIuICg+gbFa2UKIC7Bx12HnVAffnW57jeFtyAlTrE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 946483F311;
        Tue, 12 Sep 2023 13:11:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19E4C3F310;
        Tue, 12 Sep 2023 13:11:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff --stat: add config option to limit filename width
In-Reply-To: <487bd30e5a4cdcea8697393eb36ce3f3@manjaro.org> (Dragan Simic's
        message of "Tue, 12 Sep 2023 04:11:28 +0200")
References: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>
        <xmqqil8gs3s0.fsf@gitster.g>
        <487bd30e5a4cdcea8697393eb36ce3f3@manjaro.org>
Date:   Tue, 12 Sep 2023 10:11:40 -0700
Message-ID: <xmqqbke7pb8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 717C1F5E-518F-11EE-B492-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

>> Someday, as a follow-up after the dust from this topic settles, we
>> would probably want to look at how these rev.diffopt.* members are
>> initialized and refactor the common code out to a helper.  It would
>> allow us to instead of doing this ...
>
> Another good point.  If you agree, I'd prefer to have my patch
> accepted and merged as-is, ...

That is exactly what I meant by "follow-up after the dust settles".

All of the "we should probably do this and that in the future" are
called #leftoverbits comments.  Food for thought, something people
can use to find inspiration for areas they may want to work on, that
has no impact to how "complete" the current patch being discussed
is.
