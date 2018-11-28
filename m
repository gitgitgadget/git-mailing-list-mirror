Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2531F609
	for <e@80x24.org>; Wed, 28 Nov 2018 20:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbeK2HkZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 02:40:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39370 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeK2HkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 02:40:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so10738625pfc.6
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 12:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lgv5HAr2ptIo+XZIX0x2gtUE/S5O7iFcvBK5Jd5FeM8=;
        b=AQBxW/JWjMxJRvQ4MtYRyvcyfZ0/WCcCpjhlpd4yjZFWntoEQKgSHwDWedLOrNNi2Y
         btcPkT9Lki2OhQdxFsKYex1UCfPr3hvAd1QDZQ3wNBAYRYYLfRblSBuFnzk/oCG1giAn
         NDBG+nCk8wnBDJj5WSbGtAHl0laCukLXMPkoCINSzMBoXZorrVk5OIMC3XG9/xGgeAg+
         F/0lJCUHdbIn+i8KwOS1epUpdmYeXZabjSolsxn7knDcnQcFqeKwU0jWJtrSC0IXIlNk
         KNTFnVaLFT1doA2t4NxInIweMLmw21eeW+iWInfyJiiUczwywcHvgd/Qk23SD3cRl+ug
         R+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lgv5HAr2ptIo+XZIX0x2gtUE/S5O7iFcvBK5Jd5FeM8=;
        b=def+E/i/1pbEFtFC+vHFBrjRnTkxjewIk3+7X0zhVimpBGxfJcE+4yxkdjMGjAyyLj
         ZDu0CT9RgiS1h+RXg0QhQ9Uk9WFq2dZHDvNGa4cYmxtcz39P+snX+RHVtqpX6ag3UVAl
         BMTK3uzqLQmZTzCRw30XjxsRojwJ/DmH6iByy1V7GJ4XiI6v1mEtlSCfCEMOrB+a2IAT
         A1puQ09vVjRNLncaqxm4aQpIIzTBZQYxX8ST/e2DDZMOZqsHCCIfYuAWfovwzgk5rF0A
         HtvC5Ng16skQ10WXHU0cZYBg+O7xwXF31O4N04AZaHghRXKq2sBC/0YXsiJOnZftoErd
         yE5g==
X-Gm-Message-State: AGRZ1gLvSz5TLPuyFIpFD5bJB6Okbk5k3dT4303BBjuIhfa9WRN91jzo
        ZJdGB3zTSQxP5/B7ofBT+/LxS+Nx8pzK/Mzqa3M=
X-Google-Smtp-Source: AJdET5ds3YhKxhgj7C7WhU80gDcCgFzgtNJvnNylp2cJHu5ci9P3MB4hugVF0rNpt+SAoWn9jkE4XGd+I19lqO8Ac+o=
X-Received: by 2002:a62:75d1:: with SMTP id q200mr38970341pfc.254.1543437451218;
 Wed, 28 Nov 2018 12:37:31 -0800 (PST)
MIME-Version: 1.0
References: <CAN0heSph-a08AzsihqqxfC=nqmUQLsqx-rKGULXQ-gmT4+c10w@mail.gmail.com>
 <cover.1543429054.git.martin.agren@gmail.com> <1596a9ff9fa6849f53590de1b15eb18ee6b41e4d.1543429054.git.martin.agren@gmail.com>
 <877egxyojp.fsf@evledraar.gmail.com>
In-Reply-To: <877egxyojp.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Nov 2018 21:37:19 +0100
Message-ID: <CAN0heSob+Ac4BvM-vuKvPZKxrTW53-d91a55NX5kC7ZyNXntWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-reset.txt: render tables correctly under Asciidoctor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Samoraj?= <samoraj.pawel@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Nov 2018 at 20:45, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
> On Wed, Nov 28 2018, Martin =C3=85gren wrote:
>
> > Asciidoctor removes the indentation of each line in these tables, so th=
e
> > last lines of each table have a completely broken alignment.
>
> Earlier I was trying to get the Documentation/doc-diff script to diff
> the asciidoc and asciidoctor docs without much success (hadn't used it
> before, just hacking the Makefile to turn on asciidoctor yielded syntax
> errors or something).
>
> Is something like that a thing we could make into a regression test?

Interesting idea. I just tried a gross hack:

 * Use `make --always-make ... install-man` in doc-diff.
 * ./doc-diff -f HEAD HEAD # note -f
 * Add empty commit and tweak config.mak
 * ./doc-diff HEAD^ HEAD # note no -f

There are lots of irrelevant differences in the headers and footers,
which is a bit unfortunate.

Also, lots of annoying differences originating in Asciidoctor's
inclination to render a space after linkgit:foo . There are those
differences themselves, obviously, but also follow-on differences such
as entire paragraphs that wrap differently.

I could spot a few things that should be fixable on our side, but on a
quick skimming, I didn't spot too many "huge" differences, which feels
good. The one which this patch fixes, obviously, and there's some work
to do in git-status.txt and git-column.txt (at least).

Tacking on `--stat` to the call to `git diff --no-index` singles out
git-config.txt, but it seems like lots of small or maybe even irrelevant
differences, plus lots of spaces around linkgit: , as already mentioned.

Martin
