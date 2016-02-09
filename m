From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stripspace: Call U+0020 a "space" instead of a "blank"
Date: Tue, 09 Feb 2016 15:00:56 -0800
Message-ID: <xmqqbn7p1obb.fsf@gitster.mtv.corp.google.com>
References: <1454037056-26355-1-git-send-email-alexhenrie24@gmail.com>
	<xmqqvb5x1q01.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kao-DWwn2j4aO8ArSPHAX65KeL7NyD=ONkB6qjOrDZNSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Tobias Klauser <tklauser@distanz.ch>,
	Alex Henrie <alexhenrie24@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:01:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTHHV-0001U5-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 00:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756953AbcBIXBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 18:01:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756932AbcBIXA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 18:00:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92E9242C01;
	Tue,  9 Feb 2016 18:00:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=svUhZEfbXucg4B+/blXaenMN0+M=; b=bmb9e/
	f9dApY3YH2zHMkqAeVhatXf4C1rqK0wQmBxIMJBiMU7OTUsnsMv5NzZGnExYPXBM
	SRutKAhsv4Z0vm5Zm7wak67kVt2Z1sHEh/Zs9FWLx6RK5II7qGYjxaNAlt0kyUqh
	3jKDqvc4EJdhjaBHQD6t02T6O7snGevQr1jB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aciK1BHZnPn4InauPUuR2Ni9QT5cimQ8
	o4LfQUc2J5ptviUbsXwhEkFLJRKHrZC2e+HZeObeVn4Mt9brS4AhHi+qgekc+EgY
	LR4NPw6+ZV+ESO+gpW8w1qm7x+XPyLe09faie5vAWRrCOmjMODhXMbBK2w6W6O8M
	Wum0zDCBZt8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8984B42C00;
	Tue,  9 Feb 2016 18:00:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0089642BFF;
	Tue,  9 Feb 2016 18:00:57 -0500 (EST)
In-Reply-To: <CAGZ79kao-DWwn2j4aO8ArSPHAX65KeL7NyD=ONkB6qjOrDZNSQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Feb 2016 14:53:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB19857E-CF80-11E5-B2DB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285882>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Feb 9, 2016 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>>> I couldn't find any other examples of people referring to this character
>>> as a "blank".
>>>
>>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>>> ---
>>
>> Any comments on this from anybody other than the author that I
>> missed to support this change?
>
> I remember "blank" being used in my early days of computing.
>
> The blank was somehow more accurate as it described the exact
> thing (i.e. char U+0020 as commonly produced via the space bar
> on the key board)
>
> A space however could refer to any kind of indentation.
>  * tabs would qualify for that
>  * other tricks of your (wordprocessor-) editor would qualify for that
>    (indent by 2 inches in footer section or other weeirdness)
>  * any other character not using any ink in a printer[1]
>
> [1] https://www.cs.tut.fi/~jkorpela/chars/spaces.html
>
> Looking at that table in there, U+0020 is officially called "space",
> so I guess the patch is technically correct.

So the "blank" is correct because we just want a gap between the
comment char and the text, and use of " " is merely an
implementation detail.  The "space" is correct because that happens
to be the byte used as the implementation detail of leaving that gap
between the comment char and the text.

;-)



>
> Orthogonal to this discussion, I'd suggest adding an "a"
> into the string
>
>      N_("prepend a comment character and a {space, blank} to each line"),
>
>>
>>>  builtin/stripspace.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
>>> index 7ff8434..15e716e 100644
>>> --- a/builtin/stripspace.c
>>> +++ b/builtin/stripspace.c
>>> @@ -35,7 +35,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>>>                           N_("skip and remove all lines starting with comment character"),
>>>                           STRIP_COMMENTS),
>>>               OPT_CMDMODE('c', "comment-lines", &mode,
>>> -                         N_("prepend comment character and blank to each line"),
>>> +                         N_("prepend comment character and space to each line"),
>>>                           COMMENT_LINES),
>>>               OPT_END()
>>>       };
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
