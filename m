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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE65620248
	for <e@80x24.org>; Tue, 26 Feb 2019 02:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfBZCMZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 21:12:25 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43936 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfBZCMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 21:12:25 -0500
Received: by mail-qt1-f172.google.com with SMTP id y4so13137264qtc.10
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 18:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kjph4D+WbNq3xj8h88ZYhR/Srj/5se9UTpiC7KDPDyU=;
        b=YRoQmNUtnwh6z7GE+ZX2IlUZn4c3PwgeVE8j8g5ovoSwXc6mV+nEtQr1Eh0IhOpZPi
         +CdkVvsOje2N61sE4pMGZN1Mn72osf5WwDnj+oUKjNsYBNicQmPbtIWoMS6kwZFDisZa
         GnSHi1Dwr+I8HZI95GuzB8nR3i5K3yVrq22xN7w4yLPfYalPwyXZsy37bHauijcO9kAe
         dOpd3rm0YgoKyPQe1qqtln1FHrJNFJ7yLnjkNjOgDbHb/uyyEDO9YWUz4McLZ2F4KPvx
         Jv7rThchRlzFh/BIkg0E9qcaJ5X868WAUw9ugj2gk+7p+MwPai12bzHA/yoEvAusLlrc
         6xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kjph4D+WbNq3xj8h88ZYhR/Srj/5se9UTpiC7KDPDyU=;
        b=f5BrmdrWPlAhHXaMj5X4EICVwx52ZvJ28wUGywPz8AIm/96CTDmbpJ/YkOC/cf8eWa
         1BJ2bfDuMMlhI9cu7X4ea0r7zwl3bb4QQCfU29WAf59Y7UHokQ3h8Y+PbC8tCRKxOOuh
         VLbcm4fJhsojxHrW8O1s0feFJoiPB2tJKHt6spPiAc9UxLDX4iP+lwqNFRMNs3YsYICC
         mrxa+EUskTwmOxH7uDSaKo59X+qLKKsG6akncNMLpUDG6eDZlD5pBjqmcNf+qnTJ7qhr
         yvvoh2nfE5OVzY6WIAJJ5QdzyKlYItEg3o5ljebjznhGu0o+ySOXScC6VUJJ01rt/Tla
         dX1g==
X-Gm-Message-State: AHQUAuY1x2wfWpwdVtxPNzzJ5UvXP+26ORCriDUXHAPAtmxinreSqsc+
        l6IMCZmhebmFIA7gyYDreNqZc+d+GXAjtikLQDQ=
X-Google-Smtp-Source: AHgI3IZcSvW4e8FjOfm2KqPZOCbOQpvP47Iuq6aT7A+hXHpw9eLCCS+P7tS/6tlRKIiC0rKbHht9p0KGZCEMg+WFbso=
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr16385711qvq.106.1551147144341;
 Mon, 25 Feb 2019 18:12:24 -0800 (PST)
MIME-Version: 1.0
References: <874l8rwrh2.fsf@evledraar.gmail.com> <2933589.YIuU4JMJIj@cayenne>
In-Reply-To: <2933589.YIuU4JMJIj@cayenne>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 26 Feb 2019 10:12:13 +0800
Message-ID: <CANYiYbF_6U6x7fCV6LNt_c8yc9mF0PhwdqXdQNHB9eP5onDUKw@mail.gmail.com>
Subject: Re: Compile error due to po/fr.po on old gettext in v2.21.0
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> =E4=BA=8E2019=E5=B9=B42=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:54=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Monday, 25 February 2019 21:19:53 CET =C3=86var Arnfj=C3=B6r=C3=B0 Bja=
rmason wrote:
> > On a NetBSD test box I have with msgfmt 0.14.4 v2.21.0 fails to compile=
.
> >
> > I didn't spot this in rc2 because b3225a4183 ("l10n: fr.po v2.21.0 rnd
> > 2", 2019-02-13) along with the rest of i18n updates gets pulled in afte=
r
> > all the RCs.
> >
> > I.e. this is because of the comments being parsed (fuzzy comments).
> >
> > The 0.14.4 gettext release was back in 2005, so presumably this is due
> > to some GPLv3 allergy of NetBSD's. The OS version itself is 7.1,
> > released a couple of years ago.
> >

gettext (version below 0.16) doesn't work well with the special format
in `po/fr.po`. I will update the validation script to check for this
issue for future l10n updates.

    $ LC_ALL=3DC PATH=3D/opt/gettext/0.15/bin/:$PATH po-helper.sh check
    ------------------------------------------------------------
    bg.po     : 4363 translated messages.
    ca.po     : 3450 translated messages, 417 fuzzy translations, 318
untranslated messages.
    de.po     : 4363 translated messages.
    el.po     : 1038 translated messages, 3325 untranslated messages.
    es.po     : 4363 translated messages.
    fr.po     : po/fr.po:22482:4: parse error
    po/fr.po:22482: missing `msgstr' section
    po/fr.po:22487:4: parse error
    po/fr.po:22487: missing `msgstr' section
    po/fr.po:22492:4: parse error
    po/fr.po:22492: missing `msgstr' section
    po/fr.po:22497:4: parse error
    po/fr.po:22497: missing `msgstr' section
    po/fr.po:22502:4: parse error
    po/fr.po:22502: missing `msgstr' section
    po/fr.po:22507:4: parse error
    po/fr.po:22507: missing `msgstr' section
    po/fr.po:22512:4: parse error
    po/fr.po:22512: missing `msgstr' section
    po/fr.po:22517:4: parse error
    po/fr.po:22517: missing `msgstr' section
    po/fr.po:22522:4: parse error
    po/fr.po:22522: missing `msgstr' section
    po/fr.po:22527:4: parse error
    po/fr.po:22527: missing `msgstr' section
    msgfmt: too many errors, aborting
    is.po     : 14 translated messages.
    it.po     : 2347 translated messages, 583 fuzzy translations, 1433
untranslated messages.
    ko.po     : 3608 translated messages.
    pt_PT.po  : 3198 translated messages.
    ru.po     : 3366 translated messages, 594 untranslated messages.
    sv.po     : 4363 translated messages.
    vi.po     : 4187 translated messages.
    zh_CN.po  : 4363 translated messages.
    ------------------------------------------------------------

>
> I kept the commented entries as a translation memory, even when they are
> fuzzy.
>
> Would unfuzzying these entries resolve the issue?
>
It's not caused by the fuzzy directions in comments (e.g. line 22481),
but because of the duplicated msgid in line 22482. Removing line 22482
will fix this issue.

    22481 #, fuzzy
    22482 #~| msgid "git archive [<options>] <tree-ish> [<path>...]"
    22483 #~ msgid "git diff --no-index [<options>] <path> <path>"
    22484 #~ msgstr "git archive [<options>] <arbre ou apparent=C3=A9> [<ch=
emin>...]"
