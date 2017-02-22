Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F4F201A9
	for <e@80x24.org>; Wed, 22 Feb 2017 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbdBVBi0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 20:38:26 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35859 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbdBVBiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 20:38:24 -0500
Received: by mail-wr0-f195.google.com with SMTP id z61so16224508wrc.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2NkSTn6B1rOldeI6qSZewrjSJWj0tl85hmcKFcp6scg=;
        b=uhB8Am++s8uMXrc9hZiWkpEqyg7z+g5mK4j6NcwuKAEvqpa73bhZFIkMtJgK28QA8u
         sIhYQN6/Y1CcPbB1aAOoE5yDG3M2CvCd4ENhVR2vvJZZGxwq2Aj3vsHe0/cqcsAsnMu6
         OxwOKNY65ptwoExI1JkT1HNcQlyY3yx6x4CiWZbJyHSni9Gnm5FxPw/a4RQBI9zQBzyw
         A0WwBMLQrS/BD2Mpkz8ViBhce2RbqWZ02VqJY9mCmpgmQlhjt5EaaqD+0WIS+n05JkUB
         0fzSmXJFnWB3p0dBXZgdD8qntLRuoomSRipbEgpLcA5aLLJ4Dlrz8BGdUqXdzF2vH+MK
         n/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2NkSTn6B1rOldeI6qSZewrjSJWj0tl85hmcKFcp6scg=;
        b=A/r45P/TaGGmEllizyVr4qYgNvvZynqKa2shM5dVXTi04Q/PV8UuclhQ1nvrGpq70x
         8FaPmqJmYaJIThpzrgDJXME09ARkLS5hPQ4mqr29jOLL1FS6+qGMIPN+1AMrAQ1t/DhK
         yNXi01ehpaKZ4Irx5Xd4lCZp5wHWoFZStCsGcO3NW0WgGgZXMeKmCjoglfhEoCAR3Lic
         gA16CvcbpCxn3NZz/qm96Fa2OdASgNNZfntgzSYWA96kJ1O+QsIu17dntUUWJ1Ux6ZHq
         9eK1WHtvmk2bxlII4Giv0NzT9eTJIBcx414mh0pnrAr5Cubx0CKnZFVh5+W91JDwpHR6
         YWRw==
X-Gm-Message-State: AMke39k7dPxLRMT1yiQRrlR7fLPxM5IHtkjhldZV4mINKvCzXQ8Z+WQ2jHecYeCCJyZuOw==
X-Received: by 10.223.140.145 with SMTP id a17mr24091054wrb.1.1487727502752;
        Tue, 21 Feb 2017 17:38:22 -0800 (PST)
Received: from ?IPv6:2001:a61:3434:d400:f45e:e7e:d939:ba62? ([2001:a61:3434:d400:f45e:e7e:d939:ba62])
        by smtp.googlemail.com with ESMTPSA id u198sm501611wmf.9.2017.02.21.17.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 17:38:22 -0800 (PST)
Subject: Re: [PATCH] Documentation: Link git-ls-files to core.quotePath
 variable.
To:     Junio C Hamano <gitster@pobox.com>
References: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com>
 <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <e55b3cb7-65bf-1609-2e8d-823b4336e07a@gmail.com>
Date:   Wed, 22 Feb 2017 02:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[PATCH] Documentation: Clarify core.quotePath, remove cruft in
 git-ls-files.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---

I have merged the best parts about quoting into the core.quotePath
description and cleaned up the text in git-ls-files.txt regarding the
control characters.


 Documentation/config.txt       | 22 ++++++++++++----------
 Documentation/git-ls-files.txt | 11 ++++++-----
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f4721a0..25e65ae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -340,16 +340,18 @@ core.checkStat::
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
+	Commands that output paths (e.g. 'ls-files', 'diff'), will
+	quote "unusual" characters in the pathname by enclosing the
+	pathname in double-quotes and escaping those characters with
+	backslashes in the same way C escapes control characters (e.g.
+	`\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
+	values larger than 0x80 (e.g. octal `\265` for "micro").  If
+	this variable is set to false, bytes higher than 0x80 are not
+	considered "unusual" any more.  Double-quotes, backslash and
+	control characters are always escaped regardless of the
+	setting of this variable.  Many commands can output pathnames
+	completely verbatim using the `-z` option. The default value is
+	true.

 core.eol::
 	Sets the line ending type to use in the working directory for
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index d2b17f2..88df561 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -76,7 +76,8 @@ OPTIONS
 	succeed.

 -z::
-	\0 line termination on output.
+	\0 line termination on output and do not quote filenames.
+	See OUTPUT below for more information.

 -x <pattern>::
 --exclude=<pattern>::
@@ -192,10 +193,10 @@ the index records up to three such pairs; one from
tree O in stage
 the user (or the porcelain) to see what should eventually be recorded
at the
 path. (see linkgit:git-read-tree[1] for more information on state)

-When `-z` option is not used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively. The path is also quoted according to the
-configuration variable `core.quotePath` (see linkgit:git-config[1]).
+Without the `-z` option pathnamens with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).  Using `-z` the filename is output
+verbatim and the line is terminated by a NUL byte.


 Exclude Patterns
-- 
2.7.4

