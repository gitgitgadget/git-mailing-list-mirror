Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB23E20248
	for <e@80x24.org>; Wed, 27 Feb 2019 03:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfB0DpS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 22:45:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46018 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfB0DpL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 22:45:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id v139so9023589qkb.12
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 19:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CDXXktL5+qIFhvpnsT+Ou94HdMZyLM0FGUJ9ofdoRPg=;
        b=MCoo/KjKSmqHhj6crz/MQ94RAf1AMkKTM+tKVfjNhQceupSsnMLo4utndllgBd6Vg1
         PpYmfrPZWqEqPuF7yT+oFyk7I1xovTx4Ps/LfLQQZlvan+kZ61BZsVUAX4RdgtD3NE1M
         nat+i0xi1W8OcuydeftIAlGe2gHm2C6bPd0gdKq0eP0pVcrxMex4YjruFT8ahKACaON5
         jP+nqos10dWx6I0K1N7KYyLwB125NQjExDNExXLgc0CEkUKcnXNwOdH7qRfYl/U4hAXr
         YjZ/t5CTVYopiu/CKZORyAD1zxBsZsDHoniILANJd5i+0VTb4TiujspOFF74sgPm73YB
         OV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CDXXktL5+qIFhvpnsT+Ou94HdMZyLM0FGUJ9ofdoRPg=;
        b=C26IZuX+AGEn3BI0DwgsmnNI54OCl/OSdYr4cm0tlPQUlPshJEPBpdn3A1RKX3YxiF
         W3/iCt3BChgk1+YgyXqQAFczwjAF2A5soNev4uwAf3ArSZew86vHj+W4McY81DG9Fjef
         X60KV/0ngsArd5J+tFvS+cvGYd0YVZeALishHrA1NmxCLBvT8pG5g38yOLuG1cHm+GGX
         iZwGJ4SUXnbUKpqO4tBZwE8uJSJstrR2p1KqlBVuT9UyV2HKVHqaL84ooeLQ3n0qsJCQ
         qlB5d+2QQ+kQsOocenv6Qpxh2NUI69gNo99iQ08R/bWdgV2AJS1nezxxn0BsU7VrOsuK
         182w==
X-Gm-Message-State: AHQUAuZwhQheGmWEnhXh7fed6YhV/3bQMHjBeNrWdbe8YyziJkiuuViz
        Uuz7RRprw+Cvs8EfWFMwwcWiWRUWd5KUepet2SAsJ3KQ
X-Google-Smtp-Source: AHgI3IZw/EyUvboaoLYSwz3aQTB12RqY6F2fX+iSY2SGbGNNj2KABBieGUTT3ThhS+1CMp34NWc1JJZEPsxpXOC1yLY=
X-Received: by 2002:a37:7707:: with SMTP id s7mr669297qkc.252.1551239110251;
 Tue, 26 Feb 2019 19:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20190225211453.28300-1-jn.avila@free.fr> <20190226205430.15920-1-jn.avila@free.fr>
In-Reply-To: <20190226205430.15920-1-jn.avila@free.fr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 27 Feb 2019 11:44:59 +0800
Message-ID: <CANYiYbGWK5NO4iy+jJcL17yQTkmz9=JJT10Yr5QGOwHS_C9G-w@mail.gmail.com>
Subject: Re: [PATCH v2] l10n: fr.po remove obsolete entries
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Tran Ngoc Quan <vnwildman@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> =E4=BA=8E2019=E5=B9=B42=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:56=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On NetBSD, the version of msgfmt is still 0.14.4. There's no hope for
> an upgrade due to some GPLv3 allergy of NetBSD's. This version chokes
> on heavily decorated commented entries in po files. It's safer to get
> rid of all these obsolete entries.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  po/fr.po | 1500 ------------------------------------------------------
>  1 file changed, 1500 deletions(-)
>
> diff --git a/po/fr.po b/po/fr.po
> index 7b15b76374..0e084f5a49 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -22474,1503 +22474,3 @@ msgstr "%s saut=C3=A9 avec un suffix de sauveg=
arde '%s'.\n"
>  #, perl-format
>  msgid "Do you really want to send %s? [y|N]: "
>  msgstr "Souhaitez-vous r=C3=A9ellement envoyer %s ?[y|N] : "
> -
> -#~ msgid "--reschedule-failed-exec requires an interactive rebase"
> -#~ msgstr "--reschedule-failed-exec requiert un rebasage interactif"
> -
> -#, fuzzy
> -#~| msgid "git archive [<options>] <tree-ish> [<path>...]"
> -#~ msgid "git diff --no-index [<options>] <path> <path>"
> -#~ msgstr "git archive [<options>] <arbre ou apparent=C3=A9> [<chemin>..=
.]"

The pull request sent by Tran this morning has the same issue, see:
https://github.com/git-l10n/git-po/pull/357.

@Jean-No=C3=ABl, you can send pull request to me to the "git-l10n/git-po"
repo on Github, I will send a pull requst to Junio when he is back
last week.
