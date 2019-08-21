Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7848A1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 18:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfHUS0Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 14:26:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62655 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUS0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 14:26:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B8BE16DA11;
        Wed, 21 Aug 2019 14:26:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/wjgRH4tLgl/xEMgsIf/91lGpgg=; b=LmQgAB
        gn+Z81nYmsPf6M2KqA9gcn937arH6pF1+F3rnjzcnnsdcClYPQU7cW6Rx96Vnsyk
        JwuJJ8mUjoThRBg1C/Goz/Ked8NmTRDhzarrm9KRGevtU+rXqgKCDYBDKvQ08R4y
        SAYgHpzZlNigj+GD4ZdKobbZxgOO+pLIYaHIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aEMz1qpzT0tD7Y201CaovlmWHWJWhtSb
        9vg5/AGopSwaw1aGsG8c5HvMQ0y/9oCwtEEYH2CxDRxTjhWwMq2MnmUX6OSHRlaZ
        D2jZ9OPdu2sGNh0FBQELINMy1eZPc/Eb+AT6BEssfByShFhhlydPqPcY27UWOiNi
        DmbzePt0x6k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 327FA16DA0F;
        Wed, 21 Aug 2019 14:26:19 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82E4F16DA0E;
        Wed, 21 Aug 2019 14:26:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 11/13] Doc: add more detail for git-format-patch
References: <cover.1566258525.git.liu.denton@gmail.com>
        <cover.1566285151.git.liu.denton@gmail.com>
        <c12534ab5dc67bdecad45e10d45d428bc783cb09.1566285151.git.liu.denton@gmail.com>
Date:   Wed, 21 Aug 2019 11:26:17 -0700
In-Reply-To: <c12534ab5dc67bdecad45e10d45d428bc783cb09.1566285151.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 20 Aug 2019 03:19:11 -0400")
Message-ID: <xmqqimqqs7cm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B0B072C-C441-11E9-BC36-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Next, while we're at it, surround option arguments with <>.

I'd suggest squashing this in to complete the above.

cf. <xmqq1rxfveym.fsf@gitster-ct.c.googlers.com>
---
 Documentation/git-format-patch.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 95bc4d53ca..0ac56f4b70 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -17,9 +17,9 @@ SYNOPSIS
 		   [--signature-file=<file>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
-		   [--in-reply-to=<Message-Id>] [--suffix=.<sfx>]
+		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
-		   [--rfc] [--subject-prefix=<Subject-Prefix>]
+		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
@@ -159,9 +159,9 @@ Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=<Message-Id>::
+--in-reply-to=<message id>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
-	reply to the given Message-Id, which avoids breaking threads to
+	reply to the given <message id>, which avoids breaking threads to
 	provide a new patch series.
 
 --ignore-if-in-upstream::
@@ -171,9 +171,9 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
---subject-prefix=<Subject-Prefix>::
+--subject-prefix=<subject prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
-	line, instead use '[<Subject-Prefix>]'. This
+	line, instead use '[<subject prefix>]'. This
 	allows for useful naming of a patch series, and can be
 	combined with the `--numbered` option.
 
-- 
2.23.0-266-g1e4abb0e04

