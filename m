Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1B8211B3
	for <e@80x24.org>; Sun,  9 Dec 2018 04:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLIEEW (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 23:04:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45684 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbeLIEEW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 23:04:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so4729330qka.12
        for <git@vger.kernel.org>; Sat, 08 Dec 2018 20:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=R0r4zsQNBxBFbrKluTVzfU98nKJO0aSdfGWGlxEkRq0=;
        b=O7oUZAmR7lZLJbbX7RYnAgmWxmOhBXJNhqfGRlcLKAUSC5cymvhWJ/xhZBjtmeZgqA
         M0uUVYAp7WFtA+cZ2PUtS2OowLDBtUxiNL8AypEoYkLgdpak15T76kjw+YgCeOQpIQ7o
         9P+qVDRqAgSpKFTRktSUfruUSaD0yKVwsHoMPJTmt5Y0II11j/3JZ0Fo85rJ3EvUoT34
         7XU7dOTnuQPnjDAmzTLrJNbM3L0cF8pPZFd75Fz5KdRA+zu3ZGS57/A8nK4/UwE4RzpY
         xWcY434pz2tXVMhC1TizPHPVl0bEZnziIR/GrvcdwQ3MxYjl36XoYMwJ1qvlfwsCsruS
         VRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=R0r4zsQNBxBFbrKluTVzfU98nKJO0aSdfGWGlxEkRq0=;
        b=raJy+Pi9gE1xgKl1W4VJagHQMT+t4UGqT/5DWOJWL9xQuypd09xcRAZHFWrx8ck8Ld
         gc1aU335kgvPSEd+OzFL97PgdjPdE8GOh3DFpNlKpmzh29HBL6Ll91X0ltPx2fSl8CQt
         Rifo5dR1RRvwjC3TuqQcEcFe+CVABQNLli2Z0pZff+CdP7Y7lUt7Qui4hY4Xdjk4pnTj
         VnZ+CL0g7CqjbDj0xJ0th22aSUqyRGQ7x64TY6muoZGZ0WqAi8eQccJ7Gw7i/Bclmv6M
         YEyds1Bfev6wmfFoMKf5bjTJmDMk2/oF+/6K1HDoZ7fx4yOppAvFQ5DDEWP8DKDkdBrI
         Mgsg==
X-Gm-Message-State: AA+aEWZ3bBQhcS4u3NwgL/8M1LkxcWdwSaT1FWE7S8NoWnRrWbafJI9A
        0IZkPJY3aJySt1h8qxWovoseHWSHQVHG8BBZgk0=
X-Google-Smtp-Source: AFSGD/VGty1ObRvBZawAOZ6CE3cwtWs3vRS9uGC4Tmv9clGO4yA1DT0rS1HC4tY+NoMVSUwExElMLnIdDVWvDVbDv5o=
X-Received: by 2002:a37:2a81:: with SMTP id q1mr6984107qkq.252.1544328261002;
 Sat, 08 Dec 2018 20:04:21 -0800 (PST)
MIME-Version: 1.0
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 9 Dec 2018 12:04:10 +0800
Message-ID: <CANYiYbF07DNC=UMm5zKJwzGFyo8UY-Auh+K3khFjCNOftV2KyQ@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.20.0 round 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Minh Nguyen <mxn@1ec5.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following git l10n updates for Git 2.20.0.

The following changes since commit 8a0ba68f6dab2c8b1f297a0d46b710bb9af3237a=
:

  Git 2.20-rc2 (2018-12-01 21:44:56 +0900)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.20.0-rnd3

for you to fetch changes up to 0688c551a3e0f812e2153b716b9674da5914122c:

  l10n: de.po: fix two messages (2018-12-07 19:43:07 +0100)

----------------------------------------------------------------
l10n-2.20.0-rnd3

----------------------------------------------------------------
Alexander Shopov (3):
      l10n: bg.po: Updated Bulgarian translation (4185t)
      l10n: bg.po: Updated Bulgarian translation (4185t)
      l10n: bg.po: Updated Bulgarian translation (4187t)

Christopher D=C3=ADaz Riveros (2):
      l10n: es.po v2.20.0 round 1
      l10n: es.po v2.20.0 round 3

Jean-No=C3=ABl Avila (2):
      l10n: fr.po v2.20 rnd 1
      l10n: fr.po v2.20.0 round 3

Jiang Xin (16):
      l10n: zh_CN: review for git v2.19.0 l10n
      Merge branch 'master' of https://github.com/Softcatala/git-po
      l10n: git.pot: v2.20.0 round 1 (254 new, 27 removed)
      Merge branch 'master' of git://github.com/git-l10n/git-po
      Merge branch 'fr_2.20_rnd1' of git://github.com/jnavila/git
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.20.0 round 2 (2 new, 2 removed)
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.20.0 round 3 (5 new, 3 removed)
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'fr_2.20_round3' of git://github.com/jnavila/git
      Merge branch 'master' of git://github.com/alshopov/git-po
      l10n: zh_CN: for git v2.20.0 l10n round 1 to 3

Jordi Mas (2):
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Minh Nguyen (1):
      l10n: vi.po: fix typo in pack-objects

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4185t0f0u)
      l10n: sv.po: Update Swedish translation (4187t0f0u)

Ralf Thielow (3):
      l10n: update German translation
      l10n: update German translation
      l10n: de.po: fix two messages

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi(4185t): Updated Vietnamese translation for v2.20.0
      l10n: vi(4187t): Updated Vietnamese translation for v2.20.0 rd3

 po/bg.po    |  7398 ++++++++++++++++-------------
 po/ca.po    | 14723 +++++++++++++++++++++++++++++++++++++-----------------=
----
 po/de.po    | 10702 ++++++++++++++++++++++++++++--------------
 po/es.po    |  7642 +++++++++++++++++-------------
 po/fr.po    |  7344 +++++++++++++++++------------
 po/git.pot  |  7243 +++++++++++++++++------------
 po/sv.po    |  7324 +++++++++++++++++------------
 po/vi.po    |  7357 +++++++++++++++++------------
 po/zh_CN.po |  7422 ++++++++++++++++-------------
 9 files changed, 46477 insertions(+), 30678 deletions(-)

--
Jiang Xin
