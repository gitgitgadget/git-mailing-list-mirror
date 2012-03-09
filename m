From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 21:38:04 -0800
Message-ID: <7vobs69vwj.fsf@alter.siamese.dyndns.org>
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
 <7vsjhi9wku.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 06:38:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5sWz-0003Xd-Nb
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 06:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158Ab2CIFiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 00:38:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab2CIFiH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 00:38:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DB0778BB;
	Fri,  9 Mar 2012 00:38:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fMgJ8+eBaftuiFDGt30SBciePH0=; b=lzLZOi
	En0ax0aPY5oW0fwHalqEeuBBn8Lcq7cik1+eoBICHVLcyHfe2ddd4iXGJDQbh9dT
	U9HKs9MadMpmUQDvV1j0iaMqgrpzfMkqsNWpO1v6W/MFhno31Cf1Q7MvA01vFp/V
	uWjf3qsEATcN8v88pZcT1pBAgTYXFdMEPys/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uXOsFjVGx2pnL+WtErikUsl0fKaqE6kJ
	7/edqOzRaLMelAHhdSDDkulYKJK9B3RJ48SpynyDmfIhxtEKvuqeEXvFUBytLtB5
	fLwcgTRB3Sgj66aPARGBbynpMw9hnFsQtntSwTDhGGMIqqyUb3A1zz7351BONaNT
	5VDYZosgfJY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13DB278BA;
	Fri,  9 Mar 2012 00:38:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A01478B9; Fri,  9 Mar 2012
 00:38:06 -0500 (EST)
In-Reply-To: <7vsjhi9wku.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 08 Mar 2012 21:23:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BF9926C-69AA-11E1-B06E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192678>

Junio C Hamano <gitster@pobox.com> writes:

> I just dug it up; start from here:
>
>     http://thread.gmane.org/gmane.comp.version-control.git/123350/focus=123541
>
> read on a few messages downthread, and then jump to the other thread
> Nana points at in the above message.
>
> In short, we started warning that we _might_ change the default
> someday, without having a clear concensus or plan, that ended up
> confusing and annoying users without giving them anything good,
> other than awareness that such a feature is _available_.
>
> So no, the conversation did not decide if changing the default was
> warranted or not. It just confirmed that we weren't anywhere close
> to deciding back then.

I think MJG's message (the second on in the "git push origin error"
thread) is probably what we would need to repeat, and this time more
strongly to squelch the opposition from old timers, if somebody
wants to resurrect the "warn until you set the default explicitly,
intending to change the default in the future" patch. And this time
around, the plan to change the default should be more concrete with
specific date, e.g. "Starting from April 1st, 2013".

I was in the "keep the default to matching, so that nobody among
existing 47 million users would be annoyed" camp (back then we
probably didn't have 47 million users, but that is besides the
point) and I still am, but notice that I was defending the argument
by the "let's be ( (new user) friendly )" camp in that thread. And
without much fire-support from those who were vocal about it.

Re-reading the thread made me sick.

I wish I had enough energy remaining to say "Let's try one more
time, and hope that people from the 'let's change the default' camp
will behave much better than the last time", but I do not have high
hopes, after having been burned once already with exactly the same
issue.
