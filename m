Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60FCC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 22:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiCBWjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiCBWjX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 17:39:23 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF527C1CA0
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 14:38:36 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 205C711C321;
        Wed,  2 Mar 2022 17:38:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VH8Uqg7i+wgn
        l+SYB87q2RLIBBDJJF0+3eJgHIUXc7A=; b=O2krSbz0UZSdS/qkG5qwu3Sf04dI
        WyA0EdRlfqcCR+Smhqx6psNAwvr7WhTw1+819mwQpMdjk5ZVKv8TFZZUwebyY03c
        RgQ90WleGre2oC5o/8tQ8DyMaxopgajRLhP5cTGO2G0Gnw+vY8+nqW6Wc26zXfRo
        cKhepGtCHg6CJgc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 184F011C320;
        Wed,  2 Mar 2022 17:38:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D06811C31F;
        Wed,  2 Mar 2022 17:38:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/10] tests: add and use a "test_hook" wrapper + hook
 fixes
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 14:38:34 -0800
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:19
        +0100")
Message-ID: <xmqqsfs0getx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F12F6CA-9A79-11EC-A807-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series is a test-only improvement series split up and adapted
> from a previous series of mine to add a "git init --no-template":
> https://lore.kernel.org/git/cover-00.13-00000000000-20211212T201308Z-av=
arab@gmail.com/

I looked at all the steps and left some comments; overall the end
result was a pleasant read, even though the progression felt some
improvements were needed.

Thanks.
