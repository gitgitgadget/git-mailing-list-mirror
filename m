From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] branch: teach --edit-description option
Date: Tue, 20 Sep 2011 19:44:50 -0700
Message-ID: <7v7h524nrx.fsf@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <7vobynui8a.fsf@alter.siamese.dyndns.org>
 <7viposfgvd.fsf_-_@alter.siamese.dyndns.org>
 <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <7vty864y24.fsf_-_@alter.siamese.dyndns.org>
 <CAH5451nai988=jB8cgFcUaQZWWUyALC-tOSV_jdLX0r_2UfbPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 04:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Cnz-0000NI-B5
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 04:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab1IUCoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 22:44:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab1IUCow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 22:44:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D5EB6D86;
	Tue, 20 Sep 2011 22:44:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EHbsb6pzpjtlk0URst/r1F1UB+I=; b=YtEEhd
	7P/ECfoj0ZhjoakYqCbbKeH/inGSPSis9e6XvruE20X6fQAHQ80CH8gzaTjO346a
	nSD7JPUbIjrYjzWXZxYqua8THaftDcE2f0OCq9+rWfVhN/jqldvyJw4KSz/HZCb0
	3Vc4KWqAXdOnBcSqVHzQbtMFW7U0bL8N6lAL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M8Ltmn8YnbN2qdLTXHRt63mh23GW8DIP
	3kxljH61IRUn8xq3L+KFvX0rStv3efLptNXjb4AtyucmCkF3wZv9GffxhEy5QYs+
	OKKU64LmuXvKgZ3PY8DW9dJ+RGFFqsjcfedXpGE8JbMpFWkrogqa0rRY2IfHEMbT
	Y3mPnRqAkiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 059AB6D85;
	Tue, 20 Sep 2011 22:44:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CB2C6D84; Tue, 20 Sep 2011
 22:44:51 -0400 (EDT)
In-Reply-To: <CAH5451nai988=jB8cgFcUaQZWWUyALC-tOSV_jdLX0r_2UfbPw@mail.gmail.com> (Andrew
 Ardill's message of "Wed, 21 Sep 2011 10:15:20 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADF41CC0-E3FB-11E0-B364-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181813>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> I understand your reasoning here, however is there a way to allow
> setting the branch description in, for example, a script?

As you read in the patch, especially the documentation part, there is not
a way to do that.

I am not interested because it does not directly help my cause of helping
the human communication between the kernel developers who may want to
perform a signed push to their public repository and send their pull
requests with the same message to Linus.

That does _not_ mean I will _reject_ a patch to add such a feature. It
just means writing such a patch myself or reviewing and accepting such a
patch is not very high in my prioritized list at this point in the
evolution of the series. Teaching the use of the information to other
commands such as "format-patch --cover-letter" would have much higher
precedence.

> Additionally I can imagine it would be useful to be able to set the
> branch description from another tool, what is the recommended way of
> doing that? Should tools modify the config directly??

An obvious answer: "do whatever you want". The only rule that the programs
that need to follow is that branch.$name.description has the string to use
to obtain the explanation text.

How they achieve that (perhaps by running "git config") is of secondary
importance.
