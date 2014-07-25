From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Fri, 25 Jul 2014 15:08:31 -0700
Message-ID: <xmqqegx95bxc.fsf@gitster.dls.corp.google.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
	<B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley>
	<xmqqegxcdjzl.fsf@gitster.dls.corp.google.com>
	<7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley>
	<xmqqvbqm74v7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:08:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAnfU-00062n-Ir
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 00:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760281AbaGYWIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 18:08:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62112 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbaGYWIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 18:08:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 949812BBFF;
	Fri, 25 Jul 2014 18:08:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p8JhWpsTp8O08nsJnTUIgTcocRM=; b=xLqDad
	Nj1bD6Q/SIG91pv4dUf6FNxH4HIXptRyiYuO3JKexcWOLsycmXm6mVrFMgk0fc4F
	wk4nmiPpT/o9xGet81cnhGaRvZQs+Q+6SLW1XHfcmSBAr8HnbTnOg4sv2TS0S1iB
	kcxASGx33uqXQMnhhMgxX5EP7f4621Fn3HWzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VS7X+ZtK29znE8DhvEQNo0vCBRjbl8kd
	yVSAnJZpexhIgrFM+QPgt8CJ/4ra1nXub0BmsIXrEqFOLl1CulxQ9Joig71MOLNP
	j9/UYsBiIczpgSzOavzpNyj2vMWp+jTVdbij83SJ5ZhJZV555VRhtXcCRmQB9THI
	Dw9X9kldDZA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B7AA2BBFE;
	Fri, 25 Jul 2014 18:08:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 733F52BBF3;
	Fri, 25 Jul 2014 18:08:33 -0400 (EDT)
In-Reply-To: <xmqqvbqm74v7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Jul 2014 15:45:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 37D4B542-1448-11E4-9F69-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254269>

Junio C Hamano <gitster@pobox.com> writes:

> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> which still makes me feel hesitant to promote this
>>> document without updating its contents, though.
>>>
>>
>> I hadn't viewed it as a 'promotion', rather it was simply ensuring
>> access to the guide via the help system, instead of leaving it
>> somewhat hidden.
>
> Stale or incorrect pieces of advice that are hidden will not harm
> (non-)readers.  Making them more available would mean giving them
> more chances to do harm ;-).

Let's disect it.  I do not have time/concentration to finish all in
one message, so I'll do the first two.

| Everyday Git With 20 Commands Or So
| ===================================
| 
| <<Individual Developer (Standalone)>> commands are essential for
| anybody who makes a commit, even for somebody who works alone.
| 
| If you work with other people, you will need commands listed in
| the <<Individual Developer (Participant)>> section as well.
| 
| People who play the <<Integrator>> role need to learn some more
| commands in addition to the above.
| 
| <<Repository Administration>> commands are for system
| administrators who are responsible for the care and feeding
| of Git repositories.

Let's assume the categorization above is sensible for now.

| Individual Developer (Standalone)[[Individual Developer (Standalone)]]
| ----------------------------------------------------------------------
| 
| A standalone individual developer does not exchange patches with
| other people, and works alone in a single repository, using the
| following commands.
| ...

Everything in the enumeration looks OK except for this one,

|   * linkgit:git-show-branch[1] to see where you are.

which is probably no longer the case, for two reasons.  In the
original design of Git UI, you see many things that encourage you to
view and think about the whole collection of your branches as a whole.
"git show-branch" whose default is to show all of your branches is
just one of them (other examples include "git push" whose default
used to be "matching", expecting that you will work on completing
all the branches before you push the result out for all of them).

Over time, Git UI mutated into put a lot more focus and stress on
the current branch, disregarding what are on the branches you are
not corrently on.  "git log @{u}.." to see how much more you have
done on top of others' work would be more in line with such an
attitude.

I'd suggest dropping this command from this enumeration.

| Examples
| ~~~~~~~~
| 
| Use a tarball as a starting point for a new repository.::
| ...

Perfectly fine.

