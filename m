Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE07ECAAD8
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 02:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIOC5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 22:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIOC5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 22:57:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D1B90C41
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 19:57:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E0491B3E73;
        Wed, 14 Sep 2022 22:57:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=vbhAZVKSYM3Z3tPwTHv++YpLY
        72UNQP87s21+NzZ33k=; b=NcB2WnQZwE/MDnttqL93lFnJTKq9zvZE93p/TjmVb
        QVquGTx1/LA/0pMEN+/ZliCYtVxHXCQ8HYNOrCaM3Ei3+5EJCcatyBWo1TMC9DdE
        UszPGkxyTThfaVpcMTfUHMlSkIYjQL8hk9+Jr087VZagrGtLJOrSCRyiWfcl7izt
        /4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8798A1B3E72;
        Wed, 14 Sep 2022 22:57:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C6DD1B3E71;
        Wed, 14 Sep 2022 22:57:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220914151333.3309-1-tboegi@web.de>
Date:   Wed, 14 Sep 2022 19:57:07 -0700
Message-ID: <xmqqmtb1pcos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 16DDE16E-34A2-11ED-AB2E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
> Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth=
()

Let's retitle it to "diff.c: use utf8_strwidth() to count display width".
