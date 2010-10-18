From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Mon, 18 Oct 2010 14:57:19 -0700 (PDT)
Message-ID: <m3ocar5fmo.fsf@localhost.localdomain>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 23:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7xhx-0002dv-5K
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 23:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502Ab0JRV5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 17:57:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48890 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878Ab0JRV5W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 17:57:22 -0400
Received: by ewy20 with SMTP id 20so2428835ewy.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ZH1QbBkRmLUBJIWEgMI2phg0VAsG2gInKjI0PE18Jww=;
        b=V0w2/RfQGzIUubuaL9Zzbh6N3F54QCDWvzkjaoOl3z0SdlZ+KejyipjSruifaWLonF
         JcLSSmj8EpdN+JKJFkWfVERg6ow4Xjyhj6g0uz0+HTISNfdy8hZiPE1Q3PpFuVcD8ke0
         Gv3m1J7IZxRpVSMqHLaRi7iJMN4Ugvkn6AP/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=WLiamd5ZWf4S2Xjr+RMAaMl4PT82B8vuatuymb51apKpOAKUd/khKgSUv/RjF9Vs1/
         F8UL4FqVW2GbF18TUcDZvC4BRbRWIKDCU3mDNXRo17ZYffdNbDaC9/MihAuZa4DY5H58
         GjcmhUvQEYIYCi6+hkbU8voy408rghi6949bg=
Received: by 10.213.2.209 with SMTP id 17mr4817282ebk.37.1287439040810;
        Mon, 18 Oct 2010 14:57:20 -0700 (PDT)
Received: from localhost.localdomain (abwp24.neoplus.adsl.tpnet.pl [83.8.239.24])
        by mx.google.com with ESMTPS id b52sm1935193eei.13.2010.10.18.14.57.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 14:57:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9ILuxUO000601;
	Mon, 18 Oct 2010 23:57:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9ILumWT000597;
	Mon, 18 Oct 2010 23:56:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159292>

Thore Husfeldt <thore.husfeldt@gmail.com> writes:

> I=92ve just learned Git. What a wonderful system, thanks for building
> it.=20
>=20
> And what an annoying learning experience.=20
>=20
> I promised myself to try to remember what made it all so hard, and to
> write it down in a comprehensive and possibly even constructive
> fashion. Here it is, for what it=92s worth. Read it as the friendly, =
but
> somewhat exasparated suggestions of a newcomer. I=92d love to help (i=
n
> the form of submitting patches to the documentation or CLI responses)=
,
> but I=92d like to test the waters first.

Thank you very much for writing those down.  It is very helpful for
us, which are used to Git and know by heart its sometimes obscure
jargon, and might not notice that it is hard to understand.
=20

> Remote (tracking) branches
> --------------------------
>=20
> There are at least two uses of the word *tracking* in Git's
> terminology.
>=20
> The first, used in the form `git tracks a file' (in the sense that Gi=
t
> knows about the file) is harmless enough, and is handled under `git
> add` below.

In this sense of "tracked", i.e. "tracked file", it means that given
file is versioned / is under version control.

Though I don't think we use `git tracks a file` anywhere in the
documentation and messages (at least I hope so); we use `tracked file`.
I think it is all right for `tracked file` and `"tracked" branch`
to mean different things.


> But the real monster is the *tracking branch*, sometimes called the
> remote branch, the remote-tracking branch, or the remote tracking
> branch.  Boy did that ever confuse me. [...]
>=20
> Please, *please* fix this. It was the single most confusing and
> annoying part of learning Git.
>=20
> First, the word, "tracking". These branches don=92t track or follow
> anything.  They are standing completely still.  Please believe me tha=
t
> when first you are led to believe that origin/master tracks a branch
> on the remote (like a hound tracks it quarry, or a radar tracks a
> flight) that it is very difficult to hunt this misunderstanding down:
> I believed for a long time that the tracking branch stayed in sync,
> automagically, with a synonymous branch at the remote.

But those 'remote-tracking branches' are *used* to track where there
are branches in remote repository.

Sidenote: give thanks that you didn't start to use git before version
1.5.0, when so called "separate remote" layout was made default (which
means tracking branch 'foo' in remote 'origin' using 'origin/foo'
remote-tracking branch).

[...]

> The hyphenated *remote-tracking* is a lot better terminology already
> (and sometimes even used in the documentation), because at least it
> doesn't pretend to be a remote branch (`git branch -r`, of course,
> still does). So that single hyphen already does some good, and should
> be edited for consistency. [...]

The name 'remote-tracking branch' is the name we arrived at after long
discussions not that long time ago, and it is a name that should be
used thorough the documentation.  It is ongoing effort.

> [...] It may be that terminology is slowly converging. (To something
> confusing, but still...)

[...]

> More radically, I am sure some head scratching would be able to find
> useful terminology for master, origin/master, and origin=92s master. =
I=92d
> love to see suggestions. As I said, I admire how wonderfully simple
> and clean this has been implemented, and the documentation, CLI, and
> terminology should reflect that.

There is also additional complication that you can have the same
relation that local branch 'master' has to 'origin/master'
remote-tracking branch with two local branches.

We nowadays say that 'origin/master' is "upstream" for 'master'
branch; we used to say that 'master' branch "tracks" 'origin/master'
branch (which can be seen in the name of `--track' option to=20
'git branch').
=20
> The staging area
> ----------------
>=20
> The wonderful and central concept of staging area exists under at
> least three names in Git terminology. And that=92s really, really
> annoying. The index, the cache, and the staging area are all the same=
,
> which is a huge revelation to a newcomer.

