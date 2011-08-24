From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] branch: list branches by single remote
Date: Wed, 24 Aug 2011 11:34:50 -0700
Message-ID: <7vei0apsj9.fsf@alter.siamese.dyndns.org>
References: <4E383132.3040907@elegosoft.com>
 <20110804040646.GA5104@sigill.intra.peff.net>
 <4E4A729D.9030906@drmicha.warpmail.net>
 <20110816151448.GA5152@sigill.intra.peff.net>
 <4E551548.9090807@elegosoft.com> <4E551AD0.7050702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 20:35:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwII1-0000tn-Ll
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 20:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1HXSe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 14:34:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab1HXSey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 14:34:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F38034AD3;
	Wed, 24 Aug 2011 14:34:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EW52CzSTDqxtVpQIKjvRPUQqCWE=; b=hTqY8q
	qcvhFpnI/RSWcN9zRl0yEIGkxNJ7CmuTxl6yWrg81QieRCCx+t83c9t7rjKCioNB
	pzqsf2XweytSs0d461ER2wbxVy6AO+xL/J04WlIdQFdq+ZqqviXnyOzAd0r7wfzz
	jFqZ3DCW0+ZXIi7duYktbsKB6GukUjKvgufsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QmnI24dGLAknxlnFGROXVtuH2iJTeWEp
	656J6IeD+TDxjC3vA4yxTOe6TVFhgGNVDgof1QdJKZWWNY3PYE/HaSuMX1JyM35R
	bR/ZgQH6kZP+sIkwjKChYAzH/PoKy2arTadarNJxCrCxUGQJDlTMIhDEe2SqXX/2
	YVAEjPgRVlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA31C4AD2;
	Wed, 24 Aug 2011 14:34:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A4444AD1; Wed, 24 Aug 2011
 14:34:52 -0400 (EDT)
In-Reply-To: <4E551AD0.7050702@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 24 Aug 2011 17:37:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1780D7E-CE7F-11E0-BE03-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180023>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> As suggested, I've just called it "--glob" for now.
>
> Well, again, what's the point in replicating
>
> http://permalink.gmane.org/gmane.comp.version-control.git/172228
>
> and how is it different?
> As I've mentioned, I've been in the middle of polishing that up.

It is not unusual for a similar itch to happen to different people
independently.

If this were something you reposted even a WIP re-polish within the past
two weeks, I would understand and even sympathise with your irritation,
but please don't expect everybody to dig back FOUR MONTHS worth of mail
backlog to find an topic that may or may not be abandoned by the original
author.  Perhaps we would need a weekly posting of topics people have
posted, found to be not quite ready yet, and are still being polished and
not abandoned [*1*]?

Having said that, I still appreciate that you posted a link to the
previous topic:

  http://thread.gmane.org/gmane.comp.version-control.git/172226

so that the discussions in this thread to scratch the same "itch" can
benefit from the points raised in the previous thread that need to be
considered.

The old thread talks about renaming existing options and transition plans
to make the "listing" mode of "branch" and "tag" more similar, which may
be a good plan in the longer term.

I however can see that teaching "--glob" to both "branch" and "tag" (in
other words, "tag -l" would become a synonym for "tag --glob") an equally
good longer term plan.


[Footnote]

*1* It does not have to be a weekly _posting_ on the list but can be a
well-known Wiki page or even a bug tracker. Whatever medium is used for
this purpose, there _must_ be a built-in mechanism to expire entries away
that are inactive for more than some reasonable limit (say two to three
weeks).
