Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870051F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeFCIzS (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:55:18 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44870 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeFCIzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:55:17 -0400
Received: by mail-yw0-f196.google.com with SMTP id p14-v6so9604853ywm.11
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=X9RZc1542yPVBx+cHlqOFgy63UfvsIfXqcRNm1GgXyE=;
        b=T3Rq/i2kLmOy2HJfG0LVo5m/RTPJD16xJJvL8+Z7PiGLH7rlM79T9oOmnkTx/Syf0G
         V1QXLrudOwj3yXnAPuuqsCo6ID9flvno/LSk9kTrx3pTOCVS8LiQk6Tmn2SpaACFxaWG
         8wMaP/KJ8lcpRo/vPEVAQDqREHPVtIRc/V2yUhqd6ROviQiTQz31IlBXtJqGc38myWtA
         qzbuwPPTDcgqoGyVHQ8M2GjADjCDzDcjT9i1b2qZqr8gzUB4UkscRKtxUSyK0lk+KI2F
         npbMIYx3eBk6zxkl61Ky0gfTuqMFblchrBTdK2dMhtGGD2IGB+rrVwz10gPvPzoX8hnx
         L1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=X9RZc1542yPVBx+cHlqOFgy63UfvsIfXqcRNm1GgXyE=;
        b=IKY84fPeHGhoY9yPVUf2WREuBuOP+kzPXVxBi+eSB2/Cg2ybi+YfbSqint8JQCIFHE
         n1uqUhzCysSdxRMnH0FeT40MT966xALKh5ICPJCm1n6pV0L84EQvu+VkL1CmOGSlaxKa
         gax4lMI3VuMap+2IXAUIUJDyiK/aItZyknYWTyYYzOToBBhlNbtE1cqCc1k5s2qvp7+k
         0W/uvfcrekW8j8c47yTIzATnMN/LWFl6mM/XBPjJtxD9r9XZaZlNnU2rDY9dh3tlic8A
         oEpZmfpyUcJIstTuoHcbJP+WX0EBFgMp8bX7jZ/hhand7L83vvERWY2a+x7Iym8h8K+d
         T9UQ==
X-Gm-Message-State: ALKqPweT6Kv3pteb/gOutsJu72wZu0A3wwhopb4R1Rq8K5NHp7LOgX3Y
        CfQag5OaiNtgvSKRK87WSQZ1qD696nlUPbDNNck=
X-Google-Smtp-Source: ADUXVKJy3YDYkut61LrB1D2bAsM/Cx1B7J0Qkm0gzIhC5YORTonWXGmZfrm/Z8SVQc3JJ8h7dljdlXGak0QfDy7/fUA=
X-Received: by 2002:a81:4517:: with SMTP id s23-v6mr5116248ywa.74.1528016117333;
 Sun, 03 Jun 2018 01:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:55:17 -0700 (PDT)
In-Reply-To: <20180602043241.9941-10-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-10-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:55:17 -0400
X-Google-Sender-Auth: jOQvOZqA-zR97JGFAclcdIaXG8Q
Message-ID: <CAPig+cR3YAk_KG5=u0FcRD-542dwKeaNMKkXpLzUZBwJmOp5BQ@mail.gmail.com>
Subject: Re: [PATCH 09/22] connect.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> There are also some rephrasing and breaking sentences to help
> translators.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/connect.c b/connect.c
> @@ -921,7 +928,7 @@ static enum protocol parse_connect_url(const char *ur=
l_orig, char **ret_host,
>         if (!path || !*path)
> -               die("No path specified. See 'man git-pull' for valid url =
syntax");
> +               die(_("no path specified. See 'man git-pull' for valid ur=
l syntax"));

Perhaps:

    no path specified; see 'man git-pull' for valid url syntax

?
