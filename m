Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042DF20281
	for <e@80x24.org>; Thu,  5 Oct 2017 17:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdJER2G (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 13:28:06 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:43950 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdJER2E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 13:28:04 -0400
Received: by mail-qk0-f175.google.com with SMTP id w134so15491065qkb.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GlaYI1uMfG5+FuTVRaiPLMtC4+Gxb84vEwiiI2qpRZU=;
        b=uXCt5XZQtMmwWT5dVzAmWf1reVX/xE4pKfuKPr3H/+rS0si7UDsng/ydVqli2f2QZS
         O/Zd6X6Wd+DhEsYYWAMkm/5U+olvzu8rp3RPFzE2/fN3esF2UhCkyompUhKoDX5VtxBO
         WpLE5bFedeFgC8PSAs5cUG+DIzA5GkLGqI2K+XIqnuqRdK4ipdsvsibQu9gv/pSH+BAJ
         UZ+gXRsQdMy02Hh733H27m66Qm0PP+xgbYdWb79CbhEneJr/VLN/W2lZ3RXAQplKF4Qb
         Rej3kqN/sulRJy1qNScjSXDz0vzNck2oG6C48xHhhCoUmbVlEcCKSL1u5++mD5smmp9c
         LNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GlaYI1uMfG5+FuTVRaiPLMtC4+Gxb84vEwiiI2qpRZU=;
        b=h5MXytW2IeosnZ+2g3oTXqWWYcX+g7hiR8gsaTTzHQjYor0uxt86/69RxTFOnNgWCJ
         3/nI0/0eER9uRvy1RzrarEDTkOYnmuKD0jb+2zPYWXz70fZg0JH+ANmKSUotfyfNOC9y
         hSE4qqKutotOUvK9TaAzAqIbvamnup48fxFPoMUmONPtGDFL5CRfqaIA4hHtm6gmjie+
         DVSbiQ6vKNtDXdU0bL97C+H42jVTMxjaLIl486TCgFkgG4nAPWjI+8X2C0aF1iPtp0BA
         Uzejthcdsx4t/BOjOy7fJLmGv8YoBMX+JXwaGyVc0K6hknstooFLBlG1V0BJ+srlT4O+
         Xh1Q==
X-Gm-Message-State: AMCzsaWQurOQ97ezyLyNFhS0jm6WzhOVbUSsmy8Pfhzw0Pv9lBIaT7XT
        sFB7ubf/7jvX7iT/EynU8mtyXmsvjggqiYu8HLsRQQ==
X-Google-Smtp-Source: AOwi7QD+KxXROLRBtK6jXdf+KGWKR9OpVG/5DkRn/0DCzEHs15orscMDZS8PwCEd7F6Fm1drwmfKQkCYgZIke+remfs=
X-Received: by 10.55.127.7 with SMTP id a7mr32231509qkd.45.1507224483893; Thu,
 05 Oct 2017 10:28:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 5 Oct 2017 10:28:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710051509360.40514@virtualbox>
References: <xmqq7ewa87fw.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710051509360.40514@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Oct 2017 10:28:03 -0700
Message-ID: <CAGZ79kb67Up1uosWrC18idLDz1rv5hU16yA5QSZfxU9zg4-iZA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.15.0-rc0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        knittl89@googlemail.com,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        tigerkid001@gmail.com, vi0oss <vi0oss@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Rene
- kernel mailing list

On Thu, Oct 5, 2017 at 6:10 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Thu, 5 Oct 2017, Junio C Hamano wrote:
>
>> New contributors whose contributions weren't in v2.14.0 are as follows.
>> Welcome to the Git development community!
>>
>>   Ann T Ropea, Daniel Watkins, Dimitrios Christidis, Eric Rannaud,
>>   Evan Zacks, Hielke Christian Braun, Ian Campbell, Ilya Kantor,
>>   Jameson Miller, Job Snijders, Joel Teichroeb, joernchen,
>>   =C5=81ukasz Gryglicki, Manav Rathi, Martin =C3=85gren, Michael Forney,
>>   Patryk Obara, Rene Scharfe, Ross Kabus, and Urs Thuermann.
>                   ^^^^^^^^^^^^
>
> I think we need a .mailmap entry there... I guess the difference is the =
=C3=A9
> vs e.
>
> Ciao,
> Dscho

Using the snippets from 94b410bba8 (.mailmap: Map email addresses
to names, 2013-07-12), I cc'd more people.

# Finding out duplicates by comparing email addresses:
git shortlog -sne |awk '{ print $NF }' |sort |uniq -d
 <jn.avila@free.fr>
 <knittl89@googlemail.com>
 <l.s.r@web.de>
 <matthias.ruester@gmail.com>
 <tigerkid001@gmail.com>
 <vi0oss@gmail.com>

Looking for duplicate names yields a lot of people, too:

# Finding out duplicates by comparing names:
git shortlog -sne |awk '{ NF--; $1=3D""; print }' |sort |uniq -d
 Adam Simpkins
 Alex Riesen
 Andreas Ericsson
 Andreas Schwab
 anonymous
 Avery Pennarun
 Beat Bolli
 Benoit Person
 Brian Gernhardt
 Carlos Mart=C3=ADn Nieto
 Charles Bailey
 Clemens Buchacher
 Daniel Knittl-Frank
 David Barr
 David Turner
 Dotan Barak
 Edward Thomson
 Gr=C3=A9goire Paris
 Hartmut Henkel
 Jacob Keller
 Jason McMullan
 Jean-Noel Avila
 Jean-No=C3=ABl AVILA
 Jiang Xin
 Joachim Jablon
 Joey Hess
 Jonathon Mah
 Kacper Kornet
 Kirill A. Shutemov
 Kirill Smelkov
 Kristian H=C3=B8gsberg
 Lars Schneider
 Lukas Fleischer
 Marius Storm-Olsen
 Martin Koegler
 Martin Langhoff
 Matthieu Moy
 Michael Coleman
 Mike Ralphson
 Nick Alcock
 Nicolas Morey-Chaisemartin
 Olaf Hering
 Orgad Shaneh
 Paolo Bonzini
 Patrick Welche
 Paul Mackerras
 Raman Gupta
 Ray Chen
 Roberto Tyley
 Sam Hocevar
 Sven Strickroth
 Thorsten Glaser
 Tom G. Christensen
 Vitaly "_Vi" Shukela
 William Duclot
 =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2
