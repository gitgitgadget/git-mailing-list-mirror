Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC07207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 21:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbcJFVnp (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 17:43:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51034 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933011AbcJFVnn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 17:43:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C5EF44FF4;
        Thu,  6 Oct 2016 17:43:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BduAfjakoCr/sCmtVXpILHyyW34=; b=IotN99
        /6C0ub0GnMX03kp567k5qIk6f+ssZ8A0urwLnkIZ40TJrYpZT/I6qaQ3/t96M+7o
        MegUT3DHOEO7Co0v/TJUzDsCxRaaMqsly/AVScZQlYVem79SVpPE4LaNctEUHp+Y
        WV8Z+PcHlGApTm5SFFnsVteUwDCDZYIZn+Ja0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XJSJOPCGGkAwg8n9d8PEFgZkr2ZlPot4
        aFErlHazMFm5AiQlk0OorAsOreVGXByXhKFdaG4EDEp7Z6wUAOhU8o8s6LfQLI1w
        L5215h3IuTFS5WYKWjQSKPk4H1q2sorpxxN4/jlwMwUNkeltMNWlskJUiVXibEJv
        88SxL+Sszmc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6547E44FF3;
        Thu,  6 Oct 2016 17:43:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D002844FF2;
        Thu,  6 Oct 2016 17:43:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Alex <agrambot@gmail.com>
Subject: Re: [PATCH v2] gpg-interface: use more status letters
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
        <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
        <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
        <24ecc903-3e5a-47f6-f073-00a1c709d5e8@ramsayjones.plus.com>
        <85fa6296-17f0-0e8c-ec1b-54cd48c45223@drmicha.warpmail.net>
        <xmqq60pdbbxh.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Oct 2016 14:43:39 -0700
In-Reply-To: <xmqq60pdbbxh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 30 Sep 2016 09:16:26 -0700")
Message-ID: <xmqqk2dli25w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2E0ADB6-8C0D-11E6-B646-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Also, I'm open to using another letter for EXPKEYSIG but couldn't decide
>> between 'Y', 'Z', 'K'. 'K' could be confused with REVKEYSIG, I'm afraid.
>> 'Y' is next to 'X' and contained in 'KEY', it would be my first choice.
>
> Sounds good enough to me.  Thanks.

I really do not want to leave too many topics listed in the "What's
cooking" report to be in undecided / waiting state.  How about
squashing this in, with a fully updated log message to replace?

-- >8 --
From: Michael J Gruber <git@drmicha.warpmail.net>
Date: Wed, 28 Sep 2016 16:24:13 +0200
Subject: [PATCH] SQUASH: gpg-interface: use more status letters

According to gpg2's doc/DETAILS:

    For each signature only one of the codes GOODSIG, BADSIG,
    EXPSIG, EXPKEYSIG, REVKEYSIG or ERRSIG will be emitted.

gpg1 ("classic") behaves the same (although doc/DETAILS differs).

Currently, we parse gpg's status output for GOODSIG, BADSIG and
trust information and translate that into status codes G, B, U, N
for the %G?  format specifier.

git-verify-* returns success in the GOODSIG case only. This is
somewhat in disagreement with gpg, which considers the first 5 of
the 6 above as VALIDSIG, but we err on the very safe side.

Introduce additional status codes E, X, Y, R for ERRSIG, EXPSIG,
EXPKEYSIG, and REVKEYSIG so that a user of %G? gets more information
about the absence of a 'G' on first glance.

Requested-by: Alex <agrambot@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-formats.txt | 3 ++-
 gpg-interface.c                  | 2 +-
 pretty.c                         | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index c28ff2b919..179c9389aa 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -146,7 +146,8 @@ endif::git-rev-list[]
 - '%G?': show "G" for a good (valid) signature,
   "B" for a bad signature,
   "U" for a good signature with unknown validity,
-  "X" for a good expired signature, or good signature made by an expired key,
+  "X" for a good signature that has expired,
+  "Y" for a good signature made by an expired key,
   "R" for a good signature made by a revoked key,
   "E" if the signature cannot be checked (e.g. missing key)
   and "N" for no signature
diff --git a/gpg-interface.c b/gpg-interface.c
index 6999e7b469..e44cc27da1 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -35,7 +35,7 @@ static struct {
 	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
 	{ 'E', "\n[GNUPG:] ERRSIG "},
 	{ 'X', "\n[GNUPG:] EXPSIG "},
-	{ 'X', "\n[GNUPG:] EXPKEYSIG "},
+	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
 	{ 'R', "\n[GNUPG:] REVKEYSIG "},
 };
 
diff --git a/pretty.c b/pretty.c
index 39a36cd825..f98b271069 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1236,6 +1236,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			case 'U':
 			case 'N':
 			case 'X':
+			case 'Y':
 			case 'R':
 				strbuf_addch(sb, c->signature_check.result);
 			}
-- 
2.10.1-520-ge127bfd383

