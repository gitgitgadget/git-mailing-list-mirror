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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1CC1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfFRMYF (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46809 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbfFRMYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so21421393edr.13
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wuS2WA7Jif5QUvj7Fml1sgZWSEjo5/eKfDep4R9AnUE=;
        b=ZHMZ6x2fl7Qq1lC8GoKmY6aiHvK6O5dMBaWljEihCB4bRuH3/haHHUWrRt6y7fu0W1
         1lxA2jYnxSOFTuFWj3NOO2gVgcIBojFhy+c5XihsBoTKhfa1UpJUEXrtDxtheT1Q1cZd
         5OBbAqafJa5lneCobni6iqmS1rH6HqrCB1mvol6VJODR17JeImi2vv9R0pZgs/MNTSzF
         jUxgieBaC7Y82Ln1YeSUb2UQNj+lfdfnW/MtElYLpTMJ697iTTdEQf1jj8EzKajQB2hH
         qK8Rjru7BLg377w7qrT6IaziHF1OFeNvVchYUR7/f/5AT3SD069SnmUn6jXfGANF+6+o
         FkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wuS2WA7Jif5QUvj7Fml1sgZWSEjo5/eKfDep4R9AnUE=;
        b=nguUVZDvpJlnmBFCpq1wgumt7pIB+PGsONGg3HM7EUkYJQMNWYGjsJ1U8NAxlPFHnJ
         Syg6/OdU2ze9T/H5wEGl1+FN/NkTlMCRkIR2MP6+kYXCJ1fmukaUTFzHICv1L9BQro06
         Pffje5/wSigo0v1TnfhamhwF5nzcROuGNH108SoeB3SDgpLaltwcGrPzmZIrWp4xy/1V
         /ON0Iu0cS1cHcpFImSmQIWzrrsax+ydwc9tIVtTs3FV9BwZe90XEHZQJVJnhNT0kZojq
         cykcmhhHNCbnHr+1mT+dJTB/kSG682HgPCRKgMIxbxjEh3iQrEOXW/Cdzg6WBm/Kaqa9
         q0cA==
X-Gm-Message-State: APjAAAU8b23P0p3ay4mqFstOUTHPPX4DC6DxKzcL0BdjHtt6OXYpP/UD
        wsybHJExnhpE/nFY9OE8/8SCgVAh
X-Google-Smtp-Source: APXvYqyyXTW38chu46DRTFqhXQRsgdF/U/9CX2+K9PYX/ORE9bdmhqsgmMzl3XlQKWMdvjB8cMtjPw==
X-Received: by 2002:a50:92cd:: with SMTP id l13mr49418150eda.136.1560860642418;
        Tue, 18 Jun 2019 05:24:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm4642663edc.20.2019.06.18.05.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:01 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:01 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:46 GMT
Message-Id: <e813075ade89380848bc7a9cb711cb52642ae4d5.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/17] msvc: mark a variable as non-const
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

VS2015 complains when using a const pointer in memcpy()/free().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0d8713e515..d14d33308d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1553,7 +1553,10 @@ static int try_shell_exec(const char *cmd, char *const *argv)
 	if (prog) {
 		int exec_id;
 		int argc = 0;
-		const char **argv2;
+#ifndef _MSC_VER
+		const
+#endif
+		char **argv2;
 		while (argv[argc]) argc++;
 		ALLOC_ARRAY(argv2, argc + 1);
 		argv2[0] = (char *)cmd;	/* full path to the script file */
-- 
gitgitgadget

