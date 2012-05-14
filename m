From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Mon, 14 May 2012 11:31:11 -0700
Message-ID: <7vipfyhaxc.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <20120511103122.GA19573@burratino> <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
 <CA+55aFyNqncpHydQJYjLu5d2y+gGLVQVV8zk=2ckZ-LLgRRNWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 14 20:31:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU03C-00089P-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 20:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512Ab2ENSbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 14:31:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757199Ab2ENSbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 14:31:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22EDD8EA8;
	Mon, 14 May 2012 14:31:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=djNZJr2LGLlPb/tjqzTIZcPdpVc=; b=v/xUVp
	MyP4glRbht8UWCjlJg44VExiQTJyW7guZykP9aLyInYgpjoiMi58hBc/FreFwxue
	9qxIpdP+caryszURo1YGZapZnital8a47qbVcCn1T8U3lWpXQaJKOyvpv35cR7Ij
	9tYwqQvz0BIxcwp/H2yRxWFGMKGHzGbOMesps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7WB4AVXaIkzrKXkYFxebzq/A0heryop
	0l0YMG/SSfamaRlVDmAjDdTVJ9pnGHBACaFnies97M18NvB8RdOz0PtbrQS4C4YW
	59+C5BwkAqYViGxF6PrE/bgsr29oUWQ1sECnWJxP7eComWfWIoWDSM38P0NzliSB
	FtoSOulJWpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 195578EA7;
	Mon, 14 May 2012 14:31:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0DFD8EA4; Mon, 14 May 2012
 14:31:12 -0400 (EDT)
In-Reply-To: <CA+55aFyNqncpHydQJYjLu5d2y+gGLVQVV8zk=2ckZ-LLgRRNWA@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 11 May 2012 16:20:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB9ACCC4-9DF2-11E1-9D86-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197798>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Btw, the counting of commits is broken for the merge people. Do this
> in the kernel tree, just to see an example of the breakage:
> ...
> I dunno. But it looks odd, and the above is not the only example of
> "those counts don't make sense".

"By" numbers were meant to give credits to people who wrote the code, and
"via" numbers were meant to give credits to people who helped usher code
by others' to the person who is making the merge.

The former is something like "git shortlog --no-merges -n -s ..MERGE_HEAD"
and is quite straightforward to compute.  I didn't think things through
for the latter and punted with an ad-hoc algorithm that does not require
us to traverse reachability when I wrote that code, I guess, and I suspect
that is what is causing the "odd" numbers.

Here are some things that "via" should count as "integrator's
contribution":

 - making a commit authored by others (1 "credit" per such commit);

 - merging a branch that has commits authored by others (1 "credit" per
   commit authored by others brought in with such a merge).

And here are some things that "via" should not count:

 - merging your own topic branches into one branch for the person who is
   making the (final) merge to pull;

 - merging backwards, pulling bunch of unrelated commits from upstream.

For that, I think the code needs to annotate each "new" commit that is
brought into the history by the (final) merge with "how many others'
commits does it pull into the history" number, or something.  But I am
still in "thinking aloud" phase here, so...
