Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906ECC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 22:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJSW3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiJSW2o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 18:28:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC489961
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 15:28:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CE0D13FD2D;
        Wed, 19 Oct 2022 18:27:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8GtWe9doFdmD5upeoACtvDsVh82qvg+UVXVYMW
        sSauI=; b=WubDbZ7F0ktJ3IHVvdDM9cOSVHzW/NqQxGte5ZXxRrUDI2jIY82S0g
        oiuql48a3cIPNiiKXcMKM/NQ7uKuLZSJeur9q1H9CgebjhlbhazilrXVBXkx9EoK
        PaHBorgGdUuHeQuRS/F1bOppv6GvMZ/wGmjZ/p66Y0CtAWPpvNuVs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62C8213FD2C;
        Wed, 19 Oct 2022 18:27:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A56D813FD2B;
        Wed, 19 Oct 2022 18:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3?= =?utf-8?Q?n?= 
        <carenas@gmail.com>, Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 3/4] Makefile: really use and document
 sha1collisiondetection by default
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
        <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
        <CAPig+cS8jvUn9bR=1ywWgCC3gPosgycdcdbm+aASo59mXz6rfw@mail.gmail.com>
        <xmqqo7u7srp4.fsf@gitster.g>
        <221019.867d0vhbsz.gmgdl@evledraar.gmail.com>
        <xmqqy1tbo3yz.fsf@gitster.g>
Date:   Wed, 19 Oct 2022 15:27:35 -0700
In-Reply-To: <xmqqy1tbo3yz.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        19 Oct 2022 15:15:00 -0700")
Message-ID: <xmqqr0z3o3e0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BCE21C0-4FFD-11ED-9685-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Let's make it a focused change that does one thing very well without
> wasting reviewer's time on discussion on non-essential things.
>
> I do not mean by "non-essential" that reorganizing Makefile comments
> to make it easier to find and write relevant documents, or making it
> harder to turn conflicting knobs.  They may by themselves be

Sorry, I forgot to finish the sentence.  I do not mean these other
changes I called "non-essential" are useless.  They are not
essential in the context of making sha1dc the default everywhere.

Thanks.
