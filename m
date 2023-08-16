Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F76C07E8F
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 18:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbjHPSlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbjHPSlP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 14:41:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E442112
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 11:41:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 874B12D92D;
        Wed, 16 Aug 2023 14:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x+VKK7NEZ3eO
        mR2NKRVZZmqIYqZcdPIIEkcih1hN5nw=; b=jZke/JGb4BtcbpKVP0hIB7qIwGiU
        yP+Q6qWdZKTTjZazryxHgzN6kgGZ8Cu4Iyl22SkCM5HUq1COup79u1ftx54hAX33
        Rndw6ScHCSUAUjRn4bTpZqHQFKETrEyR9TfuNnjqzdh5z/yaZhDeP8zVeNsv/JCU
        /GyuMd/OsuN2YbY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80A272D92C;
        Wed, 16 Aug 2023 14:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FF972D92B;
        Wed, 16 Aug 2023 14:41:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/4] rev-list-options: fix typo in `--stdin` documentation
References: <cover.1692194193.git.martin.agren@gmail.com>
        <b1b3f1d10b64e63c62db0105957a4ad5e0295d34.1692194193.git.martin.agren@gmail.com>
Date:   Wed, 16 Aug 2023 11:41:09 -0700
In-Reply-To: <b1b3f1d10b64e63c62db0105957a4ad5e0295d34.1692194193.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 16 Aug 2023 16:24:36
 +0200")
Message-ID: <xmqqzg2qesoq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7828B564-3C64-11EE-BDE1-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> With `--stdin`, we read *from* standard input, not *for*.

True, and the name of the stream is "the standard input".

> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/rev-list-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
> index e6468bf0eb..a4a0cb93b2 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -237,7 +237,7 @@ endif::git-rev-list[]
> =20
>  --stdin::
>  	In addition to getting arguments from the command line, read
> -	them for standard input as well. This accepts commits and
> +	them from standard input as well. This accepts commits and
>  	pseudo-options like `--all` and `--glob=3D`. When a `--` separator
>  	is seen, the following input is treated as paths and used to
>  	limit the result.
