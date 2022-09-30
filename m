Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C67CC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiI3VnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiI3VnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:43:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE31830C4
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:43:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F3D71BEBA6;
        Fri, 30 Sep 2022 17:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iY3MSvLXuzYr
        GcUPhBfRU5QqOVVHd3wFDHr9nI3mSt8=; b=E1sr1XUlq9yhGqrEGcP7mT0OU8Gy
        hqrL0546OlmlDMSRRaILDF28vWMqfZB6bToNvj7yDGMhviOp9Nfv7J0soQqC2mtB
        6uMWZFgLvaEytjG4n9/H25JuxXxBsHYjtDnTBn1i/I+P6ML5mJCml9o6VwNFUBLd
        GfoXqb5TxOKNlbQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37D0B1BEBA4;
        Fri, 30 Sep 2022 17:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 670561BEBA2;
        Fri, 30 Sep 2022 17:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 16/36] doc txt & -h consistency: use "<options>", not
 "<options>..."
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-16.36-db850539d2a-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:43:00 -0700
In-Reply-To: <patch-v3-16.36-db850539d2a-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:39
        +0200")
Message-ID: <xmqqill48rob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DB5FCFEE-4108-11ED-84B9-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> It's arguably more correct to say "[<option>...]" than either of these
> forms, but the vast majority of our documentation uses the
> "[<options>]" form to indicate an arbitrary number of options, let's
> do the same in these cases, which were the odd ones out.

Yeah, I agree these should say [<option>...] to mean zero-or-more of
them.  It may be fine, as long as it is clear that we use
[<options>] as a short-hand for it, though.
