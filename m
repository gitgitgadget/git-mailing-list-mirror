From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/5] Make README more pleasant to read
Date: Wed, 24 Feb 2016 22:22:44 -0800
Message-ID: <xmqqr3g1pavf.fsf@gitster.mtv.corp.google.com>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<20160224102247.GA21152@sigill.intra.peff.net>
	<vpqziuq6xha.fsf@anie.imag.fr>
	<20160225061456.GA3921@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	emma.westby@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 07:22:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYpK8-0002BG-Df
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 07:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbcBYGWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 01:22:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753847AbcBYGWr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 01:22:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9357648F66;
	Thu, 25 Feb 2016 01:22:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wjQdvfrw0RFH2g3A1DD6xTg9Er0=; b=gdiZre
	mszMebrFZ2KTK78k+HgrwFUmuvKoL+Tw2Kk/9dq8pJIvUIOKHHmUhyNcXthHJPno
	PfOK62ke2yffjyq3d3lCcXWowwuqs/Z435xcmLH9bWpCDAGj4zusvHFtxsD0HdXo
	Lm+DngRhv6QNXKTbNJentkKK6hARe5cIMBwtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nD+6UwE/bMv9ceVvbQIjY4gaVOSNl+jy
	uwOx3AabSlRoLNOFO1gATMm2JzX/OEuasQ/XlVUSNkxjqY8pX3Xipw6lgQa0U6E1
	1RoO6hYuwZAE83Vd9Ievi2LAAZkuHsEIUwGgkrAGvexTMptfxlEvuL5Em2HTxxpA
	Ax2i3hiwl5M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B4A748F65;
	Thu, 25 Feb 2016 01:22:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0ABF548F64;
	Thu, 25 Feb 2016 01:22:45 -0500 (EST)
In-Reply-To: <20160225061456.GA3921@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 25 Feb 2016 01:14:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F51618C-DB88-11E5-AD50-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287332>

Jeff King <peff@peff.net> writes:

>> > I do not overly care, but I wonder if it would be nice to keep README as
>> > a symlink.
>> 
>> I can add it if people want to see it, but we already have so many files
>> at the root, I'd rather avoid adding duplicates through symlinks.
>
> That's reasonable. I thought it might appease the "I use `less README`
> to view the README" crowd, but it is probably not that hard to find the
> `.md` variant.

Well, "less README" folks would not be happy with a mere symbolic
link anyway--things like [INSTALL][] are pure eyesore and regression
relative to the straight text version.

I do not overly care, either.  I do not think people would complain
too much about the eyesore as long as the file is named README.md,
so in that sense, we'd be better off not having such a symbolic
link.
