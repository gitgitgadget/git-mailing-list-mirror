From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 01:57:16 -0800
Message-ID: <7vwr6u6qrn.fsf@alter.siamese.dyndns.org>
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
 <7vsjhi9wku.fsf@alter.siamese.dyndns.org> <vpqobs65gfc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5wZp-0002ib-6D
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab2CIJ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 04:57:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab2CIJ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 04:57:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E8F5326;
	Fri,  9 Mar 2012 04:57:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QOOOBqXgbwUc0A3KjZT0V30JWVQ=; b=vHUlk4wcAhR6uVyhGRbB
	tkd+7DTFzjzYhgEECfvnKN9Tr6pa00k0qGn7U87XtDHf9sllgL5fMYQzZ3sVV7SB
	MPGK97GNSw4OYxHyce7gWcvrwnvpV90GsGuEG1cMZXAXD9G9vw0z2iNeH/ovjUvq
	QmSs2JPLK9GNO/j7EKocipk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HAkCB88nSqAxtUqW0toTwL2RuWfxyg7qVXRsLwsyLOPytX
	ZIGiDgnCs7WjpPZIPjEIRn3b60zgDQbcBMkvJD30XN/4Iw2VZiUGNb1k2r4AYmu0
	QFwKahPR9l54gB9pxsxtBrxlLD5ivbk8Ejo7SRDMJK1NkdFqmTCGwOBnaXUHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED1BA5325;
	Fri,  9 Mar 2012 04:57:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50C985324; Fri,  9 Mar 2012
 04:57:26 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 466F4A1C-69CE-11E1-ABA1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192706>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I just dug it up; start from here:
>>
>>     http://thread.gmane.org/gmane.comp.version-control.git/123350/focus=123541
>
> That's an old discussion. A more recent one is here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/166743
>
> (interleaved with a discussion about tag namespace, but the end of the
> message is about push.default)

I'd say that it only shows that everybody for some strange reason
forgot to learn from history, including me, in that more recent
thread. Luckily, Jeff noticed eerily familiarity this time around.

> (i.e. "Care to roll an appliable patch?", which I guess everyone has
> been too lazy to do)

I doubt that it would have solved any issue we suffered in the 1.6.3
to 1.6.4 timeframe if somebody gave a concluding patch after that
message in the more recent discussion.  Specifically, it would not
have solved anything that these raised:

  http://thread.gmane.org/gmane.comp.version-control.git/118866/focus=119142
  http://thread.gmane.org/gmane.comp.version-control.git/118866/focus=119148

Resurrecting the old patch that was reverted is the easiest part.

It is much more important to spread the word to the people who will
be hurt by the default change well before it actually happens, and
to get them engaged in the discussion, along with those who would
benefit from such a change. That needs to happen before any patch
that reverts a revert.

Even in the kernel community, I suspect that most people do not
follow this mailing list anymore and simply trust that we won't make
changes that affect them negatively. People will complain only after
a change hits them, and tell us "We didn't know that you will be
making this stupid change." And having this thread here does not
count as "spreading the word".

I can send a message saying "There is a proposal to change the
default behaviour of 'git push' on the Git mailing list, and you may
be negatively affected if you do not see anything in the output from
'git config push.default' when such a change happens. On the other
hand, you may want to see the default behaviour to change. In either
case, please join the discussion to give us more data point and help
us decide the future of Git." to the kernel list. Anybody could, for
that matter.

One thing I refuse to do is to fight this battle alone for "let's
change the default" folks, especially when I am not convinced that
it is a good change to begin with. It is "let's change the default"
folks' responsibility to help the legwork.
