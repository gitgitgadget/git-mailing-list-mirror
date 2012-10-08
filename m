From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t5400-send-pack: Use POSIX options to cp for
 portability
Date: Mon, 08 Oct 2012 14:19:32 -0700
Message-ID: <7v391ok6fv.fsf@alter.siamese.dyndns.org>
References: <1349683681-18978-1-git-send-email-bdwalton@gmail.com>
 <7vlifgncq8.fsf@alter.siamese.dyndns.org>
 <7vd30snbtk.fsf@alter.siamese.dyndns.org>
 <7vvcekluwi.fsf@alter.siamese.dyndns.org>
 <CAP30j147c47y=cWVQNCtOdjp4mqV0kjhrSr7ZEfwDCyfQWthcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 23:19:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLKju-0003RA-93
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 23:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab2JHVTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 17:19:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005Ab2JHVTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 17:19:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AC618732;
	Mon,  8 Oct 2012 17:19:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=55b38JF/EIKng+2BUmu26cC90I8=; b=NUIfZk
	92quptI4skbunoFTsy6a7KSRnEQNTbmZGMQcDHbzrSyQi+iM/OBPD1VLci98AA7I
	k9NN76SOhqY50OxozVO+nb8gJnhtEB4f4JP4vpwBPKUWbEm3JtbwlI18AloRAs1j
	tFWsAp8SFufobEziuvFUIJtp7bijESny7t3Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZC1JD5CRVNJ1S30043OL7xwSxRlLxqrY
	kO7gB8bk6Lt/IlmAtpbrhW/vzFPW0pyIZwuOUbQZ3q2SRSmSihPuDiZINRIcZFQS
	jO5yvkfQhvxwOfe0XC6g64koNiYmUdKfO8m5vQBTYcg0WIZ05I465EUXg2aps4Zt
	6R+HK+/QXpI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08CD08731;
	Mon,  8 Oct 2012 17:19:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 649EE872D; Mon,  8 Oct 2012
 17:19:34 -0400 (EDT)
In-Reply-To: <CAP30j147c47y=cWVQNCtOdjp4mqV0kjhrSr7ZEfwDCyfQWthcw@mail.gmail.com> (Ben
 Walton's message of "Mon, 8 Oct 2012 21:05:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB70D2EA-118D-11E2-8FD1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207272>

Ben Walton <bdwalton@gmail.com> writes:

> On Mon, Oct 8, 2012 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> Thanks, but is "-p" essential for this test to pass, or can we get
>>>> away with just "-R"?
>>>
>>> Besides, when you spot a potential problem, please ask "git grep"
>>> to catch them all.
>>
>> In other words, how about doing this instead?
>
> This works.  I was responding to a failing test so I didn't look for
> other instances.  Clearly I should have...I must not be exercising
> those other tests.
>
> Acked-By: Ben Walton <bdwalton@gmail.com>

I actually was planning to pass the blame to you so I'll re-queue it
under your "Author:" name, with S-o-b.

Thanks.
