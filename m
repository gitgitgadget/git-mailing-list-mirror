Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42756C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 19:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiGFTbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 15:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiGFTbG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 15:31:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F51D32B
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 12:31:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E54A313E252;
        Wed,  6 Jul 2022 15:31:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tA8Rsa6Qfcvi
        Q2y7RWVat1VrRwhZMwHd4omlkumoydw=; b=mUk6MYA3SLiZWoY7uKUuqOdA3EaO
        hcEN3qtMUnGUyYPXXFkTPPC/W44MI6SOhnOM+PC4XadBG/vBlLJI8cY0H3wPo3TS
        lB6xkGrDkqyEQM/Kqj1sCBW9CxI5R3meK3WyIpMnA/nzBJU9zcAQILtTO9N0g/RX
        ZsookcS2jFWgo5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBECD13E251;
        Wed,  6 Jul 2022 15:31:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A62613E24F;
        Wed,  6 Jul 2022 15:31:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/6] add and apply a rule to find "unused" init+free
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
Date:   Wed, 06 Jul 2022 12:30:59 -0700
In-Reply-To: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 5 Jul
 2022 15:46:54
        +0200")
Message-ID: <xmqqedyyghsc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2AFA50E6-FD62-11EC-8892-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  builtin/merge.c                     |  4 --

This finds and re-fixes what has already been fixed in another
topic, which is unfortunate, but it is minor.  If this topic takes
longer before en/merge-restore-to-pristine graduates, it may want to
get rerolled to avoid duplication, but for now I'll queue the series
as-is.

Thanks.
