From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Wed, 16 May 2012 10:28:52 -0700
Message-ID: <7vpqa4c9wr.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <20120511103122.GA19573@burratino> <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
 <CA+55aFyNqncpHydQJYjLu5d2y+gGLVQVV8zk=2ckZ-LLgRRNWA@mail.gmail.com>
 <7vipfyhaxc.fsf@alter.siamese.dyndns.org>
 <7v62bxdwgs.fsf@alter.siamese.dyndns.org>
 <CA+55aFyX66RpUA2Xh8drGErHB7Wuni20cUAMGawLsqG6MTTohA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 16 19:29:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUi2f-0004ny-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 19:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758913Ab2EPR3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 13:29:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875Ab2EPR3M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 13:29:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91E1988CF;
	Wed, 16 May 2012 13:29:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+UGGRsMdMUfsUHpMsHCKg+5Bclo=; b=SE0GtJ
	xTp03N2RV0m6zZPgXYP1/2EQZ6YJjG5BKL5hlhOLOyC9VQul/yDyMH5mxNoM2Kxc
	LN8PHmVpiqSNP1BMs7/Evrr+ETIIdafoOR3gE+i1ppG7LlJVAqx/kpcnir8k/3g+
	RDXFoshgsXBrRmapJG6x5yh3ttXZt94OBMgwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VxC4+KLJHqAwNpblhC3N98k9/A6RFXVe
	D8i7gc1Z2VPZY/H3BflzoNdicBD0fe8AJT8tdqQsgG/LIC8yDOLlDCCBIPnEU1Za
	MYsqmJP0y4wKXV9JFHtaElHeTIW3k8FX9Oayr+oIPG+6B209Na5ldvGfnPtWvl3L
	4+YgR4ms8Ug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8725988CE;
	Wed, 16 May 2012 13:29:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F206A88CB; Wed, 16 May 2012
 13:29:10 -0400 (EDT)
In-Reply-To: <CA+55aFyX66RpUA2Xh8drGErHB7Wuni20cUAMGawLsqG6MTTohA@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 15 May 2012 19:02:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A624D740-9F7C-11E1-83CE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197886>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 15, 2012 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Now, computing this efficiently may not be trivial, as you would need N^2
>> reachability analysis when pulling in N commits. Among 2000 recent merges
>> I sampled from the kernel history, 70+ pull in more than 1000 commits (the
>> largest one d4bbf7e77 pulls in 21k commits).
>
> So I have to say, for my purposes, it not only might be inefficient,
> but it can still be very misleading.
> ...
> (Admittedly, so it the shortlog we put in the merge, so that "you can
> find it later in the git tree itself" not *that* great of an argument
> - the real argument for me is that it doesn't matter what you count,
> you'll not necessarily get the actual piece of information I care
> about..).

There is no way to mine "X pulled from Y" out of the topology if you allow
fast-forward anywhere, so "I care about whom I pulled from" is something
people need to give out of band.  Your lieutenant may have fast-forwarded
his history from his lieutenant's, or you may even be fast-forwarding your
history from your lieutenant's, in which case you do not even have a merge
commit to record that fact anyway.  If you do not fast-forward, at least
the merge subject would give you where you got the history from, so it is
not like that the information *must* be obtained by looking at the history
anyway (incidentally, that was the reason why the "better than random
number generator but not by a large margin" version gives an extra weight
to the tip commit you are pulling; unless your lieutenant fast-forwarded,
that is the person you pulled from).

> So I'm not entirely convinced yet. I don't *dislike* the concept, but
> I could definitely do without it (or maybe have it in the commented
> part of the commit message, so that you'd have to explicitly edit it
> to show up).

I am tempted to suggest removing the "via" part as a failed experiment for
now.
