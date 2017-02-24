Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4675201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdBXUif (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:38:35 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32926 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdBXUib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:38:31 -0500
Received: by mail-wr0-f196.google.com with SMTP id g10so3294835wrg.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KhKgo5xzU8QptzyqRboGSS9e6zn89WlfqiyGcvvi7sU=;
        b=cef2JdjBZhkZgJlKNbDy+jSMwhyT0kMZHR7kqacL7uLEVYoIx6TWocdLO0LFN8pr1w
         D6aLg1vKoaYSS8VkyGZS0G0pi0vR2zwR8sXJVAXvZpSpUlezBsiFuy1mAAYxQKQyqcdZ
         ISZW8QtlBM0OjXtgyf/ogvHIxZBqxfD5Uuh4CWjnn1XcJb6bAqP9f6W9BkyeOVekSsEq
         Eij7tUAQdeV04JvQIaxU1+z+cLIsLahCJfE2cY6e5fsqzOKWKnbqw3MzFzllvSSkBTIN
         iAeBOKUjPkZLX4U17sOUIkRWuX+1auHdAM3aUB9lixcsBezeb0iFuthp2t1QzNrOmOy3
         FXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KhKgo5xzU8QptzyqRboGSS9e6zn89WlfqiyGcvvi7sU=;
        b=IBmvrcRF3xzWZ3y5W3T/fJ7hbKk5dH//Wik9arEbOAKmEiOb5WiCSQ65KGewDNIQw5
         J4yTe7PxMiKUXXzrSgKneZ1oX8aVhnBk1XSLaGDG1kzU2jcA8InYFHuyQd6R8z8Na/Rc
         66107r1zCcT6lPp79NWHHYlLE3brjniWfLp0Gb2kUzImdFrRQVVSgL633iwrPN7TOduB
         xt9oWHdIBiCSfNRwLHgz8eSQLI5NobGE0RQruH0cotbp5xkFg+HbpPgV7mnCrxm3EiEO
         lXN9TzPplzO2RdlbTLzXS+6hH9ulW5KoiSUlix8tdrZq9NraJtN+tRGNDFVQkvLMTWMS
         HwVQ==
X-Gm-Message-State: AMke39kd0QIjJhjrRhNGLfHRCw/3kUjsSGlwGt7oHWupMPbDtAfQItzyaSaD9Vn2Du3P1A==
X-Received: by 10.223.138.235 with SMTP id z40mr4561171wrz.130.1487968706455;
        Fri, 24 Feb 2017 12:38:26 -0800 (PST)
Received: from arrakeen.fritz.box ([2001:a61:1087:f101:3062:f226:b4ec:5b6c])
        by smtp.gmail.com with ESMTPSA id j184sm3224550wmd.31.2017.02.24.12.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:38:25 -0800 (PST)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 1/2] Documentation: Improve description for core.quotePath
Date:   Fri, 24 Feb 2017 21:37:55 +0100
Message-Id: <1487968676-6126-2-git-send-email-asheiduk@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
References: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
 <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/config.txt | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1fee83c..fa06c2a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -347,16 +347,20 @@ core.checkStat::
 	all fields, including the sub-second part of mtime and ctime.
 
 core.quotePath::
-	The commands that output paths (e.g. 'ls-files',
-	'diff'), when not given the `-z` option, will quote
-	"unusual" characters in the pathname by enclosing the
-	pathname in a double-quote pair and with backslashes the
-	same way strings in C source code are quoted.  If this
-	variable is set to false, the bytes higher than 0x80 are
-	not quoted but output as verbatim.  Note that double
-	quote, backslash and control characters are always
-	quoted without `-z` regardless of the setting of this
-	variable.
+
+	Commands that output paths (e.g. 'ls-files', 'diff'), will
+	quote "unusual" characters in the pathname by enclosing the
+	pathname in double-quotes and escaping those characters with
+	backslashes in the same way C escapes control characters (e.g.
+	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
+	values larger than 0x80 (e.g. octal `\302\265` for "micro" in
+	UTF-8).  If this variable is set to false, bytes higher than
+	0x80 are not considered "unusual" any more. Double-quotes,
+	backslash and control characters are always escaped regardless
+	of the setting of this variable.  A simple space character is
+	not considered "unusual".  Many commands can output pathnames
+	completely verbatim using the `-z` option. The default value
+	is true.
 
 core.eol::
 	Sets the line ending type to use in the working directory for
