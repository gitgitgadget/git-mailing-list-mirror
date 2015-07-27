From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Mon, 27 Jul 2015 18:06:18 +0200
Message-ID: <vpqd1zd4mbp.fsf@anie.imag.fr>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
	<vpqtwsp92wf.fsf@anie.imag.fr>
	<CAOLa=ZSXD-pjgYCOt+ZcYS4uHS0p2uBYX8Rw80xpL+9pNUvm+w@mail.gmail.com>
	<CAOLa=ZT58Fai++91AUH2VcerH5OLkbC3thoGtqVYC70R8gSkaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 18:06:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJkv7-0004HA-Q1
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 18:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbbG0QG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 12:06:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56671 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347AbbG0QGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 12:06:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RG6GN7012273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 18:06:16 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RG6I48015828;
	Mon, 27 Jul 2015 18:06:18 +0200
In-Reply-To: <CAOLa=ZT58Fai++91AUH2VcerH5OLkbC3thoGtqVYC70R8gSkaA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 27 Jul 2015 21:29:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 Jul 2015 18:06:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RG6GN7012273
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438617978.66029@5ahikazqwyf14DWIHcAVyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274689>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Jul 27, 2015 at 9:27 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Mon, Jul 27, 2015 at 6:24 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> --- a/ref-filter.c
>>>> +++ b/ref-filter.c
>>>> @@ -946,6 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>>>
>>>> +/*
>>>> + * Return 1 if the refname matches one of the patterns, otherwise 0.
>>>>   * A pattern can be path prefix (e.g. a refname "refs/heads/master"
>>>>   * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
>>>>   * matches "refs/heads/m*",too).
>>>
>>> Nit: you used to s/,too/, too/ in the comment in a previous version.
>>>
>>
>> That's carried over from a previous patch, ill change it.
>>
>>> I think I already suggested saying explicitly "... matches a pattern
>>> "refs/heads/" but not "refs/heads/m")", but I won't insist on that. Just
>>> a reminder in case you missed it.
>>>
>>
>> Sorry, I missed that out. Thanks for reminding.
>>
>
> If I remember right, I didn't change that cause It didn't pertain to
> this commit. I forgot to mention it in your previous mail.

The "but not "refs/heads/m"" part makes sense in this patch to document
explicitly the difference with the other function. But again, it's just
a suggestion, you chose whether to apply it or not.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
