From: Francis Galiegue <fg@one2team.net>
Subject: Re: pull --preserve-merges
Date: Sat, 8 Nov 2008 18:07:52 +0100
Organization: One2team
Message-ID: <200811081807.53199.fg@one2team.net>
References: <20081107160138.aa96405c.stephen@exigencecorp.com> <alpine.DEB.1.00.0811081607300.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 08 18:12:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyrM3-0003Lo-KU
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 18:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbYKHRK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 12:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbYKHRK0
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 12:10:26 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:35675 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbYKHRKZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 12:10:25 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-139-113.w90-24.abo.wanadoo.fr [90.24.114.113])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 7E9AF92C011;
	Sat,  8 Nov 2008 18:10:15 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0811081607300.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100411>

Le Saturday 08 November 2008 16:08:41 Johannes Schindelin, vous avez =E9=
crit=A0:
> Hi,
>
> On Fri, 7 Nov 2008, Stephen Haberman wrote:
> > Awhile ago I brought up wanting to have a "rebase with preserve mer=
ges"
> > option for `git pull`
>
> That might be something you want, but you cannot call it
>
> 	git pull --preserve-merges
>
> since everybody used to "pull =3D fetch && merge" would go "Huh? A me=
rge
> _does_ preserve merges".
>
> If at all, you could call it "--rebase=3Dpreserve-merges".
>

Why not --rebase --keep-merges? Personnally, I think it makes things cl=
earer=20
since in general options are either standalone or have a value.

--=20
fge
