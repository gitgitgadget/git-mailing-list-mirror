Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78731C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 19:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiBTTsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 14:48:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbiBTTsC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 14:48:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1567DEDA
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:47:40 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so847599wmp.5
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fwo3UYW6381LIeQfWZDPCrs9GMeTsHYeEpFRKWdHyLs=;
        b=Ozun0Vf8Ie1kR5lWEIZ1gXXVcoTefDenfEn1C0Z/rZPFhNGgec3u1LfNe+1Npp/A//
         by8hLzHC2j/juoETpNH8PubEI0/JpGuSawl0o/2CedFYoZaPE6/n0BLaa7437zCIo6YK
         NvWIY6+BdxinUeBFnjHXBneAOb+vihJGuk1WWTETlcfWQuyxmVu4V6ShSFzhQq00h8Xg
         KaD62nbrjbiQ59qXGI8aWCIEb1DJWIxd6vehmAQzROkTEQRz7iw1aM/KqketG9XACeOJ
         XU5xuKTCFWlWV2abUZkqSmZf4yTM8y8ICX7/ND7tqOSiu6Tz4xOqImZ73TX7/+odemxI
         WHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fwo3UYW6381LIeQfWZDPCrs9GMeTsHYeEpFRKWdHyLs=;
        b=DD9WX2cTvpMhJ7jovx1zIW8Y1NJYPSkSvKbR39L3XirXNw0bJTP58FCoLpc46orwhd
         qjorDo25y6To7AXx9VThhM4Bbxazh0l/r9eadQSzVm/MmvKEsrehktQoL2kKYXRwpPb2
         rQU4nlPZp0mEIpWgNeRYPS0OVMB2g6AQh2f645YVeZpkh6XYn/89V751sMnI0kzUPn7r
         hdWPlZHJvtttYVoK4Ha76oGsOUFBJgLzu94O1BocbOSeUc77fWDASD8cUcCsKw3ELQ6L
         5EGrnGoce2sxvMQVJwR2H9n8NkftkL/kEtvORUwYcdFINFrmp1u5UOpEBOTNpLrF3ecm
         oqkA==
X-Gm-Message-State: AOAM531YC0fjvUZbl7QzFkCjFYJbyHCneI1f3RY7iNoeDj4HREeGZPM6
        WB0/vlIiVKvpr9Avwq3V7NVmt0BPSes=
X-Google-Smtp-Source: ABdhPJxPoSS0d3O99/oJd8HIDL4GmxpOTB7JBsB6+6EUuhw16ahXrFMKCoMtqVf1hVgmfVtSBiTR3A==
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr18446669wmb.157.1645386459134;
        Sun, 20 Feb 2022 11:47:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm32733609wrg.53.2022.02.20.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 11:47:38 -0800 (PST)
Message-Id: <49abba78f45b34484982532de970c0659ee6535c.1645386457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1219.git.git.1645386457.gitgitgadget@gmail.com>
References: <pull.1219.git.git.1645386457.gitgitgadget@gmail.com>
From:   "halilsen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 19:47:35 +0000
Subject: [PATCH 1/2] gitk: trivial indentation fix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Halil Sen <halilsen@gmail.com>,
        halilsen <halil.sen@mapotempo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: halilsen <halil.sen@mapotempo.com>

No functional changes.

Signed-off-by: Halil Sen <halil.sen@gmail.com>
---
 gitk-git/gitk | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0d..c31a8b4e2f8 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2955,9 +2955,9 @@ proc savestuff {w} {
 proc resizeclistpanes {win w} {
     global oldwidth oldsash use_ttk
     if {[info exists oldwidth($win)]} {
-	if {[info exists oldsash($win)]} {
-	    set s0 [lindex $oldsash($win) 0]
-	    set s1 [lindex $oldsash($win) 1]
+        if {[info exists oldsash($win)]} {
+            set s0 [lindex $oldsash($win) 0]
+            set s1 [lindex $oldsash($win) 1]
         } elseif {$use_ttk} {
             set s0 [$win sashpos 0]
             set s1 [$win sashpos 1]
@@ -2992,7 +2992,7 @@ proc resizeclistpanes {win w} {
             $win sash place 0 $sash0 [lindex $s0 1]
             $win sash place 1 $sash1 [lindex $s1 1]
         }
-	set oldsash($win) [list $sash0 $sash1]
+        set oldsash($win) [list $sash0 $sash1]
     }
     set oldwidth($win) $w
 }
@@ -3000,8 +3000,8 @@ proc resizeclistpanes {win w} {
 proc resizecdetpanes {win w} {
     global oldwidth oldsash use_ttk
     if {[info exists oldwidth($win)]} {
-	if {[info exists oldsash($win)]} {
-	    set s0 $oldsash($win)
+        if {[info exists oldsash($win)]} {
+            set s0 $oldsash($win)
         } elseif {$use_ttk} {
             set s0 [$win sashpos 0]
         } else {
@@ -3024,7 +3024,7 @@ proc resizecdetpanes {win w} {
         } else {
             $win sash place 0 $sash0 [lindex $s0 1]
         }
-	set oldsash($win) $sash0
+        set oldsash($win) $sash0
     }
     set oldwidth($win) $w
 }
-- 
gitgitgadget

