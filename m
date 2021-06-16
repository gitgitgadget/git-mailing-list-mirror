Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD159C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF9361076
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhFPByl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:54:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60146 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFPByk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 21:54:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72770D0047;
        Tue, 15 Jun 2021 21:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zks1Lgl9jFY2
        2GNg9rl7cTaLqrR4untAQltee2C3dRI=; b=XkXA5pMQX8+uRNpOoiZYnT6IUo8o
        PSVrZ5hdZE961erPfmqGWyYF7Kuvp2dojgvAtumaE6DvTjzg/EPb+Xii/bYxtrlq
        llkmFvSlmrbU7M8Cg+E4+/xuitZEHD1j0oSzAdMFWDWuFteoR3bZYgpyDRd6Cezz
        wO9UfxUsiwXt2mA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A829D0045;
        Tue, 15 Jun 2021 21:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8305D0044;
        Tue, 15 Jun 2021 21:52:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
Date:   Wed, 16 Jun 2021 10:52:32 +0900
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 15 Jun
 2021 18:17:57 +0200")
Message-ID: <xmqqfsxitw2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 841FE7FA-CE45-11EB-9891-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> I suggested in [1] that the "alice" and "bob" examples in our
> documentation would be better written without a reference to such
> fictional characters, for reasons that have nothing to do with trying
> to bend over backwards to avoid any reference to people's gender. It
> just makes for better documentation.

I actually do not mind cast of characters with concrete names,
especially when there are more than three parties involved and
having names for them help clarify the description.  But I agree
with you that Alice and Bob should be reserved for situations where
appearance of Eve would reasonably be anticipated, or the use of
these two names become distracting to those who happen to be aware
how these characters are often used in CS literature.

Perhaps s/Alice/Tabby/ and s/Bob/Fido/ or something like that ;-)?
