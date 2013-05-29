From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] remote-helpers: rename tests
Date: Wed, 29 May 2013 11:44:06 -0700
Message-ID: <7v61y1tymh.fsf@alter.siamese.dyndns.org>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
	<1369449507-18269-3-git-send-email-felipe.contreras@gmail.com>
	<7vmwrezx7n.fsf@alter.siamese.dyndns.org>
	<51a56ce142986_807b33e18100084@nysa.mail>
	<7v8v2xvhbu.fsf@alter.siamese.dyndns.org>
	<CAMP44s2-Of=AS9Jg7YAXnZ2346ozWPS4gL5irh0devwpkdBKmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 20:44:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlM7-0002uj-8w
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986Ab3E2SoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 14:44:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757319Ab3E2SoK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 14:44:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5531E22B0D;
	Wed, 29 May 2013 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9cAqL9BKL2zD18/EvJ7nN8d7UHE=; b=TKVC0Y
	crpcFmpDtjHQs/EI6mYqQmvgvoY1Txzo8Jjntz5rFD6QO6QwNC3qEr+vBe+9jKqq
	qJab2t3yzyk/dyDOy9f21L9D2ja7pQTxkgTXV8UtGh9eOg00rjzag1rVY/QwRx3a
	IK9Z00CE9t7SLiAKERMNqKL6SlTaPwwo4s6Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bM642w8IbUIF9LEgrycxJAdz6XoqRpFO
	YKr4cVG5AO20v4x5175VCL2NvCfZ5kNW0fccdrTPSayoLowSOgvhuo52cn4YA+KT
	/9u0dtPyVi7gv1HrsCRIl3UOymjaJ3FxZGp1n6r2FlVMl9EhMK+VSfFdPy+xixci
	GIfywMiteb4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C1F722B0C;
	Wed, 29 May 2013 18:44:09 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A40D522B09;
	Wed, 29 May 2013 18:44:07 +0000 (UTC)
In-Reply-To: <CAMP44s2-Of=AS9Jg7YAXnZ2346ozWPS4gL5irh0devwpkdBKmQ@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 29 May 2013 12:56:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE854634-C88F-11E2-8A15-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225864>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 29, 2013 at 12:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> I do not see how it makes sense to copy how they deviate from us
>>>> back to our codebase, especially if we plan to eventually move some
>>>> of these tests out of contrib/ area, but even without such a plan in
>>>> the future.
>>>
>>> They deviate from us, we deviate from them, whatever. We are a single project,
>>> what more than one project does is more standard.
>>
>> We are a single project, so it is better to consistently follow the
>> local convention established here.
>>
>> If your proposal were to
>>
>>  - Convert t/*.sh to end with .t intead, to change the project
>>    convention, and
>>
>>  - Make contrib/ things also conform to that new convention.
>>
>> it may make some sense to discuss the pros and cons of such a move,
>> but changing only contrib/ has no effect other than making it even
>> less consistent with the rest of the project.
>
> It's already inconsistent with the rest of the project, as they are
> not named tNNNN-foo.sh.

Correct; that is why I said "even less consistent".

> If you want I can give it a try at renaming all the tests in the whole
> project to *.t, but I don't think you are truly interested in finding
> a better extension for our tests.

Again, correct.  I do not think it is worth the trouble to renaming
them to *.t at this moment.

Having said that, I suspect that in the very longer term it might
turn out to be a good thing to do (if we want to make our test suite
runnable under other people's tools that expect .t suffix, for
example).  But I do not think that is the topic of this patch under
discussion.
