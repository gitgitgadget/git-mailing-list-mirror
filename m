Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D362CEE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 18:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHUSch (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjHUSch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 14:32:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA5CD1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 11:32:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 848251BA92F;
        Mon, 21 Aug 2023 14:32:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uzO4tQI5znOyULT3bEkXxjxGzW6aFas333hcjS
        Fyx+0=; b=lDIcZrKAAwXyT6F56UsC4V4WvvhjmcP7xIa/Az7dUH8OkhxRHglLtx
        32An30a7IuT1/lUfThDnus2MIsIXFmcXA0JvslrMit6qH1nq4xvzQH3V/YN/QRie
        lTjkp8Tv64W52gnG9g/5Artjo93IlfHnXxam+JPPZQZm4cGOZDog0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C4501BA92E;
        Mon, 21 Aug 2023 14:32:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E12231BA92D;
        Mon, 21 Aug 2023 14:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 1/2] sequencer: beautify subject of reverts of reverts
References: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <20230821170720.577850-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 21 Aug 2023 11:32:28 -0700
In-Reply-To: <20230821170720.577850-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 21 Aug 2023 19:07:19 +0200")
Message-ID: <xmqqjztop7pf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15EC2D90-4051-11EE-BA72-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> Instead of generating a silly-looking `Revert "Revert "foo""`, make it
> a more humane `Reapply "foo"`.

Looking good.  Will requeue.  Thanks.
