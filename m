Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E97201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754838AbdBVVET (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 16:04:19 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35177 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754654AbdBVVER (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:04:17 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so1863501pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 13:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ACtDQKtcjfCxkaoIU1CxjSPt2oynOPQe38ByyUwb11o=;
        b=IOTeSXnxxzrZs93lMc8qZb8EXzOpZkhX9z5I45RxHH+bNy3s7QrwzSZO0SL5RUNnC0
         fNoovoTXL3EPsT77Do4igm4CzpQod8FpJNkFdDfWLILvw15eZI5vJv+VzRGc2Sl6O2av
         p7H35gK8hoRi4O8ghpoBTQhguj3Wn9e+iCYnnn8wyHOctXqPMUWI0gqIYYlbCJXeq1Vd
         AUArzS5t+A/u45ooM/iu1h7YIw8cKipYbPUSyd6Rm7hqDCY8+Iew+kFGXDLu4vg99Whu
         j1CSHdrOCuZBs15bxSm/3Pr24n1czVc8oTbCCzNkEIOeMP/5EKhnTap2EU/MCmAOSR16
         AY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ACtDQKtcjfCxkaoIU1CxjSPt2oynOPQe38ByyUwb11o=;
        b=STM1QGFB4LCf24rpFL2jO1ll1rxEXjJmKKCyYgqsSTMBEWtv6aGoI8WzajrPthTcll
         C49JQArWCxp39p7sveElDhSVNEicQZ6sv3XKLWpcaCl7wrqiM6MuXAAxDyBUEHCKQQ+Z
         AVrN8QyJPuYQDXAf0DdaYPkK5EauFpLi67fU9PprAfrDQ9pHRRzHxgR3CACUZfNQKpN3
         HCCbDu6m/AQIlhhqbmWw2tHGxRSJal2JpCn5VW74z9RokWSWx8TfnoY/8yLwvHzgPmo7
         PAdC2qPfgZeheg7r8q7irjZV6pVUkyQxi15oYHv8mHT9BfShRkNroUCY00VfpECskbU0
         kM1A==
X-Gm-Message-State: AMke39k3viabQrtHmOEnUSCxlpTmevcxxuCdLzM8+2yoQEwStxpZ/amO5Cz5xe2OM+SVtg==
X-Received: by 10.84.139.195 with SMTP id 61mr50187319plr.116.1487797377237;
        Wed, 22 Feb 2017 13:02:57 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id m6sm5349506pfm.22.2017.02.22.13.02.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 13:02:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Andreas Heiduk" <asheiduk@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Link git-ls-files to core.quotePath variable.
References: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com>
        <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com>
        <e55b3cb7-65bf-1609-2e8d-823b4336e07a@gmail.com>
        <F71515D0E29940CA9C421D18480AD726@PhilipOakley>
Date:   Wed, 22 Feb 2017 13:02:55 -0800
In-Reply-To: <F71515D0E29940CA9C421D18480AD726@PhilipOakley> (Philip Oakley's
        message of "Wed, 22 Feb 2017 12:21:22 -0000")
Message-ID: <xmqqh93maqgw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> -When `-z` option is not used, TAB, LF, and backslash characters
>> -in pathnames are represented as `\t`, `\n`, and `\\`,
>> -respectively. The path is also quoted according to the
>> -configuration variable `core.quotePath` (see linkgit:git-config[1]).
>> +Without the `-z` option pathnamens with "unusual" characters are
>
> s/option pathnamens/option, pathnames/    # comma and spelling.

Thanks.  Will squash it in while queuing (I need to discard the new
text added in the previous attempt in the preimage to make it apply,
too).

-- >8 --
From: Andreas Heiduk <asheiduk@gmail.com>
Date: Wed, 22 Feb 2017 02:38:21 +0100
Subject: [PATCH] Documentation: clarify core.quotePath and update git-ls-files doc

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt       | 22 ++++++++++++----------
 Documentation/git-ls-files.txt | 10 ++++++----
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f4721a048b..25e65aeb01 100644
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
index 078b556665..a415223b45 100644
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
@@ -192,9 +193,10 @@ the index records up to three such pairs; one from tree O in stage
 the user (or the porcelain) to see what should eventually be recorded at the
 path. (see linkgit:git-read-tree[1] for more information on state)
 
-When `-z` option is not used, TAB, LF, and backslash characters
-in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively.
+Without the `-z` option, pathnames with "unusual" characters are
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]).  Using `-z` the filename is output
+verbatim and the line is terminated by a NUL byte.
 
 
 Exclude Patterns
-- 
2.12.0-rc2-250-gd33575c7f2


