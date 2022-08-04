Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD7C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 21:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiHDVYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiHDVYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 17:24:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC3357DA
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 14:24:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D608A13FA68;
        Thu,  4 Aug 2022 17:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uVa0qGBhDq/I
        dfDD/LmSGzFe/xqvwN7vbMP9FIaAEnY=; b=kMZdtMu7RGfbFqQw9k6GYACj1QJO
        +Mb15E8xYPwte3W9z65zzf0rLUAxbgNcahfJr+VKmRD3AHOvHZedm9aH13chz0Ov
        KBiZYKgNVSO9UjaZo/ncFa3Ye1C3phj7uzePeCank4Aqbub6dtJ6qz0MZu2XXPoz
        h1j3SE+bOlP1xBk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD3A813FA67;
        Thu,  4 Aug 2022 17:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1754613FA66;
        Thu,  4 Aug 2022 17:24:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 08/12] docs: move index format docs to man section 5
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
        <patch-v8-08.12-ea98b37e41a-20220804T162138Z-avarab@gmail.com>
Date:   Thu, 04 Aug 2022 14:24:32 -0700
In-Reply-To: <patch-v8-08.12-ea98b37e41a-20220804T162138Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 4 Aug
 2022 18:28:37
        +0200")
Message-ID: <xmqqedxv3dnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D6686144-143B-11ED-B449-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Continue the move of existing Documentation/technical/* protocol and
> file-format documentation into our main documentation space by moving
> the index format documentation.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/Makefile                        |  2 +-
>  .../index-format.txt =3D> gitformat-index.txt}  | 20 +++++++++++++++++=
+-
>  command-list.txt                              |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)
>  rename Documentation/{technical/index-format.txt =3D> gitformat-index.=
txt} (98%)

OK, the corresponding step in the previous round mixed the index
format and the bundle format together with formats of pack-related
files in a single patch, but now we have a separate patch for the
index on its own, which we are seeing here.

Nothing unexpected in the patch.  Very cleanly done.

Thanks.
