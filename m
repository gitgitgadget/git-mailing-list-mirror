Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F09207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 23:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756064AbcJFXsH (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 19:48:07 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33533 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbcJFXsG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 19:48:06 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so1771075pac.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 16:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=t/Jyw8d7FYk9KkqYIDrfAlr3FGQtNMG0lKyoIaPsr04=;
        b=bAqWFb2B+L07YeEkq3fOOfdEcWzXR732mU08+xbGupLXvLov25i5uKcoy6dfw44EWT
         vjzG04E35apFry1OdheiOmF2JB4QOFGDoR8AIoK+XQcCXCgmLiSYF5nje5vYhTNKTqFk
         TY2s8lUEU++MSzYirN3e492AFStvYGUa9aTxjyFB1ehaaGZiZw7pnpe8EexC+/KxJewu
         3eMuicrXIYOIBMW1TtlLvbo3FwxwceLbdhWWW1/gjlZjDL4KDGoaPhUn9YYy8meRbq+d
         8C6YdqoSSUhkQRoS+1RGPBFqtTbkyvtm3h/0mI4kJ9mVEKPENKSD69cKZTbjZlDofa+x
         TqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t/Jyw8d7FYk9KkqYIDrfAlr3FGQtNMG0lKyoIaPsr04=;
        b=EURfZ4S0HQoJshbnheo/XgGsODzGAf51UrWIb9gPrvUDkmhicR6JsvCSMuA7naR0Ke
         WSMohJTVjKIBrW8Jt36HxGiXHnp0hO6KuO+3zckuW0Xd9QmfjsaQHNatMHfIvc1RL7Aq
         L888Sd/XVn1tyvh05w15/Y0EnZyaxJpYzFzH4yVJCh3eDV4JJ9+TT4Z/tqUgEv18jkPo
         1YHO+oztgqdXnlkx2VDJeho7yVCYr1RMwYdGgl0sKK4ZIQKJ1iA82jphrrsIDUOatqS/
         0s8I4pZT4ZYaTXD6R+6p2jkAwXLLMgp2dMs2MkUjtQtg2/SnvTYFkSPVkjVVsqXMo/6+
         GNJg==
X-Gm-Message-State: AA6/9RmX18uWY5kFNF3MY/ny2CxzZ0JUU1VtOL/V3TdRUiHSj71j3tY2gRyHoZgWMYE5kQ==
X-Received: by 10.66.253.7 with SMTP id zw7mr25760008pac.25.1475797685533;
        Thu, 06 Oct 2016 16:48:05 -0700 (PDT)
Received: from localhost.localdomain ([107.72.96.123])
        by smtp.gmail.com with ESMTPSA id m83sm8490726pfg.48.2016.10.06.16.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 16:48:04 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH 1/4] mergetool: add copyright
Date:   Thu,  6 Oct 2016 16:47:56 -0700
Message-Id: <1475797679-32712-1-git-send-email-davvid@gmail.com>
X-Mailer: git-send-email 2.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index bf86270..300ce7f 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -3,6 +3,7 @@
 # This program resolves merge conflicts in git
 #
 # Copyright (c) 2006 Theodore Y. Ts'o
+# Copyright (c) 2009-2016 David Aguilar
 #
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Junio C Hamano.
-- 
2.10.1.355.g33afd83.dirty

