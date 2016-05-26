From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Formatting variables in the documentation
Date: Thu, 26 May 2016 09:37:19 -0700
Message-ID: <xmqqbn3sydvk.fsf@gitster.mtv.corp.google.com>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160518181500.GD5796@sigill.intra.peff.net>
	<b06231ac-b100-2565-3bf7-99f268014788@ensimag.grenoble-inp.fr>
	<vpq8tz0hd2g.fsf@anie.imag.fr>
	<20160526043607.GB6756@sigill.intra.peff.net>
	<xmqqmvncyera.fsf@gitster.mtv.corp.google.com>
	<20160526162348.GA18210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@ensimag.grenoble-inp.fr,
	jordan.de-gea@ensimag.grenoble-inp.fr, stefan@sevenbyte.org,
	jrnieder@gmail.com, rybak.a.v@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 18:37:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yHn-0000bh-En
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbcEZQhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:37:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750985AbcEZQhX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:37:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E70D1DB30;
	Thu, 26 May 2016 12:37:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X6JBAwGXvekagkHqg75gv0zPNbY=; b=jp+BV6
	JbiC6UENoRGU34MhHuhjcbzzjV7NtZjJxhRo/6YeCgV9jFEF/NMCMawMAwwHw2i2
	1++pRC++tLkCA+o2k5GMFn+ACniZQu4Sm8c8mgvNUmXW84tX7JE/nE1rnWZyRmgd
	poZAp2p+V8lMZYsjIcQowF5wXYLjkjEjwH+RU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v/ER6KBuPVEUJmhU5grfgejnJQ+hqVCe
	HjiGqA8R/K7AZX/5WW98dr02pQOAH2qQHnvlwM3TtyUSZP6Mkuxwckgm6byPiwjM
	wFT4s0FBJhCoApNN0GqYA4znIB0Tqjy1rmLNTf1nz01plXZl8YLqDK93XejHZ8mD
	8MbmE7t681s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 059071DB2F;
	Thu, 26 May 2016 12:37:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 807831DB2E;
	Thu, 26 May 2016 12:37:21 -0400 (EDT)
In-Reply-To: <20160526162348.GA18210@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 12:23:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E7263DC-2360-11E6-9D87-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295665>

Jeff King <peff@peff.net> writes:

> On Thu, May 26, 2016 at 09:18:17AM -0700, Junio C Hamano wrote:
>
>> >   1. Somebody produces a patch flipping the default. The patch is
>> >      trivial, but the commit message should tell why, and try to dig up
>> >      any possible problems we might see (e.g., why wasn't this the
>> >      default? Particular versions of tools? Some platforms?)
>> [...]
>> There was no particular "caveat" raised there to recommend against
>> using this on particular versions of tools or platforms.  It was
>> inertia that has kept the new optional feature "optional".
>
> Thanks for digging. That matches my recollection and the limited
> research I did more recently.

For completeness's sake I should point out that the discussion on
the first thread did point out some version-dependent issues.  But
with 79c461d5 (docs: default to more modern toolset, 2010-11-19), we
declared the problematic versions obsolete; I suspect that it is
safe to assume that those who would be hurt by flipping the default
would already be extinct after 6 years since then.

>> >   2. Assuming no problems, Junio merges the patch to "next". We get
>> >      any reports of issues from people using "next" day-to-day.
>> 
>> So I can do these steps myself up to this point.  After waiting for
>> a few days to see if somebody else with better memory tells me what
>> I forgot, perhaps.
>
> OK. I was trying to see if (1) could be low-hanging fruit for any of the
> newcomers, but at this point it probably makes sense for you to just
> write the patch.

Leaving it as low-hanging fruit is actually a good idea.

I was thinking about flipping it in Meta/dodoc.sh, which would
update the git-manpages.git repository whose mirrors are found at

    git://git.kernel.org/pub/scm/git/git-manpages.git/
    git://repo.or.cz/git-manpages.git/
    git://github.com/gitster/git-manpages.git/
