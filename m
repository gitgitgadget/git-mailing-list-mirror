From: Francis Galiegue <fg@one2team.net>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Mon, 3 Nov 2008 19:44:02 +0100
Organization: One2team
Message-ID: <200811031944.03116.fg@one2team.net>
References: <200811031943.30033.angavrilov@gmail.com> <200811031845.46451.fg@one2team.net> <m38ws0fzca.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Alexander Gavrilov" <angavrilov@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:46:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx4Rg-000301-AJ
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYKCSpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 13:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbYKCSpW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:45:22 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:33382 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbYKCSpW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 13:45:22 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-94-105.w90-20.abo.wanadoo.fr [90.20.169.105])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id AC41192C011;
	Mon,  3 Nov 2008 19:45:10 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <m38ws0fzca.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99978>

Le Monday 03 November 2008 19:18:56 Jakub Narebski, vous avez =C3=A9cri=
t=C2=A0:

> >=20
> > Well, as far as Apache is concerned, it can do:
> >=20
> > * basic .htpasswd authentication,
> > * LDAP,
> > * PAM,
> > * SSL certificate check (via mod_ssl),
> > * probably others.
> >=20
> > Plenty of possibilities.
> [...]
>=20
> Well, the question is if Apache (and other web servers used with
> gitweb) can do authentication based on path_info or on query-string.
> Because it is encoded in gitweb (via $projectroot) where to find git
> repositories...
>=20

Can you expand on path_info and query-string? Keep in mind that Apache
has mod_rewrite, which can rewrite URLs in any way before it gets
actually sent to the underlying program (whether it be a CGI or
anything else), even badly (or mischievously).

--=20
fge
