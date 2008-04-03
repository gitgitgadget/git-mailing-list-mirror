From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: Wrong sync config filename
Date: Thu, 3 Apr 2008 09:09:10 +0200
Message-ID: <200804030909.11067.simon@lst.de>
References: <e66701d40804020123qb66f52fo13c32e939a7d6f75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1970727.TCl1EsETGi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kevin Leung" <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 09:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhJaG-0002bH-G7
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 09:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758440AbYDCHJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 03:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758504AbYDCHJU
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 03:09:20 -0400
Received: from verein.lst.de ([213.95.11.210]:33756 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114AbYDCHJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 03:09:19 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m3379BF3028624
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Thu, 3 Apr 2008 09:09:12 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <e66701d40804020123qb66f52fo13c32e939a7d6f75@mail.gmail.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78728>

--nextPart1970727.TCl1EsETGi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 02 April 2008 10:23:00 Kevin Leung wrote:
> The filename should be p4-git-sync.cfg.db instead of p4-git-sync.cfg.
>
> Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
> ---
> I encounter this problem after submitting the changelist to Perforce.
>
> I was using Mac OS X 10.5 with Python 2.5.1. I am not sure if this patch
> will help others.

Thanks for the patch! Fortunately this config file is not needed anymore an=
d I=20
removed its use alltogether a while ago, also as a result of running into=20
this problem on Mac OS X myself :). So the latest git has this resolved :)


Simon

> Change 29323 submitted.
> All changes applied!
> Performing incremental import into refs/remotes/p4/master git branch
> Depot paths: //depot/POPCAT/
> Import destination: refs/remotes/p4/master
> Importing revision 29323 (100%)
> Do you want to rebase current HEAD from Perforce now using git-p4
> rebase? [y]es/[n]o n
> Traceback (most recent call last):
>   File "/Users/kevin/bin/git-p4", line 1828, in <module>
>     main()
>   File "/Users/kevin/bin/git-p4", line 1823, in main
>     if not cmd.run(args):
>   File "/Users/kevin/bin/git-p4", line 835, in run
>     os.remove(self.configFile)
> OSError: [Errno 2] No such file or directory:
> '/Users/kevin/cdc.git/popcat/.git/p4-git-sync.cfg'
>
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index c80a6da..623757a 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -796,7 +796,7 @@ class P4Submit(Command):
>                  self.logSubstitutions[tokens[0]] =3D tokens[1]
>
>          self.check()
> -        self.configFile =3D self.gitdir + "/p4-git-sync.cfg"
> +        self.configFile =3D self.gitdir + "/p4-git-sync.cfg.db"
>          self.config =3D shelve.open(self.configFile, writeback=3DTrue)
>
>          if self.firstTime:



--nextPart1970727.TCl1EsETGi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH9IKWWXvMThJCpvIRAm9SAKDi56gM1AlJzqxuXopPnurpqCxbXgCg3Bi8
5KPMfdiBytaKRSM9W/31/Vs=
=ihXm
-----END PGP SIGNATURE-----

--nextPart1970727.TCl1EsETGi--
