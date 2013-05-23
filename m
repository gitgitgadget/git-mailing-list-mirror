From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Thu, 23 May 2013 20:16:16 +0200
Message-ID: <20130523181615.GB3270@client.brlink.eu>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
 <CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
 <CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com>
 <7402110.vsgz8zEiin@cs-pc>
 <CAN0XMOK4oniunZz5KpC1x=JrY4yH4HnecxMSCyPF+kEyYRRjTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ralph =?iso-8859-1?Q?Hau=DFmann?= <ralph@scanmyfood.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 20:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfaGC-0002mk-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 20:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198Ab3EWS3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 May 2013 14:29:03 -0400
Received: from server.brlink.eu ([78.46.187.186]:57638 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758147Ab3EWS3C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 14:29:02 -0400
X-Greylist: delayed 756 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2013 14:29:02 EDT
Received: from client.brlink.eu 
	by server.brlink.eu with esmtpsa (tls-peer-hash KfHJgA)
	id 1Ufa3l-0000yl-4j; Thu, 23 May 2013 20:16:17 +0200
Received: with local; Thu, 23 May 2013 20:16:16 +0200
Content-Disposition: inline
In-Reply-To: <CAN0XMOK4oniunZz5KpC1x=JrY4yH4HnecxMSCyPF+kEyYRRjTw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225279>

* Ralf Thielow <ralf.thielow@gmail.com> [130522 17:17]:
> >>     remote branch          =3D Remote-Branch
> >>     remote-tracking branch =3D Remote-Tracking-Branch
> >>     upstream branch        =3D Upstream-Branch
> >
> > Yes. What's the main reason for using "Branch" in the German text? =
Consistency
> > with the commands, or assumed familiarity of the term within the ta=
rget
> > audience? "Zweig" is available.
> >
>=20
> I think it's at the same level as "Commit" and a well known SCM-term.=
 Users
> (even beginners) who know "Commit" and "Tag" do also know "Branch". A=
nd
> I think it sounds better in combination with "Remote-", "Remote-Track=
ing-" and
> "Upstream-" which are english words.

Additionally "Zweig" might be a bit misleading. A branch is not part of
the "tree"s. It is called branch because in other VCSes the commits
build a tree and a any commit outside of the main branch of that tree i=
s
part of exactly one different branch (so the head of that branch and th=
e
branch are synonymns). With git the commits are no longer a tree, so a
git-branch is no branch and does not describe the whole branch of the
tree of commits but is just a names pointer into the graph of commits.
As it lost all meanings of the original word "branch", translating it
with a translation of the original English word might more confusion
than helping anyone.

> (same for push). In other messages, the translation is in the same me=
ssage
> as the command itself. I think it's OK when we just use "fetch" and "=
push"
> when the command is meant (as it's done for "pull", e.g. in error mes=
sages),
> and the translation when the messages tell what the command is doing =
(e.g. help
> messages). So it would depends on the message whether we translate th=
e word
> or not. This would apply to other terms that are commands, too, like
> "clean" or "revert".

I'd not call it "OK". It's the only sane possibility. If you speak
about the magic keyword you have to give the command line, you won't
translate it, of course[1]. (The obvious interesting case is where the
English text plays with the command name having a meaning as word
itself. Here the translation will have to diverge to differentiate
between both (or sacrifice one of them, where it is not important)).

[1] Unlike you want to introduce a translated command line interface,
like "Depp anfordere Herkunft Original" instead of "git fetch origin ma=
ster"

> >>     diff               =3D Differenz
> >>     delta              =3D Differenz (or Delta)
> >>     patch              =3D Patch
> >>     apply              =3D anwenden
> >>     diffstat           =3D (leave it as it is)
> >>     hunk               =3D Bereich
> >
> > IMHO "Kontext" is better if you use a German word. Technically the =
context is
> > something else, but in a German text IMHO it fits nicer when explai=
ning to the
> > user where he/she can select the n-th hunk.
> >
>
> Not sure if German users would know what "hunk" means, in case we
> leave it untranslated. And I'm not sure if I would understand "Kontex=
t".
> I tend to leave it untranslated.

Anyone found a German translation of the Patch manpage? Translating the
English word-play here, I'd suggest "Block" or "Patch-Block".

> >>     paths          =3D Pfade
> >>
> >>     symbolic link =3D symbolische Verkn=FCfung
> >>     path =3D Pfad
> >>     link =3D Verkn=FCpfung

In the filesystem a "Link" is a "Verweis" in Unix, not a "Verkn=FCpfung=
"
(that are usually the pseudo-links Windows supports).

        Bernhard R. Link
