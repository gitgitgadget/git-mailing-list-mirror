Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5BD202A5
	for <e@80x24.org>; Thu, 28 Sep 2017 14:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdI1OGz (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 10:06:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53534 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdI1OGy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 10:06:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id q132so2528982wmd.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N7R4UhvKLn8HQSgo6hPvNT4p/Xp5C+/lCPQ5+KShNnM=;
        b=j7vbqAvBkDICImQnrkOVltEhWgb/m3OewHaE14WHtVsxuOJq1bLkctngwL2CoOJ58V
         nAuXLGWA8QBrPz6CW/kgONZ7kx/qkA3zT1EHWsMOvTSZT9Qt+Sm5rXLyjyYWq7LuZM2i
         THgAr6x+0EDRo7sTqEy1UV6Spu/CxSVNTCp9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N7R4UhvKLn8HQSgo6hPvNT4p/Xp5C+/lCPQ5+KShNnM=;
        b=C8yLM4W/9mctmqTyBuByb0SD6vmB9teGHmzKp3BODN2Hva6OyTEK/KIEhE0/P5pcGP
         NF0QrfD2JgQa6Iv/tHkXdLE3Y05hod/2KZ47GLI1Uk0l9NT3PtlRSTKv8YRAlGKbRXeN
         mxHJIpN57WpbhaAGcgXCZD3FC3e8nVjwgddY6rz0f6nyZST+O8iZ1f0ncG88XwPCNlxK
         U0IV9UrsJKRJq2t1f5b1YkiaMjYnFt4UfCUgYYnPPRx/5IvRrbc9MSQGdiNUhAFqczrT
         lD2LULfYcEJsNyKTZ5XAyUw0LaQyXkh4Ff/6sHqvrpePGzVBy/n0vm72mZYtvtmod6+f
         V52g==
X-Gm-Message-State: AHPjjUiSKWtSJMgGQJZOeor5M0lGwYD+SnP4omNj/DD5+Gnzg5l7Wb1u
        4cBWkpg9pUlOUWV92dqLfE2XUqezqnk=
X-Google-Smtp-Source: AOwi7QBxRnJ2usRPXVR+IhwrXopKoNPdbX2wFzoDIpP033UQT++5F3cbNspzpGQkgdr8gxz9IvEW1A==
X-Received: by 10.28.24.7 with SMTP id 7mr1376858wmy.78.1506607613079;
        Thu, 28 Sep 2017 07:06:53 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id n10sm1913963wrb.0.2017.09.28.07.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2017 07:06:50 -0700 (PDT)
Date:   Thu, 28 Sep 2017 15:06:48 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] doc: correct command formatting
Message-ID: <20170928140648.GC9439@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leaving spaces around the `-delimeters for commands means asciidoc fails
to parse them as the start of a literal string.  Remove an extraneous
space that is causing a literal to not be formatted as such.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6e3a6767e..98b9b46b9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -75,7 +75,7 @@ example the following invocations are equivalent:
 Note that omitting the `=` in `git -c foo.bar ...` is allowed and sets
 `foo.bar` to the boolean true value (just like `[foo]bar` would in a
 config file). Including the equals but with an empty value (like `git -c
-foo.bar= ...`) sets `foo.bar` to the empty string which ` git config
+foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 --bool` will convert to `false`.
 
 --exec-path[=<path>]::
-- 
2.14.1

