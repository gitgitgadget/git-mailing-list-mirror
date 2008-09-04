From: Kai Blin <kai@samba.org>
Subject: Re: Directory renames without breaking git log.
Date: Thu, 4 Sep 2008 21:45:09 +0200
Message-ID: <200809042145.09573.kai@samba.org>
References: <200809032338.35359.kai@samba.org> <905315640809031716j7d74d7a6m51b434f62b011135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1675328.BtMqQGVHMs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 21:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbKmY-0000rq-Tp
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbYIDTpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYIDTpL
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:45:11 -0400
Received: from mail.samba.org ([66.70.73.150]:53573 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbYIDTpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:45:10 -0400
Received: from ip6-localhost (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id D7CCB16391B
	for <git@vger.kernel.org>; Thu,  4 Sep 2008 19:45:05 +0000 (GMT)
User-Agent: KMail/1.9.9
In-Reply-To: <905315640809031716j7d74d7a6m51b434f62b011135@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94954>

--nextPart1675328.BtMqQGVHMs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 September 2008 02:16:24 Tarmigan wrote:
> On Wed, Sep 3, 2008 at 2:38 PM, Kai Blin <kai@samba.org> wrote:
> > Unfortunately, the directories are big enough that git log stops to tra=
ck
> > the renamed files, so e.g. git log ./samba3 does not show the samba3
> > history. The history is not lost, of course, but it's way less intuitive
> > to get it.
>
> You can try setting diff.renamelimit to 0 in your ~/.gitconfig.  See
> Linus's email here for a similar situation in the kernel:
> http://lwn.net/Articles/292948/

That doesn't seem to fix "git log path/to/file" cases. The really interesti=
ng=20
part is that if I try git log --follow -M -C path/to/file, I don't get any=
=20
history at all. (--follow is the culprit, if I remove that I at least get t=
he=20
merge commit)

git blame still works, and git log --sparse path/to/file works, of=20
course. --sparse makes giving a path a bit pointless, of course, but we=20
probably can live with that for time being. I'm still open for suggestions,=
=20
of course. :)

Cheers,
Kai

=2D-=20
Kai Blin
WorldForge developer  http://www.worldforge.org/
Wine developer        http://wiki.winehq.org/KaiBlin
Samba team member     http://www.samba.org/samba/team/
=2D-
Will code for cotton.

--nextPart1675328.BtMqQGVHMs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIwDrFEKXX/bF2FpQRAgJQAJ9qnBB/PSVf8HZMsP8gAHK3R9amaQCfWz+1
fLQZROHSme3HWNHxudxzhl4=
=X5Vg
-----END PGP SIGNATURE-----

--nextPart1675328.BtMqQGVHMs--
