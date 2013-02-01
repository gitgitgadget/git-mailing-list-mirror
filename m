From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Fri, 01 Feb 2013 14:15:13 -0800
Message-ID: <7vpq0j8yvi.fsf@alter.siamese.dyndns.org>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
 <20130201050343.GA29973@sigill.intra.peff.net>
 <7v7gmsd26o.fsf@alter.siamese.dyndns.org>
 <20130201073352.GB970@sigill.intra.peff.net>
 <7vr4kzamt7.fsf@alter.siamese.dyndns.org>
 <20130201190007.GB22919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 23:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Oth-0001KC-2z
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 23:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890Ab3BAWPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 17:15:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757831Ab3BAWPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 17:15:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00ED7B47B;
	Fri,  1 Feb 2013 17:15:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q5/PDHx79awTgfSIskCdCO9dfkA=; b=foiz3z
	rVVO3akHJcIxtpcFOAmoErykTR6fDn5UOIHJkk+//H9sK8yo5DNcpvmVs+mh3jET
	5Cq6t/UWdyllSPydQIYz9FlBm2SHabmojxyH2vbQ0Qlwdm68gdcPS9YAJybV3/Gv
	9dVX3BVu15JYkxqr5buY7KATHadQtG5pWZ6PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AmY6n8EnjEX9tj8LosX0Dhz4UfwtmFuG
	cKI7g4FLdRN0Y8JCwJfU0LjpKcDp5UOiZxpb4iHMWWSmZnUhHy0/rf7mutDH4nRR
	noFyfknLRLRRLO08lCFyl7iEEfwJTikd5TQ76TmiYw+GdVDO5KtYKu4ZZPwTe/a0
	Y2iEKcHUaJs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E950BB47A;
	Fri,  1 Feb 2013 17:15:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5559CB475; Fri,  1 Feb 2013
 17:15:15 -0500 (EST)
In-Reply-To: <20130201190007.GB22919@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Feb 2013 14:00:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAB67BEA-6CBC-11E2-9458-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215275>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 01, 2013 at 10:52:52AM -0800, Junio C Hamano wrote:
>
>> >   4. Replace the rename "gitfoo" above with a "see git-foo..." pointer.
>> >      Users of "git help foo" would not ever see this, but people who
>> >      have trained their fingers to type "man gitfoo" would, along with
>> >      anybody following an outdated HTML link.
>> >
>> >   5. Update internal references to "linkgit:gitfoo" to point to
>> >      "git-foo".
>> >
>> > Hmm. That really does not seem so bad. The biggest downside is the
>> > people who have to see the redirect made in step 4.
>> 
>> Yeah, I see that a show-stopper in the whole sequence.
>> 
>> This is one of the "if we had perfect knowledge we would have
>> designed it this way, and we could still migrate our current system
>> to that ideal, but it is dubious the difference between the current
>> system and the ideal will outweigh the cost of migration" moment,
>> isn't it?
>
> Yeah, perhaps. I did the patch series just to see what the effort would
> be like. But at this point I am fine if we drop it (it sounded like
> Jonathan was in favor of this direction, so maybe he wants to make a
> final argument).

OK.
