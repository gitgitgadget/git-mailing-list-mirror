From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 09 Nov 2011 09:26:42 -0800
Message-ID: <7v4nydurzh.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Wed Nov 09 18:26:51 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1ROBvG-0003ND-0G
	for lnx-linux-ide@lo.gmane.org; Wed, 09 Nov 2011 18:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554Ab1KIR0s (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Wed, 9 Nov 2011 12:26:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718Ab1KIR0r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Nov 2011 12:26:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4BE8603D;
	Wed,  9 Nov 2011 12:26:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gHwpIrt8fJ1O7CGFZisbWtwe7mY=; b=XMjRIi
	qB6dAD7RzXCPfeAB6EAFV+cvg86Ear+gLEqxWK5ke3gGGLmwp0DQJiOJkvE74/fA
	Pm1drkupkNTRJJJrhInDQFOPiU6DfsvQN6rGfymwR3hOxoQ42nyCm0XVDQzDWf2n
	3zVqSajB2MER2bJt7UglH9amc67Axsv3ZPB78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kybpeiqKRzfuLu23QAi0Dlw9UJJ3OJJ2
	Lg7jPclmZ5t5QKXFdDjgHpczUYlClvblVN/g9Wt1/LSX5TO39AyKns9Zogt+g608
	50uxmz3wrsBeqSTsJZb2nAj44waK3CXa4ZhKMphMJgw2T2p+mBoVbI2qkzgvQLEH
	b42yPHz1Foo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAFC9603C;
	Wed,  9 Nov 2011 12:26:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCE27603B; Wed,  9 Nov 2011
 12:26:43 -0500 (EST)
In-Reply-To: <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com> (Linus
 Torvalds's message of "Thu, 3 Nov 2011 12:09:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF02C1D4-0AF7-11E1-8D67-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185162>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> No, no, don't consider my "put in the merge message" a winner at all.
>
> I personally dislike it, and don't really think it's a wonderful thing
> at all. I really does have real downsides:
>
>  - internal signatures really *are* a disaster for maintenance. You
> can never fix them if they need fixing (and "need fixing" may well be
> "you want to re-sign things after a repository format change")
>
>  - they are ugly as heck, and you really don't want to see them in
> 99.999% of all cases.
>
> So putting those things iin the merge commit message may have some
> upsides, but it has tons of downsides too.
>
> I think your refs/audit/ idea should be given real thought, because
> maybe that's the right idea.

With the latest round of touch-ups, modulo a few bugs I will be fixing
before the 1.7.8 final, I think what we have is more or less OK in the
shorter term and should be ready for general consumption. The ugliness is
gone, but the issue around internal signatures may remain to be solved in
the longer term. At least, by storing the full contents of the tag today
in an extended header, when we figure out how a detached signature should
really work, we could convert by extracting them from the history.

In a separate message earlier in the thread, you raised another issue.

> I hate how anonymous our branches are. Sure, we can use good names for
> them, but it was a mistake to think we should describe the repository
> (for gitweb), rather than the branch.
> 
> Ok, "hate" is a strong word. I don't "hate" it. I don't even think
> it's a major design issue. But I do think that it would have been
> nicer if we had had some branch description model.

At the first glance, our branch model is indeed peculiar in that a branch
does not have a global identity. The scope of its name is local to the
repository, and it is just a pointer into the history. A "note" [*1*] that
can annotate a commit long after the commit is made is not a good way to
describe what a branch is about, because the tip of the branch can advance
beyond the commit that is annotated by such a note. A commit on a branch
does not serve as a good anchoring point to describe the branch.

However, a commit that merges the history of a branch, whether the merged
branch is from a local repository or from a remote one, does serve as a
good anchoring point. The work on a branch is finished as complete as
possible at the time of the merge, and the committer who merges the branch
agrees with both the objective and the implementation of the work done on
the branch, and that is why the merge is made [*2*]. Describing what the
history of the side branch was about in the resulting merge is a perfectly
sensible way to explain the branch. So in that sense, I am very happy with
the way the merge message template uses the pull request tag to let the
lieutenant explain and defend the history behind the tag used for the pull
request. Such an explanation does not have to be keyed with anybody's
local branch name (e.g. "for-linus" would mean different things for
different pull requests even from the same person), but keying it with the
resulting merge commit is a sensible way to leave the record in the
history.

After justifying with the above two paragraphs that it is perfectly
sensible to record the annotations on commits and not on "branch names", I
do agree that we would eventually want to be able to have such annotations
on commits after the fact. Neither "tags" nor "notes" is necessarily a
very good mechanism, however, for the purpose of "signed pull requests"
and "signed commits" [*3*]. Here are some pros and cons:

 - tags must be named, but the only thing we need is to be able to look
   the contents (with signature if signed) up given a commit object.
   Unlike the usual "I want to check out v3.0 release" look-up that goes
   from tag names to the commits, annotation look-ups go the other way, do
   not have to have a tagname, and having tagname does not help our
   look-up in any way. If we want to use tag to annotate various commits
   by various people and keep them around, we would need global namespace
   that would not cause them to crash (we can work this around by using
   the object name of the tag, e.g. renaming 'for-linus' tag to $(git
   rev-parse tags/for-linus), but that is merely a workaround of having to
   name things that do not have to be named in the first place). As a
   local storage machinery for annotations, tags hanging below refs/tags/
   (or refs/audit for that matter) hierarchy with their own names is an
   inappropriate model.

 + tags can auto-follow the commits when object transfer happens (at least
   in the fetch direction), and for the purpose of "signed pull requests"
   and "signed commits", this is a desirable property. When a repository
   gains a commit, the annotations attached to the commit that are missing
   from the receiving repository are automatically transferred from the
   place the commit comes from. Annotations given to other commits that
   are not transferred into the repository do not come to the repository.

 - "git notes" is represented as a commit that records a tree that holds
   the entire mapping from commit to its annotations, and the only way to
   transferr it is to send it together with its history as a whole. It
   does not have the nice auto-following property that transfers only the
   relevant annotations.

 + "git notes" maps the commits to its annotations in the right direction;
   the object name of an annotated object to its annotation.

In the longer term, I think we would need to extend the system in the
following way:

 - Introduce a mapping machanism that can be locally used to map names of
   the objects being annotated to names of other objects (most likely
   blobs but there is nothing that fundamentally prevents you from
   annotating a commit with a tree). The current "git notes" might be a
   perfectly suitable representation of this, or it may turn out to be
   lacking (I haven't thought things through), but the important point is
   that this "mapping store" is _local_. fsck, repack and prune need to be
   told that objects that store the annotation are reachable from the
   annotated objects.

 - Introduce a protocol extension to transfer this mapping information for
   objects being transferred in an efficient way. When "rev-list --objects
   have..want" tells us that the receiving end (in either fetch/push
   direction) would have an object at the end of the primary transfer
   (note that I did not say "an object will be sent in this transfer
   transaction"; "have" does not come into the picture), we make sure that
   missing annotations attached to the object is also transferred, and new
   mapping is registered at the receiving end.

The detailed design for the latter needs more thought. The auto-following
of tags works even if nothing is being fetched in the primary transfer
(i.e. "git fetch" && "git fetch" back to back to update our origin/master
with the master at the origin) when a new tag is added to ancient part of
the history that leads to the master at the origin, but this is exactly
because the sending end advertises all the available tags and the objects
they point at so that we can tell what new tags added to an old object is
missing from the receiving end. This obviously would not scale well when
we have tens of thousands of objects to annotate. Perhaps an entry in the
"mapping store" would record:

 - The object name of the object being annotated;

 - The object name of the annotation;

 - The "timestamp", i.e. when the association between the above two was
   made--this can be local to the repository and a simple counter would
   do.

and also maintain the last "timestamp" this repository sent annotations to
the remote (one timestamp per remote repository). When we push, we would
send annotations pertaining to the object reachable from what we are
pushing (not limited by what they already have, as the whole point of this
exercise is to allow us to transfer annotations added to an object long
after the object was created and sent to the remote) that is newer than
that "timestamp". Similarly, when fetching, we would send the "timestamp"
this repository last fetched annotations from the other end (which means
we would need one such "timestamp" per remote repository) and let the
remote side decide the set of new annotations they added since we last
synched that are on objects reachable from what we "want".

Or something like that.

[Footnote]

*1* By this word, I do not necessarily mean what the "git notes" command
manipulates. A tag that points at a commit is also equally a good vehicle
to annotate a commit after the fact.

*2* For this reason, it may make sense to "commit -S" such a merge
commit. The "mergetag" asserts the authenticity of the pull request from
the lieutenant whose history is being integrated, and the "gpgsig" asserts
the authenticity of the merge itself--the fact that it was made by the
integrator.

*3* I do not mean what "git commit -S" parked in 'pu' produces, which is
to store the signature in the commit. Adding "Signed-off-by:" after the
fact to an existing commit by many people is a more appropriate example.

