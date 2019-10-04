Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25C81F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 22:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfJDWIc (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 18:08:32 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:32790 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 18:08:31 -0400
Received: by mail-qk1-f202.google.com with SMTP id w198so7967658qka.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rrfjlT2d1ppUSO9oJnMgWJPtCSuFxQnwsKohJ+DUp2w=;
        b=KmK7DM0n0dqOpuDixssDLQsvfz8O+y0y2LUPkWc8aM/qoWqYyCkUcfpkx8SFDmIVKf
         HJ5bUEOVzr1bXY8QvBN3BTzsqoISEkHaGjYMxR6x/FCGwjIU8eZYmXeiFPfskkbBULJQ
         nVh4hZ3Eyy8Qwo6xvEdNLZ5IiyGwZ1GFEEA+Z/6OSc/2t4CX1VH3APboiV6RvZqrEyJ8
         dr1KpfGmNr9/0GDGE32AzAVz6IaD3iOc8UhYp1SGt0vDWVl7R2n7UJ90vbR6+Y8ukqGO
         WPZlONVKutcWiwLmwoZjf/8otM7qHx8E8+EIx+dwvRCLXaMnDvlCrytEZgt8/wGCc5RC
         xLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rrfjlT2d1ppUSO9oJnMgWJPtCSuFxQnwsKohJ+DUp2w=;
        b=GnFz4aVasiiqv5MHPc/puQ+Ca3zfED9ifb84PC66ykY8jZXbgk+r+TmDDhSCuhm9Mh
         yqMvJvuW0O9ZwunA3sfULt/L9QosJ+K3qzGivMb2kkV3slfM22a3uZxZQN2d1POtLVfu
         YLEhu4rYjzygsmH/pfuBuJ9F9Vq8SaqkE8j1J6Q+UBF1M3XnfUhMujHsAfhtVA1IzAci
         aipE3u7wXhFC6Lfh9WizxQTjwkfVl4jhTa1J6ByYpwtrvAxADPNMXkSQjN510kzGQDBH
         jVDnU6aTWT69KfOw4Vtoqq2bH+WPgJvCFuopSQ6QCkYSy9HmO8Dty7TfOxPhO6b2RxH8
         flFQ==
X-Gm-Message-State: APjAAAWJv4Fp2nbA4vHYTBqIuFI8fIsJ5P/QWkmpwHQW7QlHbBi9kiPG
        H7xhg/GmEijqbRfnz5mTttQsihmNEKFiF44i7+K/eYrjyfCGZ3HsdzLSdZxzkReCqh9RIaXOuga
        ovUVqmLMwCz0kyG8UlF7RACMjZOx4cPksNM/Rsip1NARUsNCqcG0hZO2wZJdW9jk=
X-Google-Smtp-Source: APXvYqx7+uqgTO9pbaeppswZIyFapQUQ9xJQ60b83g6Ns/LWGpMxrK2MMf8cb76oWHyJ5Sjb0m08DjKTS05edA==
X-Received: by 2002:ac8:548d:: with SMTP id h13mr18689682qtq.228.1570226909267;
 Fri, 04 Oct 2019 15:08:29 -0700 (PDT)
Date:   Fri,  4 Oct 2019 15:08:19 -0700
In-Reply-To: <cover.1570225500.git.steadmon@google.com>
Message-Id: <a757bca8f99bad57806bfdcd67ac1c1f6cc38584.1570225500.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1570225500.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v5 2/4] docs: clarify trace2 version invariants
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it explicit that we always want trace2 "version" events to be the
first event of any trace session. Also list the changes that would or
would not cause the EVENT format version field to be incremented.

Change-Id: I20b9ac1fa0786bcaad7e290cc805cbf45b323021
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 80ffceada0..18b79128fd 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -604,7 +604,13 @@ only present on the "start" and "atexit" events.
 ==== Event-Specific Key/Value Pairs
 
 `"version"`::
-	This event gives the version of the executable and the EVENT format.
+	This event gives the version of the executable and the EVENT format. It
+	should always be the first event in a trace session. The EVENT format
+	version will be incremented if new event types are added, if existing
+	fields are removed, or if there are significant changes in
+	interpretation of existing events or fields. Smaller changes, such as
+	adding a new field to an existing event, will not require an increment
+	to the EVENT format version.
 +
 ------------
 {
-- 
2.23.0.581.g78d2f28ef7-goog

