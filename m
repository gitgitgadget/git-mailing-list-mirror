Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C29AECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 16:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiIUQte (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiIUQs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 12:48:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1B71710
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 09:42:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7277F1B1610;
        Wed, 21 Sep 2022 12:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kdqDoSIHDaU0
        DdeXJRJu0PBzYYStC2VMGQwfIjBNtPE=; b=WoXDFXyvq603PXyISyGM5obhX06t
        ctaq1rJ1xlMSLJ+DdUNWrDNIOfJFXxiUmmZbz1afSxgfTtPINHDacUjGcQ+q8NRp
        ClQB0z5/Sq8anR7xAAX1QLnyhumph/kXx8KB2Gvuf3xVN9ZWDyyFifyXGs9IF8A7
        niZZv33o0nhgUvw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AA351B160F;
        Wed, 21 Sep 2022 12:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EBA2B1B160E;
        Wed, 21 Sep 2022 12:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Florine W. Dekker" <florine@fwdekker.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
        <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
        <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
        <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
        <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net>
        <220920.86edw65ngv.gmgdl@evledraar.gmail.com>
Date:   Wed, 21 Sep 2022 09:42:31 -0700
In-Reply-To: <220920.86edw65ngv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 20 Sep 2022 12:23:05 +0200")
Message-ID: <xmqqh71065mw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 63DBD226-39CC-11ED-947F-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think it would be irresponsible of us to provide a feature that looks
> as though it can in any way mitigate those concerns.
>
> If you're someone that's worried about being harassed if someone makes
> the link from your previous identity Y to your current identity X where
> you already have Y as part of a public git history. The right answer is
> to not submit a change to the .mailmap to explicitly connect the two.

While I agree with the sentiment "You are in control if your three
names appear to refer to the same person" (and "On the Internet
nobody knows you're a dog"), I wish the world were so black and
white.

Many people change their names over the course of their life, and
some do not want the linkage to their past revealed.  Many of them
have nothing to be ashamed of themselves but do so due to risk of
discrimination, while some of them may do so to hide inconvenient
facts about their past.  While I have no sympathy to the latter, I
do not think it is unreasonable for the folks in the former camp to
also want recognition for the achievement made under their old as
well as their current identity.  And "pretend you have nothing to do
with that identity you used in the past life" goes directly against
the idea of taking credit for what you did in the past.

As the expertise you demonstrated under your old name will not
help others find you as an expert in an area, until your new name
starts being associated with your newly earned recognition, it is
also a loss for the development community.

I dunno.
