From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 09:35:11 -0800
Message-ID: <7vvcadgss0.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:35:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0y2z-0006kU-Lm
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab3AaRfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jan 2013 12:35:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193Ab3AaRfO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jan 2013 12:35:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6363CD62;
	Thu, 31 Jan 2013 12:35:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TKO7IIUGxXDf
	pG+j2rN+vi3W+Wg=; b=lf/YYfGOMi/VlyKM1Mz+BSeqYS/V3EmEsuCHIMZDYC2+
	zO4eTwByZYDny9Lf7pA7LuxNANPrssXf2Mgsd36IJkuZrCH/nfq6c5OCwrVP6Psm
	6/kHiBvr1tCZrtR/W9q4y6eCOEmG5GgBkdrSNBe0guniaAn5Y5VQWH4f0AYoZD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LCf3do
	jyR1pkEISNwnPmoHldbd3nzZTAQEEOIyT/xgogDU/CQlrK1jhk8fC552pTc38/1a
	eYPhqSSANYrnf4aH3ZLqXw9INuEJT7o8k1mo1rAehdA7hOZi3gvO+0TvKFk9aJf4
	GI8H87jbAx6/sjzufXC5M9EaP5cM+C+papLYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA71CD61;
	Thu, 31 Jan 2013 12:35:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14621CD60; Thu, 31 Jan 2013
 12:35:12 -0500 (EST)
In-Reply-To: <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 31 Jan
 2013 18:10:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 915E5F8A-6BCC-11E2-BDCC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215132>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Apr 23, 2012 at 10:37 AM, Matthieu Moy <Matthieu.Moy@imag.fr>=
 wrote:
>> It's been deprecated since 53c4031 (Johan Herland, Wed Feb 16 2011,
>> push.default: Rename 'tracking' to 'upstream'), so it's OK to remove=
 it
>> from documentation (even though it's still supported) to make the
>> explanations more readable.
>
> I don't think this was a good move for the documentation. Now every
> time I find an old repo with "push.default=3Dtracking" I end up
> wondering what it was a synonym for again, and other users who don't
> know what it does will just assume it's an invalid value or something=
=2E
>
> We can't treat existing config values we still support as any other
> deprecated feature. They still exist in files we have no control over=
,
> and in people's brains who are reading "man git-config" trying to
> remember what it meant.

Wow, that's a blast from the past.

I tend to agree that deprecating and removing are quite different,
but a simple "revert" of the change would not be good, either.  We
still would want to _discourage_ its use.

I think I can be persuaded to apply a patch that mentions 'tracking'
as a side note.

Thanks.

>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> Feel free to squash into previous one if needed.
>>
>>  Documentation/config.txt |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index e38fab1..ddf6043 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1693,7 +1693,6 @@ push.default::
>>    makes `git push` and `git pull` symmetrical in the sense that `pu=
sh`
>>    will update the same remote ref as the one which is merged by
>>    `git pull`.
>> -* `tracking` - deprecated synonym for `upstream`.
>>  * `current` - push the current branch to a branch of the same name.
>>    +
>>    The `current` and `upstream` modes are for those who want to
>> --
>> 1.7.10.234.ge65dd.dirty
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
