From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Premerging topics
Date: Mon, 29 Apr 2013 15:19:18 -0700
Message-ID: <7v61z5geu1.fsf@alter.siamese.dyndns.org>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
	<CALKQrgeGPo--cYoGZ30nSfASh4CPzqGXQojkG9Ve96NFr+LrjA@mail.gmail.com>
	<7vzjwofpht.fsf@alter.siamese.dyndns.org>
	<CALKQrgd8jZQ__rnAT3wbfx-Y6mg-vrTdam53nS2ya2c=yMcS6Q@mail.gmail.com>
	<7vppxkflhq.fsf@alter.siamese.dyndns.org>
	<CALWbr2wiYkHMSihh-X-ToO-j4fty-P5OHicHa8ZUoqBkLS5mow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 00:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWwPu-0004Nq-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 00:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758484Ab3D2WTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 18:19:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757464Ab3D2WTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 18:19:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A444E1AA74;
	Mon, 29 Apr 2013 22:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ioI+LTD65RP8iVsti8vtSqOw6Pw=; b=EFLMtg
	d+GOMOCvGPbb+TKLeoZnhqAh1quL7rzoAcew/FTRCXVWtqLOOzcbBjs6KKAlyHAh
	VM0i6koJAVGI31y8s/VMttbjZNrrYNQlEYkwWRUSoWWTkdwnBZHvdQ22GWX9kkzy
	33HQASSAts+sQictHzTa7/EkWf1MbB5osG04o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tff+nWZUbYWEwD44NNWeGQ5c9y3JyLKJ
	s+gM2YH6aqoNx8C8VvV9tUpa4h3HfAjZJ7khAY0f+wiqAbqYb5NJ+Wt3ddIUiWKm
	epqQuR3xCYBfTQ8qboNqFtxq08M+OzQ5LX9+U9/Qe5ocFJYrbyegEmNWfZFsB7e7
	pwB3dwz1Mhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AE2D1AA73;
	Mon, 29 Apr 2013 22:19:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 061DA1AA70;
	Mon, 29 Apr 2013 22:19:19 +0000 (UTC)
In-Reply-To: <CALWbr2wiYkHMSihh-X-ToO-j4fty-P5OHicHa8ZUoqBkLS5mow@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 29 Apr 2013 21:06:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D67D5380-B11A-11E2-A9F1-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222870>

Antoine Pelisse <apelisse@gmail.com> writes:

> Should we think about adding some commands for that ?
>
> On the very top of my head (there is certainly more than that):
> - Save such a change: By basically creating a ref to HEAD (HEAD being
> the commit, HEAD^ the fixed merge) with merge-fix/HEAD^^1-HEAD^^2
> - Apply the merge-fix: On top of a merge, find the most recent
> merge-fix for HEAD^1/HEAD^2 (according to what was discussed), and
> squash it.

Yeah, some nasties may live in the details, but these two operations
are needed and probably sufficient as the end-user facing UI.

The "save" step, when done manually, needs to be a two-step process
that saves M and then F separately, but somebody _might_ be able to
come up with a clever idea to let the user jump directly to F
without recording M.  If such a triangle (A and B merges to F) can
be recorded as merge-fix/A-B, that would certainly be less error
prone and easier for the users to use.  Having said that, in the
presense of possible textual conflicts when creating M, I do not
think of a way that is easily implementable mechanically to
internally sift changes for M and F when replaying it while
resolving a merge between X and Y to produce N and eventually F'.

The "apply" step should be a single step, and it should be easy to
implement mechanically if M and F are recorded separately (but
again, you may be able to re-synthesise M from A and B when you need
to replay the evil merge).
