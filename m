Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2518C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 21:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiHDVSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiHDVSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 17:18:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385436FA36
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 14:18:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78B6613FA13;
        Thu,  4 Aug 2022 17:18:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cGfThO/sMLkV
        NM+yyEGBUFbAwK7xpc3lVoeAQb291Ks=; b=mmhHZTIsNqaKenaqZFYeH70fPKzS
        VyvkwQAPGufTG82fbVAMMzZ8TV2rrYA5NxckbsKLfU6HAYq+PfYLZjE+U3nWludl
        ZJr1r7DkcqJkA3qrYvqy9e2kUWUEQhMd0pyAMesKDHIg+tg4u38YtubLgYYyoNYU
        Ku3CZCTzCs8x4+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F15613FA12;
        Thu,  4 Aug 2022 17:18:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C787213FA11;
        Thu,  4 Aug 2022 17:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 06/12] docs: move commit-graph format docs to man
 section 5
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
        <patch-v8-06.12-df3ef265d45-20220804T162138Z-avarab@gmail.com>
Date:   Thu, 04 Aug 2022 14:18:39 -0700
In-Reply-To: <patch-v8-06.12-df3ef265d45-20220804T162138Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 4 Aug
 2022 18:28:35
        +0200")
Message-ID: <xmqqk07n3dxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 033DF838-143B-11ED-9F98-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Continue the move of existing Documentation/technical/* protocol and
> file-format documentation into our main documentation space.
> ...
> diff --git a/command-list.txt b/command-list.txt
> index 1950c4ccd9c..3afcfcd35f0 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -210,6 +210,7 @@ gitdiffcore                             guide
>  giteveryday                             guide
>  gitfaq                                  guide
>  gitformat-bundle                        developerinterfaces
> +gitformat-commit-graph                  developerinterfaces
>  gitglossary                             guide
>  githooks                                userinterfaces
>  gitignore                               userinterfaces

This round the entire patch looks good to me, including this file.
