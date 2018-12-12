Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7A620A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 18:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeLLSO5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 13:14:57 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:43937 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeLLSO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 13:14:56 -0500
Received: by mail-pl1-f172.google.com with SMTP id gn14so8958250plb.10
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TrKL8SX33HUb/wVyrmrDmqBvDnExIjeYlm7KlX6hMZs=;
        b=EAaGTAk3JuSgPTipEv0Ryaim1uDjcBcrRrQcWoDPfwvUXiM2rNo4ExV9QF/hduC02A
         ZRLFbWiKKe2o5TeYK8EDt4TzQKxzucVGLIUFesIaChSO42WfpnDU6dbyFaAL9EM2z1eB
         Rzm/Zg+4xUS7VdZsxkyeTUjX5Fk6FhpCLWT7oEC8lxkhoi818VeNkVaTdn0pzDS7PSvH
         wn665VaWgAOvP3Dvgfac6dChe7EmeR9yJt0gSpeSbcUhqHuc2gZaToMK6sRC9zI3/ErU
         qwTjdRK8osZ41cAUug/hEy7XpfRZjo9HXq71CWlNGfdvuqSEiQ27M0qm/VmLMuoNS4G1
         3jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TrKL8SX33HUb/wVyrmrDmqBvDnExIjeYlm7KlX6hMZs=;
        b=Nl/gAxRDgLFg+KcpF1/uX29nQUPGdYYirozluzLUaHMEyIm5qeb/rfyq5zGKuDYPIQ
         4uZDUHi8a0TxuzWKTET+CsS6IRj+lOPCSKJ/yV3EGiePioZf9R48K6OlSTOqIsyTec5h
         tVNr5VAGIkfAm4eDDrXDscaYd5a0J2HIypRUe/ToNWjScuR4pLoaEcQeK4RdsGiD9Di+
         iyy4XWHk6zXLkgHXmSUi+qBv+2HH6LHc0n+kYMBjPd54rD6Do/SvSK55JlDrUyEDyQDJ
         imE786xk6ROfS3kH98YAFsViwX59VmIC4Iv9ixnU7cz6cczfJq5m+HO0CGLMDhLLXEOR
         Fo/Q==
X-Gm-Message-State: AA+aEWYRoe+LZVDVQjhbCSg6JCSZhd/r+EaQB/f8WbNVPL2YqPCbOw6r
        W9HFmEgYRCxwPK0ykDOCIJ+lU87H
X-Google-Smtp-Source: AFSGD/WydW1PKdS/yQtmN4MUBI0T1z0CuqLBaJYzpMD31WiFJblVHR/aFytfqMZpqA0zIFqXnS/4iA==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr21045594plg.319.1544638494916;
        Wed, 12 Dec 2018 10:14:54 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id i1sm28843840pgb.46.2018.12.12.10.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:14:54 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:14:54 -0800 (PST)
X-Google-Original-Date: Wed, 12 Dec 2018 18:14:49 GMT
Message-Id: <4275b8a5812b7108aecfc027fd6ace9b470a7c88.1544638490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.98.v2.git.gitgitgadget@gmail.com>
References: <pull.98.git.gitgitgadget@gmail.com>
        <pull.98.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] t4256: mark support files as LF-only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The test t4256-am-format-flowed.sh requires carefully applying a
patch after ignoring padding whitespace. This breaks if the file
is munged to include CRLF line endings instead of LF.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/.gitattributes b/t/.gitattributes
index e7acedabe1..df05434d32 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -16,6 +16,7 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t4135/* eol=lf
 /t4211/* eol=lf
 /t4252/* eol=lf
+/t4256/1/* eol=lf
 /t5100/* eol=lf
 /t5515/* eol=lf
 /t556x_common eol=lf
-- 
gitgitgadget
