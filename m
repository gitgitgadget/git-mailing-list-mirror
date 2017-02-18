Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13AB201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 22:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750785AbdBRWrb (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 17:47:31 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:32960 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdBRWra (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 17:47:30 -0500
Received: by mail-wr0-f170.google.com with SMTP id 35so6332826wrw.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 14:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=gYQohMmzwVTE2IsJueJc7sUBx4p29MrzXKIeP0yXjuk=;
        b=dHul2E8JvwPPrP8o339iHy7AZ8csihsIn5SC12KyrSL+kXEBqMhKjlWTXNBkZ42tpA
         6IT2OE80yWeCZA6WraZVd8yX0sku+3wLhR8Wl7Uxby3efvAfryjCKAiBMaYTPHTY2JQO
         d9TH5BIMO7M585IIqmmNTlwc/ygQRqsbxkcAC7dR19lJRcQ15x6ksOuQxE+R/IobwGgP
         mx1lfrXiD7gM5sbeOopFet5Aa6oR10YFAhHcuTW6DP8FPz8IgR7cKJs/nh6wsOmPE1uz
         O+sB2S1sIkXobcG4XssQ45g01nQq4+GJfIqVHDk5RZiVVHE3AalQZJnnt/CPUhV3Z7rN
         1s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:message-id:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=gYQohMmzwVTE2IsJueJc7sUBx4p29MrzXKIeP0yXjuk=;
        b=ZWjW8A7Dt2rogITvfg7wCZSEV/imot5O/AibRZTz4jribpHIFAgNbCno/SAPKsSU7i
         g4EJtGiBeqsMitLjxbPp2TbHzF/Z3Mt24NTc2eMG6N8+QvVtkCovy8CCU9nTl63arC7R
         Ux+debh+uHYrRnpZCOSoCQdDjaHTLPwYXaK0lyr1tqxeDBiMY0Eb7Q4LwI/25E9kC8fe
         bZ8P7szmLRFPIu+oKLtQp+9k6rQb51UEjvsOSfiOJzUVP2W50t2Kf/bf97/h9Bq4un3/
         pvxSPBLRenl+oaipDb6E3c7fxxeX4giBNdjqbdYktbdOWQL4G255LzSfvpnZpn0kOSAx
         AMoA==
X-Gm-Message-State: AMke39mMmJCiDFCHbPIBy/gdKWIK6Jt2vvMnAIGjhUTgm7XgUuXzMzjOG9BP4WrQifzOCw==
X-Received: by 10.223.146.39 with SMTP id 36mr10903095wrj.85.1487458043909;
        Sat, 18 Feb 2017 14:47:23 -0800 (PST)
Received: from [172.20.10.4] (82.234.197.178.dynamic.wless.lssmb00p-cgnat.res.cust.swisscom.ch. [178.197.234.82])
        by smtp.gmail.com with ESMTPSA id y65sm7237352wmb.5.2017.02.18.14.47.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 14:47:23 -0800 (PST)
From:   Damien Regad <dregad@mantisbt.org>
Subject: [PATCH] git-check-ref-format: fix typo in man page
To:     git@vger.kernel.org
X-Mozilla-News-Host: news://news.gmane.org
Message-ID: <c27d7861-b161-a3eb-fcfc-bf766fc7b20b@gmail.com>
Date:   Sat, 18 Feb 2017 23:47:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


---
 Documentation/git-check-ref-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-check-ref-format.txt
b/Documentation/git-check-ref-format.txt
index 8611a99..377c85a 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -100,7 +100,7 @@ OPTIONS
 --normalize::
 	Normalize 'refname' by removing any leading slash (`/`)
 	characters and collapsing runs of adjacent slashes between
-	name components into a single slash.  Iff the normalized
+	name components into a single slash.  If the normalized
 	refname is valid then print it to standard output and exit
 	with a status of 0.  (`--print` is a deprecated way to spell
 	`--normalize`.)
-- 
2.7.4


