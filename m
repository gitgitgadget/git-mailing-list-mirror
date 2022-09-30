Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE72C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiI3VBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiI3VB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:01:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680411C177
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:01:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97AFE1BE737;
        Fri, 30 Sep 2022 17:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=W4GjHFw4ENn96rkKKuuUdH/dP
        cUUo4xBtFu82a7dpu4=; b=tsftIDGIdcNvgKE+UFlXh9pSfsRAQOUrdHzlt9y2h
        G9F3Ccwr0CbK9LTU6f5l+nTf9wa2kVXnXBQVGNm77sj7YJyF2pkeaYalmwjKbz9s
        fDxs/C8oZYMSzaSTfErM4/zppfHezwZ0eO9rcywjhmfs3uFNusGN9QBayfVWVR5i
        mc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9107F1BE736;
        Fri, 30 Sep 2022 17:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD6FD1BE735;
        Fri, 30 Sep 2022 17:01:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 02/36] builtin/bundle.c: indent with tabs
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-02.36-b2d76494a34-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:01:22 -0700
Message-ID: <xmqqh70oa865.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A9F1392-4103-11ED-A26B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix indentation issues introduced with 73c3253d75e (bundle: framework
> for options before bundle file, 2019-11-10), and carried forward in
> some subsequent commits.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/bundle.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Makes sense.  "git show -w" allows us to see that the indentation is
the only change made with this step, too.

>
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index e80efce3a42..5c78894afd5 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -12,31 +12,31 @@
>   */
> =20
>  static const char * const builtin_bundle_usage[] =3D {
> -  N_("git bundle create [<options>] <file> <git-rev-list args>"),
> -  N_("git bundle verify [<options>] <file>"),
> -  N_("git bundle list-heads <file> [<refname>...]"),
> -  N_("git bundle unbundle <file> [<refname>...]"),
> -  NULL
> +	N_("git bundle create [<options>] <file> <git-rev-list args>"),
> +	N_("git bundle verify [<options>] <file>"),
> +	N_("git bundle list-heads <file> [<refname>...]"),
> +	N_("git bundle unbundle <file> [<refname>...]"),
> +	NULL
>  };
> =20
>  static const char * const builtin_bundle_create_usage[] =3D {
> -  N_("git bundle create [<options>] <file> <git-rev-list args>"),
> -  NULL
> +	N_("git bundle create [<options>] <file> <git-rev-list args>"),
> +	NULL
>  };
> =20
>  static const char * const builtin_bundle_verify_usage[] =3D {
> -  N_("git bundle verify [<options>] <file>"),
> -  NULL
> +	N_("git bundle verify [<options>] <file>"),
> +	NULL
>  };
> =20
>  static const char * const builtin_bundle_list_heads_usage[] =3D {
> -  N_("git bundle list-heads <file> [<refname>...]"),
> -  NULL
> +	N_("git bundle list-heads <file> [<refname>...]"),
> +	NULL
>  };
> =20
>  static const char * const builtin_bundle_unbundle_usage[] =3D {
> -  N_("git bundle unbundle <file> [<refname>...]"),
> -  NULL
> +	N_("git bundle unbundle <file> [<refname>...]"),
> +	NULL
>  };
> =20
>  static int parse_options_cmd_bundle(int argc,
