Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66791F404
	for <e@80x24.org>; Mon, 26 Mar 2018 19:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCZTD1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 15:03:27 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33722 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZTD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 15:03:26 -0400
Received: by mail-qk0-f196.google.com with SMTP id d206so8944298qkb.0
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=50nU16SCdj3epu+hkBlA4qdIJFshYaOT7rbxsyzxD1Y=;
        b=jU45BTEaJR3fZopAoYaNycv6piaXjLzWrtxqbgch/c+LiLN0sy3lkkXcm340JkfWrP
         LlHBGzJ5+zJ9xYcoYLy2Seqccu58VQnxrACLP47J+wO0CcCy8AZOpbT2I28gkGwJfIHm
         9ysXByVl6NBsD6nCSKmesfcapH5q4qwn+dgK2MfUlIYzLTRVvIJ1vTaC+Kjf7F9Ntkko
         eG5Y7fhWsewbZ+uPLsGQwLj4jauE9ErTEQDCUzMq/qA2jhoAGO+bsYOqs9ifdKgXuWJd
         dUUtjoEywBUwiAy+4nhv8e73LFoKI6wJhGlq82GrP+9PSdKWlx/n2VlGVkaSA4q/NNcf
         hgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=50nU16SCdj3epu+hkBlA4qdIJFshYaOT7rbxsyzxD1Y=;
        b=PE3wWRjpv00KWiR3V1NPjIaDT8PXajuOZDm+QLOEp6YQj3aOsLaHHjrF3q7PPVcvNC
         HAONpW7bGUndggLXNGLHEKTCLQzPFDH7wioedj8JNFUIx0ZvdGhk5fX1g6Qnz6j+zn1E
         eEcs1s9TtXIg/G/of8RZHvZvIHWf7SVCUGe0oKfSWJvAgn4N6F+dPfMX/h40bZpiMeS6
         NzLav8yXx0agNn3lWyLFjAMKZbmL3VkszsmR0liEz20fak9RzUIm4H5e4uU8ApKOl3A8
         vnxTjsDeYWQUko0uk8Bnz7MLxQ7Zy4gHynIJ8UVAdmMeHcJ9XDkL0HSrhzHHLPc2Ixbl
         nycw==
X-Gm-Message-State: AElRT7FyxgAAusUFa1fpZXzjeWL6HaOF6RiCCva1YZPzZCtdDkG5Gv3v
        A2wxxQ5oaRY8ZM2+WYFeGwrrjw5GlOoPDV2V4uE=
X-Google-Smtp-Source: AIpwx48aOkYLLmTuqFDKKgEJ17qEEYefJIFeoo8D4mY9JWWS9aWOVmfFWRnBVlYShRDSRmEGyYApBIpj516V7xj3Pyg=
X-Received: by 10.55.182.70 with SMTP id g67mr17362788qkf.314.1522091005957;
 Mon, 26 Mar 2018 12:03:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 26 Mar 2018 12:03:25 -0700 (PDT)
In-Reply-To: <20180326182708.26551-3-avarab@gmail.com>
References: <20180326182708.26551-1-avarab@gmail.com> <20180326182708.26551-3-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Mar 2018 15:03:25 -0400
X-Google-Sender-Auth: eFXObCpn3sm1RyCRHfQiFa-BVXQ
Message-ID: <CAPig+cS8kY-cmJcFVdmu9vU+2NP+YZmXuraaK9CBTyWBEy0jAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc hash-function-transition: clarify what SHAttered means
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Dan Shumow <shumow@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 2:27 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Attempt to clarify what the SHAttered attack means in practice for
> Git. The previous version of the text made no mention whatsoever of
> Git already having a mitigation for this specific attack, which the
> SHAttered researchers claim will detect cryptanalytic collision
> attacks.
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/technical/hash-function-transition.txt b/Docum=
entation/technical/hash-function-transition.txt
> @@ -28,11 +28,30 @@ advantages:
>  Over time some flaws in SHA-1 have been discovered by security
> +researchers. On 23 February 2017 the SHAttered attack
> +(https://shattered.io) demonstrated a practical SHA-1 hash collision.
> +
> +Git v2.13.0 and later subsequently moved to a hardened SHA-1
> +implementation by default, which isn't vulnerable to the SHAttered
> +attack.
> +
> +Thus Git has in effect already migrated to a new hash that isn't SHA-1
> +and doesn't share its vulnerabilities, its new hash function just
> +happens to produce exactly the same output for all known inputs,
> +except two PDFs published by the SHAttered researchers, and the new
> +implementation (written by those researchers) claims to detect future
> +cryptanalytic collision attacks.
> +
> +Regardless, it's considered prudent to move past any variant of SHA-1
> +to a new hash. There's no guarantee that future attacks on SHA-1 won't
> +be published in the future, and those attacks may not have viable
> +mitigations.
> +
> +If SHA-1 and its variants were to be truly broken Git's hash function

s/broken/&,/

> +could not be considered cryptographically secure any more. This would
> +impact the communication of hash values because we could not trust
> +that a given hash value represented the known good version of content
> +that the speaker intended.
