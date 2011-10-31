From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 11:23:55 -0700
Message-ID: <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 31 19:24:10 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RKwWn-0008VB-At
	for glk-linux-kernel-3@lo.gmane.org; Mon, 31 Oct 2011 19:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933852Ab1JaSYA (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 31 Oct 2011 14:24:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33217 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933655Ab1JaSX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2011 14:23:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D2995A70;
	Mon, 31 Oct 2011 14:23:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cG5dijzdUNiAW/4YW816RlXZfIw=; b=yAgMgV
	m/8aYFZq3uc1pcCW8An4zbsCoOoL5p+VOSK569Exq1XS32ObfWPMvrWM85aEg0O8
	P9yjx8tl6F1411RNSx4AYUXK0Hm7IDj0uFlZ1CZ5flvh2TkGbp905pfSfoDtx6zO
	MxHkMN0r/gZ/0Ma0AcaUdIfLcEyGcjc/Kfe6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AGV89KeEbTkMf/FVW8HITBJSoxmGLa2V
	Mlh+ogcFQJ77YiFbqDUfLEuEhYxM6IjNpeS43Pp/1WXqqbhfLYUQukgC2kVzHDZP
	ThJ7veNoG3CcLJGuB+3mSzp2YEQptj+Y63Yil6MGJKuGFQIRYDWwyvMlWX0wnNc8
	ns44jDo/908=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83DB05A6F;
	Mon, 31 Oct 2011 14:23:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A98455A6E; Mon, 31 Oct 2011
 14:23:56 -0400 (EDT)
In-Reply-To: <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 31 Oct 2011 08:53:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7ECE85F4-03ED-11E1-88EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184511>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> For the people who use "git request-pull", I'm attaching a trivial
> patch to make it add this kind of signature if you give it the "-s"
> flag. It basically just adds a hunk like the appended crazy example to
> the pull request, and it's small enough and simple enough that it
> makes verification simple too with just the above kind of trivial
> cut-and-paste thing.
>
> (Junio cc'd, I think he had something more complicated in mind)

You have misread me this time.

I think the minimalistic "paste this line to your 'git pull' command line
and expect to get history leading to this commit" like you did in your
patch would be the solution that is the least painful and still useful,
which is an important criterion for wide adoption.

> Now, admittedly it would be *even nicer* if this gpg-signed block was
> instead uploaded as a signed tag automatically, and "git pull" would
> notice such a signed tag (tagname the same as the branch name + date
> or something) and would download and verify the tag as I pull. Then I
> wouldn't even need to actually do the cut-and-paste at all. But this
> is the *really* simple approach that gets up 95% of the way there.

I however have a small trouble with "lieutenants use signed tags in order
to prove who they are to Linus", depending on the details.

It certainly lets you run "git tag --verify" after you pulled and will
give you assurance that you pulled the right thing from the right person,
but what do you plan to do to the tag from your lieutenants after you
fetched and verified?  I count 379 merges by you between 3.0 (2011-07-21)
and 3.1 (2011-10-24), which would mean you would see 4-5 tags per day on
average.  Will these tags be pushed out to your public history?

On one hand, we (not just you but the consumers of "Linus kernel") can
consider these tags are of ephemeral nature. Once they are used for _you_
to verify the authenticity, they are not needed anymore. The consumers of
"Linus kernel" by definition trusts what you publish, so as long as they
have a way to verify the tip commit you push out, they _should_ be happy.
If you take this stance, you would not push these tags out so that you do
not have to contaminate the tags namespace with them, and you might even
choose to discard them once you pulled and verified the lieutenants' tips
to avoid contamination of your own refs namespace.

On the other hand, the consumers of "Linus kernel" may want to say that
they trust your tree and your tags because they can verify them with your
GPG signature, but also they can independently verify the lieutenants'
trees you pulled from are genuine. Keeping signed tags and publishing them
is one way to make it possible, but 400 extra tags in 3 months feels like
an approach with too much downside (i.e. noise) for that benefit.

On Git mailing list, we have been toying with a couple of ideas. The
simplest one (cooking in next) is to allow committers to add gpg signature
in an additional header of the commit objects. "git show" and friends are
taught how to verify these signatures when asked.

This might have a potential downside on the lieutenants' workflow; after
integrating the work by their sub-lieutenants and by themselves, they
would test and review the result to convince themselves that it is worth
asking you to pull, and then they have to either

    (1) "commit --amend --gpg-signature" the tip; or

    (2) "commit --allow-empty --gpg-signature" to add an empty commit
        whose sole purpose is to hold the signature (and avoid amending
        the tip)

before pushing it out, asking you to pull.

An alternative we have discussed was to store gpg signature for the commit
("push certificate") somewhere in notes tree and push that out, certifying
that the commit indeed came from the pusher, but that would:

 (1) require upstreams to fetch (and possibly suffer from merge conflicts
     in notes tree) push certificate whenever they pull from their
     lieutenants; and

 (2) require downstreams to also fetch the notes tree for "push
     certificates" (especially when the central repository is shared among
     multiple people) before adding their own signature and then push it
     back (and possiblly suffer from "non-fast-forward" in notes tree).

both of which are downsides coming from "notes" being not a very good
match for what these signatures are trying to achieve.

Namely, the current "notes" mechanism is designed to keep track of history
of changes made to notes attached to commits, but for the signature
application, we do not care about the order that signatures came to two
separate commits. "Non-fast-forward" conflicts while pushing, or having to
fetch and merge before adding one's own signature, are unwanted burden
imposed only by choosing to use "notes" for storing and conveying the
signature.

Also the "notes" approach would end up mixing "push certificates" for
different branches (this won't be an issue in your repository where there
is only one branch) into a single "notes" tree. We would want to use
something that behaves more like the "auto-following" semantics of tag
objects. You would want to fetch only signatures that are attached to the
commits you are fetching. Use of signed tags, or commit objects that can
be signed in-place, have this property, but storing signature in notes
tree does not give it to us.

I think further discussions on this should continue on the git mailing
list.
