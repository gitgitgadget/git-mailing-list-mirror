From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 13:25:15 -0700
Message-ID: <7vaapc7jv8.fsf@alter.siamese.dyndns.org>
References: <4C4778DE.9090905@web.de>
 <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
 <m31vavn8la.fsf@localhost.localdomain>
 <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
 <4C49B31F.8000102@xiplink.com>
 <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
 <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com>
 <AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com>
 <4C4DB9AC.9000306@xiplink.com>
 <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com>
 <20100727182841.GA25124@worldvisions.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Branchaud <marcnarc@xiplink.com>, skillzero@gmail.com,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 22:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odqj5-00035I-31
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 22:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab0G0U0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 16:26:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0G0U0D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 16:26:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16825C86E9;
	Tue, 27 Jul 2010 16:25:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1CBGvUKgpZLL
	oQ972vGXrdi+rks=; b=DSDh1RK1jDqNLNb4+FIdAKHEFRPQj73XFUu4qyi6iDkC
	3ucpnoqEQNdWjHEKAgrgsQB12cufISnuUsPSBTMySEGLA5zCKe+EsDlYJu/2Zp7B
	YFiXVB4JLsSwX4BxPq/k/9Q0bM7kAElABZejPTEZpRqvBRZYB9aob1vwE2a0yqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AFtz7i
	x4eOqCGo1DCpgPjNaF6eVubmWqOodJ9W7z9BoXKAtWJzBzf+gUH4vp6NrSefTxRE
	85leHlC4MIEwiTH0n4RW+VDB3ZXZEEzRoKfYyXcCJQQedsghRk+jzhwF5rWYXFQW
	yJ70lto9wGPBFeEhC3fRa0GKdpIgxcBO8wXoM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C4BC86DC;
	Tue, 27 Jul 2010 16:25:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 878A4C86C9; Tue, 27 Jul
 2010 16:25:17 -0400 (EDT)
In-Reply-To: <20100727182841.GA25124@worldvisions.ca> (Avery Pennarun's
 message of "Tue\, 27 Jul 2010 14\:28\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1EECB69C-99BD-11DF-A710-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151984>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Mon, Jul 26, 2010 at 09:41:42AM -0700, Linus Torvalds wrote:
>
>> On Mon, Jul 26, 2010 at 9:37 AM, Marc Branchaud <marcnarc@xiplink.co=
m> wrote:
>> >
>> > I think I should mention one aspect of what we're doing, which is =
that a lot
>> > of our submodules are based on external code, and that we occasion=
ally need
>> > to modify or customize some of that code. =C2=A0So it's quite nice=
 for us to
>> > maintain private git mirrors of the external repos, with our own p=
rivate
>> > branches that contain our modifications. =C2=A0Although we want to=
 get much of our
>> > changes incorporated into the upstream code bases, upstream releas=
e cycles
>> > are rarely in sync with ours.
>>=20
>> THIS.
>>=20
>> This is why I always thought that submodules absolutely have to be
>> commits, not trees. It's why the git submodule data structures are
>> done the way they are. Anything that makes the submodule just a tree
>> is fundamentally broken, I think.
>
> I agree completely.  The major failing of git-subtree is that it uses
> tree->tree links instead of tree->commit links.
>
> This was necessary only because git fundamentally *mistreats* tree->c=
ommit
> links: it refuses to push or fetch through them automatically.

I do not think that is so "fundamental" as you seem to think.

Isn't it just the matter of how the default UI of object transfer comma=
nds
(like push and fetch) are set up?

Admittedly, the way the default UI is set up is to strongly favor the
early design decision we made back when Linus did his initial "gitlink"
implementation, which is "separate project lives in a separate reposito=
ry,
and not having to check out any subproject should be the norm for using=
 a
superproject". =20

Some "recursive" operations have been added to commands for which it ma=
kes
sense (e.g. "clone --recursive") by people who cared enough.  Even thou=
gh
there are a few other commands that shouldn't ever learn the recursive
mode (e.g. "commit --recursive -m $msg" would not make sense), there st=
ill
are some commands where a similar "--recursive" option would make sense
but haven't learned it (e.g. "push --recursive").

I also consider it merely a lack of UI enhancement that you have to clo=
ne
the submodule again (or cannot switch to a clean slate very easily) whe=
n
switching between revisions of superproject before and after you add a
submodule, and nothing fundamental. =20

When switching back in history to lose a recent submodule, the user
experience should be like switching to a revision that didn't have a
directory.  You shouldn't be able to lose your change in that directory=
,
but if the directory is clean, you should be able to lose it.  And when
you switch to a more recent revision that has the submodule, you should=
 be
able to get it back (again, if you have a precious file there, the
checkout should barf).

We have added support for having "gitdir: $dir" in a regular file .git
exactly because we wanted to be able to stash away the submodule's .git
directory somewhere inside .git (e.g. .git/modules/<submodulename>) in =
the
superproject when we do that kind of branch switching, so that we can g=
et
it back when switching back to a revision with the submodule without
having to re-clone (also this presumably would help when you move the
submodule in the superproject tree), but there haven't been further wor=
k
to make use of this in "git submodule update" (it probably needs to sta=
rt
by teaching "git clone" how to make use of "gitdir: $dir", if anybody i=
s
interested).

By the way, I also do not think it is such a bad thing that git-subtree
does not bind commit into its superproject tree while it is working
"natively" (in a "git-subtree" workflow), but allows users to easily sp=
lit
the history into an exportable shape to upstreams of its submodules whe=
n
such an operqation is needed.  If you rarely push back to upstreams but
constantly consume their changes, that sounds like a reasonable way to =
go.
