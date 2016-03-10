From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Wed, 09 Mar 2016 16:59:45 -0800
Message-ID: <xmqq60wvf8qm.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
	<xmqqlh5ungct.fsf@gitster.mtv.corp.google.com>
	<xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
	<xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
	<CACsJy8AUs-DAo-GceO9ND9RPVeDOfm_UM4ZuaeNWDwBVMu+dnQ@mail.gmail.com>
	<xmqqk2lbil7k.fsf@gitster.mtv.corp.google.com>
	<CACsJy8D=OjLBN-EXyKM4NnGhSGftYX+RAaR9fg8ML3QWAAb+iQ@mail.gmail.com>
	<xmqqd1r3f9rc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adoxE-0004V4-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934527AbcCJA7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 19:59:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754327AbcCJA7s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 19:59:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27D7C4CD35;
	Wed,  9 Mar 2016 19:59:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tM6a6IrC4bzwtbN32haExK0wtYQ=; b=Z8JghN
	x8VMeL/wC/7FfGeIY8ZE8grei4IIwyzPhBDGjaMseoeyLZ+nkTKIADdntg4jfc7m
	8laJKGaFGj7JqqcubcwcsFnJvJxxG6IuSJzrgEpRoM3kYszvUzjel6BsNn8WUYYp
	zgp5gI+5oAQYMhVDdOk+U2pBS6u1cpaQMgQHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q24i2V1kzWYDInE1aNsGSYP8QQv1xPKH
	BwR7m8lipThFoktG8xi0o5nb1safMeveZqDAaWAN3l4EGiPoU2aR9DYE6ouTRgpp
	W9lB2BJzK8z34rV3tGDoq/bT7A03v+WzbDGpmHyTcy4A0g0NHYfodjjfrhKpGTWL
	IhMXjTfL8X0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F3154CD34;
	Wed,  9 Mar 2016 19:59:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F3F54CD33;
	Wed,  9 Mar 2016 19:59:46 -0500 (EST)
In-Reply-To: <xmqqd1r3f9rc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 09 Mar 2016 16:37:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 621049B6-E65B-11E5-835C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288593>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> A bit off topic, but these two paragraphs may need rephrasing, I don't
>> really understand what it's trying to say
>>
>>  - If the pattern does not contain a slash '/', Git treats it as
>>    a shell glob pattern and checks for a match against the
>>    pathname relative to the location of the `.gitignore` file
>>    (relative to the toplevel of the work tree if not from a
>>    `.gitignore` file).
>>
>> Not sure why "relative to the location of .gitignore file" matters. We
>> basically just take `basename $path` out and try to match it.
>
> That is because the documentation was written with ...
> matches, even though '*.c' does not match 'd/hello.c' in the shell
> glob sense,...

Sorry, this does not make much sense, as d/e/hello.c would still
match '*.c' in d/.gitignore.  So it is a straight-forward match
against the basename, and there is nothing relative to the location
of .gitignore.  If anything, relative to where the pattern is found
should be relevant to a pattern _with_ slash in it.

I should have been more careful and thought things through, but as
this was an "off topic" comment, I didn't.  Sorry about that.

In any case, back to "on topic" part again; I couldn't come up with
a better rewrite using named rules (partly because you need to
clearly define each rule before referring them, and some of the
rules are temporary workarounds for the 2.8 regression that will
hopefully disappear in near future).  I think you understand the bug
and the limitation of the current code a lot better than I do, so if
you can please send a final version of the documentation update in
the coming 18 hours (I have an option of using what is already
queued on 'pu' as a fall-back-good-enough version but I want to keep
the last-resort option as that--if I know a potential source of a
better version, I'd choose to ask first ;-).

Thanks.
