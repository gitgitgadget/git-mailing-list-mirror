From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Mon, 11 Jun 2007 10:45:33 +0200
Message-ID: <20070611084533.GA24327@artemis.intersec.eu>
References: <20070610140204.GA6730@artemis.madism.org> <46a038f90706101614h48112deel70d848f4312c88d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="MGYHOYXEY6WxJCY8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 10:46:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxfXd-0007nw-Lc
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 10:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229AbXFKIpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 04:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764100AbXFKIpl
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 04:45:41 -0400
Received: from pan.madism.org ([88.191.52.104]:51134 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757229AbXFKIpg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 04:45:36 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 862D9CA6E;
	Mon, 11 Jun 2007 10:45:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0643317605; Mon, 11 Jun 2007 10:45:34 +0200 (CEST)
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90706101614h48112deel70d848f4312c88d7@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49833>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2007 at 11:14:03AM +1200, Martin Langhoff wrote:
> On 6/10/07, Pierre Habouzit <madcoder@debian.org> wrote:
> > On Sun, Jun 10, 2007 at 06:59:13PM +1200, Martin Langhoff wrote:
> >> Adding git & gitweb support to traq, bugzilla, mantis, gforge, etc is
> >> what is going to make the difference. Most of those have already the
> >> ability to "link" to one or more commits -- after the commits are done
> >> and in GIT.
> >
> >  Sure, you can do that and still inherit from the many downsides of
> >those tools: central, needs another separate tool to work with, and a
> >tool that nowadays tends to eat 500Mb of your memory if you take the
> >most hype implementation of it (Yes I'm describing a web browser), that
> >is slow like hell (because yes, there is many clients at the same time
> >on the central server, that is overloaded like hell), and so on.
>
> Most usable BTSs work on lighter webbrowsers, and can be tuned to work
> reasonably. That's not a dead-end per se.

  okay, my point is also that using yet another tool that is neither
integrated in my shell nor in my editor sucks. I use the shell to use
$SCM, and to perform tests of my work, so it's in my workflow. I use the
editor (well do I need to tell why ? :P), I just don't want to use a
browser where the two previous should be enough.

> >  You can like central web UIs, your choice. And I suppose if grit works
> >well, there will be one at some point.
>=20
> Bugtrackers are communication tools between developers and users. In
> many spaces, they are _teaching tools_, teaching the users about info
> developers need. That's why BTSs have explicit fields asking for
> important variables like OS, Arch, and version you are reporting a bug
> against. That's also why the BTS gains a lot from being web-based:
> extreme portability, reachability, zero-install for users.

  Because it's git-based does not implies there won't be a web UI. And
it's not because there is a lot of options to the underlying process
that you need to show them all to the user.

  My experience is also that people never fill informations about OS,
Arch, version properly, because it's tiredsome. debbugs (through
reportbug) approach is excellent: assuming that the user reports the
error from the machine where he experienced it and taking all the
information automatically. _here_ is how it should work for the user,
e.g.: =E2=80=9Cplease download and run that script, and paste the results i=
n your
bug report pretty please ?=E2=80=9D

> >  yeah, that is what bugtrackers already do. Though, that's of no use
> >for release managers. What is useful is what people call "milestones" in
> >trac e.g., meaning a set of bugs that has been flagged as needing to be
> >fixed. And what a release manager need is a tool to deal with this set
> >of bugs as a whole.
>=20
> Hmmm. Most BTSs have milestones, and the integration of the above with
> milestones is useful for release managers.

  How many of those bts'es help the RMs to know if their
soon-to-be-stable branch fits the milestone ? milestones in any BTS I
know are global "yes the fix exists, in this revision (and this
information is not always here)". Sorry but it's worthless.

> How about the _rest_ of the BTS-using populace?

  Okay, who else uses a BTS ? developpers, as I'm a developper, I'll
write a tool that pleases me. Let's say developpers are taken care of.

  Users ? For a user, what should be made easy is reporting, and
interacting with whoever is dealing with the bug on the other end.
Advanced users will want to be able to track discussion about some bugs
they are interested into (meaning that it must be a way to crawl the
bugs database).

  So let's take the three points:
  * reporting: the tools to make reporting fast, efficient, _and_
    useful to the developpers - many many many bug reports suck, hard -
    are very often project dependant: a project in python e.g. won't
    care about the architecture usually (hence forcing it is stupid) but
    will probably mind the OS, python version, distribution, ... Another
    project in C will mind the architecture, but is knowingly working
    only on Linux so won't mind the OS, but would maybe mind the kernel
    version. etc...

    =3D> What can I do ? provide a way to deal with some kind of
       property/values that can be customizeable at the BTS side and
       show some examples of reporting scripts. ttbomk only debbugs and
       reportbug knows how to do that. It does not prevents bad bug
       reports at all, but it makes many that would have been bad almost
       good, at least usable.

  * simplicity to follow up: there isn't 12987123 solutions here. mail,
    mail, mail, mail. A BTS should be able to track mail discussions one
    way or another. For pure-web BTS, there is still mail alerts to say
    "hey $someone has said $sth on your bug $bug". So the user already
    is in his MUA when he receives that, well, "reply"-button is the
    shortest way to answer, make it possible.

  * crawling the database: that one should not be done by the BTS. Every
    BTS on the planet doing that is wrong. There is plenty of good
    search engines (xapian, clucene, ...) just adapt one. And the most
    simple your storage backend is, the simplest it will be.

  What I'm saying is that maybe we don't call BTS the same object. To me
