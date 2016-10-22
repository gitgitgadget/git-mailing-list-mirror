Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B89920986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965111AbcJVXdk (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:40 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36218 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965078AbcJVXd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:28 -0400
Received: by mail-it0-f51.google.com with SMTP id e187so74382174itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3PE/J5GE13C9kVBR9iQQlac2hbJQvOJ+ADVC9rRS6SI=;
        b=hJMBp1cPoSzlWWggmHoqN5eGWLI4u+C6VPKQS010MkKxwDaLwphhjSMC+yxtX3NZIY
         vlvMAYV6vQy2fb6iMjzXkQDh1hgZXeJtZHZuW7cmFXMWBBTPHTYWIHEqEg/4CwtGKjyC
         4cnQiC+Rmzn907e+br2p8AHrPulaTJ74oH4dO+MMBksrgofWYEiNaKoCflpnMIIw5AH9
         oFSPzdQ0g1aNJwfHqiZz0S+Sypr/AzV+6EhvuyLIwgq+hoiTd2iy+dbgKjOi1pUh0uts
         IRPmXNx2qaF6zGa+Nw3jpHf7lJKqiMwUqluMmaPoVn9L1LcbmPI4L/YDVZQUphKAyXoX
         RcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3PE/J5GE13C9kVBR9iQQlac2hbJQvOJ+ADVC9rRS6SI=;
        b=j/Lyfstg+/4s91xZMqDNkbj58KE/1V6G2ID6NrIBQg+HGqUaxwmcGiMXLwqfpz8WkB
         Z6LkE2HalQlmhsHZA1YjTN+idJL2coShYOVyoc/3mpjbYwz/b5blWLQZWkS+VytBcxYy
         SofBQ3uNb11HvjK4nk6xWxPENRyhpdxBzt6eDr2eZWLvcNcMgRMby/NKnnmL+mX4CxKE
         f/VmVVaZ5id35WU7Dc42XmPwxZ7n9/m5rxp1/OZrTYpyyYdmsDFpuHQUNIfEjcI65xBJ
         s/EFAV7RGsqNPe+hQ3U5C4FtD+SlGwkTP5LWjn3vvqoZDQB0tstU7mPQD876RWs25RvK
         SnTw==
X-Gm-Message-State: ABUngvfUtU9dYUfff7vAiD5k2R/qypjQVd+uU+xEPznq/qvxAHaHLQ9sg3jHfThylGM7sqoq
X-Received: by 10.36.13.207 with SMTP id 198mr4733467itx.82.1477179207880;
        Sat, 22 Oct 2016 16:33:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id 80sm4549978iot.36.2016.10.22.16.33.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 29/36] Documentation: fix a typo
Date:   Sat, 22 Oct 2016 16:32:18 -0700
Message-Id: <20161022233225.8883-30-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8a061af..5b31797 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -88,7 +88,7 @@ is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
-Sometimes you would need to override an setting of an attribute
+Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
-- 
2.10.1.508.g6572022

