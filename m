From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 08:22:12 -0800
Message-ID: <7vobs57nij.fsf@alter.siamese.dyndns.org>
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
 <7vwr6u6qrn.fsf@alter.siamese.dyndns.org> <vpq4ntyrn3c.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 17:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S62aD-0004lW-HR
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 17:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889Ab2CIQWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 11:22:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757137Ab2CIQWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 11:22:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B89D5644;
	Fri,  9 Mar 2012 11:22:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o8mPre1EpKQiQuElsZGFd5oS6Z4=; b=SG1nWW
	TgZ9iNy8UcWxQAkLSD8JChBFn5FHyyz4mM9fzRCnD+XYCx73Rqo5haJ1ZB8dWowI
	DIDt1BckEeFc2wHEyLrVSfxajfy+SQ4KHMU/L7dZ2gaecj2YWguSfPo+zvu7UhfE
	f5wh/5nVeFs/I378mHpZS76Kb2SJ0uzk9QTMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dj9e5d72nM8Zzm+OvLKVszh3UePyKaQx
	+0DzDzvb/DhbzqRMKCfKvul8JzfSKVP4XqXF0zJ8I9MHyq79Sp54hqbcENpftRmR
	CEK+W5wf4b5nAgYhUCSMaKTkeMqkHgmskkdVk4MbZmxIuHBbbsX7H62u2tclkFJR
	IdL+AwOr4xA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7F05642;
	Fri,  9 Mar 2012 11:22:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7BEA563E; Fri,  9 Mar 2012
 11:22:14 -0500 (EST)
In-Reply-To: <vpq4ntyrn3c.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 09 Mar 2012 13:11:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0830BCAA-6A04-11E1-B505-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192724>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I can send a message saying "[...]" to the kernel list. Anybody could,
>> for that matter.
>
> That would have been something sensible to do a few years ago, but
> today, I think we are far, far beyond the point where Git was a tool
> meant primarily for kernel hackers. I don't think considering the kernel
> community as more important than other users will help making Git easy
> to use for bare mortals.

That is *EXACTLY* the issue.

The kernel is one example community that *I* can cover, and if we
were going to continue discussion, I'm willing to help doing so
because your change will *NEVER* work unless we spread the word to
*all* the relevant communities whose members may be negatively
affected.  That is what I am saying in the part you quoted.

But I obviously *WILL* *NOT* be able to do so for *all* communities
whose members may be negatively affected.

Let me repeat the part you omitted from your quote:

  One thing I refuse to do is to fight this battle alone for "let's
  change the default" folks, especially when I am not convinced that
  it is a good change to begin with. It is "let's change the
  default" folks' responsibility to help the legwork.

Now, you have realized that the kernel community is only one of the
places where "let's change the default" folks need to spread the
word and solicit their involvement, are you willing to do your part?

People will complain only after a change hits them, and tell us "We
didn't know that you will be making this stupid change." And having
this thread here does not count as "spreading the word".
