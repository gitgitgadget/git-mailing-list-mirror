From: Francis Galiegue <fg@one2team.net>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 21:21:17 +0100
Organization: One2team
Message-ID: <200811102121.17835.fg@one2team.net>
References: <200811101522.13558.fg@one2team.net> <alpine.DEB.1.00.0811102030180.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdHp-00031w-B2
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbYKJUVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 15:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYKJUVr
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:21:47 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:46202 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYKJUVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 15:21:46 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-115-179.w90-20.abo.wanadoo.fr [90.20.190.179])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id CC7C192C003;
	Mon, 10 Nov 2008 21:21:34 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0811102030180.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100558>

Le Monday 10 November 2008 20:46:02 Johannes Schindelin, vous avez =E9c=
rit=A0:
> Hi,
>
> On Mon, 10 Nov 2008, Francis Galiegue wrote:
> > A very nice git feature, without even going as far as merges, is th=
e
> > cherry pick feature.
> >
> > For this to be doable from within the Eclipse Git plugin, a diff/pa=
tch
> > implementation needs to be found, in a license compatible with the
> > current JGit license (3-clause BSD, as far as I can tell). Or a new
> > implementation can be rewritten from scratch, of course.
>
> Do not forget creating efficient packs.  They also need an efficient =
diff
> engine.
>

I wasn't even thinking about this, honestly :p

Let's say that as far as IDE users are concerned, they do have disk spa=
ce, and=20
having the ability to cherry-pick is more of a priority than packs ;) E=
ven a=20
less efficient but "to the point" engine will be good enough for the ti=
me=20
being, or at least, this is what I think.

I understand way too little about the algorithm myself to tell whether =
it's=20
also efficient for such a purpose. Maybe it is...

--=20
fge
