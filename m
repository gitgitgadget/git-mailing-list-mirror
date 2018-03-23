Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46E71F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeCWS12 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:27:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39444 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWS11 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:27:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id f125so5158110wme.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XcRXFfxvcTK6zQJgncAe5MUNs7As07AkHYHWios0Qmk=;
        b=1l8Q6VGTrWBAhPV1sq1lSaecENpBItb7nxXo2BGTzMp+y4phdgtxP9wSUHtkZ3Tchx
         RqfWDhdMD/g36VocRoRCTQNG2j+O8zmiWmsOBs4LVwBvg9gBfx3xSJZtECB6pH2LYfIZ
         PJlalupc2Dg62VVXEwJAcLS3qnZtBJ6mWjj1OEqmH9TzYUzFRj4Xs5dKJ5trLDWlPxGI
         m3W2IXG8e8ahLZq5+WudkuACELbjaoj1f+9ezITA/4XctWedFFCd6J8iQvpBPSIL9PJF
         KiqbEh4g2QpuvAmEnrWFtXbnNjiPhiUtmixE6LyDLSTB7ZuohHeInwiWuM2kfE/SeCQd
         0eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XcRXFfxvcTK6zQJgncAe5MUNs7As07AkHYHWios0Qmk=;
        b=i5jIa6rRR6tgbhRcyTcPNXrw/KwEDMpZ87OmCUS7QnqA8u6CAHetLYxQAv6GfuLcUn
         8Cp5NxXVMkJ2X77BnPAvMzgtsv49g7ppE+k74TNgR98ckqb9VZDZn51Zubot4+A2Bp/X
         0UA9vTQEye0QUFjmKq+IlmL15z4mfALEllDT1U/nI6knfqwp6sb7MNkJZxQLrj5AzcxH
         PaUuo1b54nTiPVobOfvigmggyg+CGd19tnU6LAfvblCeSdoSbwdLaPibeEpU0Jb/JpWV
         /B9iHpF9ckHZRJXeJyXarKbhC79iSjp/S/9aKWQC5CnNKPI654UQt29U9Z71jkz26yXo
         YxKQ==
X-Gm-Message-State: AElRT7GnOlJ1fgt7Ziy7U1izfxMKxkx+iyXUIsCjjpo237SeBIW55BJX
        KBnVFGOsysE0A9+V68djeFHh5w4o
X-Google-Smtp-Source: AIpwx4/xcQfX9Ng370VSFlymI3MXzDd5FGn2+Gtmk5pLAbXBnqYpzjxT07fwKl0LAIoeyW0IfU2Psg==
X-Received: by 10.28.191.75 with SMTP id p72mr2521302wmf.15.1521829646222;
        Fri, 23 Mar 2018 11:27:26 -0700 (PDT)
Received: from voidlinux ([41.136.242.177])
        by smtp.gmail.com with ESMTPSA id f10sm4936390wrg.67.2018.03.23.11.27.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 11:27:25 -0700 (PDT)
Date:   Fri, 23 Mar 2018 22:25:06 +0400
From:   Loganaden Velvindron <logan@hackers.mu>
To:     git@vger.kernel.org
Subject: [PATCH] Allow use of TLS 1.3
Message-ID: <20180323182506.GA15493@voidlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Done during IETF 101 hackathon

Signed-off-by: Loganaden Velvindron <logan@hackers.mu>
---
 Documentation/config.txt | 1 +
 http.c                   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea..f31d62772 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1957,6 +1957,7 @@ http.sslVersion::
 	- tlsv1.0
 	- tlsv1.1
 	- tlsv1.2
+	- tlsv1.3
 
 +
 Can be overridden by the `GIT_SSL_VERSION` environment variable.
diff --git a/http.c b/http.c
index 8c11156ae..666fe31f3 100644
--- a/http.c
+++ b/http.c
@@ -61,6 +61,9 @@ static struct {
 	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
+#if LIBCURL_VERSION_NUM >= 0x075200
+	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
+#endif
 #endif
 };
 #if LIBCURL_VERSION_NUM >= 0x070903
-- 
2.16.2

