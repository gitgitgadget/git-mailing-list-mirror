Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D361F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 21:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfJAVFa (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 17:05:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39609 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJAVFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 17:05:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so14885078ljj.6
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NkgL89JjT7Vq0nmP5xt2oCsFhD9x7Bis0/S3LLPgusY=;
        b=itLxi7urpD3LATnOcwp0+XaFQmeC0o6Ksxso7LAZ/prCH9bY2sVmVfaIW0waDLNNQW
         /GByxZdE0P/lY/vf2iJlQcdYG/5OtyAp9R5ymhUKaNeWM+FFYT6fa6Mesn55T9KG9qdT
         v//H1kQmBlQGyqPuWWfqSgT1P9TDG2k0oiOjTvplDoYrX23iXuUjAArLP00lmR+fuN93
         oedHBX0Z4CfgGn2GfFFzMU6W6w5bYeoPEnL+DCmR1miZDPrMeLND0qK49G1r2YDPnmfV
         kyY4y10p9pS21+wnv87dYAHxjGHRV7a9nUrWFaX3BBu8EE+Xs/7pC1qgaXzPIFyxzrnc
         Wc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NkgL89JjT7Vq0nmP5xt2oCsFhD9x7Bis0/S3LLPgusY=;
        b=TaxWsWwzI+MYtqRKGJjbuJf1r5GT7ofMyaDwdlCUhE6zE2bVANVrMrpNCVgMEHS0dR
         dc+SczM9Si/KPAP4H9YEP2guBw6idk8jZqnerP3uyUjNO1LMaVVKIJJDKv7WXMtFUs5O
         +P1I2YFK1UugDTcsmyFbzuhZEBxK8O+SJIHRjtWiWkj64Bt5FsOV9IIwmhkbFjtejfkp
         zjtybC8nPTcOitzltV/LaZJXasVPw+yxGz7OHzU25wSFTUY0DORf6binDzP2PfoCC/F6
         +fC93tXB4slK9jaRXZTMlZkiQ7w64uRFIhCziNGxyt75aZREE8HjUwEukg1wNlVeKqD4
         wmfg==
X-Gm-Message-State: APjAAAU4WPZf0Uwyb3HJLCxCBusozm22cudw+GuaWxFioPeOOIqhOPh/
        gYLoSfqF813KWiLUKCPyC0M=
X-Google-Smtp-Source: APXvYqzHDaoDDoS/2Ro0Z0IH9vDEmFTiLPJ9LMsPC6mGtodB7XWHCBHh/JV9bSq1KsLUwREcxVbGjg==
X-Received: by 2002:a2e:8919:: with SMTP id d25mr13184572lji.176.1569963928207;
        Tue, 01 Oct 2019 14:05:28 -0700 (PDT)
Received: from [192.168.1.68] (ppp79-139-245-50.pppoe.spdop.ru. [79.139.245.50])
        by smtp.gmail.com with ESMTPSA id c16sm4027775lfj.8.2019.10.01.14.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 14:05:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] completion (zsh): fix misleading install location
From:   Maxim Belsky <public.belsky@gmail.com>
In-Reply-To: <0102016b2ebafc26-1bd39076-62e4-4b7e-9309-b08cc072fbdf-000000@eu-west-1.amazonses.com>
Date:   Wed, 2 Oct 2019 00:05:26 +0300
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <30798B33-EF82-449F-BDF3-B639A292BCFA@gmail.com>
References: <0102016b2ebafc26-1bd39076-62e4-4b7e-9309-b08cc072fbdf-000000@eu-west-1.amazonses.com>
To:     Durant Schoon <durant.schoon@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,=20

I face same issue a few days ago. Initially I thought `~/.zsh/_git` =
should be a dictionary. I=E2=80=99ve made all required actions, but =
completion didn't work. After a few hours I found that it should be just =
a file instead of a dictionary.

I have two ideas how to patch this comments to help another users setup =
completion:

1. Add a note that `~/.zsh/_git` should be a file =
https://github.com/mbelsky/git/commit/e951a0dee5f124ad755d32fa5cc5cded471d=
389b=20
2. Change the patch to make it more obvious =
https://github.com/mbelsky/git/commit/6c839727163b29b2d2cf5d2ec7f780c28268=
48d6

It=E2=80=99s my first time mail listing experience so I just put links =
on github to don=E2=80=99t make something wrong.

What do you think about this changes?=20

> On 7 Jun 2019, at 00:38, Durant Schoon <durant.schoon@gmail.com> =
wrote:
>=20
> diff --git a/contrib/completion/git-completion.zsh =
b/contrib/completion/git-completion.zsh
> index 886bf95d1f594..0e63004e2613e 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -11,8 +11,8 @@
> #
> #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
> #
> -# The recommended way to install this script is to copy to =
'~/.zsh/_git', and
> -# then add the following to your ~/.zshrc file:
> +# The recommended way to install this script is to copy to =
'~/.zsh/_git/',
> +# and then add the following to your ~/.zshrc file:
