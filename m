Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDECD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjIRQqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjIRQq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:46:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE79DE4A
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:38:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98E3123D1C;
        Mon, 18 Sep 2023 12:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=r0DXOQ0haBxwa5pyhyjuV3EjiVS0nQROabCsnu
        3YLN8=; b=oyGRXjT0bXr/EyvG0EyaVsYW6wB3B63VO29LC4IkTUGe6af4o7t2vq
        lSsJ5wuCr+UXO/iDFB7DyV5jNEYg7ZtuzUnTL/vOf1fLWCODU1MOSG9TDZQ2QCSb
        IXfZ478DfR0vp24AXKL2DY3DvoTFz2QxybsJAfcS76X/R9L2FfS9g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91B7C23D1B;
        Mon, 18 Sep 2023 12:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0C9A23D19;
        Mon, 18 Sep 2023 12:38:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff --stat: add config option to limit filename width
In-Reply-To: <7aceb7db8d3f4b569564ffd9d1e2e368@manjaro.org> (Dragan Simic's
        message of "Sat, 16 Sep 2023 04:09:39 +0200")
References: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>
        <xmqqil8gs3s0.fsf@gitster.g>
        <487bd30e5a4cdcea8697393eb36ce3f3@manjaro.org>
        <7aceb7db8d3f4b569564ffd9d1e2e368@manjaro.org>
Date:   Mon, 18 Sep 2023 09:38:45 -0700
Message-ID: <xmqqttrrl9m2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6B3AAE8-5641-11EE-950F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> Just checking, do you want me to perform any improvements to this
> patch, so you can have it pulled into one of your trees?

I do not think of any outstanding issues I spotted on this change.
Thanks for pinging.
