Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567201FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 14:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754825AbcKVO7N (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 09:59:13 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32929 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbcKVO7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 09:59:12 -0500
Received: by mail-qk0-f194.google.com with SMTP id x190so4436619qkb.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2JYgA/bxMc3Tncs9c3p2j3sqXX+9YhVxFT6peYvkLjY=;
        b=Scpci5ryeOV9XDODj9PQPrr58VoGupm2GZxuPFG/uUxSpGN8kK/f6XqN1KunaUIkIW
         L/hprHpBnaeXNfNdJDZnf3F/Yq+QrTylEinnDzq3atpH39PENE0U5m7TgaeMelN/cL73
         DKCHrVjjvnDmvKB1sTXlbvxAQtUujaG1y/PCSXpx5ov6SZz69B+8CI7SszsfSfFIYC3Q
         Ae+lHK7B7igmL+nDkzyr4HBSekF0J/9QfBR7Q2U0ftcDo4dn3viRffY2ahxjh1bXpGEA
         HanCXIB/wPaRTPkjm79/Q2A4s1F/VfCBgAbsVblEuat496qUgfjXtsvbkHXzqDwRrNX6
         HZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2JYgA/bxMc3Tncs9c3p2j3sqXX+9YhVxFT6peYvkLjY=;
        b=GrIFSiurv/x/aXgiZZ+ilF2oJLppx+K1CpASQGKiFCGsrbaBS71omXcfQP2KLoHhA6
         8gJWzK192RNOiRJIwhkQ/9LEBtE2vLbFMKzWc3yE1lSBxX56rodjKLNyV0tAe+DORukk
         TgHL0KSEgRU57ZJV2n8KesplyEWif7Roc90S2yJAM0VA4Xluufa4iUPFdlH1NwzNkzOU
         8F4ps5qTkUFqcVC/TNJbUO7ViFbRbqPQyenG++n9xXQBkn8RIIleLKupAAeSPDFQj4bc
         fj4tspT32zApypi3S7iAZat+3Vnh3Ln9+GcU6l/bipx7ZDhiQpuKjo8XAe3upfKGcPZT
         x0sA==
X-Gm-Message-State: AKaTC00tL+DKca2vE0vYzwHNC4T/d5muEbz7z4Ls8loV8eLT/Qd7O/Fxwm4fATfwwkDbApW8iIHbUybfq7KfUg==
X-Received: by 10.233.221.135 with SMTP id r129mr22403707qkf.56.1479826750906;
 Tue, 22 Nov 2016 06:59:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.129.65 with HTTP; Tue, 22 Nov 2016 06:59:10 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 22 Nov 2016 22:59:10 +0800
Message-ID: <CANYiYbGtfZKshmfYxHM0sL2Z67=3KTF0kixP1OjumRw87e9XkA@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.11.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

The following changes since commit 1310affe024fba407bff55dbe65cd6d670c8a32d=
:

  Git 2.11-rc2 (2016-11-17 13:47:36 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.11.0-rnd2

for you to fetch changes up to 275588f93eedd8d7a556c38b75944b858e704dce:

  l10n: Fixed typo of git fetch-pack command (2016-11-22 22:24:59 +0800)

----------------------------------------------------------------
l10n-2.11.0-rnd2

----------------------------------------------------------------
Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jean-Noel Avila (1):
      l10n: fr.po v2.11.0_rnd1

Jiang Xin (8):
      l10n: git.pot: v2.11.0 round 1 (209 new, 53 removed)
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru
      Merge branch 'ko/merge-l10n' of https://github.com/changwoo/git-l10n-=
ko
      Merge branch 'fr_v2.11.0_rnd1' of git://github.com/jnavila/git
      l10n: zh_CN: for git v2.11.0 l10n round 1
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.11.0 round 2 (1 new, 1 removed)
      l10n: Fixed typo of git fetch-pack command

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2913t0f0u)

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po: Updated translation to v2.11.0 (2913t)

Vasco Almeida (1):
      l10n: pt_PT: update Portuguese translation

jfbu (1):
      l10n: fr.po fix grammar mistakes

 po/fr.po    | 8916 +++++++++++++++++++++++++++++++++----------------------=
----
 po/git.pot  | 6664 ++++++++++++++++++++++++--------------------
 po/ko.po    | 8729 +++++++++++++++++++++++++++++++------------------------=
--
 po/pt_PT.po | 8794 ++++++++++++++++++++++++++++++++-----------------------=
---
 po/ru.po    | 4429 +++++++++++++++++------------
 po/sv.po    | 8709 +++++++++++++++++++++++++++++++------------------------=
--
 po/vi.po    | 8697 +++++++++++++++++++++++++++++++------------------------=
--
 po/zh_CN.po | 8689 +++++++++++++++++++++++++++++++------------------------=
--
 8 files changed, 35318 insertions(+), 28309 deletions(-)

--
Jiang Xin
