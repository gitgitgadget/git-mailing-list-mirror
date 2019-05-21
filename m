Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50B31F462
	for <e@80x24.org>; Tue, 21 May 2019 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfEURuW (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 13:50:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35703 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbfEURuW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 13:50:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so30689853edr.2
        for <git@vger.kernel.org>; Tue, 21 May 2019 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TJlPxt06C0FkP8ovRz0Bw2rL9zlMpUsaEueRFtg7Wtk=;
        b=I+7sv+3y8sj8P6ExRTRBX6WEBZLDI6vUm2GjvjIQWpsEQs34faQts7zIeHShhHRkPn
         dRF4lhEmKzhS5nWF+oGtZsq9Pq/C4szHQz2fpnbV08wl5fMIcWiOCLd3k0TuNBsKMyqp
         MbHafBZIktHclCnGqKG90IgQ1jPCc60Nb+HEyHmYiXDzyt5RUXFbtniimTLCSV9x6Q9O
         RU6eLkgNIBf+qu+/YnYqpHoNWZyEvRd5yxVyRim3LIVpyE4klzUfz+E9RP1pVKT4UeYh
         4C+Bc1k68/CqgaqU1azIRmD8e1Dww1KjXAtjx64PxKE32zFax4fRMp4uww2eFwF0mZVz
         2fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TJlPxt06C0FkP8ovRz0Bw2rL9zlMpUsaEueRFtg7Wtk=;
        b=Pp79b/8GkUuF4q7D2YJfxCuwDA3vzOo6V8Gefc6+LsTcNq5MmucsP/emypb+h2QDRh
         lWGx3sz4oW1XKPzncCp/Dwgfh5gADMpN3tJ87d+4P1AsfY46KB3dYxwhkPYVlt2+AbPI
         a/sukhzPwzFCC62pDTGEoJrStvhsDCJuDWWkwKfj64jAV0bPjPJpbsyz4TmrXYcTRc69
         EnBtHRXfIXAOyhKX4qVm/wahx6lu0hmBV5ba97vHxqduCkgUoZtNWnDz4ahrUlH6tfnN
         5vjMdOhfrW/2E9HPbTgmjqRXieijL3mTi+wxsJ1npY8+XsNTxGg3EAt076hC95Td5vHP
         qD3g==
X-Gm-Message-State: APjAAAW/P1f2wzTMwmqzSSD3VpzBk33bn9z7a22pkrCF17r/jnPxukvP
        O9Uhd87up6oAJzhkYMfwdr8x7DKK
X-Google-Smtp-Source: APXvYqxkjWIJ0K++DjazcLj6U1eEITe89oGRYmkGwG7HSGcXnV3u8ykT+/efoBlD8rli1YdVRFlK8Q==
X-Received: by 2002:a17:906:66c9:: with SMTP id k9mr17872209ejp.21.1558461020771;
        Tue, 21 May 2019 10:50:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm376846edc.24.2019.05.21.10.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 10:50:20 -0700 (PDT)
Date:   Tue, 21 May 2019 10:50:20 -0700 (PDT)
X-Google-Original-Date: Tue, 21 May 2019 17:50:17 GMT
Message-Id: <aa0acf4c5ff843a480afdb5715fa03186d82a6d1.1558461018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.221.git.gitgitgadget@gmail.com>
References: <pull.221.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] rebase: replace incorrect logical negation by correct
 bitwise one
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

In bff014dac7d9 (builtin rebase: support the `verbose` and `diffstat`
options, 2018-09-04), we added a line that wanted to remove the
`REBASE_DIFFSTAT` bit from the flags, but it used an incorrect negation.

Found by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ba3a574e40..db6ca9bd7d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1203,7 +1203,7 @@ static int rebase_config(const char *var, const char *value, void *data)
 		if (git_config_bool(var, value))
 			opts->flags |= REBASE_DIFFSTAT;
 		else
-			opts->flags &= !REBASE_DIFFSTAT;
+			opts->flags &= ~REBASE_DIFFSTAT;
 		return 0;
 	}
 
-- 
gitgitgadget

