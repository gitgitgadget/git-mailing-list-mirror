Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A7820248
	for <e@80x24.org>; Sun, 17 Mar 2019 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfCQTSs (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 15:18:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45221 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfCQTSs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 15:18:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so602191pgk.12
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bTx4Zx51wVT7EVOxqZDdXbOXLfjVJlGK5EjYilBIl2Y=;
        b=elI1hCMs8Vbizj7q0fyQ3uDADxl6bqMb7tgErElY2Fx6uzlCrmVojg+rOgzmZZBB6h
         gX1Du8BOoPENjoHPzXSOTiXh6TK3BVkOPoXVzUnb9S/L+LBRl3cx9BAcEvC7lanqEfE4
         Y7Oi5Jn9RZGZOaA4zeAkrUygAw0dy7yikhGT9kcaZ+LFAFblf/RvmWzFI2XH4vl0F3Ao
         /YYWCw/ixiTrqNIKVyqAxRp3+0bRzrwmblyKWNwgXjX8EvI8rj9e6jkgTZ2VYjPWrPQ8
         F89tSJvygoje7n7a4nnXUwYJwJ/JS8uMsF5Qtyo0YMZrIBLEX0Ab817jdH2jexq7OG2x
         K3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bTx4Zx51wVT7EVOxqZDdXbOXLfjVJlGK5EjYilBIl2Y=;
        b=O4HL0t2v/31RX+gPOsI7RBaeZY2PS5wHfiMbmHG19Yn7ad81niEmNmA5hBtgpuQbFD
         5RMa4wxQISdMsipIf7DOFVB+nfFozgFOGpmnBYMFomM+YnAQiv9su9LvhA5NwdlIR4Us
         C5fYc1hsUea1bagb+j+mgjBKoX/QLuSwBzZxOxucC3kI1ehA34OdG/mZbedReuGmmE9z
         iUR2tsIz4TOE6oyDQgQreaK98GmQ221kvngyX4krj4j/4749qMNptCdzozBPe88hBnV0
         CfUNS2ivsKRNnYbtSp/x0De8XoSD/kZIYVf+vKx8AJR1ZYW09ntBQYtSub3v5W8k/m9V
         1Ocg==
X-Gm-Message-State: APjAAAXZeV+5Ea+RIxlo1SN39qI9OmgPcd6z1kd6Tt/GoO/9hGofE2Kx
        PV6mplyhJcMXZNTcxXpfRNCq+84swvIJnYBdVi4=
X-Google-Smtp-Source: APXvYqyZuMhNvZLO03SFKww+l39sMzYk1knKADc4ujTFzLfyYfXnFkke7oOAFpZkY85+kyVH7hRIHL7Lix5ySpI1cTY=
X-Received: by 2002:a62:be08:: with SMTP id l8mr15258160pff.162.1552850327573;
 Sun, 17 Mar 2019 12:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190317124926.17137-1-pclouds@gmail.com>
 <20190317124926.17137-4-pclouds@gmail.com>
In-Reply-To: <20190317124926.17137-4-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 17 Mar 2019 20:18:35 +0100
Message-ID: <CAN0heSrWzU-2hgoU6oG12CwtQFH83Cgc8Eh7gXbXL3ZSQE_4vg@mail.gmail.com>
Subject: Re: [PATCH v4 03/26] doc: document --overwrite-ignore
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        Jacob Keller <jacob.keller@gmail.com>,
        phillip.wood123@gmail.com, rybak.a.v@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Mar 2019 at 13:49, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
>
> I added this option in git-checkout and git-merge in c1d7036b6b
> (checkout,merge: disallow overwriting ignored files with
> --no-overwrite-ignore - 2011-11-27) but did not remember to update
> documentation. This completes that commit.

> +--overwrite-ignore::
> +--no-overwrite-ignore::
> +       Silently overwrite ignored files when switching branches. This
> +       is the default behavior. Use `--no-overwrite-ignore` to abort
> +       the operation when the new branch contains ignored files.
> +
>  --recurse-submodules::
>  --no-recurse-submodules::
> -       Using --recurse-submodules will update the content of all initial=
ized
> +       Using `--recurse-submodules` will update the content of all initi=
alized
>         submodules according to the commit recorded in the superproject. =
If
>         local modifications in a submodule would be overwritten the check=
out
> -       will fail unless `-f` is used. If nothing (or --no-recurse-submod=
ules)
> +       will fail unless `-f` is used. If nothing (or `--no-recurse-submo=
dules`)
>         is used, the work trees of submodules will not be updated.
> -       Just like linkgit:git-submodule[1], this will detach the
> -       submodules HEAD.
> +       Just like linkgit:git-submodule[1], this will detach `HEAD` of th=
e
> +       submodule.

All of this `--recurse-submodules` stuff seems to have have ended
up in the wrong commit.


Martin
