From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Mon, 12 Mar 2012 09:29:51 -0700
Message-ID: <7vk42pu6io.fsf@alter.siamese.dyndns.org>
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
 <7vwr6u6qrn.fsf@alter.siamese.dyndns.org> <vpqmx7mcgdz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:29:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S788F-0007pb-96
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab2CLQ3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:29:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab2CLQ3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:29:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66BF16B91;
	Mon, 12 Mar 2012 12:29:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xH5qHyZIurWu26hx+VJNnOY+8BY=; b=teizVH
	spFK2vGhliadi7JYbY15+O78wk0BSV6wgVicYqzieIGVOkvFrHZUIxd4D391Qpwf
	B4wxyJiMPI266GbfwKx2yYgP12eiOkMTP79XW3R904qtRKHugyT5QjmejT0uteaq
	wGGAOV5CEqloQ1y4ItqRZyaSdfpg5KGrEQz8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3sSKnWI13p1H2JnliyqIVPTYDZYBaf1
	NGT/b63/gJykwQJdVsBwuQb9sLXtiPpyd1i2vYCe18r78Tfo3Ke4eqoVPebBzLD3
	yHF61KfsbSOqio6e3UPtPZl1ikKvOA/UvLcylBgxaA1RPvaEqC6axNAp/Ov5h3d8
	zuBqs7867UU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D2866B90;
	Mon, 12 Mar 2012 12:29:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FAC46B8E; Mon, 12 Mar 2012
 12:29:52 -0400 (EDT)
In-Reply-To: <vpqmx7mcgdz.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 12 Mar 2012 10:34:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98563DB0-6C60-11E1-83CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192897>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Here's an attempt to an improved message. The first paragraph is here to
> make sure people understand their opinion counts (before they stop
> reading because it's too long). The rest explains the change and the way
> to get involved:

Sounds OK from a cursory read, except for a few minor details.

Thanks.  Nitpicks follow.

> ---------- 8< ---------- 8< -----------
>
> There is a proposal to change the default behaviour of 'git push'
> on the Git mailing list. The goal of this message is to encourage you
> to discuss it before it happens (or the change is aborted, depending
> on the outcome of the discussion).
>
> In the current setting (i.e. push.default=matching), 'git push' without
> argument will push all branches that exist locally and remotely with
> the same name. This is usually appropriate when a developer pushes to
> his own public repository, but confusing if not dangerous when using a
> shared repository. The proposal is to change the default to

"usually appropriate" tries to avoid claiming that this statement is
the final judgement.  "confusing" may need to be stated the same
way, i.e. "but may be confusing".  Alternatively, we can drop "usually".

> 'upstream', i.e. push only the current branch, and push it to the
> upstream branch (the one 'git pull' would pull from). 'current' is
> another candidate.

When I find myself needing to clarify a jargon with parenthesized
rephrase, I drop the jargon and parentheses and see if it makes it
easier to read.  And in this case I think it does.

    i.e. push only the current branch to the branch 'git pull' would
    pull from.

What 'upstream' does is explained but not 'current'; here is my
attempt.

    Another candidate is 'current'; this pushes only the current
    branch to the branch of the same name.

> For more details on the behavior of Git with these values, read
> the documentation about 'push.default' in 'man git-config'
> (http://schacon.github.com/git/git-config.html).
>
> You may be negatively affected when such a change happens if you
> do not see anything in the output from 'git config push.default'
> and if you rely on the fact that 'git push' pushes all your
> matching branches. On the other hand, you may want to see the

Let's stress that they are relying on the _default_ a bit stronger.

    "and if you rely on the default that pushes all your"

> default behaviour to change, especially if you are using shared
> repositories. In either case, please join the discussion to give
> us more data point and help us decide the future of Git.

> To join the discussion, send your messages to: git@vger.kernel.org
> You don't need to subscribe the list to post, and it's customary to
> Cc: posters when replying on this list.
> To view the current discussion, see this thread:
> http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694

As this is not an invitation to start a new discussion, "speak
without reading what have already been said" is not something we
would want to encourage, so I'd prefer to see the order swapped, like

	What has been discussed so far can be seen in these threads:

        	... gmane references ...

        To join the discussion, send your messages to: git@vger.kernel.org
        The list accepts messages from non-subscribers, and you do
        not have to ask "please Cc me, I am not subscribed", as it's
        customary to Cc: posters when replying on this list.
