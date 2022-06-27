Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16080C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 20:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiF0UAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbiF0UAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 16:00:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A801C91A
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 13:00:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FD0D128CC3;
        Mon, 27 Jun 2022 16:00:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aXub1x2Os2wenftOt53FJB3VIzvM7hb+Kr5hN5
        BQUcs=; b=PYXr2Mms7cv/gGERK/WDSreanhtdHaTgO9QTKdgQFyjekyCnFJ0xhZ
        inoAnMj9YoIhLa8JJXblHx5JEtiJf5ywcGchlbeWgFM8Z0RS9few5MIbtoKo0+//
        +WRiPqgLz7QulfH/WDJ4r/raJDILs/RgRSg9/6ihGQZeZqYkR0Atw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5E6A128CAC;
        Mon, 27 Jun 2022 16:00:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E473128C6B;
        Mon, 27 Jun 2022 16:00:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.37.0
References: <20220627192154.4051-1-johannes.schindelin@gmx.de>
Date:   Mon, 27 Jun 2022 12:59:59 -0700
In-Reply-To: <20220627192154.4051-1-johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Mon, 27 Jun 2022 19:21:54 +0000")
Message-ID: <xmqqilolop1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB94E4D8-F653-11EC-98D6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.37.0 is available from:
>
>     https://gitforwindows.org/

Thanks.
