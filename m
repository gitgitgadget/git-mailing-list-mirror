Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5421A1F732
	for <e@80x24.org>; Sat,  3 Aug 2019 23:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfHCXwP (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:52:15 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39443 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfHCXwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:52:13 -0400
Received: by mail-wr1-f45.google.com with SMTP id x4so27639368wrt.6
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ScuOaEaAnvZI50Ln+G80AcumRGAO9EqCNmbRV8mrfaQ=;
        b=Q5PiuhiVfSP4GOOPcviJAsqVFQkEcY/lpmUbUJqgFsh6RIYUlC9AvuupLJY5Jxo5Na
         AW6TlakI+WV2tFo7n7V4tyapnZbKJOAD85WFcvcsm02/XbKIUgw+S1Giz2f4r6Qghtzr
         o4x/76tS1uw6MW8E48FMkFKdb5hs+o2GHvi65SPy9eMcw+YIzNUX0rukbYwrLMP2Iecd
         /UcpnH+DTmIFMynyOeFou2IE5F1e/l0cKEw4lVte3l7n6V1CJ3rwvshuTpEHIUnZXGPQ
         ZKEXCGD3Oj6g4//ZMvVaYVA4q9sJps4KyooTcD+x+lpilJj26iM4bsTglWBjzov4LPdP
         ihUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ScuOaEaAnvZI50Ln+G80AcumRGAO9EqCNmbRV8mrfaQ=;
        b=gLjgcnvh4u9g0a80saQxvbBlMp1yph3HUVsCtdgNF68YbwmDxkcCL9QxbEnOhcXmFL
         tFzcJbpU6hEzhfOYNLKtCd3asibyQvSViEeBfEa3aeySF+Tm3cP1IrJIiBIC8Jz0TQ7h
         6vpj9HufspMiaqncvyVLzaGrY77YndptjAQrePgWHdoEOKbvpJ2mAgUJX6n6vXwnbe4t
         gtTRHXwl+i+f8vPr6Xc6T44fvV0BD0BqipNnL4/gS44Xr6iOAW3WYNqWtTPVAz9Qm3Wg
         /Nh9vV7T6Ergk6LQEbng60sWRN8dciAZdkDH7sjogvAjDlUlcldP+z9ZChtuU9UxJeSB
         YmHw==
X-Gm-Message-State: APjAAAWu49xkTc2cdePn6lQcoAn9ytSfcUxzEN0NlByDVp2kYfJAdpGw
        w7+84Tr+UP7LUhq7tXTaMv44upp+
X-Google-Smtp-Source: APXvYqyzW67FohdIdTd6P7zNDKnKD5ZY5mlMAbhoSZMTinF34p+DeTu+7E/sRKYbqghAetnSpcP+0A==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr20589642wro.209.1564876331524;
        Sat, 03 Aug 2019 16:52:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3sm83408396wrx.19.2019.08.03.16.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 16:52:11 -0700 (PDT)
Date:   Sat, 03 Aug 2019 16:52:11 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 23:52:04 GMT
Message-Id: <df67a7e1d307d6a7a91ae1bba085959154006ed1.1564876327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/6] GIT-VERSION-GEN: Use sed instead of expr
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

Plan 9 don't have expr(1).

Signed-off-by: lufia <lufia@lufia.org>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index a0766f64ed..754d4486f5 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -26,7 +26,7 @@ else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+VN=$(echo "$VN" | sed 's/^v*//')
 
 if test -r $GVF
 then
-- 
gitgitgadget