| Create a topic branch and develop.::
| +
| ------------
| $ git checkout -b alsa-audio <1>
| $ edit/compile/test
| $ git checkout -- curses/ux_audio_oss.c <2>
| $ git add curses/ux_audio_alsa.c <3>
| $ edit/compile/test
| $ git diff HEAD <4>
| $ git commit -a -s <5>

Perefectly fine up to this point.

| $ edit/compile/test
| $ git reset --soft HEAD^ <6>
| $ edit/compile/test
| $ git diff ORIG_HEAD <7>
| $ git commit -a -c ORIG_HEAD <8>

This shows how a typical sequence "I try to further tweak what I
committed" looked like.  With the modern Git, you would do

    $ edit/compile/test
    $ git diff HEAD^ <7>
    $ git commit -a --amend

without the soft reset, which was invented solely because there
wasn't "commit --amend" available.

The example is perfectly fine after this step, but <6> and <8> need
to be dropped and others renumbered.

| Individual Developer (Participant)[[Individual Developer (Participant)]]
| ------------------------------------------------------------------------
| ...
|   * linkgit:git-format-patch[1] to prepare e-mail submission, if
|     you adopt Linux kernel-style public forum workflow.

Probably git-send-email needs to be appended to the end of the
enumeration.

| Examples
| ~~~~~~~~
| 
| Clone the upstream and work on it.  Feed changes to upstream.::
| +
| ------------
| $ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
| $ cd my2.6
| $ edit/compile/test; git commit -a -s <1>
| $ git format-patch origin <2>
| $ git pull <3>
| $ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <4>
| $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <5>
| $ git reset --hard ORIG_HEAD <6>
| $ git gc <7>
| $ git fetch --tags <8>
| ------------
| +
| <1> repeat as needed.
| <2> extract patches from your branch for e-mail submission.
| <3> `git pull` fetches from `origin` by default and merges into the
| current branch.
| <4> immediately after pulling, look at the changes done upstream
| since last time we checked, only in the
| area we are interested in.
| <5> fetch from a specific branch from a specific repository and merge.
| <6> revert the pull.
| <7> garbage collect leftover objects from reverted pull.
| <8> from time to time, obtain official tags from the `origin`
| and store them under `.git/refs/tags/`.

This example works directly on 'master', which is not ideal.  If I
were writing this today, I would have made it work on 'mine' branch,
produced a patch series out of that branch relative to @{u}, threw
in 'git send-email' invocation, and had "git pull" update the
pristine 'mater' branch after "git checkout master".  Merging of
work by jgarzik (i.e. not your upstream) would also have gone to its
own branch, not to 'master'.

| Push into another repository.::
| +
| ------------
| satellite$ git clone mothership:frotz frotz <1>
| satellite$ cd frotz
| satellite$ git config --get-regexp '^(remote|branch)\.' <2>
| remote.origin.url mothership:frotz
| remote.origin.fetch refs/heads/*:refs/remotes/origin/*
| branch.master.remote origin
| branch.master.merge refs/heads/master

Perfectly fine up to this opint.

| satellite$ git config remote.origin.push \
|            master:refs/remotes/satellite/master <3>

Somewhat iffy; "+refs/heads/*:refs/remotes/satellite/*" would have
been better.  Need to adjust the explanation below.

| satellite$ edit/compile/test/commit
| satellite$ git push origin <4>

Fine, except that the explanation below needs adjustment.

| <3> arrange `git push` to push local `master` branch to
| `remotes/satellite/master` branch of the mothership machine.
| <4> push will stash our work away on `remotes/satellite/master`
| remote-tracking branch on the mothership machine.  You could use this
| as a back-up method.

With wildcarding, we would be backing up all our local branches, not
just master.

| Branch off of a specific tag.::
| +
| ------------
| $ git checkout -b private2.6.14 v2.6.14 <1>
| $ edit/compile/test; git commit -a
| $ git checkout master
| $ git format-patch -k -m --stdout v2.6.14..private2.6.14 |
|   git am -3 -k <2>
| ------------
| +
| <1> create a private branch based on a well known (but somewhat behind)
| tag.
| <2> forward port all changes in `private2.6.14` branch to `master` branch
| without a formal "merging".

The last one is fine, but "cherry-pick v2.6.14..private2.6.14" would
be more common with today's Git.
