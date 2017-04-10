Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406C5209F1
	for <e@80x24.org>; Mon, 10 Apr 2017 10:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbdDJKAF (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:00:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34763 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdDJKAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:00:04 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so20465180wrc.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D39/b+paenu3MAo5fNP3DFLg7OZpTXcnSGwKYyp7lAY=;
        b=QTcqUMGeCz8J4jMEfS1cysbQH2CPuSdiCLo5eI75UxLbAOuNDNm1WvEZwUGqIEF6or
         44fYiQxZ6tqRYmQKJ0jbQq7rPpV6iquz514wqh9EhtywEdc0Zp/nBUrM+RiicnDkquah
         40s7/2/YTy8BuPFTjIk68mmkZi/BRhyZZ4OOfOv2t4Mvr3d2H3bY306Epu1uT6Tdhn7l
         HDVDRmpIy4nTfayYTgPmLiq8DjTFkVA7AnSQRPFnPq+hqu3N50lZEaSBjYJZFM7JULmw
         VTKmosTi1Sk7W7qrKfyb+FO+dDxRctE7CEkBjcvT7CjtJfiHhgUAKhJ70XjK63Spg3JF
         rwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D39/b+paenu3MAo5fNP3DFLg7OZpTXcnSGwKYyp7lAY=;
        b=qsCnSxw+L7k3zQIUPs1+0/6DW9eISFnaHltPYFquaSMBlN0Q+IzSpJ9lRaFEgd4MZ6
         slFOt1NHNxz2kDsItiwQ4SgS7BySJpfYCMzm2TVm5J8nzeXyVrF2MVkl5eyGDLcmZPYH
         pm9PHrmYdtyu7nv1URzuwbL933YYS2r8O6estfIwBO9p++hqfACzUFnUSxYic1Jt3evX
         VOJGRFNpzVGBUiv2mChhJDtl6cW77fECbG/6d4f5xYcRJOxFOohqAqDUZo9Y/sJdvjtD
         Qc9u51b4f4T0bm9fzSUE90BPII1hkZxQ5uKC3S6UFw1GIoqb42acqaF1NNbvoF+Y1HaQ
         KFSg==
X-Gm-Message-State: AFeK/H0PxtVWsuMp7VMsAurN2EyuLMa7zBgeGWnbRUTOyBGgpttq/uLC0YV3LrlDfJdaPg==
X-Received: by 10.223.141.140 with SMTP id o12mr25957642wrb.69.1491818403155;
        Mon, 10 Apr 2017 03:00:03 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k26sm8492013wre.9.2017.04.10.03.00.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 03:00:02 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170409191107.20547-5-larsxschneider@gmail.com>
Date:   Mon, 10 Apr 2017 12:00:01 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>, ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <16331164-8E8C-4CDA-B319-AB8092BD7188@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com> <20170409191107.20547-5-larsxschneider@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Apr 2017, at 21:11, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
> Some `clean` / `smudge` filters might require a significant amount of
> time to process a single blob. During this process the Git checkout
> operation is blocked and Git needs to wait until the filter is done to
> continue with the checkout.
>=20
> Teach the filter process protocol (introduced in edcc858) to accept =
the
> status "delayed" as response to a filter request. Upon this response =
Git
> continues with the checkout operation. After the checkout operation =
Git
> calls "finish_delayed_checkout" which queries the filter for remaining
> blobs. If the filter is still working on the completion, then the =
filter
> is expected to block. If the filter has completed all remaining blobs
> then an empty response is expected.
>=20
> Git has a multiple code paths that checkout a blob. Support delayed
> checkouts only in `clone` (in unpack-trees.c) and `checkout` =
operations.
>=20
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> ...
> diff --git a/convert.h b/convert.h
> index 82871a11d5..da6c702090 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -42,6 +42,11 @@ extern int convert_to_git(const char *path, const =
char *src, size_t len,
> 			  struct strbuf *dst, enum safe_crlf checksafe);
> extern int convert_to_working_tree(const char *path, const char *src,
> 				   size_t len, struct strbuf *dst);
> +extern int async_convert_to_working_tree(const char *path, const char =
*src,
> +					 size_t len, struct strbuf *dst,
> +					 void *dco);
>=20

I don't like the void pointer here. However, "cache.h" includes =
"convert.h" and
therefore "convert.h" cannot include "cache.h". That's why "convert.h" =
doesn't
know about "struct delayed_checkout".=20

I just realized that I could move "struct delayed_checkout" and "enum =
ce_delay_state"
definition from "cache.h" to "convert.h" to solve the problem nicely.

Any objection to this approach?

Thanks,
Lars=
