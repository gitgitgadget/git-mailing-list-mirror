Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4981F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDQTPr (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:15:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41065 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeDQTPq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:15:46 -0400
Received: by mail-wr0-f196.google.com with SMTP id v24so21418624wra.8
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FuRrCrDgxaz3K+PDqNCM9VX8Nhgnllak9JxyqzlMFik=;
        b=uvlr5DS2IeUr2AGZXqlf21BI5iAIYy5qj9RIDka+AqRy9rJ24dnJotuJSlcEafv3c1
         bYCSwELcFsOY6hekYKJ+cn2R6h+DO/ZrQ1NbEguAYa2KPa0o9R+mWVTwIDsNAbCKL+Hn
         IdQHE1WkF8giXAVR/KbLC3JCawq7VRJd2/7kI/ipm2iU5D/RseITt/dBNuf8FNVIfcAa
         csoeSmvtTgTU9YqZ4PInMzEs5IC5rUSNIQ9zecqaySgrOBUgLvTpEN+LLGGrqlQoxHZf
         Z0nTxqKOmrPVTQJVhgaYBz8kqcYO5QdMwHDDbQaDCt5c3KpFzs+VEvQ6gh0rYGGRfCMq
         zy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FuRrCrDgxaz3K+PDqNCM9VX8Nhgnllak9JxyqzlMFik=;
        b=Ili6B5KDMRlx7hYh9I4Rk3q8vm9myHiorBcQhUACEdesYVBaqD0Cfv/Kx57L9EdhPL
         2ohpf3Mc39fwrB1UuA/+vxctjr/hXWndA2+6bN9KMp6BxYQJqSuAnP0c/R/1+RDgHQ43
         14b78QTNiXyl81hCt2wc5cO/cAPz+FY9PdR84ZLWu7uJ1SLyQzPxtJRZsXhJMoEtBgyY
         EbTBc74lsTCj805NSgblwQSwkRdXH1u55hLvKNRAK8+cGQjVE2768sAc18XlbXAmKgKW
         6IoxpSPSu0EE0rLYZZQwfZfJwDps2999bNKg6u3ksTqGeK+9MXT3KB/cgx8iP+KC3S7I
         RP1w==
X-Gm-Message-State: ALQs6tB/+Dzv0iZxKvOYy/ILd54xFv0vDjgb5QKiXHtmK61CfZbzyWVM
        4Glb2+uMN5diToVwNd9CJS1a9eCA
X-Google-Smtp-Source: AIpwx4/gTsmM/PkB96nbWWRbpUZx6CN9KLUOsbqOjXfyjghj07XpdJn4AbZWxnCCGvrVdPeT0H8eBw==
X-Received: by 10.28.6.149 with SMTP id 143mr1881747wmg.61.1523992544716;
        Tue, 17 Apr 2018 12:15:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id m62sm2745398wmc.41.2018.04.17.12.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 12:15:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 0/4] doc: cleaning up instances of \--
Date:   Tue, 17 Apr 2018 21:15:25 +0200
Message-Id: <cover.1523991648.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com>
References: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a patch series to convert \-- to -- in our documentation. The
first patch is a reiteration of 1c262bb7b2 (doc: convert \--option to
--option, 2015-05-13) to fix some instances that have appeared since.
The other three patches deal with standalone "\--" which we can't
always turn into "--" since it can be rendered as an em dash.

Martin

Martin Ågren (4):
  doc: convert \--option to --option
  doc: convert [\--] to [--]
  git-[short]log.txt: unify quoted standalone --
  git-submodule.txt: quote usage in monospace, drop backslash

 Documentation/git-format-patch.txt | 2 +-
 Documentation/git-log.txt          | 8 ++++----
 Documentation/git-push.txt         | 2 +-
 Documentation/git-shortlog.txt     | 6 +++---
 Documentation/git-submodule.txt    | 4 ++--
 Documentation/gitk.txt             | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.17.0.252.gfe0a9eaf31

