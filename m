Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51900C4332F
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0AB61157
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhINUws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:52:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57501 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhINUwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 16:52:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D345815DA24;
        Tue, 14 Sep 2021 16:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HThBd7h5BZ/bZafxj+6ML0vSKnA1sC8qu6dTbM
        dTNQY=; b=aeSmrPOljjPC+p4X4myj+lOP+Dh6DDC2Z89Pfa+VDCaBsVBGiyVfRo
        WPVYybdotqmsiOCP+/gxJ0wMXUIMgWl7qj0AArjnu8rzrBgp3anJPuJ38eB9QkW2
        TdVRH6x8IeaTzLoOiVmSvZ2E8blw0/ed6N+to5cyn4qhLKV+TyG3M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCB8E15DA23;
        Tue, 14 Sep 2021 16:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 225CA15DA22;
        Tue, 14 Sep 2021 16:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #04; Mon, 13)
References: <xmqqtuinc3tx.fsf@gitster.g>
        <6fce08a4-876f-62d0-ed4b-05327e452985@jeffhostetler.com>
Date:   Tue, 14 Sep 2021 13:51:20 -0700
In-Reply-To: <6fce08a4-876f-62d0-ed4b-05327e452985@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 14 Sep 2021 15:47:38 -0400")
Message-ID: <xmqqczpazxrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84ABD6B2-159D-11EC-BB07-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Junio, how would you prefer that I submit this?  Would you rather
> drop the existing series and have me send 4 or 5 parts (in a fresh
> series of gitgitgadget PRs) that could be reviewed in parallel and
> just sent to "next" in series.  And then maybe they all wait in
> "next" until the last one is ready and all graduate to "master"
> together?

Sounds like that should work.

