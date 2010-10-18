From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Mon, 18 Oct 2010 16:35:32 -0500
Message-ID: <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 23:36:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7xNA-0004M5-PG
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 23:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233Ab0JRVfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 17:35:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60011 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab0JRVfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 17:35:54 -0400
Received: by gwj19 with SMTP id 19so63993gwj.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kAb9XNJS2nnOrutkmVoI3R1XksOQmaywUPq4WgQ7eoU=;
        b=Ajd77ILbAH4Fq4VbmdLpf/WL9Jxn+GJ8xW3/yLKNaAlguQLLQTvrW9xJeNxwfpg58X
         n4ORvkUAXkH5dQwj1hLv7ru9mh7Ia1vgW9InNj5bYkgIZujraiI0l56F4JKjqvDMQ3iR
         IfjK0PMkfBjngOu1rOxi7lkRHkvgts6ZXwP4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QU0c82b5lJOEo2V8CzOVUHxHj2jheGyTzElY0YNHMBeCnm+WJkHOYyz+DVmu2DO6GJ
         7M89VyFZYbf8t8C4/Mg8znGamfIZFhK0ms8mte+Dc7zpbCRusfwJhIuL61FcSOZITUK1
         59gey/Mt44DKatsLG/WJEPYR2hueiZyVooY1c=
Received: by 10.151.92.9 with SMTP id u9mr7372106ybl.319.1287437753246; Mon,
 18 Oct 2010 14:35:53 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Mon, 18 Oct 2010 14:35:32 -0700 (PDT)
In-Reply-To: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159289>

Heya,

[+Scott, who's done a lot of work on making git more newbie friendly]
[+Jonathan, I saw his reply just before sending this]

On Mon, Oct 18, 2010 at 15:45, Thore Husfeldt <thore.husfeldt@gmail.com=
> wrote:
> I=E2=80=99ve just learned Git. What a wonderful system, thanks for bu=
ilding
> it.

Thanks.

> And what an annoying learning experience.

Thanks again :).

> I promised myself to try to remember what made it all so hard, and to
> write it down in a comprehensive and possibly even constructive
> fashion. Here it is, for what it=E2=80=99s worth. Read it as the frie=
ndly, but
> somewhat exasperated suggestions of a newcomer. I=E2=80=99d love to h=
elp (in
> the form of submitting patches to the documentation or CLI responses)=
,
> but I=E2=80=99d like to test the waters first.

Awesome! Your experiences are very welcome indeed!

> So, remote tracking branches are neither remote (they are *local*
> copies of how the remote once was) and they stand completely still
> until you tell them to =E2=80=9Cfetch=E2=80=9D. So remote means local=
, and tracking
> means still, =E2=80=9Clocal still-standing=E2=80=9D would be a less c=
onfusing term
> that =E2=80=9Cremote tracking=E2=80=9D. Lovely.

*chortles*, nicely observed.

> The hyphenated *remote-tracking* is a lot better terminology already
> (and sometimes even used in the documentation), because at least it
> doesn't pretend to be a remote branch (`git branch -r`, of course,
> still does).

What do you mean with the last part (about `git branch -r`)? The fact
that 'refs/remotes' is not immutable?

> So that single hyphen already does some good, and should
> be edited for consistency.

If we agree that "remote-tracking" is the way to go, a patch doing
such editing would be very welcome.

> And *even if* the word was meaningful and consistently spelt, the
> documentation uses it to *refer* to different things. Assume that we
> have the branches master, origin/master, and origin=E2=80=99s master
> (understanding that they exist, and are different, is another Aha!
> moment largely prevented by the documentation).

How could the documentation make this more clear?

> Or rather, it is the confirmation one needs that nobody in the Git
> community cares much

On the contrary, we care a lot, but once you're not a new user
yourself anymore, it's hard to know what to fix.

> There probably is a radical case to be made for abandoning the word
> =E2=80=9Ctracking=E2=80=9D entirely. First, because tracking branches=
 don=E2=80=99t track, and
