Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE31201CF
	for <e@80x24.org>; Thu, 18 May 2017 14:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbdERODD (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 10:03:03 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33702 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754241AbdERODC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 10:03:02 -0400
Received: by mail-vk0-f68.google.com with SMTP id h16so2972067vkd.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eSmGltedDb7JMpWC7mcp+ys82mmMRzvPKIHn7Dbdi9o=;
        b=SdFMT/U4uuqGmhT2PjdwCif/IVO6d56tcyGbRRCgIqvW/QQs7RT6NtAUnYkObEbZSm
         wTVTqKMfJSLOCWC3ppYZuAc8SvYnHdqj5teJ8sABCSscLk2EmAyThxuMKGH60Od5ezQo
         /h+qWxJsaHqPRaIjXl7vRPF4guOBB2IBznndRjeBWQl1Lm5XyfvsLPRE+ztZxrzveihh
         VAfyEieTwFIJ4iPXPukLA2UyhI4JoA5J66dOZvAdzKE0DDbsXPn4MENTybercg5OJJKf
         8GZzixry/dZIn9hJNXJ/xoeSDNHE9knMkUmOr85IzRh9zQhO1+W2OyeLwmYcgFRrZ5yf
         k5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eSmGltedDb7JMpWC7mcp+ys82mmMRzvPKIHn7Dbdi9o=;
        b=QXpLJWimd7AC2187Sd+/d6kncTW+Xa2sqtpwXLf7j2OUo6yzxsCIyg6khRjr50powd
         LZtz0P/pkuwl/aV1YzWgYO2EckyGjgT5eoze8SqXKQrdL+vt6m863USttQDFs8CKlbTa
         vAXxp8UFBNWw3+6IrdpLZxTnAA9Rquu2PjfEcUKkD10GldSBM+WEVNCLE2VZJj6xJM0j
         KPunlMCwr0fNpwBfqdr5tJYqsDJaiPIruCOqmsgY9wCKeG8MekrSVR95UcLhq+fb8wsm
         VOYkGBYBbehhxl1qFrbrZSeQy0zwvyaPAsgYA034zEAJshxk2jbRnQ2pD0FuLwPn+1R+
         yGNg==
X-Gm-Message-State: AODbwcCYBGmU5p1LKjarSN4zR2y6nNqahvSxVwPk2FhqF1fR0WyAS376
        5s7NjLZIpFqmOIwVqIcdBn/VJiZcCCwl
X-Received: by 10.31.181.141 with SMTP id e135mr1827227vkf.23.1495116181369;
 Thu, 18 May 2017 07:03:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.54.233 with HTTP; Thu, 18 May 2017 07:03:00 -0700 (PDT)
From:   =?UTF-8?Q?Andr=C3=A9_Werlang?= <beppe85@gmail.com>
Date:   Thu, 18 May 2017 11:03:00 -0300
Message-ID: <CAP96LmMtfO5DC6hGeqJdZvcqj+29H_7=8S+uua8YC7YwFRC9Nw@mail.gmail.com>
Subject: [PATCH] doc: explain default option for rev-parse --short
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 2b1c229153a89c7608e64b87d2f933704c18b7ae Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Werlang?=3D <beppe85@gmail.com>
Date: Thu, 18 May 2017 10:50:11 -0300
Subject: [PATCH] doc: explain default option for rev-parse --short
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Git 2.11 introduced a computation to guess the default length
for commit short hashes. The documentation isn't updated.

Signed-off-by: Andr=C3=A9 Werlang <beppe85@gmail.com>
---
 Documentation/git-rev-parse.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index 7241e96..b49f053 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -139,8 +139,10 @@ can be used.
 --short::
 --short=3Dnumber::
  Instead of outputting the full SHA-1 values of object names try to
- abbreviate them to a shorter unique name. When no length is specified
- 7 is used. The minimum length is 4.
+ abbreviate them to a shorter unique name. When no length is specified,
+ it is guessed from the number of objects in the repository. In any case,
+ the actual length will be enough to identify the object unambiguously
+ in the current state of the repository. The minimum length is 4.

 --symbolic::
  Usually the object names are output in SHA-1 form (with
