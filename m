From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: cogito push problem
Date: Sun, 25 Sep 2005 23:52:59 +0200
Message-ID: <20050925215259.GE19023@schottelius.org>
References: <20050925192214.GC19023@schottelius.org> <20050925210908.GA21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 23:53:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJeQm-0003Zl-48
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 23:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVIYVxF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 17:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVIYVxF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 17:53:05 -0400
Received: from wg.technophil.ch ([213.189.149.230]:58601 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932306AbVIYVxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 17:53:04 -0400
Received: (qmail 22115 invoked by uid 1000); 25 Sep 2005 21:52:59 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050925210908.GA21019@pasky.or.cz>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9288>


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Petr Baudis [Sun, Sep 25, 2005 at 11:09:08PM +0200]:
> Dear diary, on Sun, Sep 25, 2005 at 09:22:14PM CEST, I got a letter
> where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me=
 that...
> > Hello!
> >=20
> > I was trying to push my current work out and recieved this error:
> >=20
> > [21:20] hydrogenium:cinit% cg-push main
> > error: remote ref 'refs/heads/master' is not a strict subset of local r=
ef 'refs/heads/master'.
> >=20
> > My questions:
> > - What does that mean to me as an end-user?
> > - What's the reason that this happened?
> > - How do I fix that?
>=20
> This means someone probably pushed out some new stuff you don't have
> yet (or you did something evil, like uncommitted something you already
> pushed out before). So what to do is cg-update, that will merge the new
> stuff, then try to cg-push again.

Thanks for your help, cg-update && cg-commit worked fine, because
cg-update overwrote the changes made by me (I checked cg-diff before,
so that was my intention, not cg-update's fault).

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQzccOrOTBMvCUbrlAQJFtw/9FvJbkvfc56Yed2ydfsYdD91fPnyQRQdd
rb1Wml1848WulauAodj6qo2C8VP6ZYwwobFJzuklDwU/ODZpuTXmx6WUEChjYSgr
Lh3WYSSg14Q+OpnGpf4zqCDllrw5c9UmGc4kX2rO+Xgpt0MdG5l1CEZVMR9FuJJo
6mffwdWAj6Qj9lqO5wLGcj/8aU9BPmyJEItTrgp1K0TcflVYu8Hw+TdNtXZVmjRZ
hPCttcf2fhK9GB6wN1tDuNazZCsinH10OvxmbS52zXxZbKgDaDawOA6K6IBHKh5g
UFww0rVy6Cnzfm2f1DQwlyNvetwYZkeJmV3Awcn6E2/0/iNZB+nxp3DPqYRoc2WV
JmQdAJfLYHNdTy5QUyC3L4xUgFXwQhMKg5x9uommacG4DgygG6Nlt8n7miwsoZ8w
gBskkbXqjP0twBVIOZ84PQpdqFJ0p6QFqCVBywovDIzjg49inqV2Skf90JkuokRM
qitj160ubEoHu/5NzbhLWBDFBBufTANZCSTFyAj0VDCN0UDy+Xr42hI7QEkRWkv1
A6Ta4FCXF5TOtY9LtpzVnNR/FXryMW0oCsDeeAbQaqUZ5OYDfjOZ7LlJkqr1uYpi
dJ30vRQ2oWOAjPeuGl0uBOdvhBvA8YWjk57+kiU6/dwQdx1L63P/ir/PRSWP8uQC
cGflG5KhBGg=
=Ejcp
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
