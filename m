Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6CA20248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCQSgi (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:36:38 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37164 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfCQSgh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:36:37 -0400
Received: by mail-lj1-f170.google.com with SMTP id a17so12053219ljd.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUG89ynv/GdmLNQSFgZg46JtclDR1ReTWo3VjbloyV4=;
        b=oDfRe0t6COIV7pVD216CyLvjFc/xztEDFC5oKZn5jaBQuAsJbGbss83SSLgelVa003
         2zxfOTSJYAnSpZzx3tpIN4CRKsyQR1yRH1xlPYFn5sEKTPcVfMrVi10RLsgQtq3l0W5x
         DgrvXFwvR2aSbpLHO/YDyKYXFnWbBwxpU2exybJu7gTUkw2wUEjJiN/BDKxbOPyTuZTZ
         ingmfSp+5mR4C/qhajOVM6U/Q0SlN2o9zmuKcJ25a8rJV94uE8XTBtMDm0zMFVkgzUqt
         0ii62+OMiWPrFD2XdlNtZxTvU1kcyOeIr+UfPh+oi7RpA14yhuDpI09fL/tKF6b+0QY1
         nMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUG89ynv/GdmLNQSFgZg46JtclDR1ReTWo3VjbloyV4=;
        b=WoFJA3VUZobcSSkq6aqHsKRlBkER4UAOhLXQjf1XSXPMpbzu6kwrrRr1gLpMumFHWs
         IEZVVmeD5qWRjSp97VlpKiA5tPwVYTxbqg2TrLF39kkMKD5tff4dLTnxgGJUwhL3OtyG
         r3A4OzoZpdy0kOqQdhNTjkSzrvUfomopAwfTD8Q3LVOAfzJGKV6XLnGBINuguBxVeISi
         f+siu587UsH93oYf+TN+DtcPAc+yRT9FZ1jpAo0D63uH/AVOzH+lFKWYz+4AfRLdb4VJ
         i3o6kpGonNRdCf1iBXJ/wIZ+t8tV1OVAebEXkEY8Cyr/rDk99+Pzm8R0IAminy8Izdx5
         6Kiw==
X-Gm-Message-State: APjAAAWVnVy4jyzJKxmgs7iZnd+iRqYPxHD7bvaqt0+nmRDWL/+lLB8h
        BZUINJ3HidVQhy9inOluwkoQK0Kc
X-Google-Smtp-Source: APXvYqwiqcnXRQSpixyE9hH+mv+xZet/jCuXvrkWL8dFElXiOnqIfJddInHf9xh1/Y0F62Si4N5YuQ==
X-Received: by 2002:a2e:3e11:: with SMTP id l17mr8272061lja.172.1552847795150;
        Sun, 17 Mar 2019 11:36:35 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id e2sm1589484lfc.75.2019.03.17.11.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:36:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 0/4] doc-diff: support diffing from/to AsciiDoc(tor)
Date:   Sun, 17 Mar 2019 19:35:59 +0100
Message-Id: <cover.1552838239.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've taught `doc-diff` a few new knobs to support usage like

  $ ./doc-diff --from-asciidoc --to-asciidoctor HEAD HEAD

and I don't think I've messed it up too badly in the process. I'm open
to the idea that this might not be interesting to a whole lot of people.
But I have made some progress on fixing up Asciidoctor *and* AsciiDoc
issues using this, and once the output of the above command is empty --
which might not be too far off -- it could be interesting to try and
keep it that way using a bit of automation around these switches.

While using/testing these patches, I've made some progress on the
rendering of the headers and footers in Asciidoctor [1], so the
`--cut-header-footer` switch that I'm adding in the final patch might
hopefully not be necessary for too long. But we'd still need a
`--cut-footer` switch -- at least I would, on my system [2]. If this
series is considered generally sane, I'd be happy to rework the final
patch to `--cut-header` if that's preferred.

Patch 1 has a minor purely-textual merge conflict with
ma/asciidoctor-fixes.

[1] https://public-inbox.org/git/20190317144747.2418514-1-martin.agren@gmail.com/

[2] After [1], the date in the footer is still formatted differently
    here. It might be a locale thing, and I tend to shy away from even
    trying to understand those. :-/

Martin Ågren (4):
  Doc: auto-detect changed build flags
  doc-diff: let `render_tree()` take an explicit directory name
  doc-diff: support diffing from/to AsciiDoc(tor)
  doc-diff: add `--cut-header-footer`

 Documentation/.gitignore |  1 +
 Documentation/Makefile   | 23 ++++++++---
 Documentation/doc-diff   | 86 +++++++++++++++++++++++++++++++++-------
 3 files changed, 90 insertions(+), 20 deletions(-)

-- 
2.21.0

