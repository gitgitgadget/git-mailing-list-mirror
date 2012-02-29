From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incremental updates to What's cooking
Date: Wed, 29 Feb 2012 00:39:48 -0800
Message-ID: <7vbooiuj6z.fsf@alter.siamese.dyndns.org>
References: <7vy5rn1mar.fsf@alter.siamese.dyndns.org>
 <4F4DD5C1.60604@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:39:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2f4m-0002F5-W5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658Ab2B2Ijv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 03:39:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755449Ab2B2Iju convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 03:39:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 588D4493C;
	Wed, 29 Feb 2012 03:39:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nBWpjk1XCq1h
	fttUJVcIpNY8x1Q=; b=HDG1QGCvYoj8yPSg0Xz0H1/dqduL/84aOWxpY6rKvwFa
	1Pg1T+FbN1aksWnj1/AE5Gkn4+/PEsxts6FOxr8mwl+I73/6llMmiy3d1JgrCrSH
	7vufR10NGDMpunTiqyOWUkqbaaeoMSdiG3ZBfPSdaNJEx3g79mKlt0VQvke2IIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WUrOL3
	J6Ub5JNC62k45hDGF7ZLXtGiPKacQ1OBwuEHX9z4IzcEo6spAhG92cnjdnaMFYd1
	QgaNg3TXcAVMmVuImm4rjFrxWss9oE6Jw54K3hueBHEqfD9bCzbI/ZsZE3E1tvfL
	C3wFScw2FTGWMiU8MxbTPUZ8L9XoXP1LzyuaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FA29493B;
	Wed, 29 Feb 2012 03:39:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA2D54939; Wed, 29 Feb 2012
 03:39:49 -0500 (EST)
In-Reply-To: <4F4DD5C1.60604@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drzeje?=
 =?utf-8?Q?wski-Szmek=22's?= message of "Wed, 29 Feb 2012 08:37:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F121502E-62B0-11E1-A18C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191820>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> On 02/28/2012 07:53 AM, Junio C Hamano wrote:
>
>> * zj/diff-stat-dyncol (2012-02-27) 11 commits
>>   - diff --stat: add config option to limit graph width
>>   - diff --stat: enable limiting of the graph part
>>   - diff --stat: add a test for output with COLUMNS=3D40
>>   - diff --stat: use a maximum of 5/8 for the filename part
>>   - merge --stat: use the full terminal width
>>   - log --stat: use the full terminal width
>>   - show --stat: use the full terminal width
>>   - diff --stat: use the full terminal width
>>   - diff --stat: tests for long filenames and big change counts
>>   - t4014: addtional format-patch test vectors
>>   - Merge branches zj/decimal-width, zj/term-columns and jc/diff-sta=
t-scaler
>>
>> I resurrected the additional tests for format-patch from an earlier =
round,
>> as it illustrates the behaviour change brought by "5/8 split" very w=
ell.
> Hi,
> the resurrected tests are partly duplicated in 4052-stat-output.sh:
>
> t4014:
> ok 75 - small change with long name gives more space to the name
> ok 76 - a long name is given more room when the bar is short
> ok 77 - format patch --stat-width=3Dwidth works with long name       =
 *
> ok 78 - format patch --stat=3D...,name-width with long name          =
 *
> ok 79 - format patch --stat-name-width with long name               *
> ok 81 - format patch graph part width                               *
> ok 82 - format patch ignores COLUMNS                                *
> ok 83 - format patch --stat=3Dwidth with big change                  =
 *
> ok 84 - format patch --stat-width=3Dwidth with big change            =
 *
> ok 85 - partition between long name and big change is more balanced
>
> t4052:
> ok 3 - format-patch graph width defaults to 80 columns
> ok 4 - format-patch --stat=3Dwidth with long name
> ok 5 - format-patch --stat-width=3Dwidth with long name
> ok 6 - format-patch --stat=3D...,name-width with long name
> ok 7 - format-patch --stat-name-width with long name
> ok 24 - format-patch ignores too many COLUMNS (big change)
> ok 28 - format-patch ignores not enough COLUMNS (big change)
> ok 29 - format-patch ignores statGraphWidth config
> ok 36 - format-patch --stat=3Dwidth with big change
> ok 37 - format-patch --stat-width=3Dwidth with big change
> ok 38 - format-patch --stat-graph--width with big change
> ok 49 - format-patch --stat=3Dwidth with big change and long name
> ok 53 - format-patch ignores COLUMNS (long filename)
>
> The ones with * are duplicated exactly. They tests run very fast, but
> maybe the duplicated ones should be culled.

Yeah, probably we should de-dup them.

Compare the behaviour change shown for t4052 and for t4014 by 119c07bf.
Which one more obviously show the effect of the code change to allow th=
e
reader judge if the behaviour change is going in a good direction?

The style used in t4052 only changes expect_failure to expect_success, =
and
the reader has to accept the judgement of the person who wrote the test
vector and declared "this is the _right_ output!".  The way t4014, take=
n
from your earlier round, shows the behaviour change shows how the
expectation changes from the old behaviour to the new one, and the read=
er
can see and decide which one is giving a better output.

Actually, the whole reason I didn't notice duplicates in 4052 was becau=
se
of the above X-<.

If we remove duplicates, will 4052 become empty?  It would be really ni=
ce
if we do not have to add a new test script for this series, and instead
add necessary new tests to existing scripts.
