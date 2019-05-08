Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEDF1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfEHPCP (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:02:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39875 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfEHPCP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:02:15 -0400
Received: by mail-io1-f67.google.com with SMTP id m7so15082868ioa.6
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqBa/A8KQ9SQDHOYHmHjxeXA+N94N3CocdRQbsTHBzs=;
        b=ofGo8OzfTjRAICqLK8yQLfux1KT24/8Zxkpvp5z7SrFs3a3QAoE6iyZQF7XG3CsbKQ
         1k2zLSmF6NGL1BYEc/2HfrkdVZjht5wiNiM3zg+EZ5SG5RwmWpLtN0S7Rzz7kIdcOy6v
         4XiN2tC2/3LhHvaFlsXYl+O3Ert6rn3J6M3o9jdKRcoZ1tXO29i+31ZWNZPt6qC/P6qo
         2S0ojCJmIto84Ktppl3lLKhuGY+cGC+JX3lMvvt2lp+90SKeXZ/kjvLyGUP/pdF7/C8I
         C5yocX0Nulq0adziUkTBswqlP+VoiOomIzulTMqZv2oH9DEJfkPpK13eaph+NTD3yYjH
         sVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqBa/A8KQ9SQDHOYHmHjxeXA+N94N3CocdRQbsTHBzs=;
        b=hbxKaySDlNPnaq9q1kvrmJZFAn5fc1JCczwkR6M7E/aByWE1pklrj2RmmYw8/krslu
         Y9N1B09zuwR0BtWU2hgY519ttiDgVrqYhlcv6h+q3JU79jSlxQhvwYUrDpf1WaNFjvae
         OfPZglHuZNsvzAX3cAlgVdz/P1OQIxPA4Y4TLh9zxG9PAj5ktkHlaKkN0JNwiTGNUd++
         FQJCE68z5VuTIbMNhgsUqXB9O4in6oGyWRKVOMSCtoAho1dhfeqHdeE1HVgT9c2V3t9r
         STZk15whaPZT7frsc7LRmClDIeN9x2jU+3LIRouwKncac2TN64yipVp02a2nrpcRBIY/
         wpeQ==
X-Gm-Message-State: APjAAAX0tyuko+/itseWrV7hMANYYVrBAFOwnwj+wPyKGZgSCN1dLi+3
        LioF2AWwHv8cXWeh4BxWF3R5RLxi
X-Google-Smtp-Source: APXvYqxgY5T5aVa2qARPR3wzE+TVr1BxpBkg2ByE/IGDFXhED9vH5ydBtZzKyKZNDX6m0uuCA4bYEg==
X-Received: by 2002:a5d:83c2:: with SMTP id u2mr16146273ior.288.1557327734197;
        Wed, 08 May 2019 08:02:14 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:780:ed13:bfd5:1bea:adb7])
        by smtp.gmail.com with ESMTPSA id p132sm1552346ita.2.2019.05.08.08.02.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:02:13 -0700 (PDT)
Date:   Wed, 8 May 2019 11:02:11 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] git-format-patch.txt: document --no-notes option
Message-ID: <4c3535f25bdffc8d94617c74f7c078cce59a044f.1557327652.git.liu.denton@gmail.com>
References: <cover.1556388260.git.liu.denton@gmail.com>
 <cover.1557327652.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557327652.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally, git-format-patch uses the `handle_revision_opt` parser. The
parser handles the `--no-notes` option to negate an earlier `--notes`
option, but it isn't documented. Document this option so that users are
aware of it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f..2c3971390e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -22,7 +22,8 @@ SYNOPSIS
 		   [--rfc] [--subject-prefix=Subject-Prefix]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
-		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--[no-]cover-letter] [--quiet]
+		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--progress]
@@ -263,6 +264,7 @@ material (this may change in the future).
 	for details.
 
 --notes[=<ref>]::
+--no-notes::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
 +
-- 
2.21.0.1049.geb646f7864

