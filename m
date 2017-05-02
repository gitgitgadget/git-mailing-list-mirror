Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF1F1F790
	for <e@80x24.org>; Tue,  2 May 2017 21:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdEBVQo (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 17:16:44 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36841 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdEBVQn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 17:16:43 -0400
Received: by mail-it0-f53.google.com with SMTP id o5so22979288ith.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AIoCFrpsYNz0BZbfgKzP7hIJkI6VPOEGWK1JchNAKbs=;
        b=bPdnC0G6ONQ0rgtxV01Qa4Ady2If4RQWd0qjazOb8jrxdjuhVNlYB1R5Iuh7ODQviH
         2xVZR090iaVyQRW7QtgGm2gyzHb6QPi9DdVAh7Ed5JF4YdEx1zS2h68WmsqtsZVTic0G
         fmZ/0CcEDrnv+3j4zp7kuHLt6t4v+dsNg1F94RIh9s/uJuF0KBcY+grz4wXjF8E/0etA
         +g125Nyxfr9G96Z7TXkEulj92sXYBBpkMgbtIWoIyEUNL156O7hAtPTQZwI/88hJUQci
         MTTnHfLnGxwCnkMpbXy1UYukMTqlnexneVTwB1S5FAQJmUbuE6mVHculjbMZ5WPjQ05E
         GMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AIoCFrpsYNz0BZbfgKzP7hIJkI6VPOEGWK1JchNAKbs=;
        b=BZYHO/tRnpM38MZhnTQQbmQDKaTB2TCqYhcb4lKqrjzr1FVi1YFOCxHkGpRjKb2Odu
         bCOtulI3QUnDRncRs/L/e8vaunA6ZnmiVywgoZKhdHyxwxTT14k8TV7Rqttnt3x4xtMY
         /vreksvD4YZVdwZnLnFg1JY+ell0exyiMbhYvnvfeemtieHJRxe7F05k0zmaItcXhGc/
         J/uyhtcYed4s6ogEKJ7VTYlBMlMqXxAvM2FtTpxiyqTp7l2AGTUS/QGOOcPQalzhBNkH
         oLwOiS9i88MhwO3H0NffZ/Khe5BdvoRhcHyVy89bqstCgTPiqb/9kqfAeOjzDtJP5y24
         e2Yg==
X-Gm-Message-State: AN3rC/5Qi70kZzKC846/PAWYSlFr9NaxRDDAmE+O7LRvGRqlDfjlts8y
        lp+65uXeTASMOXDymQsC/wqjbXh86g==
X-Received: by 10.36.26.87 with SMTP id 84mr13257272iti.94.1493759803028; Tue,
 02 May 2017 14:16:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 14:16:22 -0700 (PDT)
In-Reply-To: <20170502205138.GB17703@alpha.vpn.ikke.info>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox> <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <20170502205138.GB17703@alpha.vpn.ikke.info>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 23:16:22 +0200
Message-ID: <CACBZZX5ani4DLj4-63yZFPaJnWXquuFb+pXKvyHL61kja6YghA@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Kevin Daudt <me@ikke.info>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 10:51 PM, Kevin Daudt <me@ikke.info> wrote:
> On Tue, May 02, 2017 at 08:52:21PM +0200, =C4=98var Arnfj=C3=B6r=C5=A1 Bj=
armason wrote:
>>
>>  * Due to the bizarro existing semantics of the configure script noted
>> upthread if you have a git build script that does --with-libpcre & you
>> have libpcre1 installed, it'll link to it, but now since
>> --with-libpcre defaults to libpcre2 it'll silently skip linking to it
>> if you don't have it installed.
>>
>
> Case in point: The Archlinux git-git aur package[0] (community maintained=
,
> latest git version) does run ./configure without --with-libpcre, but
>  requests it from make with USE_LIBPCRE=3D1.
>
> I noticed when trying git grep -P which then failed.
>
> [0]: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=3Dgit-git

Whatever's going on there is unrelated to the issue I'm talking about,
but if that's producing a package where -P doesn't work that looks
like a bug in the Makefile.

The way --with-libpcre works now is that it second guesses you, i.e.
it'll put USE_LIBPCRE=3DYesPlease into config.mak.autogen (sourced by
the Makefile) only if you supply --with-libpcre *and* it can find a
working libpcre on the system, otherwise it silently ignores you.

Whatever you supply to the configure script it'll be overridden by
Makefile arguments if present, but even if there was another bug where
./configure arguments took precedence over Makefile arguments I don't
see how it would apply here, in this case nothing libpcre related will
be written to config.mak.autogen.

So I must be missing something. I don't see how that package build
doesn't either fail at compile time because it doesn't have pcre, or
work, in which case the -P option will work.
