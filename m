From: Francis Galiegue <fg@one2team.net>
Subject: Re: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Mon, 3 Nov 2008 17:54:00 +0100
Organization: One2team
Message-ID: <200811031754.00545.fg@one2team.net>
References: <200811031943.30033.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 17:56:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx2jE-0004H5-Ly
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316AbYKCQzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 11:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbYKCQzV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:55:21 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:40678 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756879AbYKCQzS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 11:55:18 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-77-130.w90-20.abo.wanadoo.fr [90.20.64.130])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 1087F92C018;
	Mon,  3 Nov 2008 17:55:08 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811031943.30033.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99964>

Le Monday 03 November 2008 17:43:29, vous avez =E9crit=A0:
> Some environments may require selective limiting of read access to
> repositories. While even dumb http transport supports it through .hta=
ccess
> files, gitweb currently does not implement discretionary access contr=
ol.
>=20
> This patch adds a configuration-contolled check that matches simple
> 'Reguire user'/'Reguire group' lines in the .htaccess files with the
> authenticated user name. Using group authentication requires specifyi=
ng
> a path to the Apache group file in the configuration.
>=20
> Using htaccess has an additional bonus that the same authentication
> data can be used both for gitweb and the dumb http transport.
>=20
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

It just seems to me that this is emulating functionality that multiple =
Web servers already provide...

What's more, knowledge about these Web servers are _much_ more widespre=
ad than knowledge about gitweb.

Why reinvent the wheel?

Just a thought,
--=20
fge
