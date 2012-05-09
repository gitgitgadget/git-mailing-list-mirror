From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] allow recovery from command name typos
Date: Wed, 09 May 2012 10:03:55 -0700
Message-ID: <7vwr4lthfo.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1336287330-7215-2-git-send-email-rctay89@gmail.com>
 <1336287330-7215-3-git-send-email-rctay89@gmail.com>
 <1336287330-7215-4-git-send-email-rctay89@gmail.com>
 <1336287330-7215-5-git-send-email-rctay89@gmail.com>
 <20120506082130.GB27878@sigill.intra.peff.net>
 <CALUzUxqXrsB8XfQL6vOiQo1pLHNRjxRUxJLRiK_mcSU8fvTSCg@mail.gmail.com>
 <878vh4con4.fsf@thomas.inf.ethz.ch> <7v62c77uss.fsf@alter.siamese.dyndns.org>
 <CALUzUxpF0zn0V89BcayavbVs6muuXPv4+eYWgCWJn90hj6s6hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 19:04:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSAJ5-0000TL-JE
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758401Ab2EIREB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:04:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756962Ab2EIREA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:04:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F8EF7DF0;
	Wed,  9 May 2012 13:03:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s61Kd9YHjkA2GACjq0YlHAJp5nc=; b=ZPZmQ2
	xDURS4FPebbscSCGXDAaBMPtksHC+DYwfbslwnsNccZe4xA1wVu/Psbsgf2oY7Be
	h3APJSSo25al86/RliS+TiKFgNR8RXv1n8BgM+VDOYabI1Ts559YurSj49o1sNm9
	7xvAEU2TaFvKRwQUHf+2HrV9WZgJQgBPiYXuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y4Q5RtU2YFAlsb2L0I9wk5RyV6sHnHYP
	3eNhw3MPot44AxwULXGADd5kEFZeNjSKzAZ7/T0GPB4OKISXrpRn3JQ9ASNDRnNq
	tVGjdUdo77NEE8z14A/9f6IEwPr0wciCbS9AT+54X7gVzEX27NAPxe5VLuEI+6QL
	GOhbYl+chg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B7B47DEF;
	Wed,  9 May 2012 13:03:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A18667DEA; Wed,  9 May 2012
 13:03:58 -0400 (EDT)
In-Reply-To: <CALUzUxpF0zn0V89BcayavbVs6muuXPv4+eYWgCWJn90hj6s6hQ@mail.gmail.com> (Tay Ray
 Chuan's message of "Wed, 9 May 2012 23:06:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7D5824E-99F8-11E1-99D1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197477>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Actually, I've never heard of that feature, until I was reading help.c.
>
> However, it's listed on Progit [1], so I'd imagine there'd be *some*
> users in the wild.
>
> [1] http://git-scm.com/book/ch7-1.html
>
> Personally, I think it's a little dangerous - imagine your script has
> a typo'd command that just runs anyway if help.autocorrect without any
> chance for user intervention. Perhaps there should be a isatty(2)
> check to guard it, like the prompting patch does.

The whole "did you mean one of these" autocorrection should trigger only
in interactive to begin with, I would have thought.  Are you saying that
we don't have isatty(3) check in the early in the codepath already?

In any case, we drifted into a tangent without seeing the patch series to
completion.  Are you rerolling with Peff's fixups, Peff hinted he is
willing to do a re-post, and are you counting on it, or should I just pick
up the pieces?

Thanks.