> second because =E2=80=9Ctracking=E2=80=9D already means something els=
e in Git (see
> below). I realise that this terminology is now so ingrained in Git
> users that conservatism will probably perpetuate it. But it would be
> *very* helpful to think this through, and at least agree on who
> =E2=80=9Ctracks=E2=80=9D what. In the ideal world, origin/master woul=
d be something
> like =E2=80=9Cthe fetching branch=E2=80=9D for the origin=E2=80=99s m=
aster, or the =E2=80=9Csnapshot
> branch=E2=80=9D or the =E2=80=9Cfetched branch=E2=80=9D.
> [...]
> More radically, I am sure some head scratching would be able to find
> useful terminology for master, origin/master, and origin=E2=80=99s ma=
ster. I=E2=80=99d
> love to see suggestions. As I said, I admire how wonderfully simple
> and clean this has been implemented, and the documentation, CLI, and
> terminology should reflect that.

I don't have any objections to changing these terms, but I don't have
any suggestions on what to change them _to_.

> 2. Introduce the alias `git unstage` for `git reset HEAD` in the
> standard distribution.

(or 'git rm --cached' for newly added files)

> =C2=A0 =C2=A0nothing added to commit but untracked files present
>
> should be
>
> =C2=A0 =C2=A0nothing staged to commit, but untracked files present

I've always liked the whole 'stage(d)' concept, so I like this, but I
remember Junio being fairly hesitant to use it more extensively.

> (Comment: maybe =E2=80=9C... but working directory contains untracked=
 files.=E2=80=9D
> I realise that =E2=80=9Cdirectory=E2=80=9D is not quite comprehensive=
 here, because
> files can reside in subdirectories.

We use "worktree" elsewhere, how about that?

> =C2=A0 =C2=A0(use "git track <file>" to track)

So basically you want to split out 'git add' into 'git track' and 'git =
stage'?

> =C2=A0 =C2=A0Changes to be committed:
> =C2=A0 =C2=A0(use "git reset HEAD <file>..." to unstage)
>
> should be
>
> =C2=A0 =C2=A0Staged to be committed:
> =C2=A0 =C2=A0(use "git unstage <file>" to unstage)

This would be extra nice since 'git unstage' could also be used in a
fresh repository.


> But this is a good example of what=E2=80=99s wrong with the way the
> documentation thinks: Git=E2=80=99s implementation perspective should=
 not
> define how concepts are explained. In particular, *tracking* (in the
> sense of making a file known to git) and *staging* are conceptually
> different things. In fact, the two things remain conceptually
> different later on: un-tracking (removing the file from Git=E2=80=99s
> worldview) and un-staging are not the same thing at all, neither
> conceptually nor implementationally.

=46air point, I think.

> The opposite of staging is `git
> reset HEAD <file>` and the opposite of tracking is -- well, I=E2=80=99=
m not
> sure, actually. Maybe `git update-index --force-remove <filename>`?

'git rm --cached'

> The entire quoted paragraph in the tutorial can be removed: there=E2=80=
=99s
> simply no reason to tell the reader that git behaves differently from
> other version control systems

I disagree, many people come from another VCS, and pointing out where
their assumptions are invalid is generally useful.

> There=E2=80=99s another issue with this, namely that =E2=80=9Cadded f=
iles are
> immediately staged=E2=80=9D. In fact, I do understand why Git does th=
at, but
> conceptually it=E2=80=99s pure evil: one of the conceptual conrnersto=
nes of
> Git -- that files can be tracked and changed yet not staged, i.e., th=
e
> staging areas is conceptually a first-class citizen -- is violated
> every time a new file is =E2=80=9Cborn=E2=80=9D. Newborn files are *s=
pecial* until
> their first commit, and that=E2=80=99s a shame, because the first thi=
ng the
> new file (and, vicariously, the new user) experiences is an
> aberration.

Eh, I think it's not an aberration, it's more of a convenience. I
don't think the benefit of making the concept of tracking vs. staging
clear to the user is worth the hassle of having to execute two things
to do one thing (staging a new file). You can also see it the other
way around, why are new files any different from other files? Why
shouldn't you be able to stage new files?

--=20
Cheers,

Sverre Rabbelier
