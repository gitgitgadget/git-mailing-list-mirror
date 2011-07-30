From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Sat, 30 Jul 2011 23:55:27 +0200
Message-ID: <1312062927.3261.334.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>	<4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
	 <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
	 <4E0A08AE.8090407@web.de>  <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com>  <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com>  <4E34122B.5020509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 30 23:53:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnHTD-0003qC-HG
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 23:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab1G3VwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 17:52:24 -0400
Received: from mail14.surf-town.net ([212.97.132.54]:34838 "EHLO
	mailgw21.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752782Ab1G3VwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 17:52:22 -0400
Received: by mailgw21.surf-town.net (Postfix, from userid 65534)
	id AB636418B; Sat, 30 Jul 2011 23:52:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw21.surf-town.net (Postfix) with ESMTP id 831B5418B;
	Sat, 30 Jul 2011 23:52:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw21.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw21.surf-town.net ([127.0.0.1])
	by localhost (mailgw21.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QMiUfhpPgCyg; Sat, 30 Jul 2011 23:52:14 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw21.surf-town.net (Postfix) with ESMTPSA id 3886A40CC;
	Sat, 30 Jul 2011 23:52:10 +0200 (CEST)
In-Reply-To: <4E34122B.5020509@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178220>

Le samedi 30 juillet 2011 =C3=A0 16:16 +0200, Jens Lehmann a =C3=A9crit=
 :
> Am 29.07.2011 11:39, schrieb henri GEIST:
> > Le jeudi 28 juillet 2011 =C3=A0 18:48 +0200, Jens Lehmann a =C3=A9c=
rit :
> >> Am 28.07.2011 10:57, schrieb henri GEIST:
> >=20
> > It is not a matter of disabling any control of git in its own
> > repository.
> > It is just a matter of adding inside the git repository a reference
> > (dependency) to an other git repository.
>=20
> ... which you want to have *outside* of the containing repository!

yes

> That will then be registered in other git repositories too in your mo=
del,
> which gets rid of the "one file/submodule, one repo" assumption we no=
w have
> and will introduce ambiguities which are *really* hard to handle.
>=20

I am sorry, I am not a native English speaker. This sentence is to
complex for me. And google translator is of no help in this case.

> >>> This pach :
> >> <snip>
> >>>   - Still forbids to add anything else.
> >>
> >> Why? If you let submodules live outside the tree I don't see any r=
eason why
> >> regular files shouldn't live there too (Disclaimer: I d not think =
that would
> >> be a good idea either ;-).
> >=20
> > there is regular file in the submodule repository but they are cont=
roled
> > by the submodule itself. Then the main repository do not need to ha=
ndle
> > them.
> >=20
> > Just like you I think that regular file should not be touche outsid=
e of
> > the repository by git.
>=20
> No, I think we should /either/ allow gitlinks *and* files to live out=
side of
> the repository /or/ *none* of them, as they have a lot in common (and=
 I'm
> working on making them to behave as similar as possible). And in the =
use case
> you describe here it is totally irrelevant if you dependency consists=
 of a
> directory tree in a submodule (=3D a bunch of files) or just a single=
 file (say
> a header containing project wide definitions).
>=20

Yes they have a lot in common but they still have a different nature.
git links pointer (not files on a hard-drive) to something which has a
special meaning for git, (a git repository).
Just like the .git directory which also have a special handling.

But I agree the step is really weak before enabling to put any regular
file outside of the directory.
I do not see any reasonable workflow (to my eyes) for it but' maybe som=
e
day someone will came with a justifiable workflow which need it. we wil=
l
never know.

But in this case we need solve some questions :
  - Will we extend git status signaling untracked files out of the
    repository ?
  - What will do git-clean ? it is already dangerous inside the
    repository. and it will be worst if it can access outside of it.

May be some other points that I do not see for the moment.

> > Because in this case it is not just a reference that is managed but=
 the
> > file itself. And this way there is a risk to overwrite some data no=
t
> > under revision control outside of the repository.
>=20
> You have the same risk when a gitlink points outside, as a submodule =
is a
> way of controlling a bunch of files through that reference. And the f=
ile
> would be under version control in the repository where it is register=
ed, no?
>=20

I agree on this point.

But they are still confined in an another git repository not
disseminated all over the file system.
And it never corrupt this pointed repository. just ask it to do by it's
own regular git commands.

In fact you can argue that it can disseminate some complete git
repository anywhere in the file system.
And you will be right. (nothing is perfect.)

I can do a second patch to prevent git submodule command to make clones
outside of the repository.
It will requires the user to do those clones manually.
In fact this is already what I do.
My only use of this is to track dependencies.
=20
> > And in fact it is just what I want, it enable me if I decide to wor=
k on
> > an optional "BigProject" depending on both project 1 & 2.
> >=20
> > Then If lib1 is in version M:
> >  - a git status in project2 will say nothing
> >  - a git status in project1 will say
> >    "modified:   ../lib1 (modified content)
> >  - a git status in BigProject will say
> >    "modified:   ../project1 (modified content)
> >=20
> > Then I know that I need to update project1 to work with the last ve=
rsion
> > M of lib1.
>=20
> Maybe no update for project1 is needed, because M only contains a bug=
fix
> which doesn't even need a recompilation of project1. But now you need=
 to
> add a commit to project1 nonetheless with a message like "Updated lib=
1
> with a bugfix which is needed by project2" which makes your idea of
> independent submodules break down.
>=20

In fact I work ni the world of "high integrity programming" then It is
just what I need.
If there is a bugfix in any library, used by the program it is no more
the same program.
I need the "SHA1" to correspond to the exact and complete source code
involved in my executable.

And this way the "SHA1" of the project sign the "SHA1" of the
libraries.=20

> >> You are opening a can of worms by having two different repos point=
 to the same
> >> submodule living in a third repo (which also happens to be their s=
uperproject
> >> and must somehow ignore it). You'll have two SHA1s for a single su=
bmodule;
> >> "git submodule foreach --recursive" will have interesting results =
too; and so
> >> on. Not good.
> >=20
> > As I just said before it is my purpose to do it like that.
>=20
> I understood that, but what are you proposing to do to solve all the
> problems your approach introduces? You can't just hand wave them away=
=2E
>=20

There is some solutions :

  - First it is one more **feature** if it does not correspond to your
    work flow it does not prevent you to work exactly the way you did
    until now.

  - Second if you want to use the feature but not want to have the
    conflict **feature** (for me it is one), just put the independent
    project with there libs in different directory

      -+- foo -+- lib1     (in version N)
       |       +- project1
       |
       +- bar -+- lib1     (in version M)
               +- project2

  - Third if you really need to have project 1 & 2 in the same
    directory foo, that means they are needed by a third BigProject in
    the same directory foo depending on project 1 & 2.
    And then you really need git to declare a conflict.

> > Let say a concret exemple
> >=20
> > 3 different teams work on libtiff, libpng, and libjpeg they are tot=
ally
> > unrelated.
> >=20
> > One more team is working on the "gimp". And they need those 3 libs =
in
> > specific versions not necessarily there heads.
> >=20
> > One other unrelated team is working on "gqview" and need the same l=
ibs
> > in other specifics versions (Why should they know what te gimp team
> > does)
> >=20
> > Neither "gimp" and "gqview" project will contain directory with tho=
se
> > libs inside. They just depend on them.
> >=20
> > And the last team work on the gnome project which need the "gimp" a=
nd
> > "gqview". It will be this team witch have to care about having both
> > "gimp" and "gqview" sharing the same libs version>
> > And has well the gnome project will not contain "gqview" and "gimp"=
 in
> > its own tree.
> > It will also depend on them.
>=20
> Cool, that is a real life example resembling what we have a my dayjob=
=2E But
> a "gimp" and "gqview" project will only have dependencies like "use l=
ibpng
> of version 1.2.3 or newer (because we need a feature/bugfix introduce=
d
> there)" and won't be tied to a special version of that library. This =
means
> they need a dependency like "SHA1 or newer" instead of "exactly this =
SHA1".
>=20

It is useful and simpler to work like this but could introduce some
bugs.

The "gimp" team has tested it with libpng 1.2.3 and maybe know that it
did not work with previous versions but if they do not have any crystal
ball they never know if newer versions will not break something.
In fact I doubt that the first version of gimp will work with the last
version of libpng.

> > It is just the same with aptitude on debian.
> > Each package know there dependency by themselves, does not contain =
there
> > dependencies, and do not need a bigger superpackage to tell them wh=
at
> > are there own dependencies.
>=20
> And this is a very good point for the "version x.yy-z *or newer*" arg=
ument,
> they are /never/ tied to the /exact/ x.yy-z version, as that would ma=
ke the
> dependencies pretty much unusable. They use a "newer than x.yy-z" sch=
eme.
>=20

It is an other feature that the one I need.
But it is a good idea.

Nothing prevent us to make a patch to add a new test in git status to
see if the current SHA1 in the libpng repository has the SHA1 of the
gitlink in the gimp in its ancestor.


>=20
> > And Still I realy want to have every project knowing there own
> > dependency by themselves and not needing an external superproject t=
o
> > tell them what they need.
>=20
> I want to have that too! I'm just convinced using a gitlink to achiev=
e that
> is wrong in so many ways. I'd rather prefer to express such dependenc=
ies in
> something like a config file, and I believe they should not be as str=
ict as
> "I need exactly that version" but rather like "this version or newer =
(and by
> the way: we of course only tested that specific version ;-)". These
> dependencies could then be checked and displayed by git status.
>=20

It effectively could be in a config file it seem good to me as well.

But if git handle this config file.
Update it on a "git add ../libpng && git commit"
And control the matching between the project and libraries on
"git status">

I can not see the difference with a gitlink.

	Henri GEIST
