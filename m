From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Mark more strings for translation
Date: Sat, 27 Feb 2016 09:34:42 -0800
Message-ID: <xmqq7fhqhxal.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:34:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZilZ-0001yC-SD
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbcB0Res convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 12:34:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756340AbcB0Rer convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2016 12:34:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD4D5459AD;
	Sat, 27 Feb 2016 12:34:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T6982gm2Q5h9
	twNpzeH4mb60e1M=; b=WlVkOUQUhaY/D9w6fbH6iBOnjecywv9vkY3HRSVHRSgY
	XvEXNUk6ky/W5hh/NoidV+t9VSbOqe1or0OhrW3oyWEFybgyV++VCAvaQ4Zw326+
	2+sfXmWYo6MORLfh2UWs3HM1/oibF+T6WkXWGGT/V7JhN4syUGn3OWiZSYiAnPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OQRGPZ
	RvlipBubI6ZnnbsrL8ibSMxhadnwqWU8MtLjEWiH25jf8JQsjDFSTbMFYA9WsM68
	McKjHjyc8VQRc1mW7itWbltcqz1/mF9PqFT4roGet+ZClxfrZAZSmPigz+nSWzhF
	2mReBvDGILNsJJ2232sFGQ+PDdfkBz6dvtjKY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5662459AC;
	Sat, 27 Feb 2016 12:34:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1A2FE459AB;
	Sat, 27 Feb 2016 12:34:43 -0500 (EST)
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:41:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63950312-DD78-11E5-999D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287705>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> On Sat, Feb 27, 2016 at 6:41 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> In previous cycles, I often left many topics in 'next' when tagging
>> this zero-th preview, but eventually merged them before the final.
>> I decided to do things a bit differently for this cycle: a topic,
>> once it hits 'next', will not be rewound and only refined and
>> corrected with incremental updates, so the only effect such a late
>> merge to 'master' before the final is that some topics are not as
>> widely tested on 'master' before the final one is tagged.
>>
>> So this -rc0 is deliberately aggressive in that it includes all
>> topics that have been cooking in 'next' that I think we can fix bugs
>> that might still lurking in them before the final (it merges 25
>> topics since the last batch to 'master').  The topics not merged to
>> this preview, on the other hand, will not be considered for 2.8
>> final, even though I might later succumb to the temptation to pick
>> up ones that are in 'next' as of today ;-)
>
> Beautiful. This allows me to fix up all i18n strings in a single
> series instead of spreading them across many topics in 'next'.

Thanks.  "A new string we added since v2.7.0 that is not marked for
i18n" is a new i18n bug and "a string that used to be marked is not
marked when the code was rewritten since v2.7.0" is an i18n
regression, and we would want to "fix" both post -rc0 period.  The
patches that touch new strings added since 1.7.x are exactly that ;-)

We'd still want the fixes to apply on top of relevant topics if we
could, as the fix to the topic itself (with or without i18n fixes),
when we discover that it has a huge flaw not desirable in v2.8.0,
might be to revert the whole thing, though.

> I'm not
> sure if there's enough time for translators before release though.

Also we need to get an Ack from the authors of commits we added in
this cycle that these patches fix i18n bugs they introduced and make
sure there is no "this i18n mark is not appropriate as it is a
plumbing output (or protocol messsage) that should not be
translated" response from them.  It won't be like I apply these
blindly today and ask translators to start working.

> This series marks many strings for translation. It's a result of
> looking for new strings between 1.7.2 and 'master', and sometimes
> looking around touched files some more.
>
> Most of these are wrapping _() around strings, except 01/22 (enable
> gettext) and 20/22 and 21/22, which convert some more strings (they
> have been in my queue for a year)
>
>   [01/22] credential-cache--daemon: enable localized messages
>   [02/22] builtin/blame.c: mark strings for translation
>   [03/22] builtin/checkout.c: mark strings for translation
>   [04/22] builtin/clone.c: mark strings for translation
>   [05/22] builtin/config.c: mark strings for translation
>   [06/22] builtin/config.c: mark strings for translation
>   [07/22] builtin/update-index.c: mark strings for translation
>   [08/22] convert.c: mark strings for translation
>   [09/22] credential-cache--daemon.c: mark strings for translation
>   [10/22] http.c: mark strings for translation
>   [11/22] ident.c: mark strings for translation
>   [12/22] notes.c: mark strings for translation
>   [13/22] ref-filter.c: mark strings for translation
>   [14/22] refs/files-backend.c: mark strings for translation
>   [15/22] remote-curl.c: mark strings for translation
>   [16/22] run-command.c: mark strings for translation
>   [17/22] sha1_file.c: mark strings for translation
>   [18/22] submodule.c: mark strings for translation
>   [19/22] trailer.c: mark strings for translation
>   [20/22] transport-helper.c: mark strings for translating
>   [21/22] transport.c: mark strings for translating
>   [22/22] wrapper.c: mark strings for translation
>
> Total 20 files changed, 385 insertions(+), 372 deletions(-)

Let's queue this and start cooking; I see you never To'ed the guilty
party that introduced i18n bug/regression to each of your patch, but
can you start pinging them to collect Acks?

Thanks.
