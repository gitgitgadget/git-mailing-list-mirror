From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 02 Nov 2011 16:34:53 -0700
Message-ID: <7vsjm6gkte.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 00:35:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLkKp-00008Y-8O
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 00:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab1KBXe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 19:34:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab1KBXe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 19:34:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70F4A6AD6;
	Wed,  2 Nov 2011 19:34:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LdTsvmqrZCgShtwgfpNZZFF5f9Y=; b=w+24Xg
	twQXEN4mYXRJ/ujQHrLwkoGbqDBXc3/ACzQsJyvQBsmQ2TSo4b0p8MS74ovy8E/r
	RmwaUSl5pyRxnTNkbadqZjj2ORylsZ9o5a1Tizbc3PGunMjko7UQEFt8JJ/89UUE
	GuL4tk+jyD5gAYZlXm9sotlwTan8IDcK03jh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oGqjcXVwsF4QwmBa5kWddaSAyHQlcRuY
	tQdLc1NqjWxPNaEA4dO5fVeifN7eAdhP+LYMwQ9hQr2b1vh6YRlIzL/UXPAJEGKV
	rrpAd5islaDyUpWJTQ8BVYzzVafmK1liJxQQfb/KtFlPVkbY9S96Z0/IYvkjAbey
	GMrArr5aal0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67D6D6AD5;
	Wed,  2 Nov 2011 19:34:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA7606AD4; Wed,  2 Nov 2011
 19:34:54 -0400 (EDT)
In-Reply-To: <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 1 Nov 2011 14:21:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44C89D80-05AB-11E1-B0AB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184682>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I hate how anonymous our branches are. Sure, we can use good names for
> them, but it was a mistake to think we should describe the repository
> (for gitweb), rather than the branch.
>
> Ok, "hate" is a strong word. I don't "hate" it. I don't even think
> it's a major design issue. But I do think that it would have been
> nicer if we had had some branch description model.
> ...
> Maybe just verifying the email message (with the suggested kind of
> change to "git request-pull") is actually the right approach. And what
> I should do is to just wrap my "git pull" in some script that I can
> just cut-and-paste the gpg-signed thing into, and which just does the
> "gpg --verify" on it, and then does the "git pull" after that.
>
> Because in many ways, "git request-pull" is when you do want to sign
> stuff. A developer might well want to push out his stuff for some
> random internal testing (linux-next, for example), and then only later
> decide "Ok, it was all good, now I want to make it 'official' and ask
> Linus to pull it", and sign it at *that* time, rather than when
> actually pushing it out.

You keep saying cut-and-paste, but do you mind feeding the e-mail text
itself to a tool, instead of cut-and-paste?

The reason I am wondering about this is because in another topic (also in
'next') cooking there is an extended support for topic description for the
branch that states what the purpose of the topic is why the requestor
wants you to have it (this information can be set and updated with "git
branch --edit-description").

A respond-to-request-pull wrapper you would use could be:

 - Get the e-mail from the standard input;
 - Pick up the signed bits and validate the signature;
 - Perform the requested fetch; and
 - Record the merge (or prepare .git/MERGE_MSG) with both the signed bits.

and the "signed bits" could include:

   - the repository and the branch you were expected to pull;
   - the topic description.

among other things the requestor can edit when request-pull message is
prepared.

That would get us back to your "the lieutenant tip is not so special, but
the merge commit the integrator makes using that tip has the signature for
this particular pull" model.
