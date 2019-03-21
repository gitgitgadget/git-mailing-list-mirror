Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1334A20248
	for <e@80x24.org>; Thu, 21 Mar 2019 11:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfCULOq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 07:14:46 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:38124 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCULOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 07:14:46 -0400
Received: by mail-it1-f180.google.com with SMTP id m18so3490930ita.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/hI2riPFVngyvvYuFcf/bFw92/GGghDuZ0YTtmWbcvY=;
        b=htVYrKTvL9im4vuQbfzLXv63Vo0e2DIakR30Qzam+ivDz08oCpjyhtTy7G8UedEdFy
         tvBdlchr0G4xo0eYB8+vh5WmPoVrxOUHun0+l5W4+aELKurrSl4jEVJzQ66w3Rv3Fkt9
         3nE5KfgYSXxp5Vxw8ah7rXxcmv6OkIL75UOklkbaacDv63H77iYfYCjxnjvrWBhgdBUE
         SJqSCwRxquOB0kdFNjdtKOfwRkev4Ixsq+IzjW7BuOscpwlRm+Mct2Z5fseGuY2O/QMW
         nZPGxvSzSPiaAlYuxyTmkcwhqjhuQMmmB6FDV5vg4imZzpCZR17ai0LQpvKwHzFSBpPF
         Zn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/hI2riPFVngyvvYuFcf/bFw92/GGghDuZ0YTtmWbcvY=;
        b=AuwOsJdfcna0+jE147PsTZ2XboFlqsDJV0JNzO6Ptpi3O85FDYzmYSgxd8XdkFGwWl
         iIlG5sOCyp7OO5o/UC/wu/SCuz4RXdtCWzsLYLjufJaNiPb8J0vxKH8CtBXFWrUOCR7H
         V91WkGQ7IkWVXLWdivn+1cFZhF3YgbuEfdSYdeIdAZRKtbJPY8+jhmnWynw6SlFbAMui
         6sT12UjXGbTfX98Sf/VRpKlkm/CSwUjugtc2yIBJuAQBjmbiCQGHtzFTvCTHtXeYUEmT
         3nOvqORO0Kho8XCo71wKlg0cXufekP2yjvA9ZG+luHGYIHHtkcUD5M6ywW87Jk+pWPx3
         uDQQ==
X-Gm-Message-State: APjAAAVLmPMZvq7/zuChJ/n6blud7PKUQ/Ee3UJ9mOfyPHxb4ILaA6HO
        r+qBt1lo59Nb40xexNn6GWpC0ypzFzWw/nG+Eyg=
X-Google-Smtp-Source: APXvYqxdmDC4n1kU9vENhVv80W2wia1kumurLC2s3QF+fsdikByPQ/VwlZsv/otdxVl0CrOGoNaekOYHKn/ig9RqrEY=
X-Received: by 2002:a24:7542:: with SMTP id y63mr2242593itc.70.1553166885139;
 Thu, 21 Mar 2019 04:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com> <871s31dv6o.fsf@evledraar.gmail.com>
 <xmqqef71uk8t.fsf@gitster-ct.c.googlers.com> <xmqqpnqkst2e.fsf@gitster-ct.c.googlers.com>
 <87va0cd1zp.fsf@evledraar.gmail.com> <xmqq7ecssgpc.fsf@gitster-ct.c.googlers.com>
 <87sgvgcy3o.fsf@evledraar.gmail.com>
In-Reply-To: <87sgvgcy3o.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Mar 2019 18:14:18 +0700
Message-ID: <CACsJy8DgNzGK3g2P7ZyRmd7sbiSOXY07KqYEh-gSsPkEZ+D5Qw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 5:37 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index b2f64790aa..28b5b599ee 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -155,14 +155,8 @@ struct commit_graph *parse_commit_graph(void *graph_=
map, int fd,
>
>         graph_version =3D *(unsigned char*)(data + 4);
>         if (!graph_version || graph_version > 2) {
> -               error(_("unsupported commit-graph version %X"), graph_ver=
sion);
> -               return NULL;
> -       }
> -
> -       hash_version =3D *(unsigned char*)(data + 5);
> -       if (hash_version !=3D oid_version()) {
> -               error(_("commit-graph hash version %X does not match vers=
ion %X"),
> -                     hash_version, oid_version());
> +               error(_("commit-graph the graph version %X is unsupported=
"),

Slightly off-topic, but it does not seem to be a good idea to use %X
here, on a user-visible message, without any indication that it's a
hexadecimal number. %d would do, or just put 0x%X.

> +                       graph_version);
>                 return NULL;
>         }
>
> @@ -172,7 +166,7 @@ struct commit_graph *parse_commit_graph(void *graph_m=
ap, int fd,
>         case 1:
>                 hash_version =3D *(unsigned char*)(data + 5);
>                 if (hash_version !=3D oid_version()) {
> -                       error(_("hash version %X does not match version %=
X"),
> +                       error(_("commit-graph hash version %X does not ma=
tch version %X"),
>                               hash_version, oid_version());
>                         return NULL;
>                 }



--=20
Duy
