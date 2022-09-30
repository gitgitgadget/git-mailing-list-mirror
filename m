Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE852C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiI3Vkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiI3Vka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:40:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB811E0064
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:40:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC6271451B4;
        Fri, 30 Sep 2022 17:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vPUUMZugmcek
        aYcRQY0qflLdT8zmYmem2R5xJ5JENxc=; b=aXV3FJs80JHOd33Odd98AMLi/3Ht
        0dzhDY5HvkeN30KX0jgITIwM84jOCD8WEI+ZqAwNOd0L/ovt+utuwRtWqTYSsPHO
        Mb3YnbQ6RE4bO1NilDacdVYDJ+ev5+eCXY0/iqNZiPBt9uLf7nfQCmYxxTTRVbDb
        +2ancgg0W5gz/Ls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E29061451B3;
        Fri, 30 Sep 2022 17:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 547041451B1;
        Fri, 30 Sep 2022 17:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 14/36] doc txt & -h consistency: correct padding
 around "[]()"
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-14.36-a29af2dcc4f-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:40:25 -0700
In-Reply-To: <patch-v3-14.36-a29af2dcc4f-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:37
        +0200")
Message-ID: <xmqqo7uw8rsm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7EF0FBE8-4108-11ED-8525-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The whitespace padding of alternatives should be of the form "[-f |
> --force]" not "[-f|--force]". Likewise we should not have padding
> before the first option, so "(--all | <pack-filename>...)" is correct,
> not "( --all | <pack-filename>... )".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-diff-files.txt     | 2 +-
>  Documentation/git-hash-object.txt    | 2 +-
>  Documentation/git-merge-base.txt     | 4 ++--
>  Documentation/git-pack-redundant.txt | 2 +-
>  Documentation/git-prune-packed.txt   | 2 +-
>  Documentation/git-rerere.txt         | 2 +-
>  Documentation/git-send-pack.txt      | 2 +-
>  Documentation/git-show-branch.txt    | 4 ++--
>  Documentation/git-show-ref.txt       | 4 ++--
>  Documentation/git-var.txt            | 2 +-
>  Documentation/git-verify-pack.txt    | 2 +-
>  builtin/bugreport.c                  | 2 +-
>  builtin/commit-graph.c               | 2 +-
>  builtin/diagnose.c                   | 2 +-
>  builtin/sparse-checkout.c            | 2 +-
>  15 files changed, 18 insertions(+), 18 deletions(-)

Consistency is good.

And ...

>  [verse]
> -'git pack-redundant' [ --verbose ] [ --alt-odb ] ( --all | <pack-filen=
ame>... )
> +'git pack-redundant' [--verbose] [--alt-odb] (--all | <pack-filename>.=
..)
> =20
>  DESCRIPTION
>  -----------
> diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-pru=
ne-packed.txt
> index 9fed59a3172..844d6f808a0 100644
> --- a/Documentation/git-prune-packed.txt
> +++ b/Documentation/git-prune-packed.txt
> @@ -9,7 +9,7 @@ git-prune-packed - Remove extra objects that are alread=
y in pack files
>  SYNOPSIS
>  --------
>  [verse]
> -'git prune-packed' [-n|--dry-run] [-q|--quiet]
> +'git prune-packed' [-n | --dry-run] [-q | --quiet]

... these show that they are easier to read with the proposed spacing.
