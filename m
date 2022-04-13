Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B7DC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiDMTtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiDMTtV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:49:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93274DF8
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:46:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A4EC19BC23;
        Wed, 13 Apr 2022 15:46:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6DXTJW2hZRq7
        Kr5m++H6UWNdDqqQmPcg5s30CK+5t5c=; b=rqWW8S6weGlgfjaMVJmqGOGjjXRw
        dkmh0rqnuLGNhLNKs9SFKYwXeAojw0zRpgwRoBzZNqw4WmY+lg7G6+HD2tEOp5hc
        DrU5oeu8aVgssvfv5sEt29WM4+8PF8iHttrPRQc/Bu1V8bnmjxR8ZphsQOJer2SX
        75g99gG8kk2sXbY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52A3319BC22;
        Wed, 13 Apr 2022 15:46:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A16FD19BC21;
        Wed, 13 Apr 2022 15:46:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] t0033: add tests for safe.directory
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <5b18bd1852d673ab5c62a67f873987d74294cd70.1649863951.git.gitgitgadget@gmail.com>
        <220413.86k0bseqq8.gmgdl@evledraar.gmail.com>
Date:   Wed, 13 Apr 2022 12:46:54 -0700
In-Reply-To: <220413.86k0bseqq8.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Apr 2022 21:16:20 +0200")
Message-ID: <xmqqbkx49369.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 793B8172-BB62-11EC-9B15-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

(just this part)

> These tests also pass with SANITIZE=3Dleak, so please add
> TEST_PASSES_SANITIZE_LEAK=3Dtrue at the top.

Derrick, please ignore the above.  It is totally outside the scope
of these patches, and they are meant to be applied on top of the
2.30 maintenance track, where TEST_PASSES_SANITIZE_LEAK=3Dtrue was
irrelevant.

I do not mind adding such after the dust settles on top of 'master'
(or possibly 'maint'), but not as part of these "let's fix the screw
up in 2.30.3 and its friends" effort.

Thanks.
