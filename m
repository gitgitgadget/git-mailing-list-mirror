From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] send-email: make annotate configurable
Date: Sun, 07 Apr 2013 10:22:44 -0700
Message-ID: <7vvc7y45nf.fsf@alter.siamese.dyndns.org>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
 <1365318630-11882-2-git-send-email-felipe.contreras@gmail.com>
 <7vfvz2948b.fsf@alter.siamese.dyndns.org>
 <CAMP44s0g5YfvprwukJ4rnqXrm+S9-KJkwyYB+sxAcQjZpDXufg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:22:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtIp-0000tI-En
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934128Ab3DGRWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:22:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762043Ab3DGRWq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:22:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A7C91313D;
	Sun,  7 Apr 2013 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JKtej9v5s9er57tZTM1u1ht4Mjk=; b=n29SY2AWJKpGKx4JKutb
	VYxCkC4ggA/yXp7ThovDMLlLg6a+e6SVQMZBWXk/ICJQ+ae/FCJOBu4aRTGexFCI
	W1VmfM1wMhJR4k9wUrmEN4cDs9X7hXngEJmBWADbtjdOtB8chU/W7Y+ufzgTvxg1
	4SxZOysl2tS8n3sRSxm6q+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ubiI2AsY6nJkpt4YhGN6PXjdWlGqF2QT2L2gJRnsoLUlIt
	ZGVBVLjIKyyUIg/Eq9Dse5p2V5hWJYCGlludz1uYyDXEuwYZhkR7/46yYU3TivIC
	snOqUQnu5rgDJOIDApsw7XfjTcUnajcDM+cq2ZzBZ9FV0ItwLkayV1eGOE9Ms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51E321313C;
	Sun,  7 Apr 2013 17:22:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B718E13139; Sun,  7 Apr
 2013 17:22:45 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C33C1D4E-9FA7-11E2-9931-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220333>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Apr 7, 2013 at 1:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Some people always do --annotate, lets not force them to always type
>>> that.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>
>> Sounds sensible; any tests to protect this from later breakages?
>
> Given that annotate doesn't even have tests, I don't think it's needed
> at this point.

That is a good way to spread earlier mistakes and add more instance
of the same kind of mistakes into the future.

It is perfectly fine to say "I ran out my Git time for the change
itself; help by others to add test for it is appreciated."  It is
not reasonable to say "See there is the same mistake already in the
code, so I am free to make the same mistake, you cannot hold it
against me, and this feature should never be protected by tests".
