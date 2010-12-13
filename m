From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 13 Dec 2010 16:46:28 -0500
Message-ID: <20101213214628.GA13447@onerussian.com>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <20080718094404.GB32184@machine.or.cz>
 <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
 <loom.20101213T194818-377@post.gmane.org>
 <7vbp4pz9hf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="29v4wwwYFo25Y52C"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 23:22:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSGmS-0006ms-B6
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 23:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190Ab0LMWV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 17:21:58 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:60213 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab0LMWV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 17:21:57 -0500
X-Greylist: delayed 2126 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2010 17:21:57 EST
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PSGE0-0003CR-VJ; Mon, 13 Dec 2010 16:46:29 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PSGE0-0003CO-Ih; Mon, 13 Dec 2010 16:46:28 -0500
Content-Disposition: inline
In-Reply-To: <7vbp4pz9hf.fsf@alter.siamese.dyndns.org>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: gitster@pobox.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163601>


--29v4wwwYFo25Y52C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, 13 Dec 2010, Junio C Hamano wrote:
> would make sense only if used with --no-commit.

> But for such a use case, "git read-tree -m -u 0.2" would work just as
> well, and discussion ended there ;-)

hm -- read-tree sounded like yet another unknown to me feature of GIT I
was trying desperately to discover ;)  unfortunately it doesn't produce a m=
erge
for me :-/ -- just a simple commit with the state taken from the other tree:

$> git read-tree -m -u origin/master                =20
cached/staged changes: 179 changes =20

$> git commit -m 'blunt merge for -s theirs: -m -u origin/master '
[maint/0.5 b246251] blunt merge for -s theirs: -m -u origin/master
 175 files changed, 9589 insertions(+), 4914 deletions(-)
 create mode 100644 doc/pics/ex_curvefitting_bold.svg
 create mode 100644 doc/pics/ex_curvefitting_searchlight.svg
 ...
$> git show HEAD^2                                               =20
fatal: ambiguous argument 'HEAD^2': unknown revision or path not in the wor=
king tree.

I am using git (Debian amd64): 1:1.7.2.3-2.1 (so it is 1.7.2.3)

--=20
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik       =20

--29v4wwwYFo25Y52C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0GlDQACgkQjRFFY3XAJMjBTgCfVe1hNvbkhXb+jFKOIh5fUCGw
QjQAn3rS78dN5tEHYoKtQNZhzztwyVAF
=9oIb
-----END PGP SIGNATURE-----

--29v4wwwYFo25Y52C--
