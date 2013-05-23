From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 23 May 2013 10:25:11 -0700
Message-ID: <7vppwhfw20.fsf@alter.siamese.dyndns.org>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	<7vk3mxze8v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
	<7vmwrr1pem.fsf@alter.siamese.dyndns.org>
	<CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
	<7vfvxixoks.fsf@alter.siamese.dyndns.org>
	<CALkWK0m1x_qrJfQ2Xw3w_kVuM-JHERFukbfxHyR08ODvxysKzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 19:25:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZGW-0006LV-JF
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 19:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758542Ab3EWRZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 13:25:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758381Ab3EWRZO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 13:25:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7A3420409;
	Thu, 23 May 2013 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lz5gSJJzjT/fhNRCzqIjYN8UslI=; b=yVRw2k
	L/bIt/h0HZxabB6S6xSD+U5NlFM2O7Ik+ZMAEvV4EOc/PhEt82VhBQ1bgPIvsxTx
	fqgfErmOgBIhFLQ+HuWcossH/SBKlhBfT0eCmZdsj05gBuCpIIVVyzEvsk5XyoDi
	jgNY7/Kz+kbesd3Ql0WlfIxrpnnF7a51BjMvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fNI70rIaABS5j7SdYRcperJNMadays7K
	eDTTt/pVOzx11LQZX4/cP5+xEQMdaW3G/XMee3ch8ycoMq9o5h5jZXwf7h8DMVjw
	MRwvYjOfjkEiyjYaC0TabtJ440cpXmg2KkrIInEIYCz0t0oRjoTA2yBD91DpZ8Uf
	55wVfzwLLJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DB6120408;
	Thu, 23 May 2013 17:25:13 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DD4520405;
	Thu, 23 May 2013 17:25:12 +0000 (UTC)
In-Reply-To: <CALkWK0m1x_qrJfQ2Xw3w_kVuM-JHERFukbfxHyR08ODvxysKzw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 23 May 2013 16:12:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9FE025C-C3CD-11E2-AB29-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225272>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> [remote "theodore"]
>     push = master
>     push = +pu
>
> This means that I will always push master without force and pu with
> force, irrespective of the branch I'm on.
>
> [remote "origin"]
>     push = refs/heads/*:refs/heads/rr/*
>
> This means that I will always push all branches without force with
> rewriting, irrespective of the branch I'm on.

Exactly.  And some people are unhappy about it, because they prefer
to work per-branch basis, as opposed to having to perfect everything
into a publishable state first and then finally push everything out
in one go.

I am not saying default=single would be _the_ single right way to
solve it, but "when you have default=single, remote.$name.push is
used only to describe the mapping, not forcing you to push
everything out at once" is one possible solution to that.
