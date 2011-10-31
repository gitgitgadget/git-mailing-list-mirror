From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 13:53:57 -0700
Message-ID: <7v8vo0q3ve.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <20111031203059.GJ16825@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:54:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKyrt-00020M-VP
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 21:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab1JaUyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 16:54:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1JaUx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 16:53:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115E35D74;
	Mon, 31 Oct 2011 16:53:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XjB+8f37/1iIV5ZVfZuWCwu+WAo=; b=RJCkeO
	+IU2qcQuuInscbBbZ3RS+ChRCCIBJprfw0MX1HNiaPr3SCk6Q6XdrBlmMpX2DHoV
	E0qiJcGiijuRmR7jL0ELtHg1yxcDtY9uv50BL7+fLxP2EF/5BAXn6ofSJUrP/vd2
	2XNGCGG2kCCIVFAKL9Ut9e3bXkXtLVOhWEKo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JJ9zC4iBbi8mIaAT84wUj+B9dNl3uW0v
	FPN2YWZWkJxAOwljoUFsiFFMCwDAxN8I0olZlvKWp/vXcABhyCBfeTRtKG2822bX
	e4cRqKIyc9/6L3rUqRd114ujTrTTNoh/d2JZA+k7to6T/OTllkwsP3IQsyrirHOJ
	d2DjK8w+j+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08D3A5D73;
	Mon, 31 Oct 2011 16:53:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ED225D71; Mon, 31 Oct 2011
 16:53:58 -0400 (EDT)
In-Reply-To: <20111031203059.GJ16825@thunk.org> (Ted Ts'o's message of "Mon,
 31 Oct 2011 16:30:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74548C8A-0402-11E1-B627-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184524>

Ted Ts'o <tytso@mit.edu> writes:

> Suppose the project wasn't Linus, but some other project, say, a
> ...
> this, and are good (Kevin Mitnick or better) at social engineering
> attacks.
>
> In this sort of scenario, it's useful if *other* people could
> independently verify the Troll3 git tree via the crypto signatures,
> even though the central maintainer couldn't be bothered to check the
> crypto signatures.

I think we are in total agreement here ;-)

> Here's an idea.... what if the "signed push" information could be
> embedded into the merge commit's description? That is, the
> information could sent via a signed git tag, or some other mechanism,...

I think you described what the signed-commit series that is cooking in
'next' is about way better than I have done so far ;-)

The contributors sign the tips of their histories (which can independently
be validated), the integrator pulls and can choose to bother or not to
bother the tips s/he obtains, and the integrator signs his/her tip before
s/he pushes the integration result out for general consumption.

> ...
> The problem with notes and tags is that they have to be pushed
> separately, and might get lost; where as if they are stored in the
> merge commit's description, they will always be there.

Exactly.
