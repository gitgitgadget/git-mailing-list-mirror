From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update_linked_gitdir writes relative path to .git/worktrees/<id>/gitdir
Date: Mon, 08 Feb 2016 14:16:25 -0800
Message-ID: <xmqqziva6e6e.fsf@gitster.mtv.corp.google.com>
References: <1454789548.23898.223.camel@mattmccutchen.net>
	<xmqqlh6w9isp.fsf@gitster.mtv.corp.google.com>
	<1454893478.2511.5.camel@mattmccutchen.net>
	<20160208135607.GB27054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matt McCutchen <matt@mattmccutchen.net>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:16:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSu6l-0006aa-3z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbcBHWQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 17:16:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754257AbcBHWQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 17:16:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57EA741F1A;
	Mon,  8 Feb 2016 17:16:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=66rQz1eUGVGK+iFrb9dttERDmYQ=; b=uezdFY
	EOoX+kkJS7yyjPdPihe5vsKFWcNkpbqb962cVxpEUrCTljIVxBY8kNwYKo0zD8iU
	15Z3XAAax+urXDSm48CYPeKsA3Y2vuO9rvRbR2aReHhnqXWK7Il4ZUExqrIWmsKj
	+LnAnmSj9kzw1tn+NNatVwQL4bvm2DSbKM7tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=goEUWT3P2oOF1KBLtkZ96mk5m71m1EZC
	yCU+I7WrBSQb4+5RJE8FZvvPdpFzr8VfL56n9EtrYXToLcV9LDs2a1h6XMC85HaF
	RY95541ZZsAPVGQvgSF3sv6FRLp/OFlgDuqVrmfVccqbGRFzRxkKqQjY5SvRBjE/
	0iVl13kYYGQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 493AA41F19;
	Mon,  8 Feb 2016 17:16:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C107D41F18;
	Mon,  8 Feb 2016 17:16:26 -0500 (EST)
In-Reply-To: <20160208135607.GB27054@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 8 Feb 2016 08:56:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9884CFD8-CEB1-11E5-A463-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285814>

Jeff King <peff@peff.net> writes:

> FWIW, as the person who wrote that section, I think that is a good
> addition.  We do have a link to Simon Tatham's bug-reporting guide, but
> this is a good place to put project-specific advice.
>
> In addition to "try it on next" you may want to also mention "try it on
> the latest version of git". That is another frequently given pointer to
> bug reporters.  Trying "next" is obviously a superset, but I suspect
> trying a released version may be an easier first step for some people.

Yes, definitely.

I agree that testing with the latest released version would
typically be much easier to end users than building from the source.
It would reduce the need for "Ah, that's ancient issue, we know it
was fixed a few releases ago." responses by us; I do not recall many
of such responses in the recent history on the list, though.

For the ones who are more into the spirit of helping each other who
can build from the source to help us even more, checking 'master'
and finding regressions before it gets too late is a very good
thing.  Checking 'next' and confirming an upcoming fix is equally
valuable.
