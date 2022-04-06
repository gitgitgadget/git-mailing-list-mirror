Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E28C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiDFVEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbiDFVEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:04:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C02D704D
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 12:37:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 668A0172207;
        Wed,  6 Apr 2022 15:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ba0MvRDw4B6NhqnmMBXzgP5T+3j3jMK6svU1i
        f/wxo=; b=VygI7qk/O18eqZCmf0zKMLOaeoY1pGPMQr9bxCtzPZvsB3hlweseNz
        y6OeYJLw2igqZWCqKpkxIDU6UNijzl+ZRU8sMnZpyMFO03dcf6jMyT0Ku+QI5PZg
        QINK11yzX4BUO0UcvTUFiy0w1skFr9oYXo+tRutFZaHAYkMVNNSnc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FDD9172206;
        Wed,  6 Apr 2022 15:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A36DC172204;
        Wed,  6 Apr 2022 15:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
        <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
        <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
        <xmqqv8vmyysp.fsf@gitster.g>
        <046001d849d2$9daf2290$d90d67b0$@nexbridge.com>
Date:   Wed, 06 Apr 2022 12:37:43 -0700
In-Reply-To: <046001d849d2$9daf2290$d90d67b0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 6 Apr 2022 12:23:09 -0400")
Message-ID: <xmqqsfqqxat4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07EC2778-B5E1-11EC-A8C6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> I have no explanation on why this and the PATH issue showed up at 2.36.0-rc0
> and not at 2.35.1. 2.35.0. Our build/test cycles are thorough but only on
> the releases and rc* ...

Ah, OK, so I had a wrong impression, which explains my puzzlement.

I somehow thought that you caught us soon after stuff got merged to
'master', and sometimes even to 'next', for a few times before.

Thanks.
