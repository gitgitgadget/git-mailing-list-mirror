From: Martin Geisler <mg@lazybytes.net>
Subject: Re: About single user setup for lightweights
Date: Fri, 19 Mar 2010 10:53:55 +0100
Message-ID: <87k4t81vt8.fsf@hbox.dyndns.org>
References: <87r5nht6uf.fsf@newsguy.com>
	<32541b131003181913v7319d6a1ydd72c0177729dbf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: bazaar@lists.canonical.com, Harry Putnam <reader@newsguy.com>,
	mercurial@selenic.com, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: bazaar-bounces@lists.canonical.com Fri Mar 19 10:54:10 2010
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1NsYu9-0005Cx-27
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 19 Mar 2010 10:54:09 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.69)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1NsYu1-00052L-PT; Fri, 19 Mar 2010 09:54:01 +0000
Received: from mail-ew0-f217.google.com ([209.85.219.217])
	by chlorine.canonical.com with esmtp (Exim 4.69)
	(envelope-from <mg@mgsys.dk>) id 1NsYtz-00051K-2r
	for bazaar@lists.canonical.com; Fri, 19 Mar 2010 09:53:59 +0000
Received: by ewy9 with SMTP id 9so624763ewy.31
	for <bazaar@lists.canonical.com>; Fri, 19 Mar 2010 02:53:58 -0700 (PDT)
Received: by 10.213.1.145 with SMTP id 17mr278840ebf.46.1268992438577;
	Fri, 19 Mar 2010 02:53:58 -0700 (PDT)
Received: from hbox.dyndns.org (x1-6-00-1c-c5-d8-bd-21.k78.webspeed.dk
	[80.197.249.218])
	by mx.google.com with ESMTPS id 16sm84648ewy.15.2010.03.19.02.53.56
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Fri, 19 Mar 2010 02:53:57 -0700 (PDT)
In-Reply-To: <32541b131003181913v7319d6a1ydd72c0177729dbf4@mail.gmail.com>
	(Avery Pennarun's message of "Thu, 18 Mar 2010 22:13:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Topics: everythingelse
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142573>

--=-=-=
Content-Transfer-Encoding: quoted-printable

Avery Pennarun <apenwarr@gmail.com> writes:

> git sucks at handling large binary files (>50 megs or so) unless you
> have boatloads of RAM. If your binary files are moderately sized (a
> few megs) then it'll probably be reasonably efficient. I don't know
> about hg and bzr for memory usage.

Mercurial also uses lots of RAM, way more than I had hoped. I did some
tests with this recently:

  http://markmail.org/message/uxqtmmnkyimxse5b

They show a factor 3-6 blowup when working with a 256 MB file.

We don't really recommend storing such large files in Mercurial. Instead
we recommend storing the files outside of the tree, e.g., on a server
with a huge disk. The bfiles extension can do this:

  http://mercurial.selenic.com/wiki/BfilesExtension

=2D-=20
Martin Geisler

Fast and powerful revision control: http://mercurial.selenic.com/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkujSbMACgkQ/GWFsD4LxSMa3gCcDtMvN0LEnfpEAAlcPdW6zs1T
tigAnj9YG46E63l9uJReMZjlqCLxjrSZ
=W6iI
-----END PGP SIGNATURE-----
--=-=-=--
