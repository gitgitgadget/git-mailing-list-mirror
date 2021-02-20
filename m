Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA455C433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 02:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3AF64EE0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 02:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBTCoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 21:44:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59726 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBTCox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 21:44:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8451106F7B;
        Fri, 19 Feb 2021 21:44:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=J
        b5KARhB0t0OIlF0wom8sPXWEGM=; b=fqD/5wpVIgJLWCBHOjmNQ8YtGqAf38t0t
        55MhRC3kfji2pGy0JazmOGHxwhx7A/EHBjfshjBV2BfWfT89XdnAZ4xUuda2ROXQ
        ygDSoV/W6KMsU8+YQME4TGwh8ps9yVr9XtPDw6A8m9s4nSXYcDHRHfb4IZGAUEQG
        xIx1uBMdiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=snd
        dCk1kSU7Vy/t3W8DvK9CpoVl3rcBQqxrA2kd3MaY/Te+L7Ti+XA9I1zZqvtZwboL
        YdWDNnR+qSdtOND9ZUQxFjAvheZMqJUkm1jn/CXT2lzHZ6dh9bE9x9qxU1Y2ceT/
        UOz8CrqHNKsA2YWgobdOdYz3IvYGl9/1sue86pic=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFE73106F7A;
        Fri, 19 Feb 2021 21:44:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26C5B106F79;
        Fri, 19 Feb 2021 21:44:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] Documentation: typofix --column description
Date:   Fri, 19 Feb 2021 18:44:05 -0800
Message-ID: <xmqqczwvbgqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 807F3338-7325-11EB-9736-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f4ed0af6 (Merge branch 'nd/columns', 2012-05-03) brought in three
cut-and-pasted copies of malformatted descriptions.  Let's fix them
all the same way by marking the configuration variable names up as
monospace just like the command line option `--column` is typeset.

While we are at it, correct a missing space after the full stop that
ends the sentence.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt | 2 +-
 Documentation/git-status.txt | 2 +-
 Documentation/git-tag.txt    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index adaa1782a8..5b4b2135a1 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -153,7 +153,7 @@ OPTIONS
 --column[=<options>]::
 --no-column::
 	Display branch listing in columns. See configuration variable
-	column.branch for option syntax.`--column` and `--no-column`
+	`column.branch` for option syntax. `--column` and `--no-column`
 	without options are equivalent to 'always' and 'never' respectively.
 +
 This option is only applicable in non-verbose mode.
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index c0764e850a..83f38e3198 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -130,7 +130,7 @@ ignored, then the directory is not shown, but all contents are shown.
 --column[=<options>]::
 --no-column::
 	Display untracked files in columns. See configuration variable
-	column.status for option syntax.`--column` and `--no-column`
+	`column.status` for option syntax. `--column` and `--no-column`
 	without options are equivalent to 'always' and 'never'
 	respectively.
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 56656d1be6..31a97a1b6c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -134,7 +134,7 @@ options for details.
 --column[=<options>]::
 --no-column::
 	Display tag listing in columns. See configuration variable
-	column.tag for option syntax.`--column` and `--no-column`
+	`column.tag` for option syntax. `--column` and `--no-column`
 	without options are equivalent to 'always' and 'never' respectively.
 +
 This option is only applicable when listing tags without annotation lines.
-- 
2.30.1-786-ga4cbb14bdd

