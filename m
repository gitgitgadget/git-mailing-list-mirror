From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] GPIO bulk changes for kernel v4.6
Date: Fri, 18 Mar 2016 08:43:30 -0700
Message-ID: <xmqqzitvrdul.fsf@gitster.mtv.corp.google.com>
References: <CACRpkdbGkfJ9bW1db64msMeQjue+=y+op5EmSx62FWOWDOJwWg@mail.gmail.com>
	<CA+55aFwV4Cq=4zJc6Fw0yAGrTmci_DFAjJKxkk05pjJJf3iYbA@mail.gmail.com>
	<56EB9B0C.4050507@nvidia.com>
	<CA+55aFy=-UAbVo+Xx08tBA7eTPk2B+G3=SbarVxThS57LdakPA@mail.gmail.com>
	<alpine.DEB.2.20.1603181532040.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio\@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: linux-gpio-owner@vger.kernel.org Fri Mar 18 16:43:37 2016
Return-path: <linux-gpio-owner@vger.kernel.org>
Envelope-to: glg-linux-gpio@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-gpio-owner@vger.kernel.org>)
	id 1agwYq-0000jt-TL
	for glg-linux-gpio@plane.gmane.org; Fri, 18 Mar 2016 16:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443AbcCRPnf (ORCPT <rfc822;glg-linux-gpio@m.gmane.org>);
	Fri, 18 Mar 2016 11:43:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752558AbcCRPne (ORCPT
	<rfc822;linux-gpio@vger.kernel.org>); Fri, 18 Mar 2016 11:43:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 881914C886;
	Fri, 18 Mar 2016 11:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=udCq2Ru5iXnUYGZT/xGhuk7L6FQ=; b=FYDwSm
	CVv56WPUuvEuIm54rGwuGkSXqcfyyfBST04xPmVsqe4LQWZWcjmgKT7zPsLM4Cza
	hB09bgIBKjlMHqlASduwTif6pRqwQxJ4nWB9RQp8MZCpTMYMmQOxxz6ZFFu+wnBx
	jQ7C5wjMHm2IjvKoIsz98K7WwM4iNdQ15cXsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mau8PgTKUzapVBAecMK9/VXiM/Q/G/1x
	CLpSC1YZ6HfBpMyX5y/ltWwszB6GmJhx1GNLvoiHOaHxwb83DUG25rHvvBwMzBxe
	Ap3R7tt8tPh6txFSjG0c9egU2GSRa7iyONma+el6WzHOSfwvghvznjOr0hRe5OZV
	WGTQ61ExrPc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F0C84C885;
	Fri, 18 Mar 2016 11:43:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F03584C884;
	Fri, 18 Mar 2016 11:43:31 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603181532040.4690@virtualbox> (Johannes
	Schindelin's message of "Fri, 18 Mar 2016 15:32:54 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AFE1EB4-ED20-11E5-981F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-gpio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-gpio.vger.kernel.org>
X-Mailing-List: linux-gpio@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289225>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Linus,
>
> On Fri, 18 Mar 2016, Linus Torvalds wrote:
>
>> I thought git didn't merge two branches that have no common base by
>> default, but it seems it will happily do so.
>
> What happened to "The coolest merge EVER!"?
>
> 	http://thread.gmane.org/gmane.comp.version-control.git/5126/
>
> Ciao,
> Dscho

An obvious response to the above, "What about it?", is something you
would have already anticipated when you wrote the above, and I wish
I saw that in the message I am responding to, but I didn't, so here
is my attempt ;-)

The old article shows two interesting things.  One is that there are
cases where it makes perfect sense to bind two unrelated histories
when the two roots are totally unrelated.

I am not Linus, but I think the proposal is to make it harder to do
this unusual merge by mistake, while keeping it possible to do so
when the user really wants to.  And the "deliberately whitespace
damaged patch" in the message you are responding to was primarily to
point out where the "making it harder" logic should go by showing
how to make it impossible, leaving it to readers to adjust it to
"harder but still possible".

Now, the second thing that the old article you pointed shows is that
it is possible to create such a merge without using "git merge" even
though it is more involved and takes conscious effort by the user.
In that sense, you could argue that, with the "make it impossible"
change in Linus's message to "git merge", there is no more change
needed (I do not know if that is what you meant to imply, though).

I think it makes sense to teach "git merge" to error out like Linus
did unless the user explicitly says "I know what I am doing" with an
explicit option (e.g. --force or --merge-unrelated-histories).
