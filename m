From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Mon, 21 Dec 2015 08:54:59 -0800
Message-ID: <xmqqzix3hhcs.fsf@gitster.mtv.corp.google.com>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
	<1450444992-25368-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Dec 21 17:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB3js-0008Cm-DE
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 17:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbbLUQzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2015 11:55:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751299AbbLUQzE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2015 11:55:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3746431B0F;
	Mon, 21 Dec 2015 11:55:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c1fpyr3y7wRJ
	E9OxxcO1/gaN1Nk=; b=fpkA9oPChkyi2utp1qBAorPUjNOUNZO+tPUZyT/+EWHZ
	FTHOmQJQmu7kyPYW7VEfeTn//s+lpL/nLRdJsKmKpJDNKd+F93Z/OHrcKiQZdq6L
	snVZmDEr2SAHkrLT4IgFYwcM8KLuAtOzanAzDpyW6QBt9OFbTLpeDAc1Nfw94ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BoPS3C
	T1qhymNP3Pk6RDAgGN+KaqIYs62t3ccNXm6ckfYnOsCh5VmyNW2MOw0q/EwpSuvH
	/RLQdPqq6KIxYmvm8zXMe2olzI+2wyg5GH1gW7rzYE1xMVOoz8Ieq36d36uftPR1
	oCDUaw5RSPCxxXr7t015qbQ+bWXz3IGYKnklM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2658631B0C;
	Mon, 21 Dec 2015 11:55:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 141C431B06;
	Mon, 21 Dec 2015 11:55:01 -0500 (EST)
In-Reply-To: <1450444992-25368-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 18 Dec 2015 14:23:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 93B2315A-A803-11E5-9CE4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282796>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> On the other hand, I've marked a handful of topics below as "Will
>> discard". They were all dormant after waiting for updates for quite
>> a long time; interested people may want to help resurrect them.
>
>> * sg/pretty-more-date-mode-format (2015-10-07) 1 commit
>>  - pretty: add format specifiers for short and raw date formats
>>=20
>>  Introduce "%as" and "%aR" placeholders for "log --format" to show
>>  the author date in the short and raw formats.
>>=20
>>  No comments after waiting for a long time.
>>  Will discard.
>
> By adding missing date format specifiers this patch improves
> consistency, improves usability of pretty format aliases, benefits at
> least one user, and does nothing wrong in its implementation. =20

The above used to say:

    I have a feeling that that this is a step in a wrong direction.
    Comments?

which came from this comment of mine in $gmane/279195

>> It makes me wonder if it's time for us to move to a more extensible
>> format, e.g. "%aT(...)", in which 'T' stands for 'timestamp' and the
>> part in the parentheses can be any format string that is understood
>> by "log --date=3D<format>"...

to which you said this in $gmane/279236

> That would be great, especially that in [*1*].  Real words are so
> much better than one or two letter codes.

and I was hoping that at least we hear justification for not doing
the right thing and instead adding more short codes that we'd need
to maintain indefinitely, which I heard none.  Of course, it would
have been great if we saw a "more extensible format" patch ;-)

I'll keep the topic in 'pu' for now as a reminder.
