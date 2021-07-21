Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E0EC12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88C861248
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 16:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhGUQRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:17:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60809 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGUQRM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:17:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 746B11459B9;
        Wed, 21 Jul 2021 12:57:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zPv/Ncs4BdRqObabMUaGFPF9v/10gTGUZ0G70G
        MNvZM=; b=J4fWacgJOyKWy5vHasq2QP/jgVpJ9/DJdtBEIQ/cPto0zyWGqNmOGo
        brH/Zgf10u2G78I1FgdoGGiFhY/I+YUlgHdlBe3ap2TuzyPgWjsyc9gYiGknSgwK
        PEbz73g2COXRVi2UX7KwzAnRTFtBdAp3W2CrTSRnopny7E0xEI2T8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CD911459B8;
        Wed, 21 Jul 2021 12:57:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3C1B1459B7;
        Wed, 21 Jul 2021 12:57:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] bundle doc: elaborate on rev<->ref restriction
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
        <patch-3.3-6d66d4480ff-20210720T141611Z-avarab@gmail.com>
        <xmqqo8awhh5z.fsf@gitster.g>
        <68ea4cc0-b9d3-a7fb-7c22-fa828f9dc52f@iee.email>
Date:   Wed, 21 Jul 2021 09:57:44 -0700
In-Reply-To: <68ea4cc0-b9d3-a7fb-7c22-fa828f9dc52f@iee.email> (Philip Oakley's
        message of "Wed, 21 Jul 2021 10:27:40 +0100")
Message-ID: <xmqqim13eh9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5867BEE-EA44-11EB-9D5F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Should the `list-heads` option be mentioned for investigating existing
> bundles?

I think 'list-heads' has been listed in the options section.  I
however may encourage people to use "git ls-remote one.bndl" over
"git bundle list-heads one.bndl"---they do the same thing, no?

Thanks.



