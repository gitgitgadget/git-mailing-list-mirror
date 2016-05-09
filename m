From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6044 broken on pu
Date: Mon, 09 May 2016 11:36:09 -0700
Message-ID: <xmqqh9e7ulie.fsf@gitster.mtv.corp.google.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
	<xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
	<5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
	<xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
	<CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
	<20160509083323.GB14299@sigill.intra.peff.net>
	<CAPig+cTyEU1gEwD5AuODkLzF--EOqo5_MQHD5QEFpb8dgh_wrw@mail.gmail.com>
	<20160509161226.GB11861@sigill.intra.peff.net>
	<xmqqr3dbulyp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	demerphq <demerphq@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 20:36:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azq2X-0003Gj-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 20:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbcEISgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 14:36:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751049AbcEISgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 14:36:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF62618DF8;
	Mon,  9 May 2016 14:36:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qFGEAfjBsHoxBzHYmpS6CKMmuto=; b=btzqk0
	msobSB/HlYopSVkRqgWzKgqqJfE8QSucSwq9hDNwxVJLaGYeZJJ8u/eclsmUwPk+
	0uCjCMwbSNR7yPEKcL57wanvo41PcacwRi9lJC8we+Aj0byLBV9YkMd4ww/wQZmd
	FNPeVw7UGclyizBNXoz0RqE+BRhQP6YmZ7pOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OYTYXl81uF72dN1ykRUIEWXnpm0ayP80
	Nu0C4D5HEK1hSu3B23Zs8ifPZfXevdC1HLM2aO6zRF/Iaf+zKgA7a/HLMzOwnrON
	PcCPyNxwseS/zBg4anAr02YZja5lzqHl1yiAfbJlu2Y/GlgavUtAHOkWSyP8redA
	4ZGsgRmK9n8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E74E118DF7;
	Mon,  9 May 2016 14:36:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AFC518DF6;
	Mon,  9 May 2016 14:36:11 -0400 (EDT)
In-Reply-To: <xmqqr3dbulyp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 May 2016 11:26:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E72F30E2-1614-11E6-BB59-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294036>

Junio C Hamano <gitster@pobox.com> writes:

> Yes, I think the comment should just go.  Nobody used that alphabet
> form since it was written in d17cf5f3 (tests: Introduce test_seq,
> 2012-08-04).
>
>> I don't really care either way whether it is replaced or not (at one
>> point there were some people really interested in NO_PERL not even using
>> one-liners in the test suite, but I am not one of them).
>
> Neither am I, but I think it is prudent to drop that "letters".  The
> comment even says the letter form is not portable already, so the
> mention of GNU seq(1) is not helping at all.

-- >8 --
Subject: test-lib-functions.sh: remove misleading comment on test_seq

We never used the "letters" form since we came up with "test_seq" to
replace use of non-portable "seq" in our test script, which we
introduced it at d17cf5f3 (tests: Introduce test_seq, 2012-08-04).

We use this helper to either iterate for N times (i.e. the values on
the lines do not even matter), or just to get N distinct strings
(i.e. the values on the lines themselves do not really matter, but
we care that they are different from each other and reproducible).

Stop promising that we may allow using "letters"; this would open an
easier reimplementation that does not rely on $PERL, if somebody
later wants to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d99eb3..cc9f61d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -718,20 +718,13 @@ test_cmp_rev () {
 	test_cmp expect.rev actual.rev
 }
 
-# Print a sequence of numbers or letters in increasing order.  This is
-# similar to GNU seq(1), but the latter might not be available
-# everywhere (and does not do letters).  It may be used like:
-#
-#	for i in $(test_seq 100)
-#	do
-#		for j in $(test_seq 10 20)
-#		do
-#			for k in $(test_seq a z)
-#			do
-#				echo $i-$j-$k
-#			done
-#		done
-#	done
+# Print a sequence of integers in increasing order, either with
+# two arguments (start and end):
+#
+#     test_seq 1 5 -- outputs 1 2 3 4 5 one line at a time
+#
+# or with one argument (end), in which case it starts counting 
+# from 1.
 
 test_seq () {
 	case $# in
