From: Guillaume DE BURE <guillaume.debure@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 23:01:28 +0100
Message-ID: <2308646.YNvKSAecjO@localhost>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMK1S_j_F6PQ73zUP9QaDBR6FVd7fMY==D9vxwpwVwRUbfkB4Q@mail.gmail.com> <CAJDDKr7r5iP_LpXAT9Xz35GOfbDuDxSAKUvx=4dxa2LE_GLgrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>, esr@thyrsus.com,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 23:01:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdTE1-0000bN-Rf
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 23:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab2K0WBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 17:01:36 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:54449 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab2K0WBe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 17:01:34 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so4188910wer.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=/vAJsKQNsY3QuTF20S8DQBh3SAN9qPssP4d+atzgrXM=;
        b=zC9Lgaupr84gRGVKjt5B4zPHsncZX5hGIuAwKuakc2ebN32JXm0uuHrI3sRLUZEHxq
         nqlkaywZVuJdD5rp8xTVNwlV895QduC7leTHUNmCdkksiIujFnO4f4HryBr/8ct30YAY
         vH7I+8r12H972B+xaMnOPd5S2ECktAfBPjLHREpF9RxoVyZG2AhPXUMxpNV8fM3egvuO
         Lq59ugh2iLObCZ9Vi7jr8ELfmY7wkNCItHUYJKgPSzNdYHnQKeQbYNQuKUEFWVg6tZPu
         tyWbAsbKsTTSlLBQvE06bMO9E2yb6AyDBG//I7dYoM9O6j03FP4Oo4M91TZxCHnYDSWg
         sBYQ==
Received: by 10.216.88.12 with SMTP id z12mr6466745wee.136.1354053693276;
        Tue, 27 Nov 2012 14:01:33 -0800 (PST)
Received: from localhost.localnet (2a02-8420-6742-bf00-0223-14ff-fe4d-0790.rev.sfr.net. [2a02:8420:6742:bf00:223:14ff:fe4d:790])
        by mx.google.com with ESMTPS id dm3sm4318430wib.9.2012.11.27.14.01.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 14:01:32 -0800 (PST)
User-Agent: KMail/4.10 beta1 (Linux/3.6.7-1-ARCH; KDE/4.9.80; x86_64; ; )
In-Reply-To: <CAJDDKr7r5iP_LpXAT9Xz35GOfbDuDxSAKUvx=4dxa2LE_GLgrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210608>

Le mardi 27 novembre 2012 02:51:04 David Aguilar a =E9crit :
> On Tue, Nov 27, 2012 at 1:17 AM, Sitaram Chamarty <sitaramc@gmail.com=
>=20
wrote:
> > On Tue, Nov 27, 2012 at 1:24 PM, David Aguilar <davvid@gmail.com> w=
rote:
> >> *cough* git-cola *cough*
> >>=20
> >> it runs everywhere.  Yes, windows too. It's written in python.
> >> It's been actively maintained since 2007.
> >>=20
> >> It's "modern" and has features that don't exist anywhere else.
> >>=20
> >> It even has tests.  It even comes with a building full of willing
> >> guinea-pigs^Wtesters that let me know right away when
> >> anything goes wrong.
> >>=20
> >> It uses Qt but that's really the whole point of Qt -> cross-platfo=
rm.
> >> (not sure how that wiki page ended up saying Gnome/GTK?)
> >>=20
> >> The DAG aka git-dag (in its master branch, about to be released)
> >> is nicer looking then gitk IMO.  gitk still has some features
> >> that are better too--there's no silver bullet, but the delta
> >> is pretty small.
> >=20
> > Gitk does a lot of things that people don't realise, since they're =
not
> > really documented and you have to scrounge around on the UI.  The
> > thing is, it's just about the most awesome tool for code archeology=
 I
