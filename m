Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0756C1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdFPSaj (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 14:30:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36596 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdFPSai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 14:30:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id v18so7386740pgb.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/qojTNXIpOgDFzCwcL/jNw9RN2Ps2F36HjIo+S3oTQs=;
        b=KgTSJ+0/KidtoPhESQPSYuIg1LBS8ApjsaTLhLBya3pCcCzIlpGjD4Q1HRpGDxcTbn
         mJtaMFYLZdxbQBXyLPKEOMIVoqV7H5qEfBSfEzQ57avyFalkVnQYvdcPzST0zMluJAER
         i/rbf1zJCVK7XC9i5qrU1IfKt+bNudCwgnMHJhdrmj/WD5+/STPdSx1lCR46VXAEwZXZ
         R3w8Gal74IB56uxaLrMUllhjaiTQ+AW+RvMZSpL9C2QBZDL3+QfAlJWefbkwv14Wll/x
         xbYElLoTrXbd8sWRRhseBhcMGEuUnC1ycD9PkpISIIUM4yYruGQ/bQDTcy6rtPVvceWG
         hMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/qojTNXIpOgDFzCwcL/jNw9RN2Ps2F36HjIo+S3oTQs=;
        b=Aqfe2q11taUFBG3O0misNhVm51PoJ7SOFCSEh3BAyKNqNJshyggxhU3e6DxLg57CSv
         hU8tcK5xsw5ZBIkhNma9PqeHYowt06NpnE5ZBmaaKG8SdOzMecA4HktGg32RtmWuFDX1
         qAuPX9hoZ0LFaYWSOF2hywO7IDtZOvOCCd1SJkNU02erA0THO/iP78nBWVZQDzSSbhuS
         Nl3V+LcKnzsocZkVQwwPWzV3CuVUAT44fVq+oPriCkdonyiR11bEC6Sd+jTakCn8ieW2
         uAbVCLeIqHpzF5te3iu+uJs/7wauJQZi3/6f7vaqW++2W7jweey5NSsrQmSAcViYAj63
         wuhA==
X-Gm-Message-State: AKS2vOwJrB+3o8NbhhhBbi+iDuphBToQqKwU5GHhj+VOwMTgoxLvslxc
        J0CSL+WUEuqK/w==
X-Received: by 10.98.223.9 with SMTP id u9mr12310441pfg.98.1497637837967;
        Fri, 16 Jun 2017 11:30:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:61d1:2cfd:fa77:c70e])
        by smtp.gmail.com with ESMTPSA id o8sm5768381pgn.52.2017.06.16.11.30.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 11:30:36 -0700 (PDT)
Date:   Fri, 16 Jun 2017 11:30:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs/pretty-formats: stress that %- removes all
 preceding line-feeds
Message-ID: <20170616183034.GY133952@aiede.mtv.corp.google.com>
References: <20170615103607.11119-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170615103607.11119-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:

> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> A mere plural "line-feeds" was too subtle for me to grasp on first
> (and second...) reading.

This could go in the commit message.

>  Documentation/pretty-formats.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

With or without such a tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 38040e95b..a48d267e2 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -213,8 +213,8 @@ If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
>  is inserted immediately before the expansion if and only if the
>  placeholder expands to a non-empty string.
>  
> -If you add a `-` (minus sign) after '%' of a placeholder, line-feeds that
> -immediately precede the expansion are deleted if and only if the
> +If you add a `-` (minus sign) after '%' of a placeholder, all consecutive
> +line-feeds immediately preceding the expansion are deleted if and only if the
>  placeholder expands to an empty string.
>  
>  If you add a ` ` (space) after '%' of a placeholder, a space
