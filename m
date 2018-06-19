Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5966F1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 01:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935508AbeFSBgz (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 21:36:55 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40684 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934880AbeFSBgy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 21:36:54 -0400
Received: by mail-pg0-f54.google.com with SMTP id w8-v6so5342810pgp.7
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1VYNiibV1TzESFLz/+b18yX3lnCBTFCLYFSMCD+AZP0=;
        b=IRlzuLNipbMVuCqwjBinfF1mwK6H/iq8dHje7ODgH2qbZ68hV6+UGcxHbYSLXEYZ1A
         TQon9mqO099rPGTQOtnwv4BF1sFBj3TiQCuf86luROuknkw90QCOQzvjrFyZY3Y2C9x7
         +OphIfBXlki8DhfwK8c25uLVsR4/BIcvdSEo/dA677Q42vgkoMhlb9Rcs7sIqmu4GsK1
         56IwpqwLsdyPHQveYwpMvIXaZRAvCcwm7FXzLhu6TDKCYwXMH52tJD98XbeZau05vry9
         Ou3hI9kOWgNLc6WBiwCRUya13kWUfI5XTeUJsu0OOQKCWH7ifkciA4dkJ2enMKZvOfQm
         PzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1VYNiibV1TzESFLz/+b18yX3lnCBTFCLYFSMCD+AZP0=;
        b=WvbtqgBq5Kx5aYUwruhwga3ntWlaOlnPnowySIgxxIcRkXv7cqOPkesSV4mluRpe+H
         K1Cix2Vzboq6bK0sVCTHluGuP7pHYFh/tsMJGj8LK0FhoIIW5n4sE+k8TvHxloM7Fuvf
         VdvAEy4HLPoiljlLBLRQo0oVgB1Y9JJxbBZFa2qYykRmhEKOLSyO/EEFsZnXH6KXu+lE
         usnkWbZgpxAVYC1shO9jmyZS5nFFvPC5yNfjj6iPdXmSmXylgkoOz/Vfeqp9n44/NP7q
         mpS8deJNj+ZoIWZQsmo7stbLIgW5gxq7+7fv/CGoqq72wiEKI3ONyl1Dfa+1Nwsz/tmM
         i1Kg==
X-Gm-Message-State: APt69E0PSNjLMXzus8PkH4KcbLiuscgnMnaxqnTH1C3xXXxmTmde7iZd
        /rfGPruU/WqayU2edhsIQnImwbFaghT5upwCYro=
X-Google-Smtp-Source: ADUXVKLtTsgTioCX+9t/lhzaYT3APRM3iwuMAjNPaO+uii8ZhWbAq6K7XoLi4hNc+kq9s3TaKFREAs6Lx8QGaAwQWLQ=
X-Received: by 2002:a63:b008:: with SMTP id h8-v6mr12960810pgf.137.1529372214231;
 Mon, 18 Jun 2018 18:36:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2167:0:0:0:0 with HTTP; Mon, 18 Jun 2018 18:36:53
 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 19 Jun 2018 09:36:53 +0800
Message-ID: <CANYiYbFx7O3y8e_VHU33HhoC_hyXAwfOb02ntSHeWuqez6ErFg@mail.gmail.com>
Subject: [GIT PULL] Korean l10n updates for Git 2.18.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

The following changes since commit fd8cb379022fc6f5c6d71d12d10c9388b9f5841c:

  l10n: zh_CN: for git v2.18.0 l10n round 1 to 3 (2018-06-18 00:31:45 +0800)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.18.0-rnd3.1

for you to fetch changes up to 4898dd2513360bd0cb32ca67ca07c70787c81399:

  l10n: ko.po: Update Korean translation (2018-06-19 02:19:42 +0900)

----------------------------------------------------------------
Merge Korean translation for l10n of Git 2.18.0 round 3

----------------------------------------------------------------
Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

 po/TEAMS |    4 +-
 po/ko.po | 6083 ++++++++++++++++++++++++++++++++++++--------------------------
 2 files changed, 3553 insertions(+), 2534 deletions(-)

--
Jiang Xin
