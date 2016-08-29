Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0DB51FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755608AbcH2T7v (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:59:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52337 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753436AbcH2T7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA4D33A09C;
        Mon, 29 Aug 2016 15:57:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7Ef6Jiqsg9Z1
        azP1nHhjVKOnIe8=; b=QKnGpYXFpTin6tY4x/hDQNNjQfdnuX5K+FDI3t5jS1dQ
        YpdQZlpMXogWeQMpfFRenYgwptTzkGL3QN3RSJIZ2HHl3fS/7s/HEIzjcVUBxOxo
        8fJKa2Xr04w/JZL8YPGPjbmN8+Dfi5rjR/MhWj4SAawGlhGHi2TWTg0fU48iE3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ptVhbD
        0KKVZSA1+F6ZZ1pYDHyeBHT97UULJekFBH2pHQ8gL9Xphb5lZUbH2jysrXQkScI6
        E9YIhIZwz7W6Abx2ntn7f246T4NK0RejVe7lXLIG6IBmiYZgRkaoDEhHUQhVrWbh
        6bLHCzSA4HXO+O/lUVtkz+dppVQyoJskHSUZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E14E53A09B;
        Mon, 29 Aug 2016 15:57:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6192C3A099;
        Mon, 29 Aug 2016 15:57:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] p3400: make test script executable
References: <9d882519-12dd-e854-9303-66df5532b67f@web.de>
Date:   Mon, 29 Aug 2016 12:57:33 -0700
In-Reply-To: <9d882519-12dd-e854-9303-66df5532b67f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 28 Aug 2016 14:39:27 +0200")
Message-ID: <xmqqpoor9wlu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D47B175C-6E22-11E6-8B6F-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This script was added by v2.10.0-rc0~3^2.

Thanks.  Will merge to 'master'.

>
>  t/perf/p3400-rebase.sh | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 =3D> 100755 t/perf/p3400-rebase.sh
>
> diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
> old mode 100644
> new mode 100755
