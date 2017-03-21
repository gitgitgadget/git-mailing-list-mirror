Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6A542095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933316AbdCUSy7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:54:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58281 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932402AbdCUSxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:53:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DDA16F1A0;
        Tue, 21 Mar 2017 14:53:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5/YVS1nZS/WW
        q2ljFa7J6VftF1k=; b=J0JXhp35/j7rghqzQoqSZkT/RNWTpA37VwfFqhP7ipOL
        vK+TxvISeyOxkDVgAjgb4W+gWQEr6XU9TV5H2LT5IUYskekjuY9gXCOi2O+OCGiI
        jz1f68VnKPmb5jRnCDrSn1aXAKf4Vy/VTAaEUbTNEpzCj6KDbF6Hn54+Ia3Pl+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MDvwFH
        3mVK6rA/7UkjXF7wKTndCCsU2k2yTgBCI31PXYwbIUMM6Yv6Ci0C1B/rXygYdhoG
        emRUHVDpAUIDyI0aOYDGRrKC7RWsqrSfRciFC5uHkC5OpGagqsacJYo3hlH1YiTo
        sSdGOXKH5IGbkyTZcfrB10uCajZBOW0DZGbxU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2588D6F19F;
        Tue, 21 Mar 2017 14:53:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 451A46F19E;
        Tue, 21 Mar 2017 14:53:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 14/16] ref-filter: reflow recently changed branch/tag/for-each-ref docs
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-15-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:53:46 -0700
In-Reply-To: <20170321125901.10652-15-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:59 +0000")
Message-ID: <xmqq7f3ipikl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B70E50CC-0E67-11E7-AF49-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Reflow the recently changed branch/tag-for-each-ref
> documentation. This change shows no changes under --word-diff, except
> the innocuous change of moving git-tag.txt's "[--sort=3D<key>]" around
> slightly.
> ---

Thanks. =20

Needs sign-off (I could just add it back in if you tell me so ;)

