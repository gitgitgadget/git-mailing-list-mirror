Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B52C433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A038B64EBB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhBWT16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:27:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54611 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhBWT1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:27:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5ECD10D926;
        Tue, 23 Feb 2021 14:26:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mPBbxzK3+uVVguoWjf5sXPYRO1E=; b=o6Mzao
        TcQgCMTLY+uKXrERAKDG5k8yESbqHGCfThEyoMY7bgWp5e5H0E+mHgsrqlTBpdoP
        PWni/nHVJvvMHNtxsBUQ24QwnbykuYP/P6aBNwXr3kOKZ8POOEVBif8omCwAqwLi
        A0pvP/LLZVbLBrwXxdJheaVgifcjaIOef4Bhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nMzhEeW79aJ2eD+qk4IPmNh9Oae/eCBd
        n/FE6371DE0sO8rbdNCcs4QtQxX+yVf49tEV2tBx2b4XW2GQJ9FbIyL4+kM3B4i0
        G+pp1npcMHm3ty+gVXb21ki0lroYu1XQk9D91IHhzUbazyjEx2mrjG2X0dpgWHQh
        ypWDiraMjiM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF7E510D925;
        Tue, 23 Feb 2021 14:26:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0567910D922;
        Tue, 23 Feb 2021 14:26:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2] i18n.txt: camel case and monospace "i18n.commitEncoding"
References: <cover.1614062288.git.liu.denton@gmail.com>
        <cc48b125166a241ef5f24138fd161223ab35e361.1614062288.git.liu.denton@gmail.com>
Date:   Tue, 23 Feb 2021 11:26:55 -0800
In-Reply-To: <cc48b125166a241ef5f24138fd161223ab35e361.1614062288.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 22 Feb 2021 22:39:06 -0800")
Message-ID: <xmqqy2fe1t6o.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17C521D2-760D-11EB-9F62-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 95791be750 (doc: camelCase the i18n config variables to improve
readability, 2017-07-17), the other i18n config variables were
camel cased. However, this one instance was missed.

Camel case and monospace "i18n.commitEncoding" so that it matches the
surrounding text.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
[jc: fixed 3 other mistakes that are exactly the same]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So, while I still remember, I amended your commit and queued
   this.

 Documentation/git-am.txt       | 2 +-
 Documentation/git-mailinfo.txt | 4 ++--
 Documentation/i18n.txt         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 06bc063542..decd8ae122 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -79,7 +79,7 @@ OPTIONS
 	Pass `-u` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
-	`i18n.commitencoding` can be used to specify project's
+	`i18n.commitEncoding` can be used to specify project's
 	preferred encoding if it is not UTF-8).
 +
 This was optional in prior versions of git, but now it is the
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 7a6aed0e30..d343f040f5 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -53,7 +53,7 @@ character.
 	The commit log message, author name and author email are
 	taken from the e-mail, and after minimally decoding MIME
 	transfer encoding, re-coded in the charset specified by
-	i18n.commitencoding (defaulting to UTF-8) by transliterating
+	`i18n.commitEncoding` (defaulting to UTF-8) by transliterating
 	them.  This used to be optional but now it is the default.
 +
 Note that the patch is always used as-is without charset
@@ -61,7 +61,7 @@ conversion, even with this flag.
 
 --encoding=<encoding>::
 	Similar to -u.  But when re-coding, the charset specified here is
-	used instead of the one specified by i18n.commitencoding or UTF-8.
+	used instead of the one specified by `i18n.commitEncoding` or UTF-8.
 
 -n::
 	Disable all charset re-coding of the metadata.
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 7e36e5b55b..6c6baeeeb7 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -38,7 +38,7 @@ mind.
   a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
-  have i18n.commitencoding in `.git/config` file, like this:
+  have `i18n.commitEncoding` in `.git/config` file, like this:
 +
 ------------
 [i18n]
-- 
2.30.1-808-g8fd60da8ea

