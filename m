Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34BE1F406
	for <e@80x24.org>; Mon, 15 Jan 2018 21:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbeAOV3m (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 16:29:42 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42925 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeAOV3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 16:29:41 -0500
Received: by mail-qk0-f193.google.com with SMTP id k201so3502599qke.9
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 13:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fkGlG1iN8zQuC70zxAAHZTu26VlLsGzhc5f8pE6ZGRU=;
        b=gMV1FhL4UPheCdFl7ltpx9OIa56k3ZmWsyHiTyANm+v8EFOvY+C+BUVKc3rPOQ3i4d
         3d0I0yh0mKl2ViQkuUy7s3HOFvgZqkDS/MNajcD8iM8mwNZ1RcWS8DzoCbw1gyBPFSwf
         ehp86hoYW3VIqn92dPTTSNNxNmRLXn0aVdyYZ3JVuDFiY+ki4HhJ36Ea57/r9gzfTSaf
         lpdT3Ro99s//j3XSoWdTpnYuMkedw5jc5y/5v7i/1SBJavRshvUmJyw1MhkNNwU79erF
         YqrP5fOo46uXIVLIZThCLkrFChPHsvTd5ClydwaFE8Ex9nriEzL+Xa9DuZZqf99F/Ub9
         1rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fkGlG1iN8zQuC70zxAAHZTu26VlLsGzhc5f8pE6ZGRU=;
        b=H6pwhf3+FhixYdu72mx039n71vm/iQ2GS6DrniEGXEyuwpJFnwb7fVAAm4Tgb3GOYr
         L9biSF9GF3rr8SwJwUh4e9krKXCWnGYlqje8nsTpzh8J+8gjzvXeJQRkzzGaI7TLqnmY
         TvVwkfYRyjYd2tdK9QnJAlvT6IDFBO2smREv9AMoKnEaqmJDQHKv4ARLxFHOCOTqfCdt
         ojDk6G/sieHX/nw4kHXS6Et+6bJnitWAe+be1lXNVRIe5O2/Z26OMdjhJS2/XeP+m378
         OzClxoHWWLF99Bw2cZhNJScCutnc1L5Yp/dQW3fLkfJqKjgsRg/QxcO+s+wJdAcexnzO
         mAWg==
X-Gm-Message-State: AKGB3mKbTI5xr/GNuA8nwXr2ctKWUUvzuo3fvox8PBNSNlvQFZ7G3dpf
        RdwOWBMcRqFPrgBD5K2R/sAnHTMEPl74CDDgTWo=
X-Google-Smtp-Source: ACJfBotwA+ZhhpQPmFS5i+6jIh8YXSQlKs2SKpU+evSIppETMdKXFAMugZTDG42vOBjWLN1PZSoMLP1Ni1V7ylOnaQc=
X-Received: by 10.55.178.134 with SMTP id b128mr51123479qkf.316.1516051780472;
 Mon, 15 Jan 2018 13:29:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.208.108 with HTTP; Mon, 15 Jan 2018 13:29:39 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 16 Jan 2018 05:29:39 +0800
Message-ID: <CANYiYbEH9Uvy29z0P9z-vNHOuLn=Xb-enpcnXP9CEueFSXQezQ@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.16.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Changwoo Ryu <cwryu@debian.org>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Jean-Noel Avila <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jordi Mas <jmas@softcatala.org>,
        Louis Bettens <louis@bettens.info>,
        Marco Paolone <marcopaolone@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Robert Abel <rabel@robertabel.eu>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following git l10n updates for Git 2.16.0.

The following changes since commit 36438dc19dd2a305dddebd44bf7a65f1a220075b=
:

  Git 2.16-rc1 (2018-01-05 13:45:17 -0800)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.16.0-rnd2

for you to fetch changes up to c9741bb98e59d6580145f4d1c9628faa1a22e623:

  l10n: de.po: translate 72 new messages (2018-01-15 07:47:30 +0100)

----------------------------------------------------------------
l10n for Git 2.16.0 round 2

----------------------------------------------------------------
Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (3284t)
      l10n: bg.po: Updated Bulgarian translation (3288t)

Changwoo Ryu (2):
      l10n: ko.po: Update Korean translation
      l10n: TEAMS: Add ko team members

Christopher D=C3=ADaz Riveros (3):
      l10n: Update Spanish translation
      l10n: es.po: Update Spanish Translation v2.16.0
      l10n: es.po: Spanish translation 2.16.0 round 2

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Fangyi Zhou (1):
      l10n: zh_CN translate parameter name

Jean-Noel Avila (2):
      l10n: fr.po v2.16.0 round 1
      l10n: fr.po 2.16 round 2

Jiang Xin (15):
      Merge branch '2.15.1' of https://github.com/ChrisADR/git-po into main=
t
      l10n: git.pot: v2.16.0 round 1 (64 new, 25 removed)
      Merge branch 'maint' of git://github.com/git-l10n/git-po
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'fr_2.16' of git://github.com/jnavila/git
      Merge branch '2.16' of https://github.com/ChrisADR/git-po
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.16.0 round 2 (8 new, 4 removed)
      Merge branch 'fr_2.16-rc1' of git://github.com/jnavila/git
      Merge branch '2.16' of https://github.com/ChrisADR/git-po
      Merge branch 'ko/merge-l10n' of https://github.com/git-l10n-ko/git-l1=
0n-ko
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      l10n: zh_CN: for git v2.16.0 l10n round 2
      l10n: TEAMS: add zh_CN team members

Jordi Mas (1):
      l10n: Fixes to Catalan translation

Louis Bettens (1):
      l10n: fr.po: "worktree list" mistranslated as prune

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (3284t0f0u)
      l10n: sv.po: Update Swedish translation (3288t0f0u)

Ralf Thielow (2):
      l10n: de.po: improve messages when a branch starts to track another r=
ef
      l10n: de.po: translate 72 new messages

Robert Abel (1):
      l10n: fixes to German translation

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po(3288t): Updated Vietnamese translation for v2.16.0 round =
2

Zhou Fangyi (1):
      l10n: zh_CN Fix typo

 po/TEAMS    |    5 +-
 po/bg.po    | 4098 ++++++++++++++++++++++++-----------------------
 po/ca.po    |  384 +++--
 po/de.po    | 4128 +++++++++++++++++++++++++----------------------
 po/es.po    | 5136 +++++++++++++++++++++++++++++++------------------------=
----
 po/fr.po    | 4095 +++++++++++++++++++++++++----------------------
 po/git.pot  | 3967 +++++++++++++++++++++++----------------------
 po/ko.po    | 4142 +++++++++++++++++++++++++----------------------
 po/ru.po    | 4010 ++++++++++++++++++++++++----------------------
 po/sv.po    | 4082 +++++++++++++++++++++++++----------------------
 po/vi.po    | 4085 +++++++++++++++++++++++++----------------------
 po/zh_CN.po | 4098 +++++++++++++++++++++++++----------------------
 12 files changed, 22202 insertions(+), 20028 deletions(-)

--
Jiang Xin
