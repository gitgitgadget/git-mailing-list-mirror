Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2FAC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E195613F6
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhGPSoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:44:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62103 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhGPSoK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:44:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB8C2148600;
        Fri, 16 Jul 2021 14:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q76jKwELiZFIFHd2xvW1hNFBh+YkzSCjHg71m3
        eb5hM=; b=agqhngEMLJQNlK1Jc+sGaVu8wfirlfNxUPGfpJD4B3VS4qH//AE4Kr
        FhKEq5gYWoUFvBoSfkm2x09qanb33iqjZpVmyvne9Lc16Ui7GrWioa+YRnYwjB2q
        JPz2uppOwmI/58oAViUyzYXWNlbdx8ZCYQXV+rqvnjJ49DdsNIEno=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B57A41485FF;
        Fri, 16 Jul 2021 14:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 056E81485FD;
        Fri, 16 Jul 2021 14:41:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] CodingGuidelines: recommend gender-neutral description
References: <xmqqmtqpzosf.fsf@gitster.g>
        <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
        <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g>
Date:   Fri, 16 Jul 2021 11:41:10 -0700
In-Reply-To: <xmqqk0lrtuh4.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Thu, 15 Jul 2021 09:25:27 -0700")
Message-ID: <xmqqv95aqeyh.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64B1899A-E665-11EB-9A4F-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Technical writing seeks to convey information with minimal
friction. One way that a reader can experience friction is if they
encounter a description of "a user" that is later simplified using a
gendered pronoun. If the reader does not consider that pronoun to
apply to them, then they can experience cognitive dissonance that
removes focus from the information.

Give some basic tips to guide us avoid unnecessary uses of gendered
description.

Using a gendered pronoun is appropriate when referring to a specific
person.

There are acceptable existing uses of gendered pronouns within the
Git codebase, such as:

* References to real people (e.g. Linus Torvalds, "the Git maintainer").
  Do not misgender real people. If there is any doubt to the gender of a
  person, then avoid using pronouns.

* References to fictional people with clear genders (e.g. Alice and
  Bob).

* Sample text used in test cases (e.g t3702, t6432).

* The official text of the GPL license contains uses of "he or she",
  but using singular "they" (or modifying the text in some other
  way) is not within the scope of the Git project.

* Literal email messages in Documentation/howto/ should not be edited
  for grammatical concerns such as this, unless we update the entire
  document to fit the standard documentation format. If such an effort is
  taken on, then the authorship would change and no longer refer to the
  exact mail message.

* External projects consumed in contrib/ should not deviate solely for
  style reasons. Recommended edits should be contributed to those
  projects directly.

Other cases within the Git project were cleaned up by the previous
changes.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 The only change relative to the previous one is that this
 explicitly calls out that some are taught that 'they' is only used
 for third-person plural.  As we already say that some foreigners
 find it ungrammatical and unnatural to use 'they', I actually do
 not think it is necessary, but I'd prefer not to leave easy loose
 end hanging untied, so let's close this round and let others polish
 on top if they wanted to after the dust settls.

 Documentation/CodingGuidelines | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 45465bc0c9..b1f199b1fe 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -541,6 +541,51 @@ Writing Documentation:
  documentation, please see the documentation-related advice in the
  Documentation/SubmittingPatches file).
 
+ In order to ensure the documentation is inclusive, avoid assuming
+ that an unspecified example person is male or female, and think
+ twice before using "he", "him", "she", or "her".  Here are some
+ tips to avoid use of gendered pronouns:
+
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
+    learned that "they" is only used for third-person plural, e.g.
+    those who learn English as a second language in some parts of the
+    world.
+
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
  conventions.
-- 
2.32.0-454-g0dabea483d

