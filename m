Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D47F1F424
	for <e@80x24.org>; Sun,  1 Apr 2018 11:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeDALSQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 07:18:16 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:37034 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbeDALSO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 07:18:14 -0400
Received: by mail-qk0-f177.google.com with SMTP id w6so12807331qkb.4
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 04:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=sgX72PboNWUUQHHMHNxJyC2Jv0iiABrOVDVQFfrsw9U=;
        b=TgOxxe7q+s3+eRTXEU7oGEAQxOqATD5DrtRfzzYIRXGabnDWJVuoCQI5gWopzldGtK
         qnlZtbzXYAsjv/Zu3cu2ZzyNZVlbSh6vSNm5UjhNgJa3aXp+avb/U66dW1YdLksyabSI
         5Yp5bpA1I8l1I/TxPf6r9N+G5KHtGYWZ458LbBqgfbD8L7oR6B1FZ6xnV39+hxuekdxb
         Kvb+jWTCeJKt2GHNkQCaBC8V1xMTnEv8f68wtIqPSxQ8ALU6kd4vppdCGhmENgZrxJoK
         Ou/IOhD6HW8SVBGJRacZywuKYB0Mo9us23ar28tghM3Q23/qkbuqmM0+GKMBJkstP0Wt
         WGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=sgX72PboNWUUQHHMHNxJyC2Jv0iiABrOVDVQFfrsw9U=;
        b=OzxJ07C2Z7itRvQ1EY0e5wP1ZAJYmn7usDLlsIlQWgzjalnwDvNwGmPAYeh1l4SzdA
         KUgnQvG+l643tQPZh6Xj6jG0r4jEygzCfe0Ze9rOwrlv+CEhePixuDBzRhZkk9RXZruY
         +2DVjPa0jOK3iJW/9v6EfSCcy8Ry9shONemyhlSQPcHWWmYBzBtNqmaOhZaPdbCwPRB0
         qyEUkq1lcxg+QtgJ0ImrrXHgxOxrkFO8xX28sfGSIokRg6LqkIPhFuNlFnZkCbd035eB
         oOnb/P3d2D/1ZQxHNohrphTrM/RhYoqM5MlsryX71A13/3Qaf1EKaW7cQSqGJEGoy/jW
         Js/A==
X-Gm-Message-State: ALQs6tCWSxVqnlLpJMtWfykeX76+ZQxfStt7/KUXfs4w4gW7J1hwEZqI
        T2LcwmHcwjn1fLK42q+rpBj40eEtKqANZa7B1yE=
X-Google-Smtp-Source: AIpwx4/zjiXIjy2vdM7x/EYDqKstTsT8/BDBS9J3nophIO6k27b2X9hyrgAnO7XlBM2JqrUaM8V2HqNki84OAqNOw8s=
X-Received: by 10.55.89.65 with SMTP id n62mr8252043qkb.46.1522581494062; Sun,
 01 Apr 2018 04:18:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.171 with HTTP; Sun, 1 Apr 2018 04:18:13 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 1 Apr 2018 19:18:13 +0800
Message-ID: <CANYiYbGfJ_R_yT5+0=qTrvzt0GdxsG6EtjWJauHNAyUNpaPwNg@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.17.0 round 1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Changwoo Ryu <cwryu@debian.org>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jordi Mas <jmas@softcatala.org>,
        Marco Paolone <marcopaolone@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Ray Chen <oldsharp@gmail.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Would you please pull the following git l10n updates.

The following changes since commit 0afbf6caa5b16dcfa3074982e5b48e27d452dbbb=
:

  Git 2.17-rc0 (2018-03-15 15:01:05 -0700)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.17.0-rnd1

for you to fetch changes up to 8bb6d60dd6b6f2f72fe091cb03d571dbdc01aa3e:

  l10n: de.po: translate 132 new messages (2018-03-31 13:21:09 +0200)

----------------------------------------------------------------
l10n for Git 2.17.0 round 1

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (3376t)

Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Christopher Diaz Riveros (2):
      l10n: es.po: fixes to Spanish translation
      l10n: es.po: Update Spanish translation 2.17.0

Jean-No=C3=ABl Avila (2):
      l10n: fr.po v2.17.0 round 1
      l10n: fr.po: v2.17.0 no fuzzy

Jiang Xin (10):
      Merge branch 'merge' of https://github.com/ChrisADR/git-po into maint
      l10n: git.pot: v2.17.0 round 1 (132 new, 44 removed)
      Merge remote-tracking branch 'git-po/maint'
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'fr_v2.17.0' of git://github.com/jnavila/git
      Merge branch 'master' of https://github.com/Softcatala/git-po
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      Merge branch 'fr_v2.17.0' of git://github.com/jnavila/git
      l10n: zh_CN: for git v2.17.0 l10n round 1

Jordi Mas (1):
      l10n: Update Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (3376t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 132 new messages

Ray Chen (1):
      l10n: zh_CN: review for git v2.17.0 l10n round 1

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po(3376t): Updated Vietnamese translation for v2.17

 po/bg.po    | 4598 ++++++++++++++++++++----------------
 po/ca.po    | 7551 ++++++++++++++++++++++++++++++-------------------------=
----
 po/de.po    | 4670 +++++++++++++++++++-----------------
 po/es.po    | 5213 ++++++++++++++++++++++-------------------
 po/fr.po    | 4586 +++++++++++++++++++-----------------
 po/git.pot  | 4396 ++++++++++++++++++----------------
 po/ko.po    | 4583 ++++++++++++++++++++----------------
 po/sv.po    | 4571 ++++++++++++++++++++----------------
 po/vi.po    | 4591 ++++++++++++++++++++----------------
 po/zh_CN.po | 4561 ++++++++++++++++++++----------------
 10 files changed, 26709 insertions(+), 22611 deletions(-)