> > have seen.
> >=20
> > I realise (from looking at the doc page) that git-cola helps you do
> > all sorts of things, but those are all things I am happier doing at
> > the command line.
>=20
> Ditto.  There's actually a few small things I use it for,
> mainly for teasing apart commits.  These days you can use git-gui
> for that, but in the old days it was the only way to interactively
> select individual lines and stage/unstage/revert them, etc.
> I don't think we can line-by-line revert in git-gui yet, though.
>=20
> Some other small things that I use: ctrl-g, type something
> for grep, hit enter twice and I'm in my editor on that
> (or any other selected) line.  'spacebar' does xdg-open,
> and 'enter' launches the editor in the status widget;
> small things.  I, too, do most stuff on the command line.
>=20
> The grep thing is a good example.  You have tons of output,
> you see the one line that you care about, and you want to jump
> there.  Clicking on that line and hitting enter is the minimal
> effort to do that.  You don't have to click because we also
> have keyboard navigation.  I have a feeling that there's probably
> something I'm missing, though.. another way of working (emacs?)
> that would render all of this custom GUI stuff pointless.
>=20
> What I learned about users:
>=20
> The commit editor is the #1 thing that got my coworkers finally
> writing better commit messages. It forces the subject/description
> separation and shows yellow, red when the subject gets too long.
> It also auto-wraps.  IMO it makes sense for git-gui to do
> the same these days.
>=20
> > Gitk does precisely those things which *require* a GUI, where the
> > amount of information presented overwhelms a text interface.  The
> > display is concisely designed to give you the maximum information a=
t a
> > minimum space use.  For example, a little black square when a commi=
t
> > has a note attached.  Even hovering over the arrow-heads, on comple=
x
> > trees where the line gets broken, does something meaningful.
> >=20
> > if I had to pin it down, the feature I use most often is "Show orig=
in
> > of this line".  Other features I use often are
> >=20
> >   - review a commit file by file (f and b keys, also spacebar and '=
d')
> >   - search by SHA1 (4 digits appear to be enough, regardless of how
> >=20
> > big your repo is),
> >=20
> >   - search for commits changing path/dir (while still showing all t=
he
> >=20
> > commits; i.e., this is not 'git-dag -- README.txt' but within gitk =
you
> > search up and down for commits touching README.txt
> >=20
> >   - and navigating the commit tree looking for stuff
> >=20
> > http://sitaramc.github.com/1-basic-usage/gitk.html is my attempt to
> > document some of the stuff I have found and use.
>=20
> Wow, this is awesome.
>=20
> > One final point: the DAG on the right wastes enormous amounts of
> > space.  Purely subjectively, it is almost jarring on the senses.  (=
If
> > you reduce it, it becomes unreadable).
> >=20
> > With all due respect, git-cola/dag isn't anywhere near what gitk do=
es,
> > at least for people who are not afraid of the command line and only
> > need the GUI to visualise a truly complex tree.
>=20
> This is really great feedback.
> cc:ing Guillaume since he had similar ideas.
>=20
> thx,

Thanks David for cc:ing me. I'm sorry I was quite below the radar latel=
y, had=20
too much work to get back on the dag. What I would really like for the =
dag is=20
to become as useful as the treeview in git extensions=20
(http://code.google.com/p/gitextensions/), where it is the central plac=
e for=20
checkout, merge, cherry picks...=20

My only complaint with git extensions is that it is poorly integrated o=
n my=20
linux desktop, due to framework choice (let's not start a flame war her=
e, it's=20
not the point). On the other hand, git-cola is quite easy to hack on th=
anks to=20
its python roots, well integrated on all OS thanks to Qt, so I thought =
it=20
would be great to make it at least on par.

Had an opportunity to rework the visuals on the dag, but not yet its=20
functionalities... As soon as I'm back on normal life, I'll pickup the =
subject=20
again :)

Cheers,

Guillaume

--=20
Skrooge, a free, Open Source, personal finances software for linux, Mac=
 OS,=20
Windows
http://skrooge.org
