Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0705F1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 14:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755898AbcIKOZS (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 10:25:18 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33013 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755728AbcIKOZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 10:25:17 -0400
Received: by mail-qk0-f173.google.com with SMTP id w204so121041421qka.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7FZEgN88ZkEl84gygVn+uE28UB37R/MhL0oGtB5Nog0=;
        b=LL3/2hWeZ3p6IiHA5wtatnjyQXASBiv4oMXtkQitMmfciqE49rUloRwxn+JXaHHFRk
         3tOdJdfmWWCVT8EQSc4IsgApFMukEBCIkRCyZv55nxVp4RakE63KNuQZkHy9zG8886ia
         msZORA64ucgLCY5dwcBRsY3qHuBtkBKGh8zUScWq/BWGtdL7OJjjYbYmpxxid/Z/IXKU
         t+Th6zsW52suSaB2Cn/fxWui0KOp0AnChsZQyooPhdqggZjPzAVbJ07pfXUXUdlb3wUm
         EJs3ItjViGB/yTtdZXhCGRkxscmJuM528r3AQqgfS6BewudDW7bkaYLhmqKdiJ1vtBco
         Jjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7FZEgN88ZkEl84gygVn+uE28UB37R/MhL0oGtB5Nog0=;
        b=C5tSKsutMbLLrk6eHtrhqqj4T8GMoMV8bAk1FXpcDm9zm4QVUeIWZRHBMJyMz8dAFe
         XByqfKKhO2N6E4C7tByF3HA6+x1DnS2cpSJEFRujQLQIQUPgTF52Erf3n8SJIv0HOt/X
         2r93uggXK4U3j+8CEZqsWpKKXQyPabcCJ7eqo6xz9uDBazGjc8rCQ05uTfOzrlfSW5QP
         s4lIeCZwgiISo90mMs2fQXbwkht19z1CRh6pL8lALv/1pzDCx7/4H8KLVvEBDMbzF6VO
         EcQBSMFDqiPckWA12kvXCPUvlEzBH1ntgg9pAyJPE03La4wSv8j9J8SNsGMfh6Lf8pB5
         xPcQ==
X-Gm-Message-State: AE9vXwM911hAdhf3DdcTJqVPXYN7v1XtN++CeezC4iYoeO5rI/7X+U/DNkO0wnw6DYVgsggLztwMjT/om7w0cg==
X-Received: by 10.55.155.78 with SMTP id d75mr14727794qke.156.1473603916818;
 Sun, 11 Sep 2016 07:25:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.146.134 with HTTP; Sun, 11 Sep 2016 07:25:16 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 11 Sep 2016 22:25:16 +0800
Message-ID: <CANYiYbFa42-q7=dbJHir5hfipK_L=x37NKQFX8WdBeeFU4V1Gg@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.10.0 maint branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ray <tvvocold@163.com>, Ray Chen <oldsharp@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

There are some l10n updates for Git 2.10.0, please merge them to the
maint branch.

The following changes since commit e8e349249c86550d3505c4abfac28caf3d13df46:

  Merge branch 'master' of https://github.com/vnwildman/git
(2016-09-02 21:29:48 +0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po l10n-2.10.0-rnd2.3

for you to fetch changes up to 9a4b694c539fead26833c2104c1a93d3a2b4c50a:

  l10n: zh_CN: review for git v2.10.0 l10n (2016-09-11 21:34:23 +0800)

----------------------------------------------------------------
l10n-2.10.0-rnd2.3

----------------------------------------------------------------
Jiang Xin (1):
      l10n: zh_CN: fixed some typos for git 2.10.0

Ray Chen (1):
      l10n: zh_CN: review for git v2.10.0 l10n

Vasco Almeida (2):
      l10n: pt_PT: update Portuguese translation
      l10n: pt_PT: update Portuguese repository info

 po/TEAMS    |   5 +-
 po/pt_PT.po | 739 ++++++++++++++++++++++++++++--------------------------------
 po/zh_CN.po | 104 ++++-----
 3 files changed, 402 insertions(+), 446 deletions(-)

--
Jiang Xin
