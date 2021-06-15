Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036FAC2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F49613BF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFODIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:08:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61252 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFODIb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:08:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C03913BCFF;
        Mon, 14 Jun 2021 23:06:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Pn1FB/DnBKuU
        MIVyIHFWvE2w7Qf9yV7B7jw0b2h0gdE=; b=TkNoAWK1H2BorZKiSizBsunf+PfN
        nkGJB0p86eBQMC878t+dI3oL/k67O5Vidntqt9X+RSi3Yh5lvFwg8jE/kyN+S9VZ
        yPPtQCY1sJSVmf/VMoODvXNqLMfqRRTTT+GKazpe5/dnuM6YF1r9CbRwQmy+2RZa
        FGsGjRB5LFtZu2Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 355B613BCFE;
        Mon, 14 Jun 2021 23:06:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7DB0713BCFD;
        Mon, 14 Jun 2021 23:06:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] mktag tests: test more exhaustively
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
Date:   Tue, 15 Jun 2021 12:06:23 +0900
In-Reply-To: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 14 Jun
 2021 19:28:17 +0200")
Message-ID: <xmqqczsnyggg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABB95B62-CD86-11EB-AB89-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> ... But now that the dust has settled I figured I'd submit this
> test-only series which stresses mktag, fsck and various commands that
> might deal with the broken objects the mktag tests creates.

Thanks for not forgetting ;-)
