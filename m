Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA0C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiI1R3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiI1R3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:29:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD4F101E3
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:29:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0512145987;
        Wed, 28 Sep 2022 13:29:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7ueEPbsGTHiE
        ZlooTZ6D/mIi9CTmqZoZyMbzrF3D/Ww=; b=Fp6J3ZsIf+dUtfSbiadIAOrXgQRj
        RnvpENLZsJb434BKLgPqWFFMq/PE48qkhOSmIwG7IiDRyhnZ+9uSIY3WCt/7m234
        8NED75WFO82a6sadoWSr3P/KGGoVuh9++h6r77Hm5cfyiSAl2o7iFDyO1cLU8v3/
        CbVOCRilAEYO+Eo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97779145986;
        Wed, 28 Sep 2022 13:29:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E9E7145985;
        Wed, 28 Sep 2022 13:29:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 01/35] CodingGuidelines: update and clarify
 command-line conventions
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
        <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <patch-v2-01.35-aecd3ff41f2-20220928T082458Z-avarab@gmail.com>
Date:   Wed, 28 Sep 2022 10:29:41 -0700
In-Reply-To: <patch-v2-01.35-aecd3ff41f2-20220928T082458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 28 Sep
 2022 10:38:56
        +0200")
Message-ID: <xmqqpmffv24a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2305CFFE-3F53-11ED-86D7-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>   Optional parts are enclosed in square brackets:
> -   [<extra>]
> -   (Zero or one <extra>.)
> +   [<file>...]
> +   (Zero or more of <file>.)

OK.

> + Use spacing around "|" token(s), but not immediately after opening or
> + before closing a [] or () pair:
> +   Do: [-q | --quiet]
> +   Don't: [-q|--quiet]
> +
> + Don't use spacing around "|" tokens when they're used to seperate the
> + alternate arguments of an option:
> +    Do: --track[=3D(direct|inherit)]
> +    Don't: --track[=3D(direct | inherit)]
> +

Hmph, that sounds inconsistent; I would have expected the same use
(or omission) of space around the vertical bar.  But if that is the
prevailing style, I won't complain about writing it down.

Thanks.

