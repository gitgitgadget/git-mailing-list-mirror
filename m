From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 23:52:18 -0500
Message-ID: <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
	 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
	 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
	 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
	 <7viqakcu56.fsf@alter.siamese.dyndns.org>
	 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
	 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
	 <ron1-F006CF.18381129012010@news.gmane.org>
	 <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 05:54:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5Ln-0005vI-Hv
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 05:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab0A3EwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 23:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592Ab0A3EwU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 23:52:20 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:56526 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0A3EwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 23:52:19 -0500
Received: by iwn39 with SMTP id 39so746651iwn.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 20:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WzRRfRdASLkOKCnzGu9l7nMzs2VdIl07Q840wtFZn9w=;
        b=LvPgeyOoc3FP2Ky7kdoeRIlCdQ3l18FNr4qMvotgJ0jTOjsyXdKLyHWLP3Ra5mDhAr
         ra6qibJF7wUWrC17dv+N3/ECdDWlS2gV9cbTi21E5hx1aFUyaGthUMM5VcAYzeP3emWf
         /dQQ1Vzf7tRJRwvlvwzzvPuNA4UENcblIl3BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kwN5VDSKQzaxU++44/UMGieDnGd+qnLLB5CCe9uCqBNuBnyDEYK6Zdk+8IojrYBIMs
         51RiNtuWyK97V5AIDPzqfoy62uJpvMbQHhGgVtSIP8a+k04D0JJvQyUNWCDr43pD2T4Z
         1ncuXM+fGhct/2N36o+EaYRk/xYpzLsmHlI1M=
Received: by 10.231.147.148 with SMTP id l20mr2635112ibv.77.1264827138738; 
	Fri, 29 Jan 2010 20:52:18 -0800 (PST)
In-Reply-To: <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138440>

On Fri, Jan 29, 2010 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ron Garret <ron1@flownet.com> writes:
>
>> 1. =C2=A0The term "detached HEAD" is inherently misleading. =C2=A0A =
detached HEAD
>> isn't detached from anything, it's just pointing to the middle of a
>> branch, which is to say, to a commit that happens to already have
>> descendants. =C2=A0For that matter, the name HEAD is itself misleadi=
ng, since
>> HEAD need not be the head of a branch (though normally it is). =C2=A0=
A better
>> name for HEAD would have been CURRENT or ACTIVE. =C2=A0I recognize i=
t's
>> probably too late to change it now.
>
> This description, especially the phrase "middle of a branch" shows th=
at
> you don't understand git yet. =C2=A0A git branch is _not_ a line (nor=
 multiple
> lines) of development. =C2=A0It is merely a _point_ in the history.
>
> "A commit that is in the middle of an ancestry chain with existing
> descendants" can be at the tip of a branch and does not have anything=
 to
> do with detached HEAD state.
>
> When HEAD points at a branch, making a commit advances _that_ branch.=
 =C2=A0And
> we say you are "on that branch". =C2=A0When HEAD is detached, because=
 it is not
> attached to anything, it advances no branch. =C2=A0"detached HEAD" is=
 detached
> in the very real sense. =C2=A0It is not attached to _any_ branch.

Let me try wording this slightly different, because I think I can see
Ron's confusion.

HEAD normally refers to a named branch. For example "master"
(technically, HEAD would contain "ref: refs/heads/master"), but we'll
just say "master" for now.

Meanwhile, the branch named "master" refers to a specific commit by
its SHA-1 hash.

The particular commit which "master" refers to is a branch head.

Now, when you create a commit in this state, the branch named "master"
is updated with the SHA-1 of the new commit. So let's say you create a
new repo and have three commits. Your history would look like this:

a---b---c master (HEAD is "ref: refs/heads/master")

That is, if you look at .git/HEAD, it will say "ref:
refs/heads/master" and if you look at .git/refs/heads/master it will
have the SHA-1 of commit "c". If you create a new commit:

a---b---c---d master (HEAD is "ref: refs/heads/master")

=2Egit/HEAD still says "ref: refs/heads/master" but now
=2Egit/refs/heads/master has the SHA-1 of commit "d".

Okay, now let's talk about what happens when you type:

$ git checkout master^

At this point, git updates HEAD to contain the SHA-1 of "c":

a---b---c---d master (HEAD is c's SHA-1)

You now have a "detached HEAD" because HEAD doesn't refer to any named
branch. Instead it refers to a specific commit by its SHA-1. So let's
create a new commit while HEAD is detached:

a---b---c---d master
         \
          e   (HEAD is e's SHA-1)

So, yes, you've created a "branch" in the DAG sense of the word. But
this branch is anonymous since it has no name. That means that commit
"e" is subject to garbage collection and may be removed. If you want
to keep it around, then you need to create a name for it. Git provides
you a number of ways to "name" commits:

$ git checkout -b foo # (1)
$ git branch foo      # (2)
$ git tag foo         # (3)

(1) will create .git/refs/heads/foo, make it have the SHA-1 of commit
"e", then update HEAD to say "ref: refs/heads/foo". You are now "on"
branch "foo" and any commits you create will update
=2Egit/refs/heads/foo:

a---b---c---d master
         \
          e  foo (HEAD is "ref: refs/heads/foo")

(2) will also create .refs/heads/foo, and make it have the SHA-1 of
commit "e", but will leave HEAD as it is:

a---b---c---d master
         \
          e  foo (HEAD is SHA-1 of "e")

You still have a detached HEAD and any commits you create that descend
from "e" are still subject to garbage collection (although "e" itself
is not), as follows:

a---b---c---d master
         \
          e  <-- foo
           \
            f (HEAD is SHA-1 of "f")

(3) creates .refs/tags/foo, but is otherwise the same as (2).

So that was a really long explanation, but I hope it clears things up.
I think the disconnect between you and Junio is that you're thinking
of branches in the DAG sense of the word, while Junio is talking about
them in the context of git.

j.
