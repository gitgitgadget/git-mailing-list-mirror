Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790A81F404
	for <e@80x24.org>; Sun,  9 Sep 2018 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeIITf7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 15:35:59 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:39318 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIITf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 15:35:59 -0400
Received: by mail-qk1-f171.google.com with SMTP id b19-v6so12743796qkc.6
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=H3HxLLeinIPYbgT4dcbl2lYXzAwau3hxfO/uuRGWgA4=;
        b=sgPJT0pTaYFYgw1EXDvON2Pvt4fgwF2ZOnv/1HIwCerayyBmREhEaHljLiSe7ILAHS
         iPXzY0uHGjcy0RuGVTekFgRIBpmH9qkCm7aFQMzZ+PMf+3bET1hCNDTO5NdgkBMl+xVa
         xuwKO2Ip4TQQ6Z+ELYZXiLl4/k3vQtIgQ2TrWWGKJKOMCq6uJtHfNsDmve3LBML3NBHq
         UWjEISMkwRX0drnC8x5gv62ccxyk2kzEiEZW3+wfWhn/zVWb2hr4D3HzYVm2OaiwL/HY
         cCFTxjIFX0Nqy2azZ7t5W6avsTqeSi+LVjZioqbxAdiZrMeuIMcyU/p63mh86Z9GlX5B
         ilKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=H3HxLLeinIPYbgT4dcbl2lYXzAwau3hxfO/uuRGWgA4=;
        b=hdscDl35m42lPCrDNF9WpYDTn7AvKYitgbbg6lPQqLIZ0L0SNOCrbGGjxVwwSGa93i
         SO21DFk3bhyLb0N5Q+TrYTZgipcJ3Y0t+hDEaMq/9L9IRKmg64e/pdfoczMFw5uCGlI9
         ZlN3apoLrFfeO+UrqVdtKNcGsIkoJgHxj1a3QT2IbOADqsSgJwAhNPS1iPMn3u1glArJ
         QN2Ji/kmXSrJd1zSU+WWZgeauNWv5ICHhUHXV1x7sbXMcOXFEFdJcTCBDeGiPl6Cw7DX
         p+QNg/hrSfcTKpErts5qs0gUoK4HZjYDd7kCVqUr5VTWP20730uWnH29M8qzvz8ib17J
         gktQ==
X-Gm-Message-State: APzg51BQn6x2NCsnLMzPu5aSJqLOOxc+JYyJu7ZyBhqc6DYZKDPjmXzV
        M00AdNDl6sq4v9T1FiYSBBm3Z2V6wiifIJZvqq0=
X-Google-Smtp-Source: ANB0VdaOgel95VuFYyV1uNaGVkqg1cWdj4jFP2KhuFNg+kMkGr2EuriIdujAxA7XBtgOYgrfyfeyVwhbqpT+K744nmw=
X-Received: by 2002:ae9:c109:: with SMTP id z9-v6mr12203967qki.290.1536504363680;
 Sun, 09 Sep 2018 07:46:03 -0700 (PDT)
MIME-Version: 1.0
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 9 Sep 2018 22:45:51 +0800
Message-ID: <CANYiYbGT7R6dLwGpefH=nUxyvdHBuKF1tTtyLy9GRnK5FdH6Kw@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.19.0 round 2
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
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

The following changes since commit 2f743933341f276111103550fbf383a34dfcfd38=
:

  Git 2.19-rc1 (2018-08-28 12:01:01 -0700)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.19.0-rnd2

for you to fetch changes up to c1ac5258dccbb62438c8df73d728271f7a316c99:

  l10n: zh_CN: for git v2.19.0 l10n round 1 to 2 (2018-09-09 22:38:39 +0800=
)

----------------------------------------------------------------
l10n for Git 2.19.0 round 2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (3958t)

Christopher D=C3=ADaz Riveros (1):
      l10n: es.po v2.19.0 round 2

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jean-No=C3=ABl Avila (2):
      l10n: fr.po v2.19.0 rnd 1
      l10n: fr.po v2.19.0 rnd 2

Jiang Xin (8):
      l10n: zh_CN: review for git 2.18.0
      Merge branch 'maint' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.19.0 round 1 (382 new, 30 removed)
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.19.0 round 2 (3 new, 5 removed)
      Merge branch 'fr_2.19.0_rnd1' of git://github.com/jnavila/git
      Merge branch 'master' of git://github.com/alshopov/git-po
      l10n: zh_CN: for git v2.19.0 l10n round 1 to 2

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation(3608t0f0u)
      l10n: sv.po: Update Swedish translation (3958t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 108 new messages

Rapha=C3=ABl Hertzog (1):
      l10n: fr: fix a message seen in git bisect

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po(3958t): updated Vietnamese translation v2.19.0 round 2

 po/bg.po    |  7453 +++++++++++++++++++++++++----------------
 po/de.po    |  5183 +++++++++++++++-------------
 po/es.po    |  7328 +++++++++++++++++++++++++---------------
 po/fr.po    |  7384 ++++++++++++++++++++++++----------------
 po/git.pot  |  7316 ++++++++++++++++++++++++----------------
 po/ru.po    | 10552 ++++++++++++++++++++++++++++++++++++++----------------=
----
 po/sv.po    |  7373 ++++++++++++++++++++++++----------------
 po/vi.po    |  7376 ++++++++++++++++++++++++----------------
 po/zh_CN.po |  7411 +++++++++++++++++++++++++----------------
 9 files changed, 41801 insertions(+), 25575 deletions(-)
