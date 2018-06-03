Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A0F1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 08:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeFCIQI (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 04:16:08 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38078 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeFCIQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 04:16:07 -0400
Received: by mail-yw0-f196.google.com with SMTP id w13-v6so3239694ywa.5
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=i9rsCe5Y8VgutwysC9GzXxiBj+qYnrjAN/D7N7asr5U=;
        b=ZOz6LYhi4AfQxuHHzXqfLxvD5OR9aqytinY3Um5IiJ1kMeUBC5tGnuBhPJ4pGNkxcR
         v/Zl58Dq0UCul7Tn4DRpHsomjYkJtUUeLgPD39+3QR4SIVXPSzlpCBFRoKy6JT8Ubx9z
         BEoUQND/iUtrbGVK72G8osjB8IkOedJ6jLEyZwt8rShF79tWz3xx5RBgm9yGW48wlkiq
         e1zQo39vhM2O2WxUo4ZXelbXaL2oIf7IDGtBU3dnp6vUeMd8+7clE4FsWMsjb6zPVcfY
         vajMuhMgDYkMYY4ytOj414IdSKFVj3A6b3C5n8Eze8RGzsB9oUowcMQWWVZyI2OcKwrc
         7L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=i9rsCe5Y8VgutwysC9GzXxiBj+qYnrjAN/D7N7asr5U=;
        b=NQfF5U4kVek38Gw0mgeL1FYs5e+sbwuKvZEUb/lauS59V+lGGMNJn5xcjrDcxw6pn5
         2Leey/i/f66iFmN11Qz8OFzulY6R3tijefAkO/qxmb0oaQKwSJNzcTkQG1JT9iASg0yV
         mrbOiBlcQGgS6LEkdB6nj+ZL16ll6g422f0n6Kw0plP5iN7megnuNe5hlov5BV6YdNwF
         fYhLlmcBrJLO254m599ZF+PU9EpVYhWTuA2dplZA2tLbsOBuuQ/ue7HTys5+NhlpKH2S
         3+eV7xBIAajy2MyTzomYQeXd6U9qalWynqkeEE67B8a05OYKarEZLpEvhicrjhsElsL0
         mD6A==
X-Gm-Message-State: ALKqPwcmet26q99zaZNvPVfqwMJOAKAg2unT7caESsX38F2U96p5NmYZ
        iphKVihGuD3VGnrDWgKYsgKjfJM4uifZifmysRc=
X-Google-Smtp-Source: ADUXVKIdISppnyDKLheM6MU2TMqRE+noQDq2cF38Iq6IzrWPq5ktgDwKKqwuyUd6Ha18+BPLNWFVQu6v+SR5EcQl1I4=
X-Received: by 2002:a81:738b:: with SMTP id o133-v6mr4332885ywc.120.1528013766639;
 Sun, 03 Jun 2018 01:16:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 01:16:06 -0700 (PDT)
In-Reply-To: <20180602043241.9941-20-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-20-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 04:16:06 -0400
X-Google-Sender-Auth: 4GRSlSfGs9TI-Bv7MOVwxh9Rm8Q
Message-ID: <CAPig+cRCJbZxaO6vmt+8D7aOLZDGrDVDMB97zfRAfwmtRPP_Zg@mail.gmail.com>
Subject: Re: [PATCH 19/22] sequencer.c: mark more strings for translation
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
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -2597,15 +2597,17 @@ static int error_with_patch(struct commit *commit=
,
> -               fprintf(stderr, "You can amend the commit now, with\n"
> -                       "\n"
> -                       "  git commit --amend %s\n"
> -                       "\n"
> -                       "Once you are satisfied with your changes, run\n"
> -                       "\n"
> -                       "  git rebase --continue\n", gpg_sign_opt_quoted(=
opts));
> +               fprintf(stderr,
> +                       _("You can amend the commit now, with\n"
> +                         "\n"
> +                         "  git commit --amend %s\n"
> +                         "\n"
> +                         "Once you are satisfied with your changes, run\=
n"
> +                         "\n"
> +                         "  git rebase --continue\n"),
> +                       gpg_sign_opt_quoted(opts));
>         } else if (exit_code)
> -               fprintf(stderr, "Could not apply %s... %.*s\n",
> +               fprintf_ln(stderr, _("Could not apply %s... %.*s"),

Did you want to downcase "Could" for consistency with other error
messages, or was this left as-is intentionally?
