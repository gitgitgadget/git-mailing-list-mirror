From: Francis Galiegue <fg@one2team.net>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Tue, 4 Nov 2008 08:42:26 +0100
Organization: One2team
Message-ID: <200811040842.26710.fg@one2team.net>
References: <200811031943.30033.angavrilov@gmail.com> <200811032259.03394.fg@one2team.net> <200811040124.36708.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Alexander Gavrilov" <angavrilov@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 08:43:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxGZl-0004Lc-HG
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 08:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbYKDHmb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Nov 2008 02:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYKDHmb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 02:42:31 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:42570 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbYKDHma convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2008 02:42:30 -0500
Received: from erwin.olympe.o2t (pas75-3-82-235-191-170.fbx.proxad.net [82.235.191.170])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 4AA8E92C011;
	Tue,  4 Nov 2008 08:42:26 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811040124.36708.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100051>

Le mardi 04 novembre 2008, Jakub Narebski a =C3=A9crit=C2=A0:
[...]
> >=20
> > As to what repository is accessible to whom, does gitweb really hav=
e
> > an internal mechanism for this? Wouldn't it be "better" is privatel=
y
> > accessible projects were available on another website to start with=
? =20
>=20
> The problem is that Apache has to decide whether to deny or grant acc=
ess
> based on URL, not on path in filesystem. Perhaps that is possible...
>=20

It is, with <Location> or <LocationMatch>. You can use mod_access direc=
tives=20
within these (or mod_auth* ones).


--=20
=46rancis Galiegue, fg@one2team.com
[ATTENTION - CHANGEMENT D'ADRESSE !]
40 av Raymond Poincar=C3=A9, 75016 PARIS
+33178945570, +33683877875
