Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25E120966
	for <e@80x24.org>; Wed,  5 Apr 2017 12:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbdDEM5n (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 08:57:43 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33572 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbdDEM5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 08:57:11 -0400
Received: by mail-oi0-f45.google.com with SMTP id b187so13866599oif.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0CaHnRuvxkpy0shk2IvbTbOdRPW8L2scFiLB/iAgJRs=;
        b=aWNXe00eH6FoLLqI0XLkCCkKbT/W27befGVDF5QUsS+LiuisIBP0N3MGMvokPREHTg
         gYlfZYFqEweVKN6xv4lDlbKtfCAomWLr4hKL0UkbgYHchNiBZOwV5mziMtkMrIO4iGAl
         UdutFXYH/UNHidk0vBbiIG90NF+RZ/SHwazzhoR8fpJiLMRtn6As9Cl+3/5JPezLls31
         MBMs1a3gL1wwGFvYz1g4pHTjCBA5Tz8UQNTLexqfwixXobGblS/qCQEacp+OwMGB0Xqx
         GB3TiQ74EixWF4ucrb8YbLBPXbWyG2Hpj0ywLZltTuMX1oCVnpcCoXoJ1Qg2HdsH4B9B
         Viqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0CaHnRuvxkpy0shk2IvbTbOdRPW8L2scFiLB/iAgJRs=;
        b=Q4W+p3UBZHjk/x2NpOV0wWExpHmHmf7Z65BT/ZkbTTIzHcixlAAbIiCIRGfO07MSs6
         /nvMOBXghczN94JiVCGUTpl6X54lB6NHkQxk8hAqA0zVAAaY520/rFMf7r1udENVVhB2
         0C2+saM3Hp2nVndvkhzpgMmaBEOS+S1gFhEdxXWW2y/6R0gFjvuC/zP+6lznI3xyujVH
         TawswB8IVTrhdDZ/KsdcwjJfXMjNg8URU3pZgAoGqA9EY7z6fskxw7SxadzpxXxTmPw2
         ZaZZGK1Q+Q2knOtiXA8Bs0/Lvc+Xyb/REDQc9PEB/miBE4QhCRCzNtCEin2FZvGyvLfz
         q/6A==
X-Gm-Message-State: AFeK/H1LD/nxLkA+daUTOElKFuB0lAYrMFZ7i1Alu+nEk8AV+hM8xC9wyGWPQB5b9YsHZmuIMGezj5lotqNVkQ==
X-Received: by 10.157.46.10 with SMTP id q10mr16894955otb.28.1491397030718;
 Wed, 05 Apr 2017 05:57:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 5 Apr 2017 05:56:40 -0700 (PDT)
In-Reply-To: <20170403211644.26814-1-avarab@gmail.com>
References: <20170403211644.26814-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Apr 2017 19:56:40 +0700
Message-ID: <CACsJy8AQjBZcpPCUNMhVNo33C4PCeFMbJhg31LfYEH+wA27ntw@mail.gmail.com>
Subject: Re: [PATCH/RFC] gitperformance: add new documentation about git
 performance tuning
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 4:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Things I have on my TODO list:

Always keep cache-tree valid. I think there's some changes in "git
checkout" to rebuild cache-tree often, so it's probably not as bad as
before. I don't know if there's a command to manually repair
cache-tree after it's damaged too much (or even better, attempt to
repair cache-tree automatically once damages go over a limit, similar
to how you automatically split index).

> +git status
> +~~~~~~~~~~
> +
> +Running "git status" requires traversing the working tree & comparing
> +it with the index. Several configuration options can help with its
> +performance, with some trade-offs.

Another option, if you know you only make changes in one (preferably
deep) subdirectory and your whole worktree is very large, then you
could do something like "git status .". This speeds git-status up a
bit because it won't need to look outside (or speeds up a lot if
"outside" is very large). The con is, changes outside "." will not be
seen.
--=20
Duy
