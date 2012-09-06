From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fetch: align new ref summary printout in UTF-8
 locales
Date: Thu, 06 Sep 2012 11:08:12 -0700
Message-ID: <7v1uif3tyr.fsf@alter.siamese.dyndns.org>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
 <1346755175-31468-1-git-send-email-pclouds@gmail.com>
 <504796A5.4070700@gmail.com> <5047A602.1020802@web.de>
 <CACsJy8D3VyFk+0PTeeXTN-Js9x7p+a+2vW+trry8-6q+9=m2xg@mail.gmail.com>
 <B268CEF3-88A6-49B0-8AE7-7C06EDAE7CEF@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9gV6-00009s-5q
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 20:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931Ab2IFSIR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 14:08:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932853Ab2IFSIP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 14:08:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F916991C;
	Thu,  6 Sep 2012 14:08:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qYOAXU2q6VlZ
	E8bvxFilr/WmA+w=; b=RqKYXcQSfPVQvZpb6dIkdGAbNKq473ZIbkFrwN6+vjit
	fkIhRuMk1YAoFEYXuV7tOHIrwQSdAX3iOprW14RjOP/eC2B8YO6rU/eU5D1qRpRe
	xlUwOjBxGpWQVwR2cjH9DtWGk8iyoaEr+wWNwmMSGwKmBV8FSpt4EwEVpYBk4vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lczOst
	FSD33bwm1/R1eklqHlObIhSec9VeYwsKmIi9QqKPXp6bpBPGsNy/IQffEDs/AkbE
	kpBOP0bTAl5b+ksHeMhJbrSDXTy4OEKKbxWN/2t4loolAEjWjvkXIbJ4K6slRKyp
	uiflLFxyGfjDt8AO8jWD/2yWq1Ul4/fkgr60s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 266E2991B;
	Thu,  6 Sep 2012 14:08:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 775779915; Thu,  6 Sep 2012
 14:08:13 -0400 (EDT)
In-Reply-To: <B268CEF3-88A6-49B0-8AE7-7C06EDAE7CEF@web.de> ("Torsten
 =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 6 Sep 2012 18:21:18
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D30F0CBA-F84D-11E1-8B15-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204912>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I try to re-phrase my question:
>
> Do installations still exist which use e.g. BIG5 or any other
> multi byte encoding which is not UTF-8?

Yes.

> Do we want to support other encodings than ASCII or UTF-8?
> (Because then the screen width needs to be calculate different, I thi=
nk)

That depends on who "we" are and what timeframe you have in mind.

Do our developers care about these encodings so much that we would
reject "ASCCI/UTF-8 only" patch and wait until we enhance it to do
the right thing for other encodings that we do not use ourselves?
No.  That does not make any sense, especially when we know we will
not have a good test coverage on the additional parts that we will
not be using ourselves.

"This change only helps people with ASCII or UTF-8 and does not help
others" alone is never a valid reason to reject a change, but we
still try to be nicer to "others" that may come after we leave this
topic behind by doing a few things:

 - If the change will make things worse than it currently is for
   "others", we would try to minimize the regression for them.

 - If the change will make the code harder to update later to
   enhance with additional change to support "others", we would try
   to anticipate what kind of changes are needed on top, and
   structure the code in such a way that future changes can be made
   cleanly.

=46or the first point, for multi-byte encodings (e.g. ISO-2022), the
display columns and byte length do not match and in general byte
length is longer than the display columns in the current code.  With
the current code that measures the required columns across elements
by taking the maximum of byte length, they will see wrong number of
filler, so they are already getting a wrong alignment.  With the
"UTF-8 only" change, the required columns and the filler will be
calculated by assuming that the string is in UTF-8, which may make
the computation off in a different way, and if we underestimate the
display columns for a string, they may see the strings truncated,
which is bad.

So as long as gettext_width() punts and returns strlen() for a
malformed UTF-8, it would be OK [*1*].

=46or the second point, I think the API "here is a string, give me the
number of display columns it will occupy, as I am interested in
aligning them" is a good abstraction that can be later enhanced to
other encodings fairly easily, so I do not see a problem in the
patch that goes in that direction.



[Footnote]

*1* If the patch used utf_strwidth() (which I didn't bother to go
back and check, though), it should be OK.  The underlying
utf8_width() will reject a malformed UTF-8 sequence and the code
falls back to strlen().
