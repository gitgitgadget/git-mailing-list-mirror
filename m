From: m.skoric@web.de
Subject: Re: Unable to clone svn repository
Date: Wed, 03 Sep 2008 13:01:47 +0200
Organization: http://freemail.web.de/
Message-ID: <1295387102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vincent Kergonna <git@kergonna.fr>
X-From: git-owner@vger.kernel.org Wed Sep 03 13:02:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaq8W-0008PF-4N
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 13:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbYICLBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 07:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbYICLBu
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 07:01:50 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:37025 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYICLBt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2008 07:01:49 -0400
Received: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id F3FF65911E96;
	Wed,  3 Sep 2008 13:01:47 +0200 (CEST)
Received: from [217.110.125.178] by freemailng2303.web.de with HTTP;
 Wed, 03 Sep 2008 13:01:47 +0200
X-Provags-Id: V01U2FsdGVkX18AEfWE4z7+M53/EzeWC/uSgHOpLFEVOXdoFar3wOanbLP3B
 fjo5qiTpRvdVcRXAK4allHP2OQrtqfuvD5R7NfZqJCqjX6WvNU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94784>

> -----Urspr=FCngliche Nachricht-----
> Von: "Vincent Kergonna" <git@kergonna.fr>
> Gesendet: 02.09.08 18:13:23
> An: m.skoric@web.de
> CC: git@vger.kernel.org
> Betreff: Re: Unable to clone svn repository


> > Hi guys,
> >
>=20
> Hi,
>=20
> > im getting an error when im trying to clone a big svn repository. t=
runk
> > and a couple of branches worked before
> > git crashed.
> >
> > git Version 1.6.0.1
> >
> > command: git-svn clone https://SECRETURL --trunk=3Dtrunk --branches=
=3Dbranches
> > --tags=3Dtags
> > error:
> >
> > Found possible branch point:
> > https://SECRETURL/branches/dirk/Abo-Uebernahme (Bug #994) =3D>
> > https://SECRETURL/branches/Abo-Uebernahme (Bug #994), 341
> > Initializing parent: Abo-Uebernahme (Bug #994)@341
> > W: Ignoring error from SVN, path probably does not exist: (175002):=
 RA
> > layer request failed: REPORT request failed on '/svn/tixx1/!svn/bc/=
101':
> > REPORT of '/svn/tixx1/!svn/bc/101': Could not read chunk size: Secu=
re
> > connection truncated (https://SECRETURL)
> > W: Do not be alarmed at the above message git-svn is just searching
> > aggressively for old history.
> > This may take a while on large repositories
> > Found possible branch point: https://SECRETURL/trunk =3D>
> > https://SECRETURL/branches/dirk/Abo-Uebernahme (Bug #994), 203
> > Found branch parent: (Abo-Uebernahme (Bug #994)@341)
> > bb831869748c98bf97d105c5894ae65331c95c08
> > Bad URL passed to RA layer: Malformed URL for repository at
> > /usr/bin/git-svn line 3792
> >
> > Maybe a https problem -> "Secure connection truncated (https://SECR=
ETURL)"
> > ?
> > Anyone has an idea and can help me?
> >
>=20
> I'm not 100% sure but I think I hit this problem last friday. It you =
cd
> into the directory created by "git svn clone" you can do
>=20
> git svn update
>=20
> it should continue to download the changes. I had to update it severa=
l
> times because I got the error several times, but in the end I managed=
 to
> have a clone of the svn repository.

git-svn update isn't a valid git cmd. Do you mean git-svn fetch?
But that didn't helped anyway.

Any clue?

Majk=20


_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=3D100071&distributionid=3D000000000066
