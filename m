From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] activate diff.renames by default
Date: Tue, 23 Feb 2016 13:40:43 -0800
Message-ID: <xmqqsi0jxfz8.fsf@gitster.mtv.corp.google.com>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8mr1bk7.fsf@gitster.mtv.corp.google.com>
	<vpqsi0jf94g.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:40:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKhO-0006U8-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbcBWVkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:40:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751370AbcBWVkq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:40:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B739B46A01;
	Tue, 23 Feb 2016 16:40:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BsPOqIMsU9/wqAfJXTQDYHEf3Vo=; b=efmg9c
	K4C11nQz6050sJwU/dKh2b8pAi+/qsXfc5nM8wkGtHou29cGS7EWaN0Qu9e4XvlU
	f6mI2oZoOSN7HXifdaig5QqgqH368O675B+bmPb+p65xVDZ9MA+aveSIekwW6gKK
	FWq/Kbq0jKOEdhw6QZWreRZU/01s2xWOQBNwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PWYRN25O1+X5mIiGSjBQWFlao1l9Rrrn
	x8lUD99mAHDyyHccMM/hm2Wr7wBC0IKSvNCCTg63XQX1Uck1jYPmFF0G+EcZt0EA
	9NUOEZQOgXKNJ8eyjHiHw3+DAq2RaTAysbFmS7yKB0x8BW32ZifqQAdfKIDlcBRK
	B0Z4LcX2wCE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF7F746A00;
	Tue, 23 Feb 2016 16:40:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 23B50469FF;
	Tue, 23 Feb 2016 16:40:44 -0500 (EST)
In-Reply-To: <vpqsi0jf94g.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	23 Feb 2016 21:46:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 18326C8E-DA76-11E5-AC7C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287130>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> I have always wondered why diff.renames was not activated by default.
>>> I've had it to true in my configuration for 9 years, and I've been
>>> teaching newbies to set it for a while without issue. I think it's
>>> time to activate it by default, but please let me know if I missed a
>>> reason to keep it to false.
>>>
>>> In any case, the first 3 patches are useful cleanups.
>>
>> It's a long time coming since I heard "I love how I can just say
>> 'oh, keep in mind that we might want to..' and 24 hours later you
>> did it." [*1*]
>>
>> I can hardly be an impartial judge for this series, though.
>>
>> [Reference]
>>
>> *1* http://thread.gmane.org/gmane.comp.version-control.git/3541/focus=3702
>
> I guess there's another reference needed to fully understand your
> message, and I'm not sure I have it right. Are you refering to the
> "merge-recursive: test rename threshold option" discussion?

Not at all.

I was just mentioning that it would at last be a major achievement,
if this can safely turned on by default for everybody, after having
invented the machinery and the feature looooong time ago ;-)
