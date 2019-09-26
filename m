Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EB61F463
	for <e@80x24.org>; Thu, 26 Sep 2019 15:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfIZP35 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 11:29:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34845 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZP35 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 11:29:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so2055053lfl.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3uT6JYSu6r3v5/fNYjEn6hnb/2qV8QL6aUmioXENpV4=;
        b=ECSj7nQli1EtwaDNV4tQM9V5pIRAJq5k9KyCBNdKz7fTg3Elajt8vA0SBg+zDeUXak
         BAaAv3ctzaDrrpiqUH+i3T5FnP67bcXeQSb6QMU6wTYa1tpEzhA2Fy6iJQ3zHQqhuzsv
         dMdjyJGcOZ2DEMsI3hEey0YRVtwMfW+VzU5QmfNuhbAtrljqRqrT5k0NXddpW4W/5cRn
         MyjkU4h7KVto+WErnWOAUZd/gkSJ63Wy/UUTtlfZONM/Rb3w2zu8UaHHgV1NJAtMv6S8
         BUkqhcWU0Ms2PIPoS865+QsGFdOOAdP9dJ/+8i78eOxIMHzsDFaOWSDgyZ8idewW0GV4
         kPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3uT6JYSu6r3v5/fNYjEn6hnb/2qV8QL6aUmioXENpV4=;
        b=Ommx4sRyEltT63Z4M3YtMRh2eZDG53B1PHQtjnwJ3uPLa+N3fPZLARUUzShscbFnRS
         xtyJ6bFG/uXwLXJVnR7e9Xp/pnRxi4AkLseNoWFE99bZY9r93eVtubQXuBaWllphBMA9
         BG//JT/orNY+6Cbh31DqL1JBtLFYiWMF8AhHbjXVZTmTFNIo7zS1uSQpApCsA3fgRyG/
         ORQ14tNW8PjFNs5uQKTH/WXazzUKeN7E6xqzRU57JQyhIpEm4lYTOE9fAgjE9hZTt871
         02t8iRs+I3gw01Iv5eHphWWc5A3tVZQ8c0f8IRcoNU6iN0fPAQ6S3sYrxPEEsCn06q0L
         6kcw==
X-Gm-Message-State: APjAAAUzfSP/Bis0vROtZ11LdKtrRI2xJG2MIMgFT/SpWrXhQOZ27RNM
        3ebpWF+fqVqFtuvbspcrYk7BGYnj
X-Google-Smtp-Source: APXvYqzXlUwx0UEfHln51vMWrxEKlgeIp76yb8fTW/PXU33Y2eV2hid8AK06z5huNHreTP14od+yrw==
X-Received: by 2002:a19:c695:: with SMTP id w143mr2474997lff.162.1569511795305;
        Thu, 26 Sep 2019 08:29:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p27sm582669lfo.95.2019.09.26.08.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:29:54 -0700 (PDT)
Date:   Thu, 26 Sep 2019 08:29:54 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 15:29:49 GMT
Message-Id: <pull.358.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] git-gui: GIT_ASK_YESNO/GIT_ASKPASS patches from Git for Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another set of patches from Git for Windows' fork that have been
sitting there since 2010, providing cross-platform GUI helpers to ask the
user a question or allow typing in a password.

This patch series was first submitted as 
https://github.com/patthoyts/git-gui/pull/5 which was ignored for almost
three years, then re-submitted as 
https://github.com/prati0100/git-gui/pull/3 which was rejected in favor of a
contribution by mail.

The patches are based on Git GUI's master branch at 
https://github.com/prati0100/git-gui/.

Heiko Voigt (1):
  git-gui: provide question helper for retry fallback on Windows

Johannes Schindelin (3):
  git gui: set GIT_ASKPASS=git-gui--askpass if not set yet
  git-gui--askyesno: allow overriding the window title
  git-gui--askyesno (mingw): use Git for Windows' icon, if available

 Makefile          |  2 ++
 git-gui--askyesno | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 git-gui.sh        |  6 +++++
 3 files changed, 76 insertions(+)
 create mode 100755 git-gui--askyesno


base-commit: 12d29c326551a6570594db525bea42ad9cea8028
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-358%2Fdscho%2Fgit-gui-askpass-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-358/dscho/git-gui-askpass-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/358
-- 
gitgitgadget
