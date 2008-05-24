From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] gitk: Update German translation
Date: Sat, 24 May 2008 22:48:23 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805242248.23413.stimming@tuhh.de>
References: <200805012142.10151.stimming@tuhh.de> <200805072256.50520.stimming@tuhh.de> <20080515162052.GC12350@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat May 24 22:49:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K00g8-0002En-4G
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 22:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760637AbYEXUsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2008 16:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760934AbYEXUsb
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 16:48:31 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:55889 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294AbYEXUsa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 May 2008 16:48:30 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m4OKmQjs005429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 24 May 2008 22:48:27 +0200
Received: from [192.168.2.102] (p549026EF.dip0.t-ipconnect.de [84.144.38.239])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m4OKmPkg002716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 May 2008 22:48:26 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20080515162052.GC12350@leksak.fem-net>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82828>

Hi Stephan,

Am Donnerstag, 15. Mai 2008 18:20 schrieb Stephan Beyer:
> > > The original
> > >  "Find next/prev commit _containing:_ [insert]"
> > > should be translated to
> > >  "Suche n=C3=A4chste/vorige Version, die [insert] enth=C3=A4lt."
> > > But this is beyond the used techniques for software translation ;=
-)
>
> I want to repeat my suggestions from the last mail:
>   1. "Suche n=C3=A4chste/vorige Version nach _Beschreibung:_ [insert]=
"
>   2. "Suche n=C3=A4chste/vorige Version nach _Pfaden:_ [insert]"
>      (or maybe "nach _Dateien:_", if it's commonly accepted that
>       directories are files, too.)
>   3. "Suche n=C3=A4chste/vorige Version nach _=C3=84nderungen:_ [inse=
rt]"
> which makes it much more clearer than the English original, imho.

Okay, I've inserted your suggestions in my translation update. I'm not =
too=20
sure about any translation of this part, but your proposal is maybe bet=
ter=20
than the existing one.

> > > Btw, 'man git-cherry-pick' says
> > >         "Apply the change introduced by an existing commit".
> > > So why not take this and use
> > >  "Durch diese Version eingef=C3=BChrte =C3=84nderungen =C3=BCbern=
ehmen" or
> > >  "Durch diese Version eingef=C3=BChrte =C3=84nderungen anwenden"?
> >
> > This is indeed a case where a better translation can still be found=
=2E
> > However, all of "kopieren, =C3=BCbernehmen, anwenden" IMHO sound to=
o similar
> > to actions that already appear here or there in the version control=
 GUI.
>
> You are right with "kopieren" and "anwenden", but where is "=C3=BCber=
nehmen"?
>
> Ok, it is used in the glossary for "pull", but nowhere in code that i=
s
> actually used. =20

The glossary is for git-gui, which has GUI items for "git pull" but not=
 "git=20
cherry-pick", currently. OTOH gitk has GUI items only for "git cherry-p=
ick"=20
but not "git pull", currently.

> And I think a better translation for "pull" is=20
> something that stresses the fact that "pull" =3D "fetch" + "merge",
> something like "Holen und Zusammenf=C3=BChren".

That's indeed an interesting suggestion. (Which bears the question why =
it is=20
being called "pull" in English in the first place, when it should rathe=
r be=20
described by "fetch and merge". Heh.)

> > Cherry-picking is a specialized action and should thus get a specia=
lized
> > German word.
>
> I'm still unsure about this.  But it's your choice. ;-)

Yeah. I'm also not completely sure, but for now I'd still prefer "pfl=C3=
=BCcken"=20
over the other possibilities we've discussed so far.

Regards,

Christian
