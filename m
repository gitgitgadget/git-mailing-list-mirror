Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C891FDEA
	for <e@80x24.org>; Tue,  9 May 2017 14:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbdEIOIN (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 10:08:13 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34952 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbdEIOIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 10:08:12 -0400
Received: by mail-qt0-f181.google.com with SMTP id n4so1508911qte.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=WrObQmZxnKW2Him7UStIdYQ2afNCE4vy5RYIovULQb0=;
        b=jX7qVSEIvLiKzfT5SovzlG4kl00ovdxzqHVkafkDBDQg1iZLwNoeTGNESEIAU55Fzi
         PQKi4DacKETCatN/pyWxLow3JfjLxWZ4LQwEmwcNkTAkGS5uuaIKWaGOk9JAMKTl9iBb
         xRnGU14LzETGaPqU7VwPn9v2tQJGzRb6qIXM30zMQgVZVyhdG6/EZdIpS2HT3drx4Pn6
         FZ+ntHCsCjGN/DhjWp/AlkSNgxaKr0HSxooECg2G2MOB2gHFhlSzu1kcT3EUUrhOxZyn
         VDSL++494vqwyzkSXogpxi+9/7T8VV7IEqozSxdvWcvFl+d94eidepQSHOskzjF2+aJV
         0SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=WrObQmZxnKW2Him7UStIdYQ2afNCE4vy5RYIovULQb0=;
        b=AKTsViGP4/OgsVFpW5YgL12LW8fMu3Y1VtjtTqHjmVI5H1HDe9J3a7G1aciTP3GKO5
         2gbkum25jTp3JMSC4mAh/mVF9dKpXLxzuPPDxdKwxSd/XrGqf9AkgGRHtMyziGa79ycN
         iPDgOSO6z2CuxP2J1ieX2nBojM0+2zne4nWDHy9EZXYlu1xFyezwxdlDrU9EbfC+H6R8
         X2uDtsjwT056O8IMGNYahEOTBYtuVZEyH8YZTsB5Q0ggu1kzQDU0cnUYtTOr1tdIP9VR
         rtqVBSRE/w1bAme7hLyVc77C8LPNc3avkjmdoKp/6fckv6/gvUT5nkEL3arl+RlKNxPn
         6Xyg==
X-Gm-Message-State: AODbwcD/y2g0UybC4wBwJhu+HmFa0UPJhI2xqawJqGc8cHfPLk6APYhB
        4gMIMxinYUOnQPDx/ay6SgYaT7YdJw==
X-Received: by 10.200.36.66 with SMTP id d2mr299725qtd.9.1494338891788; Tue,
 09 May 2017 07:08:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.148.186 with HTTP; Tue, 9 May 2017 07:08:11 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 9 May 2017 22:08:11 +0800
Message-ID: <CANYiYbGfDXj4jJTcd3PpXqsDN-TwCC8Dm8B9Ov_3NaSzwsrCfg@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.13.0 round 2
To:     Junio C Hamano <gitster@pobox.com>, Ray Chen <oldsharp@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I can not send email outside at work, but now I am back home. Here is
the pull request:

The following changes since commit 4fa66c85f11bc5a541462ca5ae3246aa0ce02e74=
:

  Git 2.13-rc2 (2017-05-04 16:27:19 +0900)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.13.0-rnd2

for you to fetch changes up to 60638e9816d0aae40d4234d1a068f94fabc2fd4d:

  l10n: zh_CN: for git v2.13.0 l10n round 2 (2017-05-09 21:55:38 +0800)

----------------------------------------------------------------
l10n for Git 2.13.0 round 2

----------------------------------------------------------------
Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (3201t)
      l10n: bg.po: Updated Bulgarian translation (3195t)

Jean-Noel Avila (2):
      l10n: fr.po v2.13 round 1
      l10n: fr.po v2.13 rnd 2

Jiang Xin (9):
      l10n: git.pot: v2.13.0 round 1 (96 new, 37 removed)
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'fr_l10n_v2.13_rnd1' of git://github.com/jnavila/git
      l10n: zh_CN: for git v2.13.0 l10n round 1
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.13.0 round 2 (4 new, 7 removed)
      Merge branch 'fr_l10n_v2.13_rnd2' of git://github.com/jnavila/git
      Merge branch 'master' of https://github.com/vnwildman/git
      l10n: zh_CN: for git v2.13.0 l10n round 2

Jordi Mas (1):
      l10n: Update Catalan translation

Michael J Gruber (1):
      l10n: de.po: lower case after semi-colon

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (3199t0f0u)

Ralf Thielow (2):
      l10n: de.po: update German translation
      l10n: de.po: translate 4 new messages

Ray Chen (1):
      l10n: zh_CN: review for git v2.13.0 l10n round 1

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po(3198t): Updated Vietnamese translation for v2.13.0-rc0
      l10n: vi.po(3195t): Update translation for v2.13.0 round 2

Vasco Almeida (1):
      l10n: pt_PT: update Portuguese translation

 po/bg.po    | 6511 +++++++++++++++++++++++++++++++++++++------------------=
----
 po/ca.po    | 4617 +++++++++++++++++++++++-------------------
 po/de.po    | 4691 ++++++++++++++++++++++--------------------
 po/fr.po    | 4548 ++++++++++++++++++++++-------------------
 po/git.pot  | 4387 +++++++++++++++++++++-------------------
 po/pt_PT.po | 4528 ++++++++++++++++++++++-------------------
 po/sv.po    | 4232 ++++++++++++++++++++------------------
 po/vi.po    | 4548 ++++++++++++++++++++++-------------------
 po/zh_CN.po | 4569 ++++++++++++++++++++++-------------------
 9 files changed, 23592 insertions(+), 19039 deletions(-)


2017-05-09 12:57 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Git v2.13.0-rc2 introduced 4 new messages, let's start round 2 for Git
>> 2.13.0 l10n.
>>
>> You can get it from the usual place:
>>
>>     https://github.com/git-l10n/git-po/
>>
>> As how to update your XX.po and help to translate Git, please see
>> "Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.
>
> What's the doneness of l10n for the upcoming release?  It would be
> preferrable if I can get a "done -- pull from me now" within 16
> hours or so, as I'd like to do the release at around May 10th 00:00
> UTC.
>
> Thanks everybody, as always, for your translations and general
> support of the project.
