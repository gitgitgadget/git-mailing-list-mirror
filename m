Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A9F1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbdHCSUs (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50366 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752031AbdHCSUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3653E85764;
        Thu,  3 Aug 2017 14:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aLT86AouEyfa
        r6KR3zD2WXh+VUs=; b=qLpcg4q9wj1F8rV3yIKFX/x5ZjMIs/1LeroyfnoeIJ9q
        uwRWkx7gHjbelRvqgdW1uDzxJpnb2syefz1QINse0sSSSkbOMyml7+DjoOIIC3C6
        5D2xIQKCGXvWs+f+4jP2DBqXdUrLLqqaWt08C+dP7CflIaJoewCry1DC1cOP1vI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qugLFY
        EC4R/ARoOge9pR7RdCfRQQDqoqie9zoSmkgpLGM2Iisie8XSi/NI3UI7YBkoPKU7
        leMNa2XcZM9ywANB7ZQ0Kx9i6fVTrwhM6uxlme8M1hIhGQopIvh69Y4MRH8ubWrP
        4SgOi1LgXARL74ZMTf5iZXw4wLMekINdv1oPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E2BA85763;
        Thu,  3 Aug 2017 14:20:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BF9685760;
        Thu,  3 Aug 2017 14:20:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/7] tag: only respect `pager.tag` in list-mode
References: <cover.1500321657.git.martin.agren@gmail.com>
        <cover.1501701128.git.martin.agren@gmail.com>
Date:   Thu, 03 Aug 2017 11:20:08 -0700
In-Reply-To: <cover.1501701128.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Wed, 2 Aug 2017 21:40:48 +0200")
Message-ID: <xmqqshh8y0mf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 62225664-7878-11E7-9525-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> This is the third version of my attempt to make `pager tag` useful (v1
> at [1], v2 at [2]). Thanks to Junio and Peff for comments on v2.
>
> I've squashed patches 01-03/10 and 07-08/10, respectively. The interdif=
f
> is below. I managed to clean up some tests thanks to a drive-by comment
> by Peff which cleared up a misunderstanding I had. Some minor changes,
> e.g., I write "built-in" instead of "builtin", since that seemed
> preferred, at least locally in builtin.h. I documented why a default
> value of "punt" could be useful, but also that it's probably not wanted=
.
>
> Martin

Thanks for working on this.  The whole series was well reasoned and
was a very pleasant read.

Will queue.
