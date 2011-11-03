From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 03 Nov 2011 11:16:37 -0700
Message-ID: <7v62j1gitn.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Thu Nov 03 19:30:23 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RM23S-0002sG-KG
	for lnx-linux-ide@lo.gmane.org; Thu, 03 Nov 2011 19:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831Ab1KCSaU (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Thu, 3 Nov 2011 14:30:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933752Ab1KCSaS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Nov 2011 14:30:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 564B45836;
	Thu,  3 Nov 2011 14:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=eqiP64kniJ2679PRTmJDXBT91uQ=; b=XmQIjgS3JV+f2QHEUeUO
	PJzKw0YO4LbDxDElF/5E0zdEKGGU9xv3Afye3CSar56vt4yjuMYZ9PkLK/+HNv9S
	2B4xeUZ7yTGokLDuZ2k13qMvC0aIrrxEFi1c7NFmmkbUL7wazZ3PXNb6/6I2+avK
	xTTlcnNt2wegLjKvQWNTWRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DBZCWYYJarOLnJ4GBgLNPaXJTLCG4h3Gj8Mo/td94+StvX
	tVI3qrlsBJy/xsurCTn2PNJDBu2mBEUWjdBf2DSRDejfcGVVghk3zc9AZxvrcKNj
	gNQlL9gMYUA0N/7FDZZa65NbQ5dCQjRfFrPk3CzGsvdz/joVnvgcpJcym7vkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48CD35835;
	Thu,  3 Nov 2011 14:30:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CF53582D; Thu,  3 Nov 2011
 14:30:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF47C6DA-0649-11E1-80C7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184732>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>   [torvalds@i5 linux]$ git fetch
> git://github.com/rustyrussell/linux.git
> rusty@rustcorp.com.au-v3.1-8068-g5087a50
>   fatal: Couldn't find remote ref rusty@rustcorp.com.au-v3.1-8068-g5087a50
>
> oops. Ok, so his tag naming is *really* akward. Whatever.

It is not "Whatever".

 $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v3.0
 fatal: Couldn't find remote ref v3.0

I do not think we ever DWIMmed fetch refspecs to prefix refs/tags/, so it
is not the naming but fetching tags without saying "git fetch tag v3.0"
(which IIRC was your invention long time ago). 

If we changed this "git fetch $there v3.0" to fetch tag, it would help the
final step in your illustration, and I do not think it would be a huge
regression---the only case it becomes fuzzy is when they have v3.0 branch
at the same time, but the owner of such a repository is already playing
with fire.

>    [torvalds@i5 linux]$ git fetch
> git://github.com/rustyrussell/linux.git
> refs/tags/rusty@rustcorp.com.au-v3.1-8068-g5087a50
>    From git://github.com/rustyrussell/linux
>     * tag
> rusty@rustcorp.com.au-v3.1-8068-g5087a50 -> FETCH_HEAD
>
> Ahh, success!
>
> Oops. Nope. It turns out that git will *peel* the tag when you fetch
> it, so FETCH_HEAD actually doesn't contain the tag object at all, but
> the commit object that the tag pointed to. MAJOR FAIL.
>
> Quite frankly, I think that's a git bug, but it's a git bug because
> "git fetch" was designed to get the commit to merge. Fair enough.

And because FETCH_HEAD started as (and probably still is) an internal
implementation detail of communication between fetch and merge inside
pull. So I do not have any issue in changing it to store tags unpeeled
there.
>    [torvalds@i5 linux]$ git fetch
> git://github.com/rustyrussell/linux.git
> refs/tags/rusty@rustcorp.com.au-v3.1-8068-g5087a50:refs/tags/rusty
>    From git://github.com/rustyrussell/linux
>     * [new tag]
> rusty@rustcorp.com.au-v3.1-8068-g5087a50 -> rusty
>     * [new tag]
> rusty@rustcorp.com.au-v3.1-2-gb1e4d20 ->
> rusty@rustcorp.com.au-v3.1-2-gb1e4d20
>     * [new tag]
> rusty@rustcorp.com.au-v3.1-4896-g0acf000 ->
> rusty@rustcorp.com.au-v3.1-4896-g0acf000
>     * [new tag]
> rusty@rustcorp.com.au-v3.1-8068-g5087a50 ->
> rusty@rustcorp.com.au-v3.1-8068-g5087a50
>
> WTF?

This is not WTF but "fetching a history to store the tip of it in your
refs/ namespace causes tags pointing into the history line followed
automatically", and it exactly is what you want to happen if rusty asked
you to fetch his for-linus branch (which the tag may point at) instead.

> We got three other
> tags too that we didn't even ask for!

We could change the rule to read "fetching a history to store the tip of it
in your refs/heads namespace causes autofollow". I am not sure if that is
what we really want, though.

> Again - not a fundamental design mistake in the data structures, and
> it actually made sense from a "signed tags are important release
> points" standpoint, but it makes it *really* inconvenient to use
> signed tags for signature verification.

We could update three things:

 - DWIM $name in "git fetch $there $name" to refs/tags/$name when it makes
   sense;
 - FETCH_HEAD stores unpeeled object names; and
 - "git pull" learns --verify option.

Then

 $ git pull --verify rusty rusty@rustcorp.com.au-v3.1-8068-g5087a50

could integrate the history leading to that tag to your current branch
while running verify-tag on it.

For this, disabling the tag-auto-following is not necessary, as you are
not storing the retrieved tag anywhere.

That is a longwinded way to say I agree what you said below.

> So signed tags are not mis-designed from a conceptual standpoint -
> they just work really really awkwardly right now for what the kernel
> would like to do with them.
>
> With a few UI fixes, I think the signed tag thing would "just work".
>
> That said, I do think that the "signature in the pull request" should
> also "just work", and I'm not entirely sure which one is better.

I do not think it is necessarily either/or choice.

Either way does not solve anything other than validating the last hop
between the last lieutenant to the integrator without having a way to give
the verification material to third parties.

Your earlier "pull request signature could be copied into the message of
the merge that integrates the pulled history" solves 90% of the "third
party validation" issue.

With the signed tags approach, you could push out these signed tags you
get from lieutenants, but there are quite a few things that need to happen
for it to be usable:

 - You or your lieutenants do not want to keep these tags in your working
   repository, to be listed in "git tag -l". They are ephemeral to you and
   your lieutenant, even though they have to be permanent for third
   party auditors.

 - Normal users of your project do not want to see them in "git tag -l"
   either.

 - Responses to "git fetch" and "git ls-remote" produced by "git
   upload-pack" do need to (optionally) include them to allow third party
   auditors to ask for them.

I wonder if an approach like the following, in addition to the three
things I listed above, may give us a workable solution:

 * "git fetch linus v3.0" called by "git pull --verify linus v3.0" fetches
   the v3.0 unpeeled into FETCH_HEAD, GPG verifies it, creates
   refs/audit/$u, before running "git merge". $u is derived from v3.0
   (given tag), the identity of the GPG signer, and perhaps timestamp to
   make it both identifiable and unique under refs/audit/ hierarchy.

 * You "git push origin". This causes refs/audit/* refs that point at
   commits in the transferred history to auto-follow, just like the
   current "git fetch $there $src:$dst" causes refs/tags/* auto-follow.
   The refs/audit/* hierarchy in your public repository will be populated
   by lieutenant signatures.

 * (Optional) You may have signed "git tag -s 'Linux v3.2' v3.2 master"
   before you push origin out, or you may have not. Currently, you do have
   to "git push origin v3.2" separately if you did. The above auto-follow
   could be extended to push refs/tags/* hierarchy to eliminate this step
   as well.

Note that because of the way "upload-pack" protocol is structured, the
first response from "upload-pack" after it gets connection is the
advertisement of refs, and there is no way for "fetch-pack" to ask for
customized refs advertisement to it. So for this to work without incurring
undue overhead for normal users, we would need to exclude refs/audit/*
from the normal ref advertisement (i.e. "ls-remote" does not see it) so
that "git fetch" by casual users will not have to wait for megabytes of
ref advertisements before issuing its first "want" request. Probably we
can change "upload-pack" to advertise only refs/heads/*, refs/tags/*, and
HEAD by default, and a protocol extension could be added to ask for other
hierarchies for specialized needs like third party auditors.

BUT.

This does not allow third party auditors to audit how sub-subsystem
histories came into your lieutenants' history unless you also fetch from
your lieutenants in "auditor" mode to retrieve their refs/audit/* refs to
be propagated to your public repository, which all of us involved in this
thread know you wouldn't bother if it is an additional manual step (and I
personally do not think I would bother if I were you).

So the audit trail will end at one level unless we have even more complex
arrangements. The auditors know the history up to some point in the past
came from you (your last signed tag at release time, which some people may
feel a bit too sparse for auditing purposes when a security incident like
that one happens in between releases), and they know subhistories of what
you merged came from your direct lieutenants (the refs/audit/* tags the
above change allowed you to forward automatically when you published), but
they have to take the word of your direct lieutenants at face value.

I do not know if that is acceptable for $DAYJOB types, though.
