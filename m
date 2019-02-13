Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DFC1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 23:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfBMXld (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 18:41:33 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38192 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfBMXld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 18:41:33 -0500
Received: by mail-qk1-f202.google.com with SMTP id v64so3594000qka.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 15:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i/XDFhIrPfzogvcR06jjsLbjshsNBPw4L2du0uZGXQk=;
        b=wFVG3WIRz/Yl/byOhxPv9dZJLOB7AZgWTma31sVbY+YYfdiNDc+e3T0hYJRjy0toUv
         ih7nEqXaZpbQXWCXd64X4Hs0/+1H1s6RVBI8RdxFq+RrghrD/6M5IZ1oD01M8u3SRdPv
         szDu5qDHTr2aY9yMd+pQqzMveS9boYOIJUgT0YxpJjK+hWDIclFRqrkzh4qXKLEjrsTA
         4MkDW/waH1tFY0BZrmuVebH2YoyEx1pmjj7Q9wHTkDLJE+U2W8PGFE4sNic1TO27t0jL
         agyhjGsagppvoZyc5yDYJTopjpxL3j0UdCE1FvnlWAA7+xqH9hGwrDBg+JZWd83M0JtN
         TpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i/XDFhIrPfzogvcR06jjsLbjshsNBPw4L2du0uZGXQk=;
        b=k6r8o6WwZ5cU/J2KQiuyzMasl36jWtgk4TdEAaqC5MN+PrYN85NozrljfFWL/WPN1G
         WvrSO2+xqXkTpHSFPzCyNWHw/EjB487Ei17O8tVXzB6+vc2G7DcOhAlAuDYoEFOZfE4R
         6AP/KZKNHF+6kHy0EaW9Oi7BMhAehjTV1Bdn36cOkg7/SlculO232mmeIblQrAKT4D8A
         pr0tFlaUWXoWPHLCxgCJrnkeCQgvIrbbBkleCTuk9tG26FPNSFfImi5JDI1yQn0Qpf2S
         pQ7RE9rXqW3lO6lpKuKmNsfgo4hcjVwpWpBijPXr/0iEzSc/2keY/ASE99fht5961ZmD
         kPBQ==
X-Gm-Message-State: AHQUAualPDGRHJlUxIF6ktzJGn3qFplsLB48EdnL2Oo1iOO5TTpaVBML
        nIVvUlp76IFoFZhlrGh7uZBU7jnD6nF/xhHWaRT5PSw68Jnlp1evC9UatzXPnJ3ClTbYWIHNJQm
        N2dcm87zbbMnL+MNq8TBlxkqQcCWIf47pi/iOx1nSz7SHUBu4dola2jpl9lfSyNQ=
X-Google-Smtp-Source: AHgI3IaHpWrVZYuqSlmVCZo0HfsfSqa+RpEXxAay64HTnsKs9542e6r4GdD1BR/HOhdYQrsHfh2S6O59p30APw==
X-Received: by 2002:a0c:ae41:: with SMTP id z1mr477167qvc.11.1550101291826;
 Wed, 13 Feb 2019 15:41:31 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:41:28 -0800
In-Reply-To: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
Message-Id: <cb1b2834b7365f6277d1ec573cee7fd68a7329d0.1550100949.git.steadmon@google.com>
Mime-Version: 1.0
References: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v2] protocol-capabilities.txt: document symref
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7171d8c15f ("upload-pack: send symbolic ref information as
capability"), we added a symref capability to the pack protocol, but it
was never documented. Adapt the patch notes from that commit and add
them to the capabilities documentation.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Range-diff against v1:
1:  4ffb11ff77 ! 1:  cb1b2834b7 protocol-capabilities.txt: document symref
    @@ -12,6 +12,17 @@
      diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
      --- a/Documentation/technical/protocol-capabilities.txt
      +++ b/Documentation/technical/protocol-capabilities.txt
    +@@
    + Git Protocol Capabilities
    + =========================
    + 
    ++NOTE: this document describes capabilities for versions 0 and 1 of the pack
    ++protocol. For version 2, please refer to the link:protocol-v2.html[protocol-v2]
    ++doc.
    ++
    + Servers SHOULD support all capabilities defined in this document.
    + 
    + On the very first line of the initial server response of either
     @@
      purposes, and MUST NOT be used to programmatically assume the presence
      or absence of particular features.

 .../technical/protocol-capabilities.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 332d209b58..2b267c0da6 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -1,6 +1,10 @@
 Git Protocol Capabilities
 =========================
 
+NOTE: this document describes capabilities for versions 0 and 1 of the pack
+protocol. For version 2, please refer to the link:protocol-v2.html[protocol-v2]
+doc.
+
 Servers SHOULD support all capabilities defined in this document.
 
 On the very first line of the initial server response of either
@@ -172,6 +176,20 @@ agent strings are purely informative for statistics and debugging
 purposes, and MUST NOT be used to programmatically assume the presence
 or absence of particular features.
 
+symref
+------
+
+This parameterized capability is used to inform the receiver which symbolic ref
+points to which ref; for example, "symref=HEAD:refs/heads/master" tells the
+receiver that HEAD points to master. This capability can be repeated to
+represent multiple symrefs.
+
+Servers SHOULD include this capability for the HEAD symref if it is one of the
+refs being sent.
+
+Clients MAY use the parameters from this capability to select the proper initial
+branch when cloning a repository.
+
 shallow
 -------
 
-- 
2.20.1.791.gb4d0f1c61a-goog

