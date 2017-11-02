Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D465B20281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934373AbdKBTmA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:42:00 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:52619 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934345AbdKBTl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:41:58 -0400
Received: by mail-io0-f194.google.com with SMTP id f20so1467109ioj.9
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BeEDvZuuydYDmEZ7FDie08jcIykXOytyJ4WRSrif5i8=;
        b=qFG33PoSsMGvDvv33Z5v4Apiz1J+YK8MDZK/Wz0P/BGXHUSAGBzjlGWaZy5aMfuuus
         JwxVunWZ3o1XjXhopR7VsZ+BwP/0U0qH68RF+5MmXXOzY68TEubXKNW4MgFqAymPpGav
         Um4EShRMFmzEv1402kIsFVCtuU/sofOEiJbU4RWtw0HupXGTuxgWLsXasKinqfvjliC8
         mdnVRseh5jKN4i3CHkti5CmSj+FoKZXlAcGLq4K+YVUHivGv42whri4S9nF4/3buF74h
         K4PYJ3hFvkd/ozXg1WFWLRx2U3/zQilhJ688zQeZnioWNRMZO+LOWGRrRWEKUEjBpIO5
         +4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BeEDvZuuydYDmEZ7FDie08jcIykXOytyJ4WRSrif5i8=;
        b=TDdeAVBAOUn+hk9FY/IE8lU4C0D615ItSxhoVlGjbA43Imj7pp1RPx0lZJV3O6EO15
         pQVSSu6aOzdDmE4XSTWMj7cs3DVSyIxf9pjEzJrw0r5hszqd6xBF49n1kAZaM7dKvoHG
         XSg8z8tp0kVnHjy3JLAf2U38VOX3pRho6Fp8sXbyPrijVAl2MeNChFGVDLZ/xU9xd11D
         LisCG6CxPBt3L98gbb9Djplpg7jPTnKyR8uo598CmXCZhsHpvopi9dCopjFXi6r+KUT8
         iBqkBPfTKLSH0KDHJtQfgPcrZUmlCMSqJa2674Ta6NiYfsPtrfN3SEq64Uw6M+F5j+mp
         Ke7g==
X-Gm-Message-State: AMCzsaUzTROf0aCkDs2fw6+JF6y5olzXwFiMLQfMgztRVeaG9QUmXjbr
        2PiI4mxpbVTZuzXZoryUWiCeqA==
X-Google-Smtp-Source: ABhQp+RSEZEvYKFycyFigOD4mvTGI+UUf3xMXyNw/3jzMvOYDbOTTChZ04y36U+3yk1NlzDtwjZOtg==
X-Received: by 10.36.144.4 with SMTP id x4mr4016082itd.103.1509651717684;
        Thu, 02 Nov 2017 12:41:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1093:e9fc:3ec5:201d])
        by smtp.gmail.com with ESMTPSA id s81sm1847425ioe.84.2017.11.02.12.41.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 12:41:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: [PATCHv3 1/7] t6120: fix typo in test name
Date:   Thu,  2 Nov 2017 12:41:42 -0700
Message-Id: <20171102194148.2124-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <20171102194148.2124-1-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
 <20171102194148.2124-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t6120-describe.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1c0e8659d9..c8b7ed82d9 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -304,7 +304,7 @@ test_expect_success 'describe chokes on severely broken submodules' '
 	mv .git/modules/sub1/ .git/modules/sub_moved &&
 	test_must_fail git describe --dirty
 '
-test_expect_success 'describe ignoring a borken submodule' '
+test_expect_success 'describe ignoring a broken submodule' '
 	git describe --broken >out &&
 	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
 	grep broken out
-- 
2.15.0.7.g980e40477f

