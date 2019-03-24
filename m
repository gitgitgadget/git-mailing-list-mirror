Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1FD20248
	for <e@80x24.org>; Sun, 24 Mar 2019 15:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCXPw0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 11:52:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38722 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXPw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 11:52:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so7345573wrm.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pW4+v+x/bsdUq1YfedztakDhpmLT5SUJT8/Oto3vApU=;
        b=vgnhPC2DFw5nXMsSNosGeP5zrYZnoA6SPE63Ma93XFzrqowAfK9OLoK5lkmn60xgxh
         Yo3z7lSliCRCLxX1aMiPfYiOt+F6b1OENLrvKJ0Day3qN8rx1bpLS837GHA9CJciPgvB
         rdSi7GNLnOClfg7ues7QOVtQ2h3HgDCY13ibpcK9LoEdGKPYg8Ye7IJ1UwjKB+AALcXX
         w9OHmRC0u3KEFt6BD6zD1x681St9xyTfiPVwZQ0sZDGytNoRK4YVJb3PRtFS3vqgpsXt
         u+X1HDRnkNhZ3OoFQeBEi/2G5YC9RSWT3kwD34SCut26bOrmznamImhJvT0Xl0J1jNWM
         Puwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pW4+v+x/bsdUq1YfedztakDhpmLT5SUJT8/Oto3vApU=;
        b=eTFQZ8ZE4VJxO+/Skk5zwFoKJ+ZykfAjztedTPbvoPhaqyaXpeUSSG8DCeTRjgKYoq
         pgw1MR4TGPwCCIHFsjO25Dfwhr9j+vz2/jIuK7Yk6O4ySPuBHxsurgynQJ4AaONc+67A
         6ku5D1NzXEge5LH3PnqVjoBVgj2XCqKb+m/vkD755T4lD881Gz4jtfGxnLWrLkuI3h6f
         au06DI3GEd6SZygl1Nq6lfVvQ503aAKuUAvWWJAohK9sLa7H0JPg5EjUKUuqlEt15Eg+
         dPx947UMRihftgdnCCNdviMXhd9UzLUhjg6jkCcU2YR1FjBM1thuMUzStcc9Alxhizr5
         MVvQ==
X-Gm-Message-State: APjAAAUIl9qhQFCmsSG+/1owQmqzeXQp1KDAmPVJKqcihP8KyTDhZ1Wg
        fANN9JRtFnts2QUnEG2J37n92CW8
X-Google-Smtp-Source: APXvYqzXyVLrgg0Ar6Gb6OAvpR6jrb1W8eZ3hYJTsz+MQWCxwVdfmlDKl2Xl9w1Z64V8SsgO8JoMVg==
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr13965481wrg.149.1553442743930;
        Sun, 24 Mar 2019 08:52:23 -0700 (PDT)
Received: from localhost.localdomain (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id y1sm31197407wrd.34.2019.03.24.08.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 08:52:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] Documentation/git-diff-tree.txt: fix formatting
Date:   Sun, 24 Mar 2019 16:52:17 +0100
Message-Id: <20190324155219.2284-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some more recent versions of Asciidoctor issue the following warning
while building the documentation:

      ASCIIDOC git-diff-tree.xml
  asciidoctor: WARNING: diff-format.txt: line 2: unterminated listing block

This highlights an issue where the "Raw output format" header is not
rendered as a header, and the rest of the document is rendered in
monospace.  This is not caused by 'diff-format.txt' in itself, but
rather by 'git-diff-tree.txt' including 'pretty-formats.txt' and
'diff-format.txt' on subsequent lines, while the former happens to end
with monospace-formatted example commands.

Fix this by inserting an empty line between the two include::
directives.

The page rendered with AsciiDoc doesn't have this formatting issue.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-diff-tree.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 24f32e8c54..5c8a2a5e97 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -118,6 +118,7 @@ include::pretty-options.txt[]
 
 
 include::pretty-formats.txt[]
+
 include::diff-format.txt[]
 
 GIT
-- 
2.21.0.539.g07239c3a71.dirty

