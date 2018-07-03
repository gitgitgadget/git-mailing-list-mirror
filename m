Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703E81F660
	for <e@80x24.org>; Tue,  3 Jul 2018 13:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeGCNRX (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 09:17:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44263 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeGCNRW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 09:17:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id r1-v6so971757pgp.11
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=whileimautomaton-net.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TR7NMl6ULQKCpmmNMDy3jNzn5gTpy1pc5hbID2imwWA=;
        b=etrOPEyQiSueGA3Ww9GtZ62cFFGWgPvGDv3ZlLeg6wzIoMo6pw4PXAG9rm3e1zJqKv
         9ojmp6bDkp0bDF+hPqX1C25Xfk7VHY/nmdZc7eCoqSRh+ZFG8x3GIjrO9ppcdRIKWwda
         /wqXQQ40gUQnEKtNV4Dhmo5UeNBdqaHLD+g8u8SPFM+c9y/yicA0MVpM77jt0FvEpNK0
         4WH/zJW5mVxwqLZnZcLmc+8lcDy+OUakM97mrSbEctQjYq3hvh9fX2G2R7MwLgd9GLi/
         L4yoUQS9D+9PZQratOkcu7UYz5N74xuzfPQVu0kRTjzXX+bcULqJSIz6Cb3AA/+KimmY
         9nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=TR7NMl6ULQKCpmmNMDy3jNzn5gTpy1pc5hbID2imwWA=;
        b=omb1i+XuZ2ylLtCAK5WJzNVBBxC3/nox2/J7fHVqbbsm059ZDa0Li/p4uOoZb9TqFZ
         G8zFZlVJKEUhIqkT9ZQQ65t49xQG4ad9acC9p39Idqql0PfmFxQgpArgbjWVedkMdP8u
         7jm2amAqze9KwqLgGTpPyWF9cFkl3NmzPkuln89ZoKiqhqqecPbpBcOyqiQtmXCF9UpM
         YYRjQgu7US7hJSfiI3xXpO7ZujzA/51rg7CqbZcR+48xF2BCY3G03THii77Kpp8DAiYD
         SQqBDCWycX6VCaIfk5LHAzGYj7trXjE582onvB6l90x9pEg0yYw2JuPT3WisnixTgsBH
         gIMg==
X-Gm-Message-State: APt69E2KGnY2A7GULnUvhWa9izAyZRisQ24/raArEijfvy+EGDTGJkGV
        spOV1grxUiI6vQrH9A0L1in0kI/VB96Bcg==
X-Google-Smtp-Source: ADUXVKK7QQgWHddwznL4mxokR88n9CCFd0ciM0TnDcur4kcVypWFmYqx4sii/0kgfBCrAcuhtN1g6A==
X-Received: by 2002:a63:64c2:: with SMTP id y185-v6mr25305007pgb.126.1530623842186;
        Tue, 03 Jul 2018 06:17:22 -0700 (PDT)
Received: from localhost.localdomain ([150.249.215.106])
        by smtp.gmail.com with ESMTPSA id 14-v6sm3664730pft.10.2018.07.03.06.17.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 06:17:21 -0700 (PDT)
From:   Kana Natsuno <dev@whileimautomaton.net>
To:     git@vger.kernel.org
Cc:     Kana Natsuno <dev@whileimautomaton.net>
Subject: [PATCH 1/2] t4018: add missing test cases for PHP
Date:   Tue,  3 Jul 2018 22:15:39 +0900
Message-Id: <20180703131540.60789-2-dev@whileimautomaton.net>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20180703131540.60789-1-dev@whileimautomaton.net>
References: <20180703131540.60789-1-dev@whileimautomaton.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later patch changes the built-in PHP pattern. These test cases
demonstrate aspects of the pattern that we do not want to change.

Signed-off-by: Kana Natsuno <dev@whileimautomaton.net>
---
 t/t4018/php-class    | 4 ++++
 t/t4018/php-function | 4 ++++
 t/t4018/php-method   | 7 +++++++
 3 files changed, 15 insertions(+)
 create mode 100644 t/t4018/php-class
 create mode 100644 t/t4018/php-function
 create mode 100644 t/t4018/php-method

diff --git a/t/t4018/php-class b/t/t4018/php-class
new file mode 100644
index 0000000..7785b63
--- /dev/null
+++ b/t/t4018/php-class
@@ -0,0 +1,4 @@
+class RIGHT
+{
+    const FOO = 'ChangeMe';
+}
diff --git a/t/t4018/php-function b/t/t4018/php-function
new file mode 100644
index 0000000..35717c5
--- /dev/null
+++ b/t/t4018/php-function
@@ -0,0 +1,4 @@
+function RIGHT()
+{
+    return 'ChangeMe';
+}
diff --git a/t/t4018/php-method b/t/t4018/php-method
new file mode 100644
index 0000000..03af1a6
--- /dev/null
+++ b/t/t4018/php-method
@@ -0,0 +1,7 @@
+class Klass
+{
+    public static function RIGHT()
+    {
+        return 'ChangeMe';
+    }
+}
-- 
2.10.1 (Apple Git-78)