This inconsistence is results of historical issues; the concrete
object that is used as mediator betweeb working area and repository
was first called 'dircache', and now is called 'the index'.

There was strong push towards replacing 'index' and 'cache' by
'staging area' (and 'to stage' as verb), but it meets with some
resistance.


> 2. Introduce the alias `git unstage` for `git reset HEAD` in the
> standard distribution.

That is IMHO a very good idea.  The `git unstage <file>` form
describes what we want to achieve (user story), while `git reset HEAD
<file>` requires us to know what operation must we do in order to
remove staged changes from a file.
=20
> 3. Duplicate various occurences of `cached` flags as `staged` (and
> change the documentation and man pages accordingly), so as to have,
> e.g., `git diff --staged`.

Note that it is not as easy as it seems at first glance.  There are
*two* such options, which (as you can read in gitcli(7) manpage) have
slightly different meaning:

 * The `--cached` option is used to ask a command that
   usually works on files in the working tree to *only* work
   with the index.  For example, `git grep`, when used
   without a commit to specify from which commit to look for
   strings in, usually works on files in the working tree,
   but with the `--cached` option, it looks for strings in
   the index.

 * The `--index` option is used to ask a command that
   usually works on files in the working tree to *also*
   affect the index.  For example, `git stash apply` usually
   merges changes recorded in a stash to the working tree,
   but with the `--index` option, it also merges changes to
   the index as well.

Some commands like `git apply` support both (though not at the same
time).


> git status
> ----------

[...]
> 2.
>     Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>=20
> should be
>=20
>     Untracked files:
>     (use "git track <file>" to track)

To "track a file" means to put a file under version control (to
version control the file).

Note also that "git track <file>" would be "git add -N <file>"=20
(where `-N` is `--intent-to-add`), which only marks a file to be
tracked / versioned, but doesn't stage its contents.
=20
> Adding
> ------
>=20
> The tutorial tells us that=20
>=20
>     Many revision control systems provide an add command that tells
>     the system to start tracking changes to a new file. Git's add
>     command does something simpler and more powerful: git add is used
>     both for new and newly modified files, and in both cases it takes
>     a snapshot of the given files and stages that content in the
>     index, ready for inclusion in the next commit.
>=20
> This is true, and once you grok how Git actually works it also makes
> complete sense. `Making the file known to Git' (sometimes called
> `tracking the file') and `staging for the next commit' result in the
> exact same operations, from Git=92s perspective.
>=20
> But this is a good example of what=92s wrong with the way the
> documentation thinks: Git=92s implementation perspective should not
> define how concepts are explained. In particular, *tracking* (in the
> sense of making a file known to git) and *staging* are conceptually
> different things.

But they are not independent.  When you stage contents of a file which
was not known to git, it is automatically made "tracked" i.e. put
under version control.  Obvious.

>                    In fact, the two things remain conceptually
> different later on: un-tracking (removing the file from Git=92s
> worldview) and un-staging are not the same thing at all, neither
> conceptually nor implementationally. The opposite of staging is `git
> reset HEAD <file>` and the opposite of tracking is -- well, I=92m not
> sure, actually. Maybe `git update-index --force-remove <filename>`?

`git rm <filename>` to remove it both from staging area, and working
area, or `git rm --cached <filename>` to remove it only from staging
area, which means that it is removed from version control but kept on
disk.

[...]

> Fixing this requires no change to the implementation. `git stage` is
> already a synonym for `git add`. It merely requires discipline in
> using the terminology of staging. Note that it completely valid to
> tell the reader, maybe immediately and in a footnote, that `git add`
> and `git stage` *are* indeed synonyms, because of Git=92s elegant
> model. In fact, given the amount of documentation cruft one can find
> on the Internet, this would be a welcome footnote.
>=20
> An even more radical suggestion (which would take all of 20 seconds t=
o
> implement) is to introduce `git track` as another alias for `git
> add`. (See above under `git status`). This would be especially useful
> if tracking *branches* no longer existed.

Well, there is different suggestion: make `git stage`, `git track` and
`git mark-resolved` to be *specializations* of `git add`, with added
safety checks: 'git stage' would work only on files known to git /
under version control already, 'git track' would work only on
untracked files (and do what 'git add -N' does), and 'git mark-resolved=
'
would work only on files which were part of a merge conflict.
=20
> There=92s another issue with this, namely that =93added files are
> immediately staged=94. In fact, I do understand why Git does that, bu=
t
> conceptually it=92s pure evil: one of the conceptual conrnerstones of
> Git -- that files can be tracked and changed yet not staged, i.e., th=
e
> staging areas is conceptually a first-class citizen -- is violated
> every time a new file is =93born=94. Newborn files are *special* unti=
l
> their first commit, and that=92s a shame, because the first thing the
> new file (and, vicariously, the new user) experiences is an
> aberration. I admit that I have not thought this through.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
