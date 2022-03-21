Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC3C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 19:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352048AbiCUTIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiCUTIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 15:08:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F2DFF84
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:07:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC6361860A6;
        Mon, 21 Mar 2022 15:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dEMW83I2xsOa
        W6Yty05P7aXW1F4AzygaZQa5+ymNO8A=; b=OIi+cNh2MvuePt7orVb8p/h3p8pD
        D+Ljfd9vz0K5n7frhc7uoxugjxvJLf6SWw5PzeOcjGe2E54AWVFTjcTfytkgFYHO
        7LmJ1UHgnQpqM+VV6oyvroRkIOqbiV6/20l07vXNWXP/ubsbShepHQMIvDGmkPTc
        6r2YuqLZMRc0kvI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B349D1860A4;
        Mon, 21 Mar 2022 15:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A8371860A3;
        Mon, 21 Mar 2022 15:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v13 00/16] ls-tree: "--object-only" and "--format" opts
References: <cover.1646390152.git.dyroneteng@gmail.com>
        <cover.1647846935.git.dyroneteng@gmail.com>
Date:   Mon, 21 Mar 2022 12:07:09 -0700
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com> (Teng Long's message
        of "Mon, 21 Mar 2022 15:33:14 +0800")
Message-ID: <xmqqh77rxgyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BD51626-A94A-11EC-BB8A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Diff from v12:
>
> Current patch is based by the review patch of =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason in [1].
>
> In terms of the review commits, I replied =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason [2] and listed the
> actions, therefore this v13 patch was implemented by these actions. =20
>
> Links:
>
> 1. https://public-inbox.org/git/cover-0.7-00000000000-20220310T134811Z-=
avarab@gmail.com/
> 2. https://public-inbox.org/git/20220317095129.86790-1-dyroneteng@gmail=
.com/
>
> Thanks.

Thanks for sticking to this topic.  Will queue.
