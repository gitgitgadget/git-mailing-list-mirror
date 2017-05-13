Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933C9201A4
	for <e@80x24.org>; Sat, 13 May 2017 10:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbdEMK6l (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 06:58:41 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35038 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdEMK6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 06:58:40 -0400
Received: by mail-it0-f68.google.com with SMTP id 67so8054092itx.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m44KJ9cM50Z+KQP9e7D7Aw4M2pxcr0lR8ySK9QemopM=;
        b=EGqpu7L42xqOuotNw+lo8w1Swgv31IVkBGIvUmLpaQKQVhocAR9+0Vu88sP7ynfcBb
         btyxTUkaqMqIISSbKbl3cibg8gVIUfWTsUPDlacqFVkO5eR4GeaHDsQ/SAXJ37ij+ceQ
         ILl/gODjkApWOkgN2oyJgYVNiHYwS6HKBpcU3AmmGRITqqPgw1g8JxLBzSCICYNjGRrJ
         i2McQNtWLunebQLE7+dZlGAN1Pd8UB+LOa+/07TLV/9H2TOo4/OwspSKg/HH9f1urvS8
         fkduduhU2SNCVB2tzPA+9Tnli7evjbsbCPdwxkc/uIEQ9DhhLAk2m/vgu6qovzpIhtyE
         3bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m44KJ9cM50Z+KQP9e7D7Aw4M2pxcr0lR8ySK9QemopM=;
        b=sCLu37ov2cY02fHEXu87TAv00bv4tuOQw3JOb9kMl687j1DsH2ijEfT1oLYR7f6LLS
         jZWqPGCc6NmCj3f7lIvNdikX0oeCwU0ToLJirzEybdeGHLcrFGZ6kPYYJWTz2Yvjiw4M
         wh7Vc9roeEaixljgQd9LMb0a/6+ZMwlKiqJ2sCmRaWay01QaXQloWwYkGK9eOD8p7NzD
         6RmZxYU/wbd0NPrHeuZrXgKcWRysiavytIGKHP98jG/WjyYKbl6TVTeFlXrNWnsj07Ul
         yj0utLe3oYI267jxGNW4RmwhqiiF7QGidZBrj1INKFqM9MKtfMmSfg9gBzcrDhZvNMvG
         GPWg==
X-Gm-Message-State: AODbwcDCumRowXtKbgrh9IuzD0pgGRbgi8+lO3Fd/q+unGy5rprc/5Nu
        ZcpIWu1eb5M9Hkv3FBensvW8r6H+tSFkM3k=
X-Received: by 10.36.53.2 with SMTP id k2mr7994457ita.71.1494673119670; Sat,
 13 May 2017 03:58:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 03:58:18 -0700 (PDT)
In-Reply-To: <20170513095716.C718E221C2B@srv1.79p.de>
References: <20170513095716.C718E221C2B@srv1.79p.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 12:58:18 +0200
Message-ID: <CACBZZX6dcy9DEp8AZsdV5SPG-86ELOXUSuFkOaoUxjVreJXhDA@mail.gmail.com>
Subject: Re: [PATCH] doc: use https link to Wikipeai to avoid http redirect
To:     Sven Strickroth <email@cs-ware.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 11:54 AM, Sven Strickroth <email@cs-ware.de> wrote:

Spelling error: Wikipeai

Looks good, but let's change these too while we're at it:

$ git grep http://en.wikip
Documentation/gitweb.txt:87:http://en.wikipedia.org/wiki/Query_string#URL_encoding[]),
the difference
bisect.c:549: * http://en.wikipedia.org/wiki/Integer_square_root
gitweb/gitweb.perl:8088:<a
href="http://en.wikipedia.org/wiki/Regular_expression">regular
expression</a> (also case



> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
>  Documentation/gitweb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> index 96156e5e1..88450589a 100644
> --- a/Documentation/gitweb.txt
> +++ b/Documentation/gitweb.txt
> @@ -84,7 +84,7 @@ separator (rules for Perl's "`split(" ", $line)`").
>
>  * Fields use modified URI encoding, defined in RFC 3986, section 2.1
>  (Percent-Encoding), or rather "Query string encoding" (see
> -http://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the difference
> +https://en.wikipedia.org/wiki/Query_string#URL_encoding[]), the difference
>  being that SP (" ") can be encoded as "{plus}" (and therefore "{plus}" has to be
>  also percent-encoded).
>  +
> --
> 2.12.1.windows.1
>
