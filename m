Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5B11F453
	for <e@80x24.org>; Tue, 30 Apr 2019 01:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfD3BCd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 21:02:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:49667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfD3BCd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 21:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556586146;
        bh=H11BXwE/0STlBWVigGAr4mDn7Xws3u56axhC43sbheA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Lwd5do0+TuqCEtr99hGh97Pk1P9UJ6iMspGolF8darorDKBkTRUbaxDmlp1NIeVnK
         fkx7X68y5AhunzKodicV0SMfshzDyz8y23YNOTtVQ5fRteHMP33ZxqHIAwZIi3KJIz
         opFc+kyDiC4Hcw8qnSeLn8/BBvcHr/9i82KvOeaw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1hDweA49E3-00TTKB; Tue, 30
 Apr 2019 03:02:26 +0200
Date:   Mon, 29 Apr 2019 21:02:28 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 19/20] diff --no-index: use parse_options() instead
 of diff_opt_parse()
In-Reply-To: <20190324082014.2041-20-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904292055300.45@tvgsbejvaqbjf.bet>
References: <20190320114703.18659-1-pclouds@gmail.com> <20190324082014.2041-1-pclouds@gmail.com> <20190324082014.2041-20-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1637733259-1556586151=:45"
X-Provags-ID: V03:K1:ZVGX6tev1PXx500aYDydzFQ5YJ3Zde9JfyIFuqTNvC2wG6m4/7J
 mTFbG+aYWj0CYTyc8FKEfpvbr/gzdTudAGa5vcTlmXFKbX356lL9oubbeLoMDa1CuqoJKBy
 CCr3dQ0WSt5cAoIqM6ji/qUVL5F8fzefGag9N5ETBRzQD4MachsnCLJXpCPP/nqlB6gOvAK
 d6yjtSH7VbJf3TZOBelMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:INCobmJilJw=:MrKdSJZKlCFLPXJ1027ou+
 6id7x9ys7edseaB0hQ1aFbRVkfhf7FYS3iuvT8zhRCHF5KQmHXqKWKfpxC9n53dkknF4AYkKD
 VZpf/6MJcdTXlbB7kqXTGn795aPeJRCkDO5/X//vJDZMvw/ii320Qatt2twvh4OXaQgB2oa8E
 dKIjnBa52srgkjYmdWg3Uhx02yXvIWNmL6KrDt5pwygbbRS8+mkjReV2n8aT9gUwPCxINvZEu
 2J5ZPnzPW2yOp1wdYhruP6FyiEj9ZfIX6Sj4ve6Vnftmm87WGU5GA6dUZUCDkIKjTZrgnUcle
 nXsmRlw8jqcCCrseS8bddWk788xCRrIIZMqw5MbpRvsLYyFMtYpjZeOmErfMdF0RI1CbUg4eB
 N7d/TBlU7Txk89bNXAGFEislJBz7IM/qwTsA7DceVpBkk8MM2Y4OoYhpWh4ee7tSYkXfgSmGD
 oYS8mAvJnw+r2x18kdLPaNTzNMC0TQ0XcrHSZf2D81jz45XJhi+p+bplI85a+Qao7TNHC9fvE
 sPBF3DEu2V/SK65IT/vtF8izj+6GFMqqEZ8Q6C37q0pdnywd03VeRvI/URTKcg1uojZsMXuhc
 VoYBBY795uT2bub/rGTMvt0Zsa9w8dm0QoSAcdLE2442Br2G+QT7XWFV/vSOMpkJ/vhKZxuQ4
 AM+LIOOo2SnEfKqh1LEMMkkKbLQwBH74bd+2FyxhpD3+h6EtSZ/kVyK9mxri+kmwDHiy9pqvo
 MczSx03w17xe0Qj0s/iYKLbfFQ5LLs05NjRDZ09ypKTVsvAzLrvPx5x8G6JcQBoFGskAbWILq
 n3Vu/0nHr0VU8drTBQcnhCYRRHM+PQFI0qk3l9VECjGn3/lflbwM6UIsUYouDPQVl3ZV6JqFW
 /SE72RbW+LU7iwanoyl/ruEIGORXUZXCGAbtVgUjVKy+u/k85MYnxVXya2SRDz5d9be8Bwo8Z
 BcfpTQTIyYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1637733259-1556586151=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Sun, 24 Mar 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> While at there, move exit() back to the caller. It's easier to see the
> flow that way than burying it in diff-no-index.c

I just noticed that this commit message is missing more than just a
trailing period. It does not explain the change of behavior: previously,
`GIT_EXTERNAL_DIFF=3Dheya git diff --no-index a b` would silently ignore t=
he
external diff, it would have required an explicit `--ext-diff` to pick it
up.

After this change, it is necessary to pass `--no-ext-diff` to reinstate
the original behavior.

While this might seem like a desirable change, it is a
backwards-incompatible change and would do with a *lot* more of a message
to users whose scripts now potentially break.

Ciao,
Johannes

--8323328-1637733259-1556586151=:45--
