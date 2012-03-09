From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 21:23:29 -0800
Message-ID: <7vsjhi9wku.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
 <CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
 <vpqfwdjas0m.fsf@bauges.imag.fr>
 <20120309033826.GA6164@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 06:24:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5sJ5-0007c6-6h
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 06:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab2CIFXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 00:23:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36228 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab2CIFXd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 00:23:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C0757618;
	Fri,  9 Mar 2012 00:23:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cu7ISBX0v+4j19HZX1hZB03jWxI=; b=fNVtFa
	BTYVpSBhrjdExA3zbkQ6TyioCea2L06wP7v70Q8Rf05QIUA7gqXHs/mmkxMiupPO
	dY7RSda3FXVJ6MigRm35wYYziqdzXU0jhjsaaesnUYXXcjxYoXPkBkS3kQiSV8x6
	PiEIxe6/FQlErxPO5T6L/hluJqfBEqvDuS4Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VWA2+NUtgdviW0FWHpkkSyUfPL+35vbF
	1UiJDiTo1bHA4ZZuyggGTwY4MBjTNTFZ5JxJtKnFcctahMlnpLJRnR56Rnwou+q0
	YESX1dljBJNmToAcj9arOGHsQnBEzrPEKJkRo+7WcVlvjbQMFegCP1kDqaXCYQRi
	FZuaM52AIFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11B3C7617;
	Fri,  9 Mar 2012 00:23:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19D547616; Fri,  9 Mar 2012
 00:23:30 -0500 (EST)
In-Reply-To: <20120309033826.GA6164@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 8 Mar 2012 22:38:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0242DA96-69A8-11E1-BBE3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192677>

Jeff King <peff@peff.net> writes:

> This is all sounding eerily familiar. Indeed:
>
>   $ git log --oneline -Swarn_unconfigured_push -- builtin-push.c
>   bba0fd2 push: do not give big warning when no preference is configured
>   665d3e8 Display warning for default git push with no push.default config
>
> I don't remember the mailing list conversations that surrounded those
> patches, but if we are going to have the same conversation again, maybe
> it is worth looking them up.

I just dug it up; start from here:

    http://thread.gmane.org/gmane.comp.version-control.git/123350/focus=123541

read on a few messages downthread, and then jump to the other thread
Nana points at in the above message.

In short, we started warning that we _might_ change the default
someday, without having a clear concensus or plan, that ended up
confusing and annoying users without giving them anything good,
other than awareness that such a feature is _available_.

So no, the conversation did not decide if changing the default was
warranted or not. It just confirmed that we weren't anywhere close
to deciding back then.
