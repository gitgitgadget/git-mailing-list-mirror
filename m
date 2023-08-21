Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C5DEE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 17:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjHUR7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjHUR7h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 13:59:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393110E
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 10:59:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67A501BB1DE;
        Mon, 21 Aug 2023 13:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DaQlgk0XPSVAIUTJOZFD6hp9hIp+zXo3hyj4sL
        iVlBo=; b=kzZCe26zJoaAcPxEIg07sGKlFB7uYRIiGpbY3OvKQ2bbK6z/X4VQIc
        C37A7PfMxVZ4ZhaSI2HkiSVA0lEWf2KdH6hTf/8kAcCvsoSGBFOjzX1Qp4x/v/vS
        knCJ+0Njpu2sdChglQIL98HXZPmL+74Wn6lKJ2bnvnrotGwhbSPdw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F1071BB1DD;
        Mon, 21 Aug 2023 13:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 922FF1BB1DB;
        Mon, 21 Aug 2023 13:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] format-patch: add --description-file option
References: <xmqq1qg9qmyq.fsf@gitster.g>
        <20230821170720.577820-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 21 Aug 2023 10:59:33 -0700
In-Reply-To: <20230821170720.577820-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 21 Aug 2023 19:07:20 +0200")
Message-ID: <xmqqwmxop98a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C8A78F4-404C-11EE-A04F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> This patch makes it possible to directly feed a branch description to
> derive the cover letter from. The use case is formatting dynamically
> created temporary commits which are not referenced anywhere.
>
> The most obvious alternative would be creating a temporary branch and
> setting a description on it, but that doesn't seem particularly elegant.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---

The changed parts from the previous version all looked sensible.

Will replace and requeue.

Thanks.
