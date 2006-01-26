From: Mathieu Chouquet-Stringer <ml2news@free.fr>
Subject: Re: How to create and keep up to date a naked/bare repository?
Date: 26 Jan 2006 16:11:37 +0100
Organization: Uh?
Message-ID: <m3vew781na.fsf@localhost.localdomain>
References: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net>
	<7v64o7fac1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 16:12:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F28mr-00045r-Nd
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 16:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWAZPLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 26 Jan 2006 10:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWAZPLp
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 10:11:45 -0500
Received: from AMarseille-252-1-93-193.w86-202.abo.wanadoo.fr ([86.202.148.193]:3229
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932352AbWAZPLo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 10:11:44 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.5/8.13.5) with ESMTP id k0QFBcGB019934;
	Thu, 26 Jan 2006 16:11:38 +0100
Received: (from mchouque@localhost)
	by localhost.localdomain (8.13.5/8.13.5/Submit) id k0QFBcWb019931;
	Thu, 26 Jan 2006 16:11:38 +0100
X-Authentication-Warning: localhost.localdomain: mchouque set sender to ml2news@free.fr using -f
To: junkio@cox.net (Junio C Hamano)
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
In-Reply-To: <7v64o7fac1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15167>

junkio@cox.net (Junio C Hamano) writes:
> Mathieu Chouquet-Stringer <ml2news@free.fr> writes:
> > I can do a: GIT_DIR=3D. git fetch and it works.
>=20
> That is the right way of doing it.

Ok.
=20
> > The second question is I'd think I would have to use git fetch inst=
ead of
> > git pull as a pull is fetch + merge and merging wouldn't make much =
sense as
> > I didn't check out any files. Does it make any sense?
>=20
> Absolutely.  Bare repositories are either to be pushed into or
> fetched into.

Great I ain't totally lost then!
=20
> > The third thing (can't reproduce ATM as I just got a fresh new clon=
e) is
> > that git fetch was just fetching over and over the same objects...
>=20
> It sounds like you are not telling fetch to update the refs you
> track from outside.  Perhaps, this may help (untested):
>=20
> 	$ GIT_DIR=3D/pub/scm/git/git.git git fetch \
>         	--update-head-ok $remote master:master

I'll try that and will let you know...

Thanks Junio for getting back to me.
--=20
Mathieu Chouquet-Stringer
    "Le disparu, si l'on v=E9n=E8re sa m=E9moire, est plus pr=E9sent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exup=E9ry, Citadelle --
