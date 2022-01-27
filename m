Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93261C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbiA0UOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:14:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55156 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiA0UOK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 15:14:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13D1510C50C;
        Thu, 27 Jan 2022 15:14:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uSUjY0Sy+cJs
        x9HH/5sVGmoYHlTNuKap5+lpLoMkHfk=; b=oVATgPhvpXwUZJSloqW5w1EVPtMi
        k119JCfWVI6ClHGN/aWZTo2gLW1KEtP5NdPOkpk2R9XQgWV+/Tfx3PPuC0+PgfGb
        Rb0CzKTt38RAHYm+p6J42Xf2baDyEcXqGaucrNK8zmgVO4c43EK+6xbKKJ65OKTV
        VZyC6adSiCaW+Ms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59AC710C50B;
        Thu, 27 Jan 2022 15:14:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F1B310C508;
        Thu, 27 Jan 2022 15:14:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v8 0/7] object-name: make ambiguous object output
 translatable + show tag date
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
        <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
Date:   Thu, 27 Jan 2022 12:14:03 -0800
In-Reply-To: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 27 Jan
 2022 06:26:42
        +0100")
Message-ID: <xmqqee4t0wdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ACADECD4-7FAD-11EC-8087-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The range-diff looks rather scary though because if we're going to add
> such output it made sense to add it in a new 3/7, before we made the
> output translatable, and then to carry that change forward.

I agree with the direction.  "translatable plus show date" are two
unrelated things, but it is easier to understand if the feature
enhancement is done first, so that marking and restructuring of the
messages for i18n needs to be done only once.

Will queue.  Thanks.
