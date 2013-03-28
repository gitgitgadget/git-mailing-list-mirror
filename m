From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and GSoC 2013
Date: Thu, 28 Mar 2013 09:45:02 -0700
Message-ID: <7vtxnvv5gx.fsf@alter.siamese.dyndns.org>
References: <20130327183410.GA26066@sigill.intra.peff.net>
 <20130327185248.GE28148@google.com>
 <CAP8UFD1CjfJ8wM-htX8SOOveAt8zQ+qBRk_P016Y57jWnt6sCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:45:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFxJ-0004km-2E
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726Ab3C1QpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:45:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756508Ab3C1QpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:45:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28DB5A9C4;
	Thu, 28 Mar 2013 12:45:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OJX6m5AO3Y99UQ1W5QItdGf9y+I=; b=C7zhnW
	XZFIDiMeP3J0nOOrRV4dMm1BTQTnO+Nxyg+0oLYlX7hmDKwoFcD0Jx3lpvldcwdm
	J0peKEzPGsnBWWQqKf8yAvbk1C1FOmlLuov+rsTNiWKolU9Uw4J8C2AlCifSxKit
	wnHlDI1Y+SddgRP+ZFeAqbsIKtxwiUU0go9dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E9+zjBpT/l/CwWJK1r7GNVH41NXMLUS2
	Bcb7ExHvcxB1+m7hEWjtBnWFeRj39AN0vdBRjGWtd3TSYdiGUtXwwnCFeZMFD4PB
	yR9MI5ccHqovpM1V5XPcGagDW+kgRq4KVtK4flopT90gaLvlnn29oCXVQWtTqOz+
	I6mIHR3CDyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C66AA9C2;
	Thu, 28 Mar 2013 12:45:04 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D01DA9BF; Thu, 28 Mar 2013
 12:45:03 -0400 (EDT)
In-Reply-To: <CAP8UFD1CjfJ8wM-htX8SOOveAt8zQ+qBRk_P016Y57jWnt6sCw@mail.gmail.com>
 (Christian Couder's message of "Wed, 27 Mar 2013 23:15:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6A83428-97C6-11E2-A68A-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219427>

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Mar 27, 2013 at 7:52 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Jeff King wrote:
>>
>>> There was a big thread about a month ago on whether Git should do Google
>>> Summer of Code this year[1].
>
> I think we should do it.
>
> It looks strange to me to say that students are great and at the same
> time that we should not do it.
>
> Let's give them and us one more chance do to well. This is the only
> way we can improve.

Do you mean we should be doing the same thing over and over again
and expecting different results?  Einstein may not like it, and I
certainly don't.

What I gathered from the discussion so far is that everybody agrees
that our mentoring has been suboptimal in various ways (not enough
encouragement to engage with the community early, working in the
cave for too long, biting too much to chew etc.).  What makes you
think we would do better this year?

"We have a track record of being not great at mentoring, and we
haven't made an effort to improve it." is a perfectly valid and
humble reason to excuse ourselves from this year's GSoC.

"Students are great" is immaterial.  

In fact, if they are great, I think it is better to give them a
chance to excel by working with organizations that can mentor them
better, instead of squandering their time and GSoC's money for
another failure, until _we_ are ready to take great students.

It is preferrable if the decision were accompanied with a concrete
plan for us to prepare our mentoring capability better (if we want
to participate in future GSoC, that is), but I think it is a
separate issue, and I suspect that it is too late for this year's.
