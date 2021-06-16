Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D507C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 05:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0705D613D9
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 05:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFPFIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 01:08:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61949 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFPFIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 01:08:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44A4B12FE4A;
        Wed, 16 Jun 2021 01:06:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LCYuMIx7pHAz/qnjUl2gRnoXXeekYwdO07oFiP
        zzMlQ=; b=C2+ULUPbodu/JMS+OzBWNBQB/SxNyBi+BmX2EHCTGc65xzmGbwGtMQ
        MjIMyVk6jR9CiRcmd3/arugMtmgmkYJP8McY7r0z9dNwssKBPfUOan/z7gZtqZa0
        aOl5Y5Stz1QNKBbQF+0mIS2hG2Kd4Y0H5pz3URC/IjzWt5jX99cuo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FB8512FE49;
        Wed, 16 Jun 2021 01:06:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 96CA812FE48;
        Wed, 16 Jun 2021 01:06:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
        <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
        <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
Date:   Wed, 16 Jun 2021 14:06:32 +0900
In-Reply-To: <xmqqsg1iseza.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Jun 2021 11:47:05 +0900")
Message-ID: <xmqqbl86qtyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F19C560-CE60-11EB-B2E7-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> FWIW, I am not happy with this version for that reason, either.
>
> I wonder if replacing the first two bullet points ("Removing" and
> "If you need to talk about") above with what was added to the
> CodingGuidelines by the "succinct matter-of-factly description" in
>
> https://lore.kernel.org/git/87a6nz2fda.fsf@evledraar.gmail.com/
>
> would be sufficient.

So, here is what I plan to queue on top of these four patches to
replace my "not even draft" garbage with what you wrote, with a bit
of copyediting.

Comments?

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 605f924981..476b840d30 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -546,28 +546,43 @@ Writing Documentation:
  twice before using "he", "him", "she", or "her".  Here are some
  tips to avoid use of gendered pronouns:
 
-  - Removing the example person might make the sentence more
-    clear and efficient.  Instead of saying "The programmer
-    chooses between X and Y as she sees fit", it is clearer to
-    say "Valid choices are X and Y".
-
-  - If you need to talk about an example person, then try using
-    second-person to allow the reader to be that example.  For
-    example, "If you want X to happen, you'd pass option Y",
-    instead of "If the user wants X to happen, she'd ...").
-    Alternatively, replace the single example with more than one
-    person and use plural "they", such as "Interested readers
-    can read 'git log -p README' to learn the history in their
-    ample spare time" instead of "an interested reader" learning
-    in "his" spare time).
-
-  - If you absolutely need to refer to an example person that is
-    third-person singluar, you may resort to "singular they" (e.g.
-    "A contributor asks their upstream to pull from them").  Note
-    that this sounds ungrammatical and unnatural to those who
-    learned English as a second language in some parts of the
-    world, so should be avoided unless the earlier techniques
-    fail to improve the sentence.
+  - Prefer succinctness and matter-of-factly describing functionality
+    in the abstract.  E.g.
+
+     --short:: Emit output in the short-format.
+
+    and avoid something like these overly verbose alternatives:
+
+     --short:: Use this to emit output in the short-format.
+     --short:: You can use this to get output in the short-format.
+     --short:: A user who prefers shorter output could....
+     --short:: Should a person and/or program want shorter output, he
+               she/they/it can...
+
+    This practice often eliminates the need to involve human actors in
+    your description, but it is a good practice regardless of the
+    avoidance of gendered pronouns.
+
+  - When it becomes awkward to stick to this style, prefer "you" when
+    addressing the the hypothetical user, and possibly "we" when
+    discussing how the program might react to the user.  E.g.
+
+      You can use this option instead of --xyz, but we might remove
+      support for it in future versions.
+
+    while keeping in mind that you can probably be less verbose, e.g.
+
+      Use this instead of --xyz. This option might be removed in future
+      versions.
+
+  - If you still need to refer to an example person that is
+    third-person singular, you may resort to "singular they" to avoid
+    "he/she/him/her", e.g.
+
+      A contributor asks their upstream to pull from them.
+
+    Note that this sounds ungrammatical and unnatural to those who
+    learned English as a second language in some parts of the world.
 
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
-- 
2.32.0-241-g31cd86ad06

