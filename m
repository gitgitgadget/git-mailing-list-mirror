From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: Improved "git add"
Date: Sun, 18 Sep 2005 23:29:04 +0200
Message-ID: <20050918212904.GB1463@schottelius.org>
References: <Pine.LNX.4.58.0509181119040.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
X-From: git-owner@vger.kernel.org Sun Sep 18 23:30:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH6jM-00079u-GA
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 23:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVIRV3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVIRV3p
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 17:29:45 -0400
Received: from wg.technophil.ch ([213.189.149.230]:30679 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932211AbVIRV3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 17:29:45 -0400
Received: (qmail 1758 invoked by uid 1000); 18 Sep 2005 21:29:04 -0000
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509181119040.26803@g5.osdl.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8811>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus Torvalds [Sun, Sep 18, 2005 at 11:27:45AM -0700]:
> [git-add/directory fix]

Nice, first cogito and now git itself. You are pretty fast.

> [...]
> Also, I think we should have a default ignore list if we don't find a=20
> .git/info/exclude file. Ignoring "*.o" and ".*" by default would probably=
=20
> be the right thing to do.

I do use doc/.warning or similar in some projects files for outputting
a warning when somebody simply types 'make', so he'll get instructions
on what to do.

Other people may even want to include *.o in their tree, because it's
used by their program for another purpose.

I do not think that a VCS should ignore anything from itself. If we
generate a standard .git/info/excludes (or whatever the name of it is)
and write those standard values in there, this is a different thing.

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQy3cILOTBMvCUbrlAQLfdw//VnfW7DJqjFan84JVpnaWdoba9P+VFny+
d+/5gGEbHkm6VSB0Jf8wAx7Yv4GVlVf2Z2wxyvObbGPC2Lvi0vviE0ucOeXiULM2
vPr+O1Z4leF36YfaRfMUSnMnypxeKk/VzLm1n3qdwjMwaFXeqLcmGkMexG/Nrydz
HF3GRfKBehkQIkqxyVtN28nc/tvcXZJAqT+H8nHVMteEc3J7sP6CMvGMttPhr8DW
2wuZF0/ehDTUrYUR6vrI5M9wvo5lobEzm+mSMY2wKoj9owPdBHh0KHRn/8wKco+W
lJyeX4CxoG4+mftv2pmh3HcSnIHp9qrAdNXALAByF+QesGB+XP5CM2uz28Pr8xjQ
9MFNaRPnAR78RHSS9N+sARgOqLu35465C1wleQq1+83DGzkWc1yfV8Uq2ii3sp+T
s8p/S3qYaoXliRcXxFMzZQa26atjR0ENzrz2f6sWQBtQ+MY2tjptnTldnP4U7Rm/
h1LYUB3xKriu8fTsHry+Ol0+4mxLo7irpG773vTN4slB+edDEAr4yNypxh2/Iwet
mlB+bxOROm+4wDRpBt6e8GZfNpW4en8AQ9X8k8JbnWi972gN+CJzxD3wjWgunJH5
KXqGSemp0uQ9IMC8tQhnazzRm+w99XjOd3yFRZJm61fQ7eR08vWeq07ZoL5uTXur
Pa24kyBQSLM=
=XGfQ
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
