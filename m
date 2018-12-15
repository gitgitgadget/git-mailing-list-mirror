Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFDF71F405
	for <e@80x24.org>; Sat, 15 Dec 2018 11:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeLOL15 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 06:27:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41051 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeLOL14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 06:27:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so6164663lfj.8
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 03:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGGJmnlY8dHiTUDkWWoq8muJFeQ3xq0Xm361fX9d0ww=;
        b=cojHK0IZWLPGNdkm5EEeOpUSz6dmcwQ50rap/cxnhxvt3adHEwhSk3J5XMDk6eha57
         OF5XLmZcy44SLTJoL4Qgn2FmXeoEW8Fyu/nicF585OYFuK2gbJLz+OKuB+bHR5goYYR8
         VCbAmRJgmLpd3/sul/I+IVBdRTQTuhKfb4AIJWHg+K7h4QRQYqMB5z5pLB18L+6wd8Qe
         fabOn5NHuNRfcFxQ7k851if72PxTwwD1ylAIYRFK4NU1K0OkKDbe1T6JzOaMpEHRcvls
         uABbtDRnb5dGijoWlZCGZiZ4NuStsrwdfBSQRi6HWtwZOjwl0en2IOhzQYP/rhiVUJJ8
         9+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGGJmnlY8dHiTUDkWWoq8muJFeQ3xq0Xm361fX9d0ww=;
        b=sBCvbecqDpmHkfUCpmj3c1lLeJWb17WBqH0FX28+veieSTep0AEUubD3ooX9LsbmzY
         0cJRNin1CPpZdEcX5aiR1/UFSgTF4SC91Le69ZK4t0eFBS+fiqNL3Up2K1G9p7VC2Ch0
         i2SupAacJhF+RqnGDoMOHDUZBiLxx0NTA4r7glonO+Pi9PQXBEDva5+8AVK0ipJurjV/
         aRnU0fbsAZxwk6dxZ893jM5Xe3soPvJ6GSKPaDbQIf0mo++n7sv05rTSHWdcnR9OisQ6
         4ughWGuiMcbLwf/omMyKhTzbjygNvaiB9A2hezAaU37PL6NZx8iyrhTIIW8C4le1lItu
         7aCA==
X-Gm-Message-State: AA+aEWbvXTloSccviKVgTzL6ZjuYmCIAcxz+QN+v4JJhPHZYKXFjXZll
        kGpoMzqjK94q+UrcQK3cyom2zLr+
X-Google-Smtp-Source: AFSGD/XlD1bAQa/lhB/TXq7g62bn8e6sXQvKEiC50o9nvQfFw7eLkzgRJGa4NjmtRBMTii4BW3vJpA==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr3941269lfl.129.1544873274177;
        Sat, 15 Dec 2018 03:27:54 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id t18sm1439174lft.93.2018.12.15.03.27.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 03:27:52 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] A few Asciidoctor-fixes
Date:   Sat, 15 Dec 2018 12:27:38 +0100
Message-Id: <20181215112742.1475882-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have (ab)used doc-diff to try to find instances where Asciidoctor and
Asciidoc render our documentation differently. (See [1] for details on
the hack.) This series fixes the differences that somehow stood out in
the diff. Many smaller differences remain.

With each patch, I am giving one or a few URLs which show the current
Asciidoctor rendering at git-scm.com.

With Asciidoc, `doc-diff origin/master HEAD` reports that there is no
difference.

[1] https://public-inbox.org/git/CAN0heSob+Ac4BvM-vuKvPZKxrTW53-d91a55NX5kC7ZyNXntWQ@mail.gmail.com/

Martin Ågren (4):
  git-column.txt: fix section header
  git-init.txt: do not nest open blocks
  rev-list-options.txt: do not nest open blocks
  git-status.txt: render tables correctly under Asciidoctor

 Documentation/git-column.txt       |   2 +-
 Documentation/git-init.txt         |   4 -
 Documentation/git-status.txt       | 162 +++++++++++++++--------------
 Documentation/rev-list-options.txt |   4 -
 4 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.20.1

