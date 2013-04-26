From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] remote-helpers: fixes and cleanups
Date: Fri, 26 Apr 2013 15:23:11 -0700
Message-ID: <7vsj2due28.fsf@alter.siamese.dyndns.org>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
	<7vwqrpuedv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 00:23:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVr30-00082o-D2
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 00:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab3DZWXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 18:23:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab3DZWXO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 18:23:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5F351A05B;
	Fri, 26 Apr 2013 22:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q3poDA9XrkdAp3Ifx/7CMA2d0Hs=; b=eAfBvI
	q9T2UFt1mhEENRUIrtCZAyY7vp/rwaHiHMhrcILCP8c3KbyA1p6yCP8svXPo8A/H
	vSZBZO7bVZxNdbzAfYjFiFHWSRIe9ukgcapd8y1Ud2OjnICl1I1UaKZjTxhiVVl6
	mmJXFaQoKZbnrnOUumyOt7gB6P6CeB6T7u15Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WnpnVCt8rhwERDCCWNC0WbNBhgC2PW7P
	gJc6IDP/bkvS+dg8KkB21E2R80tvHaEvbGbNjCrZG1XBEZfNy4Odukmc81fJD4SU
	k/j6fGX7qp/wvwjUfJK8a1y4MF7tABxC6kkU1c/dhrCVgYYiXjaUULq5aWcuJGHe
	/BEhTqN0cl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A0D81A05A;
	Fri, 26 Apr 2013 22:23:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 086EC1A059;
	Fri, 26 Apr 2013 22:23:12 +0000 (UTC)
In-Reply-To: <7vwqrpuedv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 26 Apr 2013 15:16:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E22283FC-AEBF-11E2-B7DD-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222598>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Updated the commit messages, so we say Bazaar instead of Mercurial, and stuff.
>>
>> Here's a bunch of cleanups mostly to synchronize remote-bzr and remote-hg.
>
> Thanks.  Will queue on 'pu' without looking.

Actually, I was going to merge fc/remote-hg and fc/remote-bzr down
to master anyway, so I'll just apply them directly on 'master'.

By the way, I personally do not think the quality of the changes to
remote-bzr matters all that much at this point in its history.  It's
not like millions of people use it heavily from the v1.8.2 release.
A huge patch series from its original author and nobody else, either
reviewed or unreviwed, would not hurt them more than the one in the
v1.8.2 version anyway. And it is also not like bzr-to-git population
will grow significantly in the future to require us to pile a lot of
features on remote-bzr that makes the maintenance burden of it
becomes an issue.

Am I underestimating the pain of potentially breaking existing
remote-bzr userbase?
