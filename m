From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6044 broken on pu
Date: Mon, 09 May 2016 14:08:31 -0700
Message-ID: <xmqqeg9bszw0.fsf@gitster.mtv.corp.google.com>
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
	<xmqqh9e7ulie.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	demerphq <demerphq@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 23:13:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azsQB-000585-TJ
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 23:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbcEIVIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 17:08:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752599AbcEIVIe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 17:08:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 522801A36E;
	Mon,  9 May 2016 17:08:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wPTjw7L7BoAlSxBrXpfPlWyVw84=; b=Hppy8h
	6GZMJOnlj4qsVzVt3ZdIcp9XhQY+b/LsXnoWQQiuUKsttPpVz/W0Tcc0VcZuuIeR
	4hdmTa9dY7RsWFQvsxsGAoHWWLuT+yl6nOtRwN1YtPCUKksHN4KRJioQTxVFgZtm
	rnYAR7ybbVSWKtVYHwhENTpF2BdB3zNEA/P5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FZNiQM00OcXlzb58rbEEo8MCupabdQuz
	4YlqTFxOFWmhJt8mnKOsRd5coAXNGMpaTFCz1Q1ogxOHPr88HyLdAEu/uG6XgMb9
	OCnALZlVj5Pmd7FVMSDKbS43lH61zlVJShmXu541aGjKntOfrlbi+4ppWe25xX+g
	XMwqdgXHgYk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 496EE1A36D;
	Mon,  9 May 2016 17:08:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B85FD1A36A;
	Mon,  9 May 2016 17:08:32 -0400 (EDT)
Importance: high
In-Reply-To: <xmqqh9e7ulie.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 May 2016 11:36:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FD5C882-162A-11E6-8068-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294071>

Junio C Hamano <gitster@pobox.com> writes:

> Stop promising that we may allow using "letters"; this would open an
> easier reimplementation that does not rely on $PERL, if somebody
> later wants to.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

And I am not the one who particularly wants to, but here is the
previous patch sent elsewhere in the thread.

-- >8 --
Subject: [PATCH] test-lib-functions.sh: rewrite test_seq without Perl

Rewrite the 'seq' imitation only with commands and features
that are typically found as built-in in modern POSIX shells,
instead of relying on Perl to run a single-liner.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 39b8151..9734e32 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -679,7 +679,12 @@ test_seq () {
 	2)	;;
 	*)	error "bug in the test script: not 1 or 2 parameters to test_seq" ;;
 	esac
-	perl -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
+	test_seq_counter__=$1
+	while test "$test_seq_counter__" -le "$2"
+	do
+		echo "$test_seq_counter__"
+		test_seq_counter__=$(( $test_seq_counter__ + 1 ))
+	done
 }
 
 # This function can be used to schedule some commands to be run
-- 
2.8.2-557-gee41d5e
