Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0471F404
	for <e@80x24.org>; Mon, 10 Sep 2018 21:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeIKCSP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 22:18:15 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:52539 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeIKCSP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 22:18:15 -0400
Received: by mail-qt0-f201.google.com with SMTP id s1-v6so22845324qte.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wr0UcdbjFdv+aUbNtwig8rG6V+QRNiOKbyDd15H9k0o=;
        b=hSFrZFcgpv8WPk7MPbcZD6p1fYIF87bmQ2zgOefd4exdw7+DLgIUx3wkWuTONZGTpb
         kYiov5AoRNJ5xV0gVpDCvLleUh9+LVbETy02E3BzVUmpge9jTQGbklPBCsEQDIRjfvU3
         cQByGE3GIXSPku5rBU8I72TxlSVvNmhQkjx541dP/4OzwFq/8L8Ivfj5XApfXk3X9iEl
         krGF30QpQ/bsycNd5WJ+OU1AVTyMBI7D+YDRbU3uewCSe3ScU0XlF3B3Kv8npJxGkqQw
         BrrX1AOC/a3oW+3/94YXrEiZdxppWfj9xo7Yc8QuKhfVLtYNsR5M39lldAfnH6fbU3l4
         JXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wr0UcdbjFdv+aUbNtwig8rG6V+QRNiOKbyDd15H9k0o=;
        b=FVRCQ3WmdYihfKzGftUpQnryyKjPOiP4hP4QQo4QofVzwURUVDpIJZ+eLwYFLodBis
         gsCh8j2cBD4QHZcZknjt5hBmE/QIia0+1jh6oxV38725aepsZHbl6SZXd9Mkl/DDGdUr
         y500DI0jzjBp/e7DiMFv90kDVf8td0+LMuIH5uqCzmi2yQEdB9QhhQo3PoffS2NqOeI8
         fRt6y8UvA8dk4uM5sgiJigHHh8yDzLsGWTcyxu4148Yk6oPacMfY6UUPEVs97R/DRTDK
         d7RMIpbyOYFZMfbFEQXO2a3nUcDLjEnMbKjHzSKKoVwM/aUpzgI6i26JCKh6VruI+qTv
         IyCw==
X-Gm-Message-State: APzg51Co/PNVHG2MoPUuwv8pfCgpQT6n2g4jenzQB5kBDhpPXt2rkrbe
        1qZ455GAxH4dNa0ve2+Dz/VuiwklkADLrHtq688J6+YDCnapSItDN/x8T/ZZPKNxOoF4pG4biOR
        DyMnPLBzJZPwnzniGOTo3ktEIh6ZBShAl/4kAWWbyXdHvN5X64OfIntyXXbRI2+U=
X-Google-Smtp-Source: ANB0VdYvBQ87uUuvWvqcVCHP1tshNxdqDG+ObhjkGTrGuyHjUDVV1mVlAE4gdv6FgLj43Wls1lqymFCcpwjHlg==
X-Received: by 2002:a37:c8ca:: with SMTP id t71-v6mr7331728qkl.39.1536614536249;
 Mon, 10 Sep 2018 14:22:16 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:21:57 -0700
In-Reply-To: <20180522223208.GQ10623@aiede.svl.corp.google.com>
Message-Id: <20180910212157.134291-1-steadmon@google.com>
Mime-Version: 1.0
References: <20180522223208.GQ10623@aiede.svl.corp.google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH v2] config: document value 2 for protocol.version
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jrn@google.com, Brandon Williams <bmwill@google.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Update the config documentation to note the value `2` as an acceptable
value for the protocol.version config.

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/config.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eb66a1197..ee3b5dd8e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2828,6 +2828,8 @@ protocol.version::
 * `1` - the original wire protocol with the addition of a version string
   in the initial response from the server.
 
+* `2` - link:technical/protocol-v2.html[wire protocol version 2].
+
 --
 
 pull.ff::
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

