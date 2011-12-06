From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Evaluation of ref-api branch status
Date: Mon, 05 Dec 2011 22:57:46 -0800
Message-ID: <7vzkf6gpat.fsf@alter.siamese.dyndns.org>
References: <4EDAB62E.5070204@alum.mit.edu>
 <7vfwgynacr.fsf@alter.siamese.dyndns.org> <4EDDAC4A.4030805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 06 07:57:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoyR-000548-9Z
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242Ab1LFG5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:57:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124Ab1LFG5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:57:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB34A1B2D;
	Tue,  6 Dec 2011 01:57:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KtPNUHPlpxe+hCmcmIK/iqixjYg=; b=SlrXPt
	9zCB2Tk6yS6p39VyoqXklSmDGYz57InZPD+yxQIxTa1TXDhOYwQl8rQlnR09k6Ca
	cuDVeejm13lvdR75w9sEXT+qLv7RUGRqZp6fBHrLH23obFG0t95XMiIANvcFaovq
	EqPAauEsrSC1l1sza00PftLwlYi5/b9Q8OOJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PpBADgsJ3djEx/BgYgoSZr1fHykAKjuM
	83X5LyAIOhryfrb4KJjXQBun9JhotM1SHRtamSfhlXd7br9Mc7/lOklUR++APhtB
	86A9xHB8cW9uCSW957QE8kP/Xi1prLye2/Qxr1cT5ZFoPhY8wQPHdxvBWrx0EPLi
	8igClMJ13UQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A23371B2C;
	Tue,  6 Dec 2011 01:57:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14ACC1B2B; Tue,  6 Dec 2011
 01:57:47 -0500 (EST)
In-Reply-To: <4EDDAC4A.4030805@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 06 Dec 2011 06:46:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B4079A8-1FD7-11E1-8856-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186334>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 12/05/2011 07:26 PM, Junio C Hamano wrote:
> ...
>> My reading of your summary suggests that it would be easiest to drop the
>> three mh/ref-api* topics from my tree, especially the 'refs: loosen
>> over-strict "format" check' band-aid patches, and re-queue a re-roll from
>> you.
>
> OK, then, I will try to re-roll the series on top of master, and build
> the equivalent of your quick-fix into the logical point in the series.

These quick-fixes were necessary _only_ because the queued topics predate
the real fix already in 1.7.8 (and I generally refuse to criss cross merge
from master to topics), so I expect you won't need their equivalents if
the topic is rebased on top of 1.7.8

> ... How much time to I have to work on this
> while still leaving enough time to comfortably integrate it into 1.7.9?

I am hoping we can have rc0 very early next year [*1*].


[Reference]

*1* https://www.google.com/calendar/embed?src=jfgbl2mrlipp4pb6ieih0qr3so%40group.calendar.google.com&ctz=America/Los_Angeles
