Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794C51F403
	for <e@80x24.org>; Sun, 17 Jun 2018 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeFQQiH (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 12:38:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37676 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933875AbeFQQiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 12:38:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id r21-v6so6451812pgv.4
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fx+2Oz44e1YMcKw1n9mYgTeGzorMCxGmNi5VhqQsh4M=;
        b=B9ke4NMn4Cqh+n5gSRWeU0/Z9AKOrDnogRAVdkCAVe75BDi1aNhfevzBs9y/jpyvTJ
         N2zNUlkFBbx4y63DB37Jq8BgZ/mZTKnfCccRd8UrppXmgK4ktHQlrWCVP9pyExRASQCb
         Mg19JJ0+WHhvkoo4ZRUifsOJMkdvb+NzndRQsX9TZgMLkid8XfGVB23oM04bH2l9dv79
         0B6QkuRMxqaLzWj1i2Ri9aRSkqisyoERiXgtLfiSkJy8DiZD7cwyOv7dH6WwN9vQSuQ2
         MucBUPPOu8AQpAIc5Anc+jZd1EG/Q/Zs7wxs3v4kSEJr/YsoJ3Yiroz14doq6Ii77Ew2
         uurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fx+2Oz44e1YMcKw1n9mYgTeGzorMCxGmNi5VhqQsh4M=;
        b=Y7um3/HIA+trXgwVNvgbz/Sv9W4myuAO9zsApwkdAizWAxBZHBQShP1fdvubwH6df/
         MEpH4GMaDePKmzkXI7KvUGXZx5I1w+W4aql2go/LLmQelt8oMzb6NdQGuDwCGOYMJ5R0
         eBG0rgGlLTsGyYATnidNGjkiSvvFO+MmJKMpT5gRdqWq8MMSyo0wBvLcV8IVzPC5K+tT
         15DbSWqI9sYkBOU56+1AQ3+UDHrPAxZaqP60EpC+gRnKJ8TXVsrcreUmZ4nPoLslyNT8
         c2AX7AwxqnCPcR5eeAuAcLaHDvZjETZEf4niV9G8jx+0mop3E3DeqDzo0SfwM07ygiCd
         wipQ==
X-Gm-Message-State: APt69E3YmOMNjMTDyHxV9AvI0gjidPNmseR4D4r9DyfmUCm7qtqGJsxB
        u1hOv+mnWB4uYZVl1MacZDGvrrijvqtpvLNd/2s=
X-Google-Smtp-Source: ADUXVKLogMEipFNJcUb9IlIJpKIB43UXvHD/zOHiok4GiRvIhy5dJqitnJ/kVDdLuZF3Z2Bk0WiJq3C/CPrTuO9F36c=
X-Received: by 2002:a62:d653:: with SMTP id r80-v6mr10272714pfg.54.1529253485453;
 Sun, 17 Jun 2018 09:38:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2167:0:0:0:0 with HTTP; Sun, 17 Jun 2018 09:38:04
 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 18 Jun 2018 00:38:04 +0800
Message-ID: <CANYiYbGauBBodnuevKr_oOe3B-cLbtD+jjgFYi6k-gtYrrzZgw@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.18.0 round 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
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

The following changes since commit 68372c88794aba15f853542008cda39def768372=
:

  Git 2.18-rc2 (2018-06-13 12:57:07 -0700)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.18.0-rnd3

for you to fetch changes up to fd8cb379022fc6f5c6d71d12d10c9388b9f5841c:

  l10n: zh_CN: for git v2.18.0 l10n round 1 to 3 (2018-06-18 00:31:45 +0800=
)

----------------------------------------------------------------
l10n for Git 2.18.0 round 3

----------------------------------------------------------------
Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (3608t)
      l10n: bg.po: Updated Bulgarian translation (3608t)

Andre Hinrichs (1):
      l10n: de.po: fix typos

Christopher Diaz Riveros (3):
      l10n: es.po: Spanish update for v2.18.0 round 1
      l10n: es.po: Spanish update for v2.18.0 round 2
      l10n: es.po: Spanish update for v2.18.0 round 3

Jean-No=C3=ABl Avila (2):
      l10n: fr.po v2.18 round 1
      l10n: fr.po v2.18.0 round 3

Jiang Xin (14):
      Merge branch 'master' of https://github.com/ralfth/git-po-de into mai=
nt
      Merge remote-tracking branch 'git-po/maint'
      l10n: git.pot: v2.18.0 round 1 (108 new, 14 removed)
      Merge branch 'fr_2.18_round1' of git://github.com/jnavila/git
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.18.0 round 2 (144 new, 6 removed)
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.18.0 round 3 (1 new, 1 removed)
      Merge branch 'fr_2.18_rnd3' of git://github.com/jnavila/git
      Merge branch 'master' of git://github.com/alshopov/git-po
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      l10n: zh_CN: for git v2.18.0 l10n round 1 to 3

Jordi Mas (1):
      l10n: Update Catalan translation

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (3470t0f0u)
      l10n: sv.po: Update Swedish translation (3608t0f0u)

Ralf Thielow (1):
      l10n: TEAMS: remove inactive de team members

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (3):
      l10n: vi(3470t): Updated Vietnamese translation for v2.18.0
      l10n: vi.po(3608t): Update Vietnamese translation for v2.18.0 round2
      l10n: vi.po(3608t): Update Vietnamese translation for v2.18.0 round 3

 po/TEAMS    |    6 +-
 po/bg.po    | 6067 +++++++++++++++++++++++++++++++++----------------------=
--
 po/ca.po    | 1777 ++++++++++-------
 po/de.po    |    4 +-
 po/es.po    | 6178 +++++++++++++++++++++++++++++++++++--------------------=
----
 po/fr.po    | 6135 ++++++++++++++++++++++++++++++++++---------------------=
---
 po/git.pot  | 5839 ++++++++++++++++++++++++++++++++-----------------------
 po/sv.po    | 6033 +++++++++++++++++++++++++++++++++----------------------=
--
 po/vi.po    | 6061 +++++++++++++++++++++++++++++++++----------------------=
--
 po/zh_CN.po | 6022 +++++++++++++++++++++++++++++++++----------------------=
--
 10 files changed, 26144 insertions(+), 17978 deletions(-)
