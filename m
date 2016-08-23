Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B951FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754181AbcHWRdp (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:33:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35819 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbcHWRdo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:33:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so19042056wmg.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=2ozxUwKVmf9C/7c5m25x22YkZqrDld5cS3Zhs6kmXhM=;
        b=QSa69hXEtXkxL4IMSUjK7Ys1uLMF/qtbDWJ5RU1H1uRWD9+7/3O2xfHVHEXMgovNTX
         AtL+MVimck2ZA5tal4etBkiX8oJHrIl9xfq4Kamj5HpxJN52GJOUqfU1d6C8LAPwMPhP
         qF4BBmBn8Vn/Xr8YA9lYlIkfmXkri6bX73/3+zGShJgc4/SPiIO6ONPd6qcEnKmcH31e
         pNaiX847DB/Z/gDRXbeM8Dg8gN9VwHDkjRSUZWATs49QDi0HX3sPoXjPrcWVhvsgsmPU
         FMaglDbZ7Kqig0e+jwEAX7XKemxxRsgU2JCCq3Iacp5SEqY4bOfbU+0qAieAGPA+rXGv
         6L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=2ozxUwKVmf9C/7c5m25x22YkZqrDld5cS3Zhs6kmXhM=;
        b=V56sZ18C5KcNoRbcGjmpbw1IdtsQP/zPP4juPdEZRAq7OT9yOXmjU9suMWK8YoRZjo
         OS9ijzfVPECAp0MWaCOcjIECVV2u2NNKf9mjpVr/viGSQKqw6GJRFQQ8p+w3X8Xg1y++
         H3D6JVNrwJHD+6IeTmo7JA9f2B0+HJVqyGYDprRLea/tDrv11fk4/wdbTCWua7Ff2dS5
         HDG0347BSJvQQcoOE5jPv0SaB4rZnsfLTffKJ0/P0SVwc5GSpecaMIdrsQHsMf3g69IW
         2j6c+KEKzfaOUzMl2NvllsruX316ylDn4iv+uTFh45YHGs5nsHtxWoa8EzzVE8qyrogm
         ijmQ==
X-Gm-Message-State: AEkooutKH04Hdvn3zq0QkdIDAtnrm4kFzwRVZycW4VaLg3KqNLYRt78iS26sP+QsEPol2K7+lxKdEhXLzvw4dg==
X-Received: by 10.28.32.77 with SMTP id g74mr20152629wmg.45.1471973622535;
 Tue, 23 Aug 2016 10:33:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.165.199 with HTTP; Tue, 23 Aug 2016 10:33:21 -0700 (PDT)
From:   David Glasser <glasser@davidglasser.net>
Date:   Tue, 23 Aug 2016 10:33:21 -0700
X-Google-Sender-Auth: E81k2qDfeW7OnNsSxbu94ZeRSjI
Message-ID: <CAN7QDo+S21T=1zjBEM7rq3epzvVx7GhmTZ5+sgV0BPvNYhvvUg@mail.gmail.com>
Subject: [PATCH] doc: mention `git -c` in git-config(1)
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Glasser <glasser@davidglasser.net>
---
 Documentation/git-config.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f163113..83f86b9 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -263,6 +263,9 @@ The files are read in the order given above, with
last value found taking
 precedence over values read earlier.  When multiple values are taken then all
 values of a key from all files will be used.

+You may override individual configuration parameters when running any git
+command by using the `-c` option. See linkgit:git[1] for details.
+
 All writing options will per default write to the repository specific
 configuration file. Note that this also affects options like `--replace-all`
 and `--unset`. *'git config' will only ever change one file at a time*.
-- 
2.8.1
