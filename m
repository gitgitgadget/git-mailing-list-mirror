From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Tue, 15 May 2012 13:24:03 -0700
Message-ID: <7v62bxdwgs.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <20120511103122.GA19573@burratino> <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
 <CA+55aFyNqncpHydQJYjLu5d2y+gGLVQVV8zk=2ckZ-LLgRRNWA@mail.gmail.com>
 <7vipfyhaxc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 15 22:24:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUOI2-0003VW-Fh
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 22:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966080Ab2EOUYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 16:24:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48244 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757825Ab2EOUYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 16:24:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5C6813C;
	Tue, 15 May 2012 16:24:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbHsYMQXO0hfpkaZ7TyFc9KrVxg=; b=tei6hf
	rBAlo049tNVuxLtmJNNS3ut+pTdKPzlSzCm3Hx7nggqfvNPcJQQd4emYWEh6nv+R
	y6k/NxHRaxBWQ8eSMYj9ANcMGc8o4TYy8Bp28212uT2sY21UV3jr3M/va+yD5L95
	TM51gm4U0XQ8WSY5DblvPh1OHc98guZfZNTxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JzqdBibQAv2zVbX2px0YAG+4HW4NiX96
	+eXD+M3aItY2e+ecAcXezAtet0GEZgyh0S7K+8yVprWJ1VnaNFSiGiD+IPULJpkt
	0vgbyLGJoIMCp9lEZIi+30Srf8iZzV+pYndOG2OCDrgdzjgCkjDwT+bshNW0BPBi
	XQgx3nrzlqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 010AB8138;
	Tue, 15 May 2012 16:24:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65A318137; Tue, 15 May 2012
 16:24:05 -0400 (EDT)
In-Reply-To: <7vipfyhaxc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 14 May 2012 11:31:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAE5505A-9ECB-11E1-BC13-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197854>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Btw, the counting of commits is broken for the merge people. Do this
>> in the kernel tree, just to see an example of the breakage:
>> ...
>> I dunno. But it looks odd, and the above is not the only example of
>> "those counts don't make sense".
>
> "By" numbers were meant to give credits to people who wrote the code, and
> "via" numbers were meant to give credits to people who helped usher code
> by others' to the person who is making the merge.

I took a look at this again today.

The implementation you saw was written before I did any of the thinking
below, and it merely counts the committer of merges plus the committer of
the tip commit you are pulling, or something.  It is slightly better than
random number generator, but not by a huge margin.

Here is an outline of my current thinking to give a good definition for
the "via" number, which is supposed to give credits to lieutenants (and
possibly sublieutenants).

Suppose the history behind the tip commit you are pulling looked like
this:

          E-----E-----E-----E-----E
                                   \
            A/D--A/D                E
                   \                 \
       A/B---A/B----B-----B-----B-----C-----C-----C
                         /
      A-----A-----A-----A

where a commit denoted by a single letter (e.g. A on the bottom line) is
authored and committed by that person (by definition a merge is authored
and committed by the same person), and a commit deonted as X/Y was
authored by X and committed by Y.  You are responding to a pull request to
integrate the tip commit authored and committed by C into your history.

The contributor B helped by applying patches from contributor A (the
leftmost two patches on the middle line), merging the work authored by A
and vetted by D (the first merge on the middle line), and the work
authored by A (the second merge on the middle line).  He even fixed things
up with the rightmost commit in his history before asking C to pull.  He
should get the credit for all this work to help getting A's changes to the
history, including the two commits made by D (which owe credit to D as
well).

For the same reason why the two commits in D's history owe credits both to
B and D, the whole thing owes "via" credit to C, as C was the lieutenant
who was ultimately responsible for delivering this result to you (in other
words, he could have decided not to pull from B).

What I am thinking is for each commit X (not necessarily merges), count
non-merge commits that are:

 - reachable from X;
 - are being merged by the final merge;
 - not authored by the same author as X itself; and
 - have not been counted to give credit to the author of X yet. 

For example, the first two commits by B on the middle line will give 2
credits (because B helped A's patch by applying them), the first merge by
B on the middle line will give 2 credits (because it contributes another 2
commits by A via D to the final history) to B, the second merge will give
another 4 credits (commits on the bottom line) but not for the commits
that were already counted for his first merge.  Total credit to B is 8 in
this example.

The merge made by C will *count* all 8 commits by A (even though they are
credited also to B), 1 commit by B (i.e. fix-up after merging 4 commit
series from A), and 6 commits by E.  D gets 2 credits for having applied
two patches from A.  A and E will get no "via" credits.

While I find the double-counting that appear in the example somewhat
disturbing, it inherently give larger credit to sub-lieutenant that is
closer to the tip, so it might after all match intuition.

Now, computing this efficiently may not be trivial, as you would need N^2
reachability analysis when pulling in N commits.  Among 2000 recent merges
I sampled from the kernel history, 70+ pull in more than 1000 commits (the
largest one d4bbf7e77 pulls in 21k commits).
