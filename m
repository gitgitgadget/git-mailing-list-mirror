Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B611E1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 14:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934875AbcHaOOl (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 10:14:41 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36055 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbcHaOOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 10:14:40 -0400
Received: by mail-qt0-f178.google.com with SMTP id 52so25837898qtq.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=IC/Ju6hXuXyBEhJzliDdGOMgu81UR3kO1sZQaF5Be3E=;
        b=zvmjJwuzgAQc8IQ0ef8YZTXMKJWudxbshLifcEufw1Jpz62bGvNzpLrGLppZNBHYN6
         uVi75CpMkWZSwFW5j992StgBOasAMtSr7pFbK19BSg+4KKI1eJY+s/mRfrHW8GE6o7AB
         ++lA8MZ/sQYORDbFMynATE0lpWx9TA54dtgFizcbI1FYtv1/UdvkANj85NC/NZo8FR5U
         5TbTgTriip+3PvGb/lS9NVO0rdi+U4ihRCTX7yP3GP9j7SAA/rbaGIpVmmcaD/weSjdt
         XTalNxV8vabkTivdqte969QZR+2TQ7WGRofcJqzBe9SHipZ+jMGB69bu5CSl39iWOuuD
         +v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=IC/Ju6hXuXyBEhJzliDdGOMgu81UR3kO1sZQaF5Be3E=;
        b=GcAeuQxImwUHlk5tKeL33owOYKTDYz4OgZpkH6bU0fa+A1eCS3TWjDzLDZbcfs5J3a
         Aggy9x/JB55WJSlPkQDC8FAvymxLaOkyPyj5k2GDDmqL9fATipKZdHQmtA4QFVIbKNJn
         FH4nDlORfhpAeMmavyg3q8KshvWv4deoO89W2nwIA/LTlMd1tuNj1lXroAciMXB1ihMT
         MPvlHrPnS5UlCqaTFNs+E0o/JsD+O/TWb9oNcCmz61jqirZyIIRmrhEwd19lvWBUJzuU
         vJtHBZz9Wh4IFr4MOklFhw79ImJ4O+8VDx+In78IghdaVwwEvU72efNoMbPOXK9JV/tG
         mg4A==
X-Gm-Message-State: AE9vXwNPUtN73bqhj+XtOtIWNf1Udn7CIbBrsbfr1jjT38toP2iE+fV0Dg8Rgo1HcsOek2Om4gF52JV4cHnCGg==
X-Received: by 10.200.40.235 with SMTP id j40mr10366489qtj.99.1472652874785;
 Wed, 31 Aug 2016 07:14:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.106.66 with HTTP; Wed, 31 Aug 2016 07:14:34 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 31 Aug 2016 22:14:34 +0800
Message-ID: <CANYiYbGLzg6+pK85gdp3bH7qyrA3BaX1PmjbnbK8Q+23HWuotw@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.10.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Would you please pull the following git l10n updates.

The following changes since commit d5cb9cbd64165153a318e1049f8bf14b09a16b11=
:

  Git 2.10-rc2 (2016-08-26 13:59:20 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.10.0-rnd2

for you to fetch changes up to 5c57d7622e3c7c685345f9736c4c924349a321dd:

  l10n: zh_CN: for git v2.10.0 l10n round 2 (2016-08-31 00:11:13 +0800)

----------------------------------------------------------------
l10n-2.10.0-rnd2

----------------------------------------------------------------
Alex Henrie (1):
      l10n: ca.po: update translation

Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Jean-Noel Avila (1):
      l10n: fr.po v2.10.0-rc2

Jiang Xin (5):
      l10n: git.pot: v2.10.0 round 1 (248 new, 56 removed)
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.10.0 round 2 (12 new, 44 removed)
      Merge branch 'master' of https://github.com/vnwildman/git
      l10n: zh_CN: for git v2.10.0 l10n round 2

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2757t0f0u)

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: Updated Vietnamese translation for v2.10.0 (2789t)

Vasco Almeida (2):
      l10n: pt_PT: merge git.pot
      l10n: pt_PT: update Portuguese translation

 po/ca.po    | 6083 +++++++++++++++++++++++++++++++++++++------------------=
----
 po/fr.po    | 4868 +++++++++++++++++++++++++++++------------------
 po/git.pot  | 4325 +++++++++++++++++++++++++-----------------
 po/ko.po    | 4665 ++++++++++++++++++++++++++++-----------------
 po/pt_PT.po | 4975 ++++++++++++++++++++++++++++++------------------
 po/sv.po    | 4834 +++++++++++++++++++++++++++++------------------
 po/vi.po    | 4875 +++++++++++++++++++++++++++++------------------
 po/zh_CN.po | 4515 +++++++++++++++++++++++++++-----------------
 8 files changed, 24393 insertions(+), 14747 deletions(-)

--
Jiang Xin
