From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 10 Nov 2011 21:26:35 -0800
Message-ID: <7vd3czrzzo.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org>
 <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
 <7v4nydurzh.fsf@alter.siamese.dyndns.org>
 <CALKQrgfZtELcK3H5ZYvmcW8RrtKMVRACFTvw3s5SidFvmFWkGw@mail.gmail.com>
 <7vaa84t3ek.fsf@alter.siamese.dyndns.org>
 <CALKQrgdxEXQGKQ3t9Sh82=U933ypHNg8duyVmG9uJbg2iST5fw@mail.gmail.com>
 <7v39dvuca4.fsf@alter.siamese.dyndns.org>
 <CALKQrgcJmPHZG0bbgwoH6_htQODYVJtXYyHgSb_7qRKkJkb2Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: linux-kernel-owner@vger.kernel.org Fri Nov 11 06:26:54 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ROjdd-0002Fr-3x
	for glk-linux-kernel-3@lo.gmane.org; Fri, 11 Nov 2011 06:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab1KKF0k (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 11 Nov 2011 00:26:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab1KKF0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2011 00:26:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9908933B3;
	Fri, 11 Nov 2011 00:26:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F+wBBwemDrHcD2sEigyk7hb5/Ig=; b=pEcoUk
	ynukxBVYlZWUsQ9e0bo6FxJzK4mLinWCi63OeBUs40OqwEZncfYI0NTolGaZaQO9
	vmMjobLv8OQLZHebhNc/FmftR9SZouf15XgVdH+s2Kov595gt5HgJn0w36splv1i
	2Zg9EQJVmyKkbzN4NhVBl+swDPoc+97s0piKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O/NjiXrM6Lep+6xR3JnMB9fgto9oKUS+
	Kfw42EP1KLnAG4Uo9YgnkYSuU3PCFEoEAhW8nfnKYDSzOrWABfJ3QJpIi/g7zM3Q
	rjGuFPFlVIJ1AabPaM4cFKQ54v3ej2pggsJnoxHFE/vuvRygZfHBd7LjMSn0NBg4
	cxHuxYvZSxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E82833B2;
	Fri, 11 Nov 2011 00:26:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F065A33B1; Fri, 11 Nov 2011
 00:26:36 -0500 (EST)
In-Reply-To: <CALKQrgcJmPHZG0bbgwoH6_htQODYVJtXYyHgSb_7qRKkJkb2Yw@mail.gmail.com> (Johan
 Herland's message of "Fri, 11 Nov 2011 02:17:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9EB9D6C-0C25-11E1-B77D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185252>

Johan Herland <johan@herland.net> writes:

> Given that we need an alternative way to transfer annotations between
> repos (using auto-follow to select the relevant set of annotations, and
> then transferring only those annotations): Can we leverage existing
> functionality in "notes" where useful (e.g. using existing notes merge
> strategies to deal with colliding annotations), while at the same time
> extending the current "notes" feature with this alternative transfer
> mechanism? FWIW, I expect there are other "notes" use cases that
> would also prefer the auto-follow only-relevant transfer behavior.
>
> So, how can we use "notes" to better support the transfer semantics you
> suggest? The mapping from the object being annotated to the annotation
> object is already contained in the notes tree, but the "timestamp" you
> describe (needed to efficiently calculate the set of annotations to
> auto-follow) is not [1].

Please do not take the "timestamp" part too seriously.

I am starting to think that what we want in this context actually is very
close to annotated tags. I said we want a mapping from an annotated object
to "a set of other objects" that annotate it, but it was an unnecessary
and premature generalization. There is no reason that these annotations
have to be structured "Git" objects such as blobs and trees.

A set of annotated tags that have the same value on their "object" field
is a perfect match for "a set of annotations attached to a given object".

We already know that using the real tags has its own problems coming from
having to give each and every one of them unique names somewhere in the
refs hierarchy (be it refs/tags/ or refs/audit/), but imagine if we
somehow had a way to:

 - keep these annotated tags in the object store;

 - keep them from getting pruned even if they are not referenced from
   anywhere in refs/ hierarchy;

 - given an object, efficiently enumerate such annotate tags that refer to
   the object.

And then imagine that we are pushing history leading to a commit from one
repository to another. Both repositories store these "anonymous" (that is
what they are---they do not have a name in the refs/ hierarchy) tags.

The two repositories can individually enumerate all these "anonymous" tags
that annotate commits in the history that is being exchanged, and run a
set reconciliation algorithm (e.g. [*1*]) to find out the anonymous tags
that are missing from the recipient repository.

Such an approach does not require any timestamp.

My point is _not_ that the alternative in this message is superiour to the
handwaving in my other message, but is that I think it may not be the best
approach to think what needs to be added to "notes" to make it applicable
for the problem we are solving.

Rather, I think we should design how the overall system should look like
(i.e. what property the resulting system should have) and then find out
what is necessary in each part of the resulting solution (i.e. the list of
"somehow had a way to..." above, plus "efficient set reconciliation").


[Footnote]

*1* What's the Difference? Efficient Set Reconciliation without Prior
Context http://cseweb.ucsd.edu/~fuyeda/papers/sigcomm2011.pdf
