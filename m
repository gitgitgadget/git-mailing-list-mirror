Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B04C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 02:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiITCqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiITCqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 22:46:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAED57571
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:46:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a29so1440096pfk.5
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2finlG/VcQ7/LqgWWGdrA6p9K2O602n/mkfgOAgHor4=;
        b=Uu7GKpguXgC140VEMxrmTxHvLXOL+ErmWcUshatnwLqhXrSwRYSM1ziYsto9Fa4RM/
         8eOkOT7PucT1TAl4W+sPCcIglF0iPFfW2J0WEStinAEICYSHIdCKt3JpcI+iWgvCYvfz
         2QZgn79i9s7I1D6wivoUheEbvR9O5/YIviKkVTFhYjq8N3fc4T5bdfPsyRWL43aj9Zz8
         JXkp9Fdb06KorkEL4Urk91MGfgcdPq7pxngvpgRXWG4UrOdIKaaZfJnw9T8jhvBwew8F
         sQO+IdrM1L5FnEnI3OZdoPiCTMOAN9SzODF8q1qM3lTg5L4ty+l/DoVRrFyF/Q3qAYDA
         Io1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2finlG/VcQ7/LqgWWGdrA6p9K2O602n/mkfgOAgHor4=;
        b=6x1yODvNJQNNu3M/bg1r2AO6VBaSNN7h+zmRSiKcCiH0DxZfGZzlTYgNaFSwSWmMbn
         V6Bf7LbIlaCHrw0OtVSyCzgoH1MAcPU6xCopK1js2zgRIFmU4DF1kZ5G7URqWrh9NOxS
         +oC0ADMMSiObbpRxj2T18RaDVt3glivOIvaeS3ctZe9scJHlG0vCP+W+8TRPzCmCmX7N
         d3oV3fWw3nBI4FAtXx6u/pvRHWHUt6oT5MHlMiNDnsdwPmdoMuyrhRnmYsDvaCIHQm6u
         J+266NK817h0UXCTx1SS5s1pKuweSwfqRqPhvVBWEBbNcXE0Wt5IS+IvUCK5TbTFgslD
         WGXg==
X-Gm-Message-State: ACrzQf1xmXt269mdxOaze1bICaz49XkOTaB87IQAYhfPjor7Fhg9D83X
        FiHo71uKQ8RSXnIQVxDSOhr+sdjCImBw9BGz
X-Google-Smtp-Source: AMsMyM7OLKGzy34S9j6BSbheCTTpq9ZGjPuz2qwZYMz9/qem/ZcXp3RUqZIX825d95gqfml8m2i+4w==
X-Received: by 2002:a65:6055:0:b0:42a:7b2b:dc71 with SMTP id a21-20020a656055000000b0042a7b2bdc71mr18020210pgp.23.1663641987396;
        Mon, 19 Sep 2022 19:46:27 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9c0a:f300:a972:1d85:8e93:c538])
        by smtp.gmail.com with ESMTPSA id m14-20020a62a20e000000b00537aa0fbb57sm146471pff.51.2022.09.19.19.46.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2022 19:46:26 -0700 (PDT)
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH 0/2] Fix various typos in regular and technical docs
Date:   Mon, 19 Sep 2022 19:45:55 -0700
Message-Id: <20220920024557.22889-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Used GNU "aspell check <filename>" to review various documentation
files with the default aspell dictionary. Ignored false-positives
between american and british english.

Jacob Stopak (2):
  Documentation: clean up a few misspelled word typos
  Documentation: clean up various typos in technical docs

 Documentation/MyFirstContribution.txt           | 2 +-
 Documentation/MyFirstObjectWalk.txt             | 2 +-
 Documentation/git.txt                           | 2 +-
 Documentation/technical/api-parse-options.txt   | 2 +-
 Documentation/technical/bundle-uri.txt          | 6 +++---
 Documentation/technical/commit-graph.txt        | 4 ++--
 Documentation/technical/remembering-renames.txt | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)


base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
-- 
2.37.3

