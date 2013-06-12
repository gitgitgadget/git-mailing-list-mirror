From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Wed, 12 Jun 2013 13:02:01 -0700
Message-ID: <7vehc72j46.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 12 22:02:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmrFD-0005zF-HN
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 22:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab3FLUCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 16:02:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab3FLUCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 16:02:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E19278F8;
	Wed, 12 Jun 2013 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eIDt7tNNEa3yl9bRTFKUPkPwOVA=; b=UNSuvcQUnAQRo7LooHII
	qd3F4wxJkea+7ZMOwfMAzXE3UXtDSIk4/eBuAZfyzjxKDF9+Z29O/q4oQ1i6iZma
	RwPUiAnXI0KqFxIuLr4fpl6uFKaK+ummqoBDxGAPpZSNpfXcIQvaHF1n9RkoEyIS
	e4OPdsQFQlGuOiVRr4MZ+Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RPOI9RlcG9JYyOyHetgPDN049G2R/xEuBCKUelZlik9/Sd
	zApJazYGPp6Ard+AoNyEItLSjW6MnfcDUKcmNrJrJreRKC2bdz1YO/xDlopkJxdM
	fWU8BM4TnMuxcekkxVnZIYqiNltUMogobHG/YZ7zZWtktTJG83WfYVedNbvyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C715278F7;
	Wed, 12 Jun 2013 20:02:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5738278F4;
	Wed, 12 Jun 2013 20:02:02 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2F35198-D39A-11E2-8475-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227670>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I would prefer a community standards document that looks more like this:
> ...
>
> * Be welcoming to new community participants.  Help them get oriented,
> and be patient with their questions.  Gently introduce them to our
> community standards, above all by setting a good example yourself.

I agree that on-boarding is an important process.

In addition to the reviews I'd give to regulars, I personally try
to do some of these things:

 - Even in a negative review, end the message with "Thanks".  More
   important is to express that the particular patch is rejected but
   contributor's future contribution (either a reroll or a separate
   topic) is welcome.

   This is free, and there is no reason not to be nice.

 - Point out problems in a milder way than usual.  Instead of saying
   "Why is this done like so?", risking to be misinterpreted that I
   am saying the patch did something wrong and the contributor was a
   horrible programmer, rephrase it to "Hmph, this may work in such
   and such cases, but I wonder how well it would in this case?",
   followed by "How about going this route instead, which would
   cover all these cases?"

   Doing so is more time consuming at reviewers' end; once you know
   the current design well enough, you can immediately smell a wrong
   approach a lot faster by just looking at code and design in a
   patch, without having to come up with a concrete example.

 - Instead of just pointing out minor nits and have the new
   contributor reroll, point them out, and then show how the patch
   should have looked like, often after "-- >8 --" and the "From:"
   line that keeps attribution.

   Again this is more work at reviewers' end.

Coaching new contributors, like mentoring GSoC students, is often
more time consuming than scratching the same itch yourself for any
reviewer, but it is an investment, which hopefully yields dividend
in the longer term.
