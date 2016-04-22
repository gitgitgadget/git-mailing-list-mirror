From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 15:12:30 -0700
Message-ID: <xmqq7ffpnvht.fsf@gitster.mtv.corp.google.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPMYSGe0k0eAZCQFtBOHw2yZp0w+HL6iN9YPDX5EvJcg-w@mail.gmail.com>
	<xmqq60v9r20i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:12:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjJW-0007Jo-0B
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbcDVWMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:12:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719AbcDVWMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 18:12:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AC7C13988;
	Fri, 22 Apr 2016 18:12:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DRi+5CypXaQeZQkIoulurI6zlhY=; b=BwFEhD
	4kjodsycxpSL4aQCJc/IKmjMQhmPgeaPm+kMTEMCY8jWEJfLhWyaYf29yHnl3fc2
	MfaAP9C4GNRJl8RGek+o6jmzYxY4xmFoxIAzf5lJBraQ9jItxmasLrYF4M4B8s1o
	Ccl8exSy5f3FBaSoeFy62wLGV+/7TKcRR3nNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mm4Ko97Sj4xO0emuu/DywncT+OczPpOU
	TRHphjSKxnb1gItNQS4413SjlHi+mIIvz6px0l1ua3Pa2+HEKe06fX6y3qIpDMkb
	mItPQpRUTCQy+wmFk9RWfF6EoiB7jR97PQkQSjiYRn407KJ8aAqjyvgOHtOTAa+/
	XEjCWuGwTDw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5288113986;
	Fri, 22 Apr 2016 18:12:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE88D13985;
	Fri, 22 Apr 2016 18:12:31 -0400 (EDT)
In-Reply-To: <xmqq60v9r20i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 22 Apr 2016 10:23:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4F02C59E-08D7-11E6-9E05-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292284>

Junio C Hamano <gitster@pobox.com> writes:

>>>  Is this going to be rerolled?
>>>  ($gmane/291382)
>>
>> The changes weren't that big enough and I had my end semester exams
>> coming so I decided not to re-roll it.
>> If you think contrary, I can do a re-roll with the changes suggested
>> by Eric Sunshine.
>
> I agree that this was pretty close to be done.  Let me see if I can
> find time to finish it up in the coming few days.

I looked at the reviews again and I take the above back--the end
result of applying all patches may not have to change a lot, but
the ordering and structure of the series may need cleanign up.
