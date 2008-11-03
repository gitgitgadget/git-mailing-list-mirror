From: Francis Galiegue <fg@one2team.net>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Mon, 3 Nov 2008 18:45:46 +0100
Organization: One2team
Message-ID: <200811031845.46451.fg@one2team.net>
References: <200811031943.30033.angavrilov@gmail.com> <200811031754.00545.fg@one2team.net> <bb6f213e0811030926n32c1befcj5d9add6378f7dce4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 18:48:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx3XH-0006U1-V9
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 18:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbYKCRrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 12:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbYKCRrF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 12:47:05 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:38356 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbYKCRrE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 12:47:04 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-77-130.w90-20.abo.wanadoo.fr [90.20.64.130])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id D0F1592C011;
	Mon,  3 Nov 2008 18:46:53 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <bb6f213e0811030926n32c1befcj5d9add6378f7dce4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99966>

Le Monday 03 November 2008 18:26:44 Alexander Gavrilov, vous avez =E9cr=
it=A0:
> On Mon, Nov 3, 2008 at 7:54 PM, Francis Galiegue <fg@one2team.net> wr=
ote:
> > It just seems to me that this is emulating functionality that multi=
ple Web servers already provide...
> >
> > What's more, knowledge about these Web servers are _much_ more wide=
spread than knowledge about gitweb.
> >
> > Why reinvent the wheel?
>=20
> If you are speaking of web servers as in 'GitHub', then it is
> irrelevant, because its server software is nonfree.
>=20

I didn't even account for these.

> If you are speaking of web servers as in 'Apache', then how would it
> know which files are going to be accessed when it executes
> cgi-bin/gitweb.cgi?p=3Dvery/private/project.git to check permissions?
>=20

Well, as far as Apache is concerned, it can do:

* basic .htpasswd authentication,
* LDAP,
* PAM,
* SSL certificate check (via mod_ssl),
* probably others.

Plenty of possibilities.

Well, that's just mho. But if ever I complete my current work on
git-cvsimport (or using git2(svn|git)), I'll go for option 2: my LDAP
database has all the info, and Apache knows about Cache-Control, not
gitweb...

NOTE: I'm just saying here that your patch is of no use as far as _I_
am concerned. I'm basically saying that git cannot account for all
authentication schemes out there. Neither can Apache, but it supports a
buckload of them already.

--=20
fge
