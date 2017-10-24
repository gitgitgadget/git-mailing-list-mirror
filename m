Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9F5202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 02:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbdJXCgz (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 22:36:55 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:52122 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdJXCgy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 22:36:54 -0400
Received: by mail-qt0-f170.google.com with SMTP id h4so28689887qtk.8
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 19:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6BmvEGey9DFVTxMaq2QMkXhMBhgzPVMMYVrq89My7uc=;
        b=rdYp1ACLrgK8oO3NfX/7fFRHbL5+3P3kj8H+kI1Jk2+iccBu2Vhk4OiQS74i0AY+/X
         2j31VXVTL+VlieNjPQOyUIfim00xzUVRYuKa9eT9jr1sCJTBDcX1qfNY0XuWtW+pkhZe
         zf6wDW8rvTa8thuJuU7VhylhR5FwFxbX72kMUe6HE/8jwPfT1zFmeFXfk/jEjRFZV/gg
         s/nJ+7HUACLbNNQNVFPGGUf2N6hEFRMW9Mwgz8OaY/m1Q3mt0G9e7/9W9GKf9Kx9naTp
         tTwbUeDUvgyHfNhdTieDPsTM94oFE+iugwslDYkx1Y7SA61CznV4syQPE53XKIoHpbsJ
         8D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=6BmvEGey9DFVTxMaq2QMkXhMBhgzPVMMYVrq89My7uc=;
        b=gDr5T3mAyvxDn5tXGBRTxf5MT5TH3Hc65pIvxzkL/Sg4weq0Hof/FdLadYkG2jMAV5
         fIHDDS2FI8aBR2X3F5PnmhU1MG/gGuPqdQXfrXUM7Z/jkNRw2hJm4+2hBCnlbgvI4TuM
         RNQzzpBU9eOjvVyw5CPo+y/V5mwgZTxQULi+a/F6BqLMOcy+qko+3u9lmBJeuC6sTDdb
         gci8ws4fruTjMjZTF756cOdJ9U1Hvw9ZybhAPm65JZmDtVgsON+ghTmp1kWr1hYDFvBx
         FHAyB4L/xF0ePrnhlKRNCIdMkeHRyTH0HrQN4NTb6gxA3ht2/5sMWTRRTFYfDZKByEPf
         ey7A==
X-Gm-Message-State: AMCzsaX0Bhp9vFA4NWOwRChx+k8ElXzVtPYOZQ8lRZGOVMRhsOAmXdvy
        M0uOVJkhnumaNwmkrerI/u3dFg0m6VdxmW0CQhw=
X-Google-Smtp-Source: ABhQp+TiBAypXzBJaTDL5qiRbMYZg2uSbjr/tiaqVzZd+uIui0i2V/Hg5X1EoD+wZp//nTFlWCWuG//wd4W4LLM4/Ks=
X-Received: by 10.237.34.201 with SMTP id q9mr22850003qtc.198.1508812613379;
 Mon, 23 Oct 2017 19:36:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.138.51 with HTTP; Mon, 23 Oct 2017 19:36:52 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 24 Oct 2017 10:36:52 +0800
Message-ID: <CANYiYbFZLUzh0VK+Yp6y8jyc5TZ1seua1D9MpcPe2s5QxDN5Wg@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.15.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Andre Hinrichs <andre.hinrichs@gmx.de>,
        Changwoo Ryu <cwryu@debian.org>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz_Riveros?= <chrisadr@gentoo.org>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jean-Noel Avila <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jordi Mas <jmas@softcatala.org>,
        Marco Paolone <marcopaolone@gmail.com>,
        Nicolas Cornu <nicolac76@yahoo.fr>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Ray Chen <oldsharp@gmail.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull l10n updates for Git 2.15.0.

The following changes since commit 111ef79afe185f8731920569450f6a65320f5d5f=
:

  Git 2.15-rc1 (2017-10-11 14:54:04 +0900)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.15.0-rnd2

for you to fetch changes up to 1165e3c317b51a3f47afe1a5762b92cac695fe5c:

  Merge branch 'jx/zh_CN-proposed' of github.com:jiangxin/git
(2017-10-24 10:11:48 +0800)

----------------------------------------------------------------
l10n for Git 2.15.0 round 2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (3245t)

Andre Hinrichs (1):
      l10n: de.po: fix typos

Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Christopher D=C3=ADaz (3):
      l10n: es.po: initial Spanish version git 2.14.0
      l10n: es.po: spanish added to TEAMS
      l10n: es.po: Update translation v2.15.0 round 1

Christopher D=C3=ADaz Riveros (1):
      l10n: es.po: v2.15.0 round 2

Dimitriy Ryazantcev (2):
      l10n: ru.po: update Russian translation
      l10n: ru.po: update Russian translation

Jean-Noel Avila (2):
      l10n: fr.po fix some mistakes
      l10n: fr.po: v2.15.0 round 2

Jiang Xin (14):
      l10n: git.pot: v2.15.0 round 1 (68 new, 36 removed)
      Merge branch 'maint' of git://github.com/git-l10n/git-po
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.15.0 round 2 (2 new, 2 removed)
      Merge branch 'translation' of https://github.com/ChrisADR/git-po
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      Merge branch 'l10n_fr_v2.15.0r2' of git://github.com/jnavila/git
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'master' of https://github.com/ralfth/git-po-de
      l10n: zh_CN: for git v2.15.0 l10n round 2
      Merge branch 'jx/zh_CN-proposed' of github.com:jiangxin/git

Jordi Mas (1):
      l10n: Update Catalan translation

Nicolas Cornu (1):
      l10n: fr.po change translation of "First, rewinding"

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (3245t0f0u)
      l10n: sv.po: Update Swedish translation (3245t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 70 new messages

Ray Chen (1):
      l10n: zh_CN: review for git v2.15.0 l10n round 2

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po(3245t): Updated Vietnamese translation for v2.15.0
      l10n: vi.po(3245t): Updated Vietnamese translation for v2.15.0 round =
2

 po/TEAMS    |     4 +
 po/bg.po    |  4973 +++++++++---------
 po/ca.po    |  5999 +++++++++++----------
 po/de.po    |  5078 +++++++++---------
 po/es.po    | 16599 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 po/fr.po    |  5039 +++++++++---------
 po/git.pot  |  4858 ++++++++---------
 po/ko.po    |  4946 ++++++++---------
 po/ru.po    |  4902 ++++++++---------
 po/sv.po    |  5152 +++++++++---------
 po/vi.po    |  5029 +++++++++---------
 po/zh_CN.po |  4971 +++++++++---------
 12 files changed, 42782 insertions(+), 24768 deletions(-)
 create mode 100644 po/es.po

--
Jiang Xin
