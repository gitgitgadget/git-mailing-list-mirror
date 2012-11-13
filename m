From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Tue, 13 Nov 2012 14:57:28 -0800
Message-ID: <7vobj1cdrb.fsf@alter.siamese.dyndns.org>
References: <20121113175205.GA26960@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 23:57:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYPQP-0006VZ-52
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 23:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab2KMW5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 17:57:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410Ab2KMW5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 17:57:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF2FA3D4;
	Tue, 13 Nov 2012 17:57:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ExmznVFfH6/ypIzr2O8QM6J41Is=; b=hLF7Av
	Z4FcAc+kgQ3Qnm885HqebiUbt7hFZdDkN5QMEEN3zfF+9rTTGOUfRyDttpZZPaG+
	6JXeWATDqLuYguZBuuvSKZcg42DgW2h6mXjlCBt3S5h2Rp3ilOIeNkJOw+ZZiXYU
	VlqvYhbNr1X+vHvrpjj+jgwtX6ZLURJfP5RkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZOaEv8plOhqRkACbLnuIJCrRC55GhBWK
	ibv832ICa20GUgrxz35b+mfGyCEPgVGFDjG5c94wzTQGSRpnFthev6hi2u8Dankj
	75OOY4GdGaPraAnLiE1187MsMJ5AgLKajCoyyikz7lwBFzhUGJsvVIdme9/YPK88
	sfS8WSdykdc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA554A3D3;
	Tue, 13 Nov 2012 17:57:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FA92A3D1; Tue, 13 Nov 2012
 17:57:30 -0500 (EST)
In-Reply-To: <20121113175205.GA26960@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Nov 2012 12:52:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80970316-2DE5-11E2-BD76-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209681>

Jeff King <peff@peff.net> writes:

> What's cooking in git.git (Nov 2012, #03; Tue, 13)
> --------------------------------------------------
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> This is my final "what's cooking" as interim maintainer. I didn't
> graduate anything to master, but I updated my plans for each topic to
> give Junio an idea of where I was.
>
> You can find the changes described here in the integration branches of
> my repository at:
>
>   git://github.com/peff/git.git
>
> Until Junio returns, kernel.org and the other "usual" places will not be
> updated.

And now the "usual places" have been updated with the same tips of
integration branches (the broken-out https://github.com/gitster/git
repository, too).
