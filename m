Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E277ECAAA1
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 10:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIKKYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 06:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIKKX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 06:23:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91843A150
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 03:23:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y136so5929972pfb.3
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9YOoRXYerUkUlK06nn6tLLrGMyfe6JIkjYCQPxW8hGY=;
        b=Dcz5It/FIuZGcjiPwmFxMV0k2f01bZJwdc5CY8X4tziPA+N37WdC83J16/v6LKIeal
         CWQXCmsLFQwRaV/qs39pZLjWPlpuZY0BqSFHY+jwrmNcvf+1bDym5DzF7RwDxo4HX/tx
         ricbMHB9TpFlDArWAXrQHRaKU/rMDJaPDkhgUwXuMGI5z56ZHYrmzkFb0/r+G97NwvpF
         mr9QMr1noZTHy8yBg6HV0GOwvWCq+RFy4LjLQ4+aULUB6tkWTdtFNjMQXDIo22EK4OZW
         /rBy3PR0V5rI0a8UL9x7H5sjPIhknmc+rQHVdh3LLvsplUHAtspTaYjYJIxMGZIbqLEW
         gFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9YOoRXYerUkUlK06nn6tLLrGMyfe6JIkjYCQPxW8hGY=;
        b=W9GhdpD7qdf5BZ8sqMGV28SPOxHzooI+6ulbmO06cfivXnqsOcAqsvaNkbcg+aYJlc
         iABNVEGqh/7PZD3SzVQayC3/7Ml2NxPudvBYn1GPqtg9G8JN6jLLduHfT0jdXYRSr7/4
         QRTseC21uYUvy36kv27FAmYV7uV32FJIne9tB9TU6MUlnpD5iNyM6YmdUs4DRj150ato
         efkW0gq7SlKzNlMiOrNV1/9kNyrEDntiP8jnDGaIHrs7auKp8thk+DcC03Q/sxCm+96d
         yuLWsgkKiK8b/V+IeKaXlivaHHBSgBUgCg8h39svBCucpbPB6tyJnwHebUvYE2BmRirr
         JSCA==
X-Gm-Message-State: ACgBeo2fCTPvDJ3hFs4Mf0xdMgNDrUbmCxA/qA3tSxnsv0jx3ZvMJwnG
        C+NrMD5dWge17I7o34ykKL+RYIFPBPIXkQ==
X-Google-Smtp-Source: AA6agR6oiHn8K3haNxo7d0DuCsVgZAdK1jyOPGf/hTO3czL4DtWmil2clLwdG834tV7MzIvsArCeqA==
X-Received: by 2002:a63:5702:0:b0:42a:b77b:85b3 with SMTP id l2-20020a635702000000b0042ab77b85b3mr18649969pgb.263.1662891837957;
        Sun, 11 Sep 2022 03:23:57 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9c0a:f300:b5d1:79e9:801c:571f])
        by smtp.gmail.com with ESMTPSA id z14-20020aa79e4e000000b00537eb0084f9sm3079874pfq.83.2022.09.11.03.23.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Sep 2022 03:23:57 -0700 (PDT)
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH 0/1] Documentation: fix various repeat word typos
Date:   Sun, 11 Sep 2022 03:23:19 -0700
Message-Id: <20220911102320.39954-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First contribution :D!

Inspired by 24966cd982 ("doc: fix repeated words", 08-09-2019),
I ran "egrep -R "\<([a-zA-Z]+)\> \<\1\>" ./Documentation/*" to
find current cases of repeated words such as "the the" that were
quite clearly typos.

There were many false positives reported, such as "really really"
or valid uses of "that that" which I left alone.

Hope to contribute a code change one of these days!

Jacob Stopak (1):
  Documentation: fix various repeat word typos

 Documentation/CodingGuidelines                         | 2 +-
 Documentation/config/transfer.txt                      | 2 +-
 Documentation/git-bundle.txt                           | 2 +-
 Documentation/git-update-index.txt                     | 2 +-
 Documentation/git-upload-pack.txt                      | 2 +-
 Documentation/howto/keep-canonical-history-correct.txt | 2 +-
 Documentation/technical/remembering-renames.txt        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)


base-commit: dd3f6c4cae7e3b15ce984dce8593ff7569650e24
-- 
2.32.0 (Apple Git-132)