a BTS is a "thing" able to deal with large amounts of bugs in an
efficient way, and is able to deal with some basic things like bug
statuses, and some kind of queries to the database (not the full text
search ones). Then you have the Upper Layer Tools: guis, tracking
scripts, every bling you need. Note that Git is exactly designed this
way: low level tools, and then tools like git-mergetool, gitk, ... that
don't use _any_ git internal, but rather only use the underlying
commands. I want to build the core functions to deal with a BTS, so that
everybody is able to turn this into the BTS workflow he needs.

> >  That's the same argument that Linus has against per-file tracking.
> >Also atm when you e.g. backport a patch that fixes this or this bug,
> >you're no BTS helps you tagging the bug as fixed in that branch as well.
> >Not to mention that BTS I know do not make any use of the commits DAG.
> >And for a very good reason, there is no real DAG in many existing tools
> >(svn, cvs, ...).
>=20
> Making the BTS DAG-aware is overkill.

  Why ?

> The BTS can ask for every update on every branch "what commits does it
> bring into branch X?" and that's all you need. If you backport a patch
> and mention the original patch SHA1 the BTS can do its job.

  or the BTS can do it for you and you would not need to feed him with
the sha directly.

> And all of that can be done SCM-agnostic - except for the regex to
> spot a commitid.

  Sure, there is projects doing that out there, I believe they are
wrong. Portability is important. I mean, when you write a tool, that has
a purpose, yes you must try to make it available everywhere. That's why
there are people trying hard to make git build and work on windows.

  But when you write a tool to help _you_ work, there is now need to
make it work for every workflow in the planet, because that would mean
align yourself to the lowest common denominator of the workflows you can
work with. That's not an acceptable trade-off. Why would I have to
support cvs or svn ? I don't use them. I just don't care about them.
Wherever place I'll work in, I'll use git. Sorry but full genericity
(because it's what we are talking about, not portability) is an
impediment, not an enabler.

> >  You're a lucky guy. All bug trackers I've used suck a way or another,
> >that impedes my workflow a lot. Let's cite a couple:
>
> Ok - but BTSs are a compromise, something that must work for users,
> and developers.

  I don't think it needs to be a compromise.

> >> Bugtrackers are co-owned by developers, users and (where they exist)
> >> project managers.
> >
> >  That's exactly why distributed rock. Because everyone could _really_
> >own _his_ bugtracker. This solves the same range of ACLish issues git
> >solves with respect to the code.
>=20
> Don't think I've seen politics over who owns the bugtracker ;-) but I
> _have_ seen politics over specific bugs (developers close unfixed
> bugs, flamefests ensue). I guess with a DBTS everyone can have their
> own status for the bug... but does that help the user? Or the
> developer?

  That one is easy. Indeed, the big politics in bugtrackers are ...
severity-ping-pong, or close-wars. Good example of that is btw:
http://sourceware.org/bugzilla/show_bug.cgi?id=3D4509.

  Okay, what would we gain in a DBTS: developer would still be (sorry)
a perfect asshole with the user. That is a thing we cannot fix. Though,
the release manager will probably disagree with him. So this bug that
_he_ considers non existant will be closed in his repository, but still
remain open in the main one. Meaning that if another developer steps up,
he'll see this issue is not fixed. Else nobody will have any chance to
step up, ever.

  The reverse works equally well: if RM decides bugs have to be closed,
developer is able to reopen the bugs (or not merge) in his repository,
so that he can have a chance to fix them.

  Yes there is politics in BTSes, and yes it can help.

> > > And at git's end we can get the smooth integration using/abusing
> > > that loose coupling strategy. So if git-log/gitk/qgit grow some
> > > hooks that can be used to perform a lookup... I can think of a
> > > perl script that gets events for each SHA1 that git-rev-list
> > > produces and returns one bug number, url and title (or more than
> > > one) that then git-log / gitk / qgit / annotate can use to further
> > > "decorate" the commit info in a similar style to what gitk is
> > > doing now with head names in each commit.
> > >
> > > Would that fit your vision of a nicely integrated tracker?
> >
> >  Honestly ? No, because that would be horribly slow (but I'd love to be
> >proven wrong).
>
> What part would be slow?

  The perl scripts. It would perceptibly slow down commits. And I don't
want that now that I finally have a fast SCM. I just don't want to turn
git into bzr.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbQutvGr7W6HudhwRAp/DAJ9NLCSCxm0YlZ+g+tuD0GuBzNQLFQCfazJu
V/TalarT7uVzOolL+ehGz6Q=
=3TvW
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
