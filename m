Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD61C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B582613D3
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGOQ20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:28:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54646 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhGOQ2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:28:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA68113A452;
        Thu, 15 Jul 2021 12:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FwzCrnpYMtlp
        n2A9ZiQjrnUJk+0wQksFNzX7LtK8VB8=; b=uWlP3BX25smtO4gJr0oS+ivPyviK
        BfMLUBQk8nA9Sa7/76Tq1m1lKfA1Is45DDQlY5Kej6OvU16AnXvl5+JJXH0/AmvS
        s/sf/CRyt46EhfHN9cu8b3NDDmPMT1hdn5i/YbDskgK47qucD8Uy2Jz5mQzAks5r
        AcmA5Y4NEsmMslU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3E1413A451;
        Thu, 15 Jul 2021 12:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4371713A44D;
        Thu, 15 Jul 2021 12:25:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: [PATCH] CodingGuidelines: recommend gender-neutral description
References: <xmqqmtqpzosf.fsf@gitster.g>
        <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
        <87czrl0wob.fsf@evledraar.gmail.com>
Date:   Thu, 15 Jul 2021 09:25:27 -0700
In-Reply-To: <87czrl0wob.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 14 Jul 2021 16:32:30 +0200")
Message-ID: <xmqqk0lrtuh4.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 44D36F44-E589-11EB-B2B8-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I've said before and will repeat here that the draft in your
>> SQUASH??? commit looks like a good compromise to me. It can
>> replace the other commit in this branch.
>
> Just doing that would leave the commit message that says "change X",
> when we're now changing X, Y and Z. I.e.  With the squash it changes
> from narrowly focusing on the pronoun question into a start of a genera=
l
> prose and style guide for our documentation.

Yeah, that is a good point.  Perhaps like this?

-- >8 ---- >8 ---- >8 -- cut here -- >8 ---- >8 ---- >8 --

Technical writing seeks to convey information with minimal
friction. One way that a reader can experience friction is if they
encounter a description of "a user" that is later simplified using a
gendered pronoun. If the reader does not consider that pronoun to
apply to them, then they can experience cognitive dissonance that
removes focus from the information.

Give some basic tips to guide us avoid unnecessary of gendered
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
 Documentation/CodingGuidelines | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 45465bc0c9..476b840d30 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -541,6 +541,49 @@ Writing Documentation:
  documentation, please see the documentation-related advice in the
  Documentation/SubmittingPatches file).
=20
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
+    learned English as a second language in some parts of the world.
+
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
  conventions.
--=20
2.32.0-443-g7e6d7322bf

