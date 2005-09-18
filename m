From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: first impressions to git
Date: Sun, 18 Sep 2005 13:12:59 +0200
Message-ID: <20050918111259.GA10882@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Cc: Kay Sievers <kay.sievers@vrfy.org>, Christian Gierke <ch@gierke.de>
X-From: git-owner@vger.kernel.org Sun Sep 18 13:14:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGx78-0000Gz-8n
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 13:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVIRLNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 07:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVIRLNj
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 07:13:39 -0400
Received: from wg.technophil.ch ([213.189.149.230]:63191 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751128AbVIRLNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 07:13:39 -0400
Received: (qmail 11242 invoked by uid 1000); 18 Sep 2005 11:12:59 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8780>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I was testing git for my needs with the following ideas in my mind:

- it must be easy to use
- documentation must be easy to find, understand and remember
- it should be fast
- optionally using the filesystem as a database would be nice

My first impressions are:

- many commands, reminds me of arch/tla
- nice idea with .git
- uses the filesystem
- using git directly seems to be more work than necessary
- cogito looks like a good frontend, but has some drawbacks
- it's not clear which protocols for pull/push are supported
- the documentation is not in sync with the programm (0.99.5 vs. 0.99.6)
- gitweb.cgi could be better documentated and supported
   recursive directories when using $projects_list =3D $projectroot;
   and splitting configuration completly outside of gitweb.cgi would be nice
   (having .gitweb in the same directory as gitweb.cgi for instance)
- I am not able to upload cinit, because
   o adding directories with files and files I want to exclude is not easily
     possible

   o it's not clear to me, how I should publish (push)
      - scp/rsync from outside
      - git/cogito push
   o excluding *.o seems not to work, neither through .gitignore nor through
     .git/info/exlude
- How do I check integrity of files, is signed files somehow implemented?

I've written some notes down in
   http://creme.schottelius.org/~nico/temp/cogito
   http://creme.schottelius.org/~nico/temp/git-erfahrungen

Adding directories with git-script-add (or whatever) would be nice in the w=
ay
it adds the contents of the directory recursively.

That's it for the first impression, I would be happy for any hints and crit=
ic
if I did something 'really wrong' with git/cogito.

My current position to git/cogito is that using could be possible, but not
as comfortable (from a developers view) as it is with monotone.

Sincerly,

Nico

P.S.: These are mostly the negative things, I've to say that
   o gitweb.cgi looks very beautiful
   o git es very fast
   o cogito could in fact be a nice frontend, after removing the current bu=
gs
     and if it has nicer error messaeges, which tell me WHAT I did wrong and
     HOW to do it right.

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQy1LurOTBMvCUbrlAQIEXw/+MHPDIgh4EcvEzaSxKo9aIyg+Gw2IcuVf
vKkDj5swMYtyacXsXmQmF5szq7svOLYdt4tC5JvL9POqqiXs20ivEClM5wmy2ZAl
jy5erh8Jlhka9B5Zerl74qgfHc9Jmk827ieigL1MBQeE44gEKlPoXKeBuFj5qfiD
SC4cGuMH4t97BgniKPDRWgGp/+HQtsFnIuQSz/zAGNAkpNmj/kVJ8Yraly1H0ETR
+KGORu48+pVTnI66/V2EbTE0fgA2OK4q00nB5p7aPBoR2TXhizm/szl9MsK1jxNW
2KvwqxNWg4ujN3bv7gQ13Ixte3ltPmxZ73q/XuhxFYzUSsWZTb67cfv7IxeBg3HW
okkoBzAoZ17CoMkXeqfxSgy8ti7j72qlbwckW17qGXkMMz82aExb2vY74tYcX3YZ
MgNGhW1yvIsFgw1ISiBTJodl5uwl4R1naKMlr9F8Ru7o+5i3b2HBDg9XCSHVGE2f
Gz0iuEV6elcFZp+Beb6VcbL6nLUjL7kKGvq060D3wpx5sdgqexse+oeeEmxP/htl
LE+QUb6uvxo13NKsC1FAvZ/h/pUfnhz7K+Xi8sTmiM8qcOHBOhLUzYKAKXBVJ08z
SPR6xohmfGd9RrVYit441KD4HY6YGATJZQgbHAG0S9WwnaowTCPbVlOffX2zoZac
7UMAh9Lw7Gc=
=6IDz
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
