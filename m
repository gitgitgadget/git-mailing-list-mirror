From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 02 Aug 2011 14:19:44 +0200
Message-ID: <1312287584.3261.798.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>	<4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
	 <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
	 <4E0A08AE.8090407@web.de>  <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com>  <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com>  <4E34122B.5020509@web.de>
	 <1312062927.3261.334.camel@Naugrim.eriador.com>  <4E370107.3050002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 02 14:16:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDu2-0008UL-BO
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 14:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab1HBMQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 08:16:52 -0400
Received: from mail14.surf-town.net ([212.97.132.54]:41119 "EHLO
	mailgw3.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754284Ab1HBMQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 08:16:39 -0400
Received: by mailgw3.surf-town.net (Postfix, from userid 65534)
	id D71201236F8; Tue,  2 Aug 2011 14:16:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw3.surf-town.net (Postfix) with ESMTP id 6EE771236F8;
	Tue,  2 Aug 2011 14:16:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw3.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw3.surf-town.net ([127.0.0.1])
	by localhost (mailgw3.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IjrxtagyhpZV; Tue,  2 Aug 2011 14:16:30 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-37-125.w92-141.abo.wanadoo.fr [92.141.172.125])
	by mailgw3.surf-town.net (Postfix) with ESMTPSA id 5BBCC1398DA;
	Tue,  2 Aug 2011 14:16:24 +0200 (CEST)
In-Reply-To: <4E370107.3050002@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178464>

Le lundi 01 ao=C3=BBt 2011 =C3=A0 21:39 +0200, Jens Lehmann a =C3=A9cri=
t :
> Am 30.07.2011 23:55, schrieb henri GEIST:
> > Le samedi 30 juillet 2011 =C3=A0 16:16 +0200, Jens Lehmann a =C3=A9=
crit :
> >> Am 29.07.2011 11:39, schrieb henri GEIST:
> >>> Le jeudi 28 juillet 2011 =C3=A0 18:48 +0200, Jens Lehmann a =C3=A9=
crit :
> >>>> Am 28.07.2011 10:57, schrieb henri GEIST:
> >=20
> >> That will then be registered in other git repositories too in your=
 model,
> >> which gets rid of the "one file/submodule, one repo" assumption we=
 now have
> >> and will introduce ambiguities which are *really* hard to handle.
> >=20
> > I am sorry, I am not a native English speaker. This sentence is to
> > complex for me. And google translator is of no help in this case.
>=20
> Your proposal of letting multiple gitlinks in different repos point t=
o the
> same submodule will break the assumption that each file is only handl=
ed by
> a single git repo.

I Agree

This is not an issue for me but I can understand that it could be for
some one else. Even if I do not see why. As it only do it for other git
repository that you already now they could have there own autonomous
live.

> For example when you have a conflict and do a "git
> submodule update --recursive" in the superproject, the SHA1 used for =
"lib"
> will depend on the alphabetical order of "project1" and "project2".

Exact.

> And normally after running "git submodule update --recursive" you exp=
ect all
> submodules of the superproject to be clean.

Not me. and the next "git status" will immediately tell me.
I do not know about you but "git status" is for me a reflex after any
important command.

> But your change breaks this expectation, it will still contain unclea=
n
> submodule entries even though you just told git it should clean them.
> What will a "git submodule sync --recursive" do when "project1" and
> "project2" use different urls in their gitmodules? And so on.

I suspect exactly the same conflict as with "git submodule update
--recursive" or any recursive submodule management.
But again if I deliberately chose this model I know what I am doing.

> Commands won't always behave like you expect them to and sometimes wi=
ll
> give different results just because different names are used. That's =
what
> I meant with ambiguities and that's why I don't think gitlinks are th=
e
> right method here.

I am sorry. but I do not understand the relation with names.

> > But I agree the step is really weak before enabling to put any regu=
lar
> > file outside of the directory.
> > I do not see any reasonable workflow (to my eyes) for it but' maybe=
 some
> > day someone will came with a justifiable workflow which need it. we=
 will
> > never know.
> >=20
> > But in this case we need solve some questions :
> >   - Will we extend git status signaling untracked files out of the
> >     repository ?
>=20
> I don't think that would work well.
Me to but it is not me to decide.
>=20
> >   - What will do git-clean ? it is already dangerous inside the
> >     repository. and it will be worst if it can access outside of it=
=2E
>=20
> Hopefully git clean will learn the --recurse-submodules option in the=
 not
> too distant future, then you will have just the same danger for the f=
iles
> inside a submodule.

Then this command will be once again more dangerous.
But it was before and pepole using it already knows then I suspect it i=
s
not worst than before.

> > But they are still confined in an another git repository not
> > disseminated all over the file system.
> > And it never corrupt this pointed repository. just ask it to do by =
it's
> > own regular git commands.
>=20
> The only difference here is that a submodule can contain more than on=
e file,
> but you can corrupt those files just as easily as a single file using=
 git
> commands.

Your right.

> > I can do a second patch to prevent git submodule command to make cl=
ones
> > outside of the repository.
> > It will requires the user to do those clones manually.
> > In fact this is already what I do.
> > My only use of this is to track dependencies.
>=20
> But gitlinks are more than simple dependencies, they are followed! "g=
it
> submodule", status, diff and fetch already follow them. push is learn=
ing
> that right now. checkout, reset, merge and friends are being taught t=
hat
> too (see the enhance_submodule branch in my github repo for the curre=
nt
> state). So a gitlink is more than just a simple reference, it is foll=
owed
> by a lot of commands and the submodule it points to is manipulated by
> those commands. We had a patch for "git archive --recurse-submodules"=
 on
> the list, what will that do when used in "project1"?

I think your right. I will make a parallel way not using gitlinks but
something similar which is not followed!

> > In fact I work in the world of "high integrity programming" then It=
 is
> > just what I need.
> > If there is a bugfix in any library, used by the program it is no m=
ore
> > the same program.
> > I need the "SHA1" to correspond to the exact and complete source co=
de
> > involved in my executable.
> >=20
> > And this way the "SHA1" of the project sign the "SHA1" of the
> > libraries.=20
>=20
> I cannot believe you want single commits in your "Gimp" repo for ever=
y
> combination of distributions and library versions where someone said
> "this works". This is insane and won't scale at all.
>=20

That is exactly what I do. but my team is only 9 people.
But we do not make a commit for each possible solution.
It. is only when I work on gimp to improve it that I made a commit whic=
h
is update for the ne libpng. but between to commit on the gimp there ma=
y
bu 10 update of libpng an I do not do a commit for each of them only th=
e
last stable one.

It is only on the gnome project that I also need tu update my old
version of gqview to work with the libpng used by gimp but as long I do
not work on gnome I do not need to synchronize them.

But I write aircraft autopilot and if I am not at least as strict as
that. The certification department of the FAA and EASA will reject my
code and my boss will fire me.

> What you do is that each distribution tests their combination of prog=
rams
> and libraries and says "that works". And that is why the only sane wa=
y to
> record this "high integrity programming" test result is in the superp=
roject
> (=3D distribution) and not in each of the program repositories.
>=20
> I also see that it would be cool when a program could record "I do wo=
rk with
> that library version, if you use another you are on your own". But it=
 will
> never say "I only work with *this* specific library version", which i=
s what
> your proposal is trying to do.

No git status only said "modified:   ../libpng (new commits)"
=46or me modified just mean "you are on your own" It do not prevent to
compile, execute or do anything else.

> >> I understood that, but what are you proposing to do to solve all t=
he
> >> problems your approach introduces? You can't just hand wave them a=
way.
> >=20
> > There is some solutions :
> >=20
> >   - First it is one more **feature** if it does not correspond to y=
our
> >     work flow it does not prevent you to work exactly the way you d=
id
> >     until now.
> >=20
> >   - Second if you want to use the feature but not want to have the
> >     conflict **feature** (for me it is one), just put the independe=
nt
> >     project with there libs in different directory
> >=20
> >       -+- foo -+- lib1     (in version N)
> >        |       +- project1
> >        |
> >        +- bar -+- lib1     (in version M)
> >                +- project2
> >=20
> >   - Third if you really need to have project 1 & 2 in the same
> >     directory foo, that means they are needed by a third BigProject=
 in
> >     the same directory foo depending on project 1 & 2.
> >     And then you really need git to declare a conflict.
>=20
> No you don't. You just need to git to tell you: this is not the versi=
on I
> was tested against, repeat the tests to be sure.
>=20

That is just what it will do.

> >> Cool, that is a real life example resembling what we have a my day=
job. But
> >> a "gimp" and "gqview" project will only have dependencies like "us=
e libpng
> >> of version 1.2.3 or newer (because we need a feature/bugfix introd=
uced
> >> there)" and won't be tied to a special version of that library. Th=
is means
> >> they need a dependency like "SHA1 or newer" instead of "exactly th=
is SHA1".
> >=20
> > It is useful and simpler to work like this but could introduce some
> > bugs.
>=20
> But that model is awfully successful and is used by all distributions=
 I know,
> so I suspect it is not that dangerous (especially when you do your ow=
n QA).
>=20

Depending of how critical is a bug.
=46or an image manipulation programme the ratio effort/needed safety is=
 in
the favor of your approche.

But will you be confident if the nuclear power-plant 50 km from you use
this kind of devloppement to contr=C3=B4le the uranium bars ?
=20
In any case in my workflow it is not about testing and not seeing
obvious bugs. It is about having a development process that permit to
prove there is obviously no bugs. And that model obviously break the
proof process.

> > The "gimp" team has tested it with libpng 1.2.3 and maybe know that=
 it
> > did not work with previous versions but if they do not have any cry=
stal
> > ball they never know if newer versions will not break something.
> > In fact I doubt that the first version of gimp will work with the l=
ast
> > version of libpng.
>=20
> But in the real world it is exactly like that: gimp will work with al=
l libpng
> 1.2.3 and newer, only when libpng is updated to 2.0.0 you have to che=
ck that
> again. Of course there will be bugs in some combinations. But the adv=
antage of
> being able to then only fix libpng and have the bug fixed in Gimp wit=
hout
> having to change it is far greater than the possible problem you are =
describing
> here.
>=20

In this case the commit is not about a change in gimp code, but is a
stamp to validate the use of gimp with this new version of libpng is
certified.
But just like in your current use of submodules.

> >>> It is just the same with aptitude on debian.
> >>> Each package know there dependency by themselves, does not contai=
n there
> >>> dependencies, and do not need a bigger superpackage to tell them =
what
> >>> are there own dependencies.
> >>
> >> And this is a very good point for the "version x.yy-z *or newer*" =
argument,
> >> they are /never/ tied to the /exact/ x.yy-z version, as that would=
 make the
> >> dependencies pretty much unusable. They use a "newer than x.yy-z" =
scheme.
> >=20
> > It is an other feature that the one I need.
> > But it is a good idea.
> >=20
> > Nothing prevent us to make a patch to add a new test in git status =
to
> > see if the current SHA1 in the libpng repository has the SHA1 of th=
e
> > gitlink in the gimp in its ancestor.
>=20
> To make that feature useful for others (e.g. at my dayjob) this would=
 be
> necessary. And we would never want the exact SHA1 match, even though =
that
> information might be what others (like you) want.
>=20

Ok I will do it.


> > But if git handle this config file.
> > Update it on a "git add ../libpng && git commit"
>=20
> I'm not sure an automatic update at "git commit" would be the right t=
hing to
> do, as I think that should only happen after all tests have run succe=
ssful,
> not at the time you commit it. But anyways, that could be done with a=
 post
> commit hook. Or the test script can do it when it succeeded.
>=20

I am sorry "make && make test && git add ../libpng && git commit"

> > And control the matching between the project and libraries on
> > "git status".
>=20
> An extension to "git status" to display the dependencies that aren't =
met is
> a valid goal. What about starting with a script ("git depends"?) and =
then see
> what can go into status?
>=20
> > I can not see the difference with a gitlink.
>=20
> Then you can just use a config file for that, no? ;-)
>=20

Off corse, I immediately start to work on it.

	Henri GEIST
