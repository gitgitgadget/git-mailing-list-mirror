From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Mon, 10 Sep 2012 12:35:05 -0700
Message-ID: <7vhar5oemu.fsf@alter.siamese.dyndns.org>
References: <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <20120910161904.GC9435@sigill.intra.peff.net>
 <7vpq5told4.fsf@alter.siamese.dyndns.org>
 <20120910171954.GA15583@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 21:35:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB9lQ-00039e-A5
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 21:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758455Ab2IJTfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 15:35:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758444Ab2IJTfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 15:35:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7357699F8;
	Mon, 10 Sep 2012 15:35:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e7k6noff70AKUXp/14I7ftUN++0=; b=PoNZzD
	t+a45f96y11Rj7jP0dNjTPstBB977+vZ/b6dCMCsCqLG1nRk1E7+/5ufROEwE5je
	fzv99nQBC06PSUqKNrt4FGKADv/70f5jGv6KlEVC9dCi4yaQsyIWyJKf+tFyWPhl
	XIEl8eMLuRGfbs2Z0tjGBNN1nYIIuqALKLl4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RHftZZCCcXSF+oGWAZve/V8iRewNQkoq
	vLjonUdlli31wu0f26ZsIuK+wjb6Fx58tcke0wXXfPN6neGR20ac3/xyGbye/arr
	kVJld0JwPXnHkPfwqF/+Vo2mBAnd9iwFRsZaxcu8RJ9IFyJ8lsaOWVlXYa+lJy3m
	WAAbebj8bow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6188B99F7;
	Mon, 10 Sep 2012 15:35:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA89799F6; Mon, 10 Sep 2012
 15:35:06 -0400 (EDT)
In-Reply-To: <20120910171954.GA15583@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 13:19:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A010AEAC-FB7E-11E1-8F5D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205164>

Jeff King <peff@peff.net> writes:

> I would argue the opposite; if it is about a specific point, then put it
> with the point. Otherwise, you are asking the reader to remember back to
> an earlier point (that they may not even have read; in reference
> documentation, the point of a list is often to let readers skip from
> bullet to bullet easily).

You need to follow all the rules when composing your command line.
You cannot simply ignore ones that are inconvenient for you and pick
only the one you like.

The second and the third one are related in the "sides of the same
coin" sense; you either have "--" in which case no disambiguation
checks are done, or don't in which case your command line may get an
ambiguity error, so in that sense, you could say "I am writing '--',
so point C does not apply to me and I skip".  But whether you do or
do not say '--', you have to have your revs before pathspecs, so you
cannot skip point A.

So I do not think a bullet list is designed to let the readers skip
and forget (or "may not even have read").  If that is the case,
perhaps we would need to use something else to give the set of rules
that apply to the command line here.

> I don't think that makes it any better. You went from:
>
>   * A
>   * B
>   * C
>   * D
>
>   By the way, B and C imply BC.
>
> to:
> ...
> I think it would make more sense to do:
>
>   * A
>   * B
>   * C
>
>   By the way, B and C imply BC.
>
>   Also, D.

I think the following is probably the best.

    * A (revs and then paths)
    * B (with "--", no dwim is done).
    * C (without "--", disambiguation kicks in. By the way, this
      means your script had better avoid this form; make sure you
      use "--").
    * D (pathspecs are patterns).

without the trailing paragraph, which is meant only for people who
write their script without using "--" by mistake, i.e. it only
belongs to point C.
