Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1044C1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 07:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeJYPjC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 11:39:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40102 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeJYPjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 11:39:02 -0400
Received: by mail-io1-f68.google.com with SMTP id a23-v6so4791676iod.7
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 00:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rq8KN8RQMEpfcftO3/RGpGjVx5NEbnHEzWo4/R8Oom0=;
        b=GKCMwVRkzZNOgSvntN9BshSS98FhH/9dDanyKF6rqmsoPqvlt1FZhVwtRgWI5WupkC
         LGEUXjsY3dLeecF6cpbYfah3ksUoGiazGBNQpqHY7IGnp7AePc5PbbC8CaL+QLDoJMcD
         AtAS497ct55yahb98V1LU7hnE90NSAC6IAgoZuUucBPsvC+kMlraOe8nzPiuLgocjHYm
         VG5BAybNJNfSrxxWxnD0WzaLSQyCHkcr+RkHGL+MUqFmSxWZ7fChICqmEjOUhhSmH1lj
         rzPBrMTCnRmH+r4qzBmH5unwZaMfCBFIcFLUR+Iof+i79RJfTFSZCJYaHZ+dqcAXNGLD
         /iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rq8KN8RQMEpfcftO3/RGpGjVx5NEbnHEzWo4/R8Oom0=;
        b=kUxg2BnTOXMtYNe+COYi1BEeJT07T95TIldz2IkOAhTbckcTtG77KIempzJJCMmjlA
         +bQARt1U+6rgH86C3vYiBcEqH/DS/ZywxPLj0xelzl2GYdsi2itvXhWbZ0qZuV1LoUz/
         t6TsBNtGHWiGvXULUp/nQCGMXoMPQThzQj4bKQ7S6tYFllAZA9K3mMHY1cwOba0AUxGz
         /lnT7aGS4bM5M3X66bRGEMLyyBbduUYdJHOvqecuhBWLr0LiI3dWCSXSARjrEdoowtID
         yKz7Z3ejVp/B/hzC8H1yD601X0vcdwyKjc/LS1jNaxfIKMCI8/Y3+Gu0zXPnozjVWT/4
         vf9Q==
X-Gm-Message-State: AGRZ1gKRbu89Svsm+FJoBq6mNnj696U8OeoAOiV/amM1j8H2erAh+VAE
        dF5U49sQchyieGIIeyzjuCP7DubL
X-Google-Smtp-Source: AJdET5doPNMtdWeU36KwxE/JuS6s0/6wNZ1H/R1d+qglCo+8EZPthllIbBUxNLDWvbbEGGsK1UE4MQ==
X-Received: by 2002:a6b:5a0f:: with SMTP id o15-v6mr206625iob.136.1540451256472;
        Thu, 25 Oct 2018 00:07:36 -0700 (PDT)
Received: from [192.168.1.2] ([14.167.148.1])
        by smtp.googlemail.com with ESMTPSA id o75-v6sm197160ito.20.2018.10.25.00.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 00:07:35 -0700 (PDT)
Subject: Re: [PATCH] l10n: vi.po: fix typo in pack-objects
To:     git@vger.kernel.org
References: <874dee7c-af9f-a609-c325-748160df89cc@1ec5.org>
From:   =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Cc:     Minh Nguyen <mxn@1ec5.org>
Message-ID: <4245c166-7d5a-f173-6329-52b3e562d920@gmail.com>
Date:   Thu, 25 Oct 2018 14:07:31 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <874dee7c-af9f-a609-c325-748160df89cc@1ec5.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your patch. This typo probably  is my false.

On 10/25/18 2:01 AM, Minh Nguyen wrote:
> ---
>   po/vi.po | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/po/vi.po b/po/vi.po
> index bc79319b6..e646825ed 100644
> --- a/po/vi.po
> +++ b/po/vi.po
> @@ -13663,7 +13663,7 @@ msgstr "Đánh số các đối tượng"
>   #: builtin/pack-objects.c:3382
>   #, c-format
>   msgid "Total %<PRIu32> (delta %<PRIu32>), reused %<PRIu32> (delta 
> %<PRIu32>)"
> -msgstr "Tỏng %<PRIu32> (delta %<PRIu32>), dùng lại %<PRIu32> (delta 
> %<PRIu32>)"
> +msgstr "Tổng %<PRIu32> (delta %<PRIu32>), dùng lại %<PRIu32> (delta 
> %<PRIu32>)"
> 
>   #: builtin/pack-refs.c:7
>   msgid "git pack-refs [<options>]"


-- 
Trần Ngọc Quân.
