Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBEF1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390399AbfKERHs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:48 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33566 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390369AbfKERHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:44 -0500
Received: by mail-wm1-f50.google.com with SMTP id 6so357318wmf.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kLyi4cs6YrKTLG9DzH+u0EhcuEyzCz8omGW57vKs/MI=;
        b=Ew7T7Q6jb/9EYSpzcpRhIv5UJY2EWH9Run8g5/r0xwAwzDWTEoeRd4a4lRtXx1e857
         H4s0SeLjxEYHLcrVvnW7dE7+zRLoqBPutUhfBOk64LWP3dFxVEeWt9M5rJTWSVPxOVbp
         00Gy138aT4bxMKcuUOJ34NyqwaKjwK/NHg7hq+WmsM3ytpPXi573WrliEJvjuehZ7yVI
         lAKQ06qpl26JWgTZjnQmLbE2oIDQC5Og1pRFQCHvDVbX+9ubjg63CkbJ6Mpf4sdJtKUi
         RDAcgqwKrymDLGMmGFTcncIEMKEVoCp06K1oK1czItQaE1qztgJr1xMlmJbVTVt428EE
         om8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kLyi4cs6YrKTLG9DzH+u0EhcuEyzCz8omGW57vKs/MI=;
        b=jBns1+dyIvfc3knL3BHxK2h1kT+wnlhc0wKEhlAi+gn5JeCGijf3aTkmFZjjcM8w7z
         v28iknik5pW+WNDAhdPhC6skZJUBhzc+NjJ/TyyMSq81e59UU5VKNg2nX1xbMVY5Mot3
         SCeQ9JOzUW718TgXnG8/j7QbsU/DtGXeBPEOnTYj6ZBnzB/Jz43S2kKh+VKdbVMsgqhr
         CRt7boVupwLPCrW3uE/6hOrWn1L9+P6hFMHxzdWTEkRNVDQMlhvwDqoP0yusaRQvnLWQ
         vpDQwKf9Poikr+bSjLNCabI99H6X3oGqawoaDSArJkFMmULuxZsWJkFt9+qo7xzP4JTJ
         cAmQ==
X-Gm-Message-State: APjAAAX+42lxOw8yqNMTww9tbzzoqyCr5VyhvyOU/v6H+V+OhHGHe+UF
        ZJaVMy8Ww1U/TG1R0bf9YRFTEXxd
X-Google-Smtp-Source: APXvYqxAylbcdk0MSq/Yymk76rAYDjZdxWwnk3VWXmYehjG6E/cuPWE7k06FAxs4y94meAsL75pt6Q==
X-Received: by 2002:a1c:6282:: with SMTP id w124mr20968wmb.172.1572973662793;
        Tue, 05 Nov 2019 09:07:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm1290wmi.39.2019.11.05.09.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:42 -0800 (PST)
Message-Id: <9767da6f8e35efe23b23ff751dde7e7e57b49509.1572973653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:29 +0000
Subject: [PATCH v2 10/11] multimail: fix a few simple spelling errors
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Also submitted upstream as:
  https://github.com/git-multimail/git-multimail/pull/208

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/hooks/multimail/git_multimail.py     | 8 ++++----
 contrib/hooks/multimail/post-receive.example | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index 8823399e75..f563be82fc 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -95,7 +95,7 @@ def bytes_to_str(s, errors='strict'):
     unicode = str
 
     def write_str(f, msg):
-        # Try outputing with the default encoding. If it fails,
+        # Try outputting with the default encoding. If it fails,
         # try UTF-8.
         try:
             f.buffer.write(msg.encode(sys.getdefaultencoding()))
@@ -2129,7 +2129,7 @@ def call(klass, server, timeout):
                 # equivalent to
                 #     self.smtp.ehlo()
                 #     self.smtp.starttls()
-                # with acces to the ssl layer
+                # with access to the ssl layer
                 self.smtp.ehlo()
                 if not self.smtp.has_extn("starttls"):
                     raise smtplib.SMTPException("STARTTLS extension not supported by server")
@@ -2148,7 +2148,7 @@ def call(klass, server, timeout):
                         cert_reqs=ssl.CERT_NONE
                         )
                     self.environment.get_logger().error(
-                        '*** Warning, the server certificat is not verified (smtp) ***\n'
+                        '*** Warning, the server certificate is not verified (smtp) ***\n'
                         '***          set the option smtpCACerts                   ***\n'
                         )
                 if not hasattr(self.smtp.sock, "read"):
@@ -3189,7 +3189,7 @@ def __init__(self, **kw):
         self.COMPUTED_KEYS += ['projectdesc']
 
     def get_projectdesc(self):
-        """Return a one-line descripition of the project."""
+        """Return a one-line description of the project."""
 
         git_dir = get_git_dir()
         try:
diff --git a/contrib/hooks/multimail/post-receive.example b/contrib/hooks/multimail/post-receive.example
index b9bb11834e..0f98c5a23d 100755
--- a/contrib/hooks/multimail/post-receive.example
+++ b/contrib/hooks/multimail/post-receive.example
@@ -56,7 +56,7 @@ config = git_multimail.Config('multimailhook')
 
 # Set some Git configuration variables. Equivalent to passing var=val
 # to "git -c var=val" each time git is called, or to adding the
-# configuration in .git/config (must come before instanciating the
+# configuration in .git/config (must come before instantiating the
 # environment) :
 #git_multimail.Config.add_config_parameters('multimailhook.commitEmailFormat=html')
 #git_multimail.Config.add_config_parameters(('user.name=foo', 'user.email=foo@example.com'))
-- 
gitgitgadget

