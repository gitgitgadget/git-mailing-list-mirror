Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C70D1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196AbcHJSPg (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:15:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933514AbcHJSOw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:14:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CC9435710;
	Wed, 10 Aug 2016 12:59:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sI73gh8rS+Ik
	aP0hH8/Io0bb53A=; b=RLgJZp2yRwxgmx1A5L5aRwhmogldEGn+U5+EuQp1jAS0
	cIYOXqYVC+Q4jjPOETXtDIs21jllJbPg9jI2Uc47MO8eh69VzrYRb105M8ok9nLy
	hI7W+iONpwqoO441kglpcutwlB9e9Zw4CfI5bjqi7Htsj/f9qvGetIGBsvgL1Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IzCoYp
	rpVHRzAS8DJOFlhgx8D+jtYMu0leqRWL2/WykxLHxFzYeA2zi7X01GphQnJXq8gA
	JHJjjWRPKtgXgnxv0JzP2jBmWD+daEXPGxJOjD9AoHuiaUOCoDc82c2SbaNKoQkD
	9PL9eRWQGTOMWPWp8MsgKQs5xSe5ohdj/ZCDc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45FB13570F;
	Wed, 10 Aug 2016 12:59:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3CCC3570D;
	Wed, 10 Aug 2016 12:59:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] Spelling fixes
References: <1470732818-408-1-git-send-email-ville.skytta@iki.fi>
	<xmqqpophajqa.fsf@gitster.mtv.corp.google.com>
	<CABr9L5DX9uHVkNMY4ihLcQtVoOLVXJh-EDA0iiOD9ffPkJSO-g@mail.gmail.com>
Date:	Wed, 10 Aug 2016 09:59:31 -0700
In-Reply-To: <CABr9L5DX9uHVkNMY4ihLcQtVoOLVXJh-EDA0iiOD9ffPkJSO-g@mail.gmail.com>
	("Ville =?utf-8?Q?Skytt=C3=A4=22's?= message of "Tue, 9 Aug 2016 21:41:56
 +0300")
Message-ID: <xmqq37mc7e6k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CFE6BA54-5F1B-11E6-8BD5-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ville Skyttä <ville.skytta@iki.fi> writes:

> On Tue, Aug 9, 2016 at 9:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [...]
>> There are two "commited" you seem to have missed, though,
>>
>> t/t3420-rebase-autostash.sh:    echo uncommited-content >file0 &&
>> t/t3420-rebase-autostash.sh:    echo uncommited-content >expected &&
>>
>> which I'll queue on top of this patch to be later squashed (i.e. no
>> need to resend the whole thing only to add these two).
>
> Thanks. https://github.com/client9/misspell/pull/61 :)
>
> Also, there's SSTATE_TRANSFERING->SSTATE_TRANSFERRING in
> transport-helper.c, maybe you can squash that one in as well if you
> think it's fine?

One comment that refers to that token spells it correctly, which is
funny ;-)

Here is a squashable change I've collected so far.

Subject: [PATCH] SQUASH???

    <BAD>             <CORRECTED>
    indegee           indegree
    transfering       transferring
    uncommited        uncommitted
---
 commit-slab.h               | 2 +-
 t/t3420-rebase-autostash.sh | 4 ++--
 transport-helper.c          | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/commit-slab.h b/commit-slab.h
index f84b449..be16da7 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -8,7 +8,7 @@
  *
  * After including this header file, using:
  *
- * define_commit_slab(indegee, int);
+ * define_commit_slab(indegree, int);
  *
  * will let you call the following functions:
  *
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 532ff5c..ab8a63e 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -179,7 +179,7 @@ testrebase " --interactive" .git/rebase-merge
 
 test_expect_success 'abort rebase -i with --autostash' '
 	test_when_finished "git reset --hard" &&
-	echo uncommited-content >file0 &&
+	echo uncommitted-content >file0 &&
 	(
 		write_script abort-editor.sh <<-\EOF &&
 			echo >"$1"
@@ -188,7 +188,7 @@ test_expect_success 'abort rebase -i with --autostash' '
 		test_must_fail git rebase -i --autostash HEAD^ &&
 		rm -f abort-editor.sh
 	) &&
-	echo uncommited-content >expected &&
+	echo uncommitted-content >expected &&
 	test_cmp expected file0
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 4208743..db2f930 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1103,7 +1103,7 @@ static void transfer_debug(const char *fmt, ...)
 }
 
 /* Stream state: More data may be coming in this direction. */
-#define SSTATE_TRANSFERING 0
+#define SSTATE_TRANSFERRING 0
 /*
  * Stream state: No more data coming in this direction, flushing rest of
  * data.
@@ -1112,7 +1112,7 @@ static void transfer_debug(const char *fmt, ...)
 /* Stream state: Transfer in this direction finished. */
 #define SSTATE_FINISHED 2
 
-#define STATE_NEEDS_READING(state) ((state) <= SSTATE_TRANSFERING)
+#define STATE_NEEDS_READING(state) ((state) <= SSTATE_TRANSFERRING)
 #define STATE_NEEDS_WRITING(state) ((state) <= SSTATE_FLUSHING)
 #define STATE_NEEDS_CLOSING(state) ((state) == SSTATE_FLUSHING)
 
@@ -1369,7 +1369,7 @@ int bidirectional_transfer_loop(int input, int output)
 	state.ptg.dest = 1;
 	state.ptg.src_is_sock = (input == output);
 	state.ptg.dest_is_sock = 0;
-	state.ptg.state = SSTATE_TRANSFERING;
+	state.ptg.state = SSTATE_TRANSFERRING;
 	state.ptg.bufuse = 0;
 	state.ptg.src_name = "remote input";
 	state.ptg.dest_name = "stdout";
@@ -1378,7 +1378,7 @@ int bidirectional_transfer_loop(int input, int output)
 	state.gtp.dest = output;
 	state.gtp.src_is_sock = 0;
 	state.gtp.dest_is_sock = (input == output);
-	state.gtp.state = SSTATE_TRANSFERING;
+	state.gtp.state = SSTATE_TRANSFERRING;
 	state.gtp.bufuse = 0;
 	state.gtp.src_name = "stdin";
 	state.gtp.dest_name = "remote output";
-- 
2.9.2-831-g532adb1



