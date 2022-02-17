Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86E2C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbiBQWnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:43:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbiBQWnt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:43:49 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82F169233
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:43:33 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4F00104432;
        Thu, 17 Feb 2022 17:43:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xBtwFP5zE/Be+nx+4yBMksqlBEHUFN1uwe1nY1
        QWypE=; b=HLMyvSb/fUJEDmMs4syj5lFaf5nHKLuRbOpx/tx4aUbg85X4pqMqWQ
        571rQvuFh9iDqkRjA46qe99J3bony07rDTkmLkrWpX4qZ2kGk7UrpVs7KnYUAmyz
        hkENOJ8Ni/vSYJjrflHGPTyG4O/P6197XPn+9cyYOkXKHZjjW4UEU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CD37104431;
        Thu, 17 Feb 2022 17:43:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF002104430;
        Thu, 17 Feb 2022 17:43:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/7] fetch: increase test coverage of fetches
References: <cover.1645102965.git.ps@pks.im>
        <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
        <xmqqczjl8buq.fsf@gitster.g>
Date:   Thu, 17 Feb 2022 14:43:30 -0800
In-Reply-To: <xmqqczjl8buq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        17 Feb 2022 12:41:33 -0800")
Message-ID: <xmqqa6ep6rn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0854E524-9043-11EC-A7C3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Is there a reason why we cannot do <<-\EOF here to lose the
> backslashes in the here-text?

Yes.  We refer to "$B".
