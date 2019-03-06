Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CA8202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 06:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfCFGag (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 01:30:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33111 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfCFGag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id z23so8043105lfe.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 22:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbC7vFOE2lyFpVd0/ouzIq9sPK7FDk9zO5YwECIjIfg=;
        b=SomZaP0Kgza/Ng3fgg7qMLjm0FUGEJuxcVmm38I+FVJBmKFk3+ZlAc6kNv8lQ5D1Tb
         LUFPqxKqZucX0bh2Jd4gWZUTL7ZJaEPAAiJl3tE+4rDkLzwfbTniOCuCbod4DI85EkJT
         hrzyom0jnYHPcSGrNrygoXurXnzMY9aI9n93tx2nkA4jbO8JtYMfwD2EmIvYq9nJf+ye
         4ucXUQOmjWSGfpqVxLu3BNNbzzgq7zsa7G4FScy2Egdpnx6BGxTeOA2tLvIC3D+trbIT
         arg/87d7kYpWOZU39f2DveAXgnr0uTmDVC8XZSy/SofQBG08l3SAbpxQ3xyDmPfrTiDb
         e98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbC7vFOE2lyFpVd0/ouzIq9sPK7FDk9zO5YwECIjIfg=;
        b=eUzIyn9mJZ24mwC9vWyUDQSeEOCGG2MWpCwr09imC+ZYwwV/BlLyLtkgdm7EaGL23Z
         91Qos12Jx2m1NYo8MOAvOeGBj+qMjKvrfzpN3cvre1Cl1QRX5t+U2j1rx/2RXY+H8ZN6
         lvhAIySNqmyUHPfzmRuISIMMBDcZgLwD0OHnhnW/8gPTosurnw39p5by2JCqE4zfdiQT
         KyXNlx9wSY68Rj8ZxKWJTADlq3k8Tg0A3SgWLr10Lr6VsIW09ewJtWbs2np42SS/fDz/
         w4PEsGOMnzYNhHqYy+spW0ECQhH2rfKID5KQO66zc/r6xXedmI4i/Wa+eX3GKjFQ5bvy
         2tgg==
X-Gm-Message-State: APjAAAVX+zK6jK8QgBUPC1thkcHhS9GSEDq1gE3n4fDk1VTxYfqAmYxG
        T5/UHjcySJRl6PBn1rqHsFvqVlqA
X-Google-Smtp-Source: APXvYqwIKaNVRi22Od9sQJTqdnJAyYjV4e3aLIDMXpjKCwZ1P6q4CFXl8r6eDxc42SgPtelgqdR70g==
X-Received: by 2002:ac2:53ab:: with SMTP id j11mr2844531lfh.49.1551853833464;
        Tue, 05 Mar 2019 22:30:33 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u29sm149715ljd.84.2019.03.05.22.30.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 22:30:32 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] fixing a few Asciidoc/tor differences
Date:   Wed,  6 Mar 2019 07:30:13 +0100
Message-Id: <cover.1551853194.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've got a W-I-P series to teach our doc-diff tool to diff between
AsciiDoc and Asciidoctor. It looks promising, and here are a few fixes
that fell out from my first round of testing things.

The W-I-P doc-diff is able to find three types of problems, as shown by
these patches. One is where Asciidoctor trips on something, but Asciidoc
doesn't. There's the other way around. And sometimes they both stumble,
but differently.

Based on maint.

Martin Ågren (5):
  config/diff.txt: drop spurious backtick
  config/fsck.txt: avoid starting line with dash
  git.txt: remove empty line before list continuation
  git-svn.txt: drop escaping '\' that ends up being rendered
  Documentation: turn middle-of-line tabs into spaces

 Documentation/config/diff.txt       |  4 ++--
 Documentation/config/fsck.txt       |  6 +++---
 Documentation/config/gc.txt         |  2 +-
 Documentation/config/gpg.txt        |  2 +-
 Documentation/git-config.txt        |  2 +-
 Documentation/git-grep.txt          |  2 +-
 Documentation/git-http-backend.txt  |  2 +-
 Documentation/git-ls-remote.txt     |  2 +-
 Documentation/git-notes.txt         |  2 +-
 Documentation/git-svn.txt           | 10 +++++-----
 Documentation/git.txt               |  1 -
 Documentation/gitattributes.txt     |  2 +-
 Documentation/gitremote-helpers.txt |  2 +-
 Documentation/gitweb.conf.txt       |  2 +-
 Documentation/rev-list-options.txt  |  2 +-
 15 files changed, 21 insertions(+), 22 deletions(-)

-- 
2.21.0

