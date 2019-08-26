Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C8E1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfHZPUY (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:20:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65278 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPUY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:20:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 302806C1D0;
        Mon, 26 Aug 2019 11:20:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qIrdNayDNUUTBU7pgGzJjLZkGW4=; b=AKnwU5
        2IvaXtGoXNIlRyKbVaum+vJGp0oP+hHCoC/UoyyTsmQ2RyDyUlQ6Rqahd824iWNq
        d57R74Stua6MmrYg15GXEgIh1l/kyf99EGS7OYFzG57Nb0wDGRzvxJjNXj6lngUk
        HZ37Xrjakr0EcwuycTlSDCqGfFhSjVOdP+Lt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=soE1R6nY5/fY1vE/kj0DyKS0C2Ly5fnc
        Q6UtMwArq5HnrzvCHVgFLK4JEpCu+XZGSI6tNZCVeXztR+1meuuW3G3w/9C8RLAs
        MPTbl94th0DVtNWI6j/pHMxc6ZXki5N8e8uNRRz7sZI/XQJommmNj+egQe++0EGq
        wMUctmPOYnM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2790E6C1CF;
        Mon, 26 Aug 2019 11:20:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A6A96C1C6;
        Mon, 26 Aug 2019 11:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 12/13] Doc: add more detail for git-format-patch
References: <cover.1566285151.git.liu.denton@gmail.com>
        <cover.1566635008.git.liu.denton@gmail.com>
        <a97f861e6a9889545a61a750791257757fc5b8df.1566635008.git.liu.denton@gmail.com>
Date:   Mon, 26 Aug 2019 08:20:13 -0700
In-Reply-To: <a97f861e6a9889545a61a750791257757fc5b8df.1566635008.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sat, 24 Aug 2019 04:27:15 -0400")
Message-ID: <xmqq1rx8kl76.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01E5E16E-C815-11E9-A0EA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In git-format-patch.txt, we were missing some key user information.
> First of all, document the special value of `--base=auto`.
>
> Next, while we're at it, surround option arguments with <>.

I'd suggest squashing this in to complete the above.

cf. <xmqq1rxfveym.fsf@gitster-ct.c.googlers.com>
cf. <xmqqimqqs7cm.fsf@gitster-ct.c.googlers.com>
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
