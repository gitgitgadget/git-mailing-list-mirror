Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD95C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiI3VXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiI3VXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:23:18 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADFC1B912D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:23:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6570C1BEA3B;
        Fri, 30 Sep 2022 17:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kBu2nt5iCwpP
        6cOTpY0/O+ADC3CEKkDaka2AcbcIFPg=; b=m89n3OKHuayczDpDiYIuKzmgv609
        YfsFlZe83hk59CwEbdUDa0spBtd1Xi44w8keBFsFgmtc5x0qavyTschLRdycGr59
        VM924Ld8dVjgsVMmfV9PahlSEgq256YanlgSEfp4/B12AYtQwr3KFavsmWsjylTX
        BmWVsWuOdyVnz+8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E5051BEA3A;
        Fri, 30 Sep 2022 17:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33B881BEA31;
        Fri, 30 Sep 2022 17:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 05/36] doc SYNOPSIS: don't use ' for subcommands
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-05.36-ec977f7c8fe-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:23:11 -0700
In-Reply-To: <patch-v3-05.36-ec977f7c8fe-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:28
        +0200")
Message-ID: <xmqq5yh4a75s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 168CA8A6-4106-11ED-964E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Almost all of our documentation doesn't use "'" syntax for
> subcommands, but these did, let's make them consistent with the
> rest.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-reflog.txt | 2 +-
>  Documentation/git-rerere.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Good.

> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.tx=
t
> index db9d46edfa9..0537d4645be 100644
> --- a/Documentation/git-reflog.txt
> +++ b/Documentation/git-reflog.txt
> @@ -17,7 +17,7 @@ The command takes various subcommands, and different =
options
>  depending on the subcommand:
> =20
>  [verse]
> -'git reflog' ['show'] [<log-options>] [<ref>]
> +'git reflog' [show] [<log-options>] [<ref>]
>  'git reflog expire' [--expire=3D<time>] [--expire-unreachable=3D<time>=
]
>  	[--rewrite] [--updateref] [--stale-fix]
>  	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
> diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.tx=
t
> index 4cfc8833780..4b613d4140c 100644
> --- a/Documentation/git-rerere.txt
> +++ b/Documentation/git-rerere.txt
> @@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted me=
rges
>  SYNOPSIS
>  --------
>  [verse]
> -'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|=
'gc']
> +'git rerere' [clear|forget <pathspec>|diff|remaining|status|gc]
> =20
>  DESCRIPTION
>  -----------
