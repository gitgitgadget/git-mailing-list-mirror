From: Florian Lohoff <f@zz.de>
Subject: stdout vs stderr
Date: Mon, 15 Feb 2016 10:59:13 +0100
Organization: rfc822 - pure communication
Message-ID: <20160215095913.GB27034@pax.zz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 11:05:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVG1l-0003tD-C2
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 11:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcBOKFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 05:05:03 -0500
Received: from pax.zz.de ([88.198.69.77]:60099 "EHLO pax.zz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbcBOKFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 05:05:01 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2016 05:05:01 EST
Received: by pax.zz.de (Postfix, from userid 1000)
	id 89BB1D021C; Mon, 15 Feb 2016 10:59:13 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286193>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
is there a reason why those messages for pull are sent to stdout and
for push are sent to stderr?

flo@p3:~$ git pull
Already up-to-date.
flo@p3:~$ git pull >/dev/null

flo@p3:~$ git push
Everything up-to-date
flo@p3:~$ git push >/dev/null
Everything up-to-date

I am regularly trying to build automatisms around git and typically i
redirect stdout to /dev/null in the hope that when something goes
wrong i see error messages on stderr. This does not work for e.g. push
for obvious reason.

Flo
--=20
Florian Lohoff                                                 f@zz.de
      We need to self-defend - GnuPG/PGP enable your email today!

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBVsGhcZDdQSDLCfIvAQq18BAAifuCwOC6NvQI7GIJ5siVhT5Q+2smfVbh
PKHoeLDTP7pF+SlsQ4PdVfTNu3thecqE9ylhUMpStmHY7Hr9eOXw6pNCP85eBkha
n2ZeD8NPMnGznQs2ybjoNDX4Irx0yuRNpXxESTmP3pnfLVPnsYSLNTL+5hml/cCh
DzgIOGkrU4/eXij3NXZS4JEuEIHbh+/ZCioM/XEeIPF0Bq79IlfvZBvdm1/6646t
duKyjq5oxUzKiWsKjUgKjZ7HTjDpysBUwIcQR25tdfzC1q8xHno37S3X3gtHZyg+
VCVJ4xZ42ncBHKJK9UZX38N2TjgRrC9Fkck/xQD0pNf28HW5rWlpk7gZtYy5PX0l
9phDYS4ERLgOoCH1W1MvYdaolhiGHubdxvskrYQdtZb/FRUSUBdPPbV36WcNc6qp
bzSIaBnaSGKDxLaDzUDsJbTghPmWjjc3oUEvRkUzbYEYchUnhXsPqNykJxuV9x5q
Jvzu172G4w5l89ZsB7Oz/5O87yMxA+z4eVcVXo0NcgYXIFDMIuZlnI4oIVMMpqux
Nhaxhxi0g3y3QAmuKWiI2tq6/O+IO6XjG83wa/Cf34MEw9vk/qgE1O97RUeXh8K7
yiNpu1joXGH9tF5taRP4aCw4BrlAroRujcitdY+AMpwcWKXwbwbspe4FRrH65fL9
c6Mhe8mE8kM=
=cz1j
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
