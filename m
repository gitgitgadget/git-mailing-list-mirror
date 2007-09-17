From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: testsuite problems
Date: Mon, 17 Sep 2007 23:41:03 +0200
Message-ID: <20070917214103.GA13298@artemis.corp>
References: <20070917211742.GF19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/9DWx/yDrRhgMJTb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:43:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXOMj-0004FC-By
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 23:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758740AbXIQVlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758689AbXIQVlL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 17:41:11 -0400
Received: from pan.madism.org ([88.191.52.104]:60652 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758563AbXIQVlK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 17:41:10 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 060001F7CA;
	Mon, 17 Sep 2007 23:41:04 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 104E1344C33; Mon, 17 Sep 2007 23:41:04 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070917211742.GF19019@genesis.frugalware.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58483>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2007 at 09:17:42PM +0000, Miklos Vajna wrote:
> hello,
>=20
> i was running 'make test' on v1.5.3.1-109-gacd6917 and i hit the
> following issue:
>=20
[...]
> * FAIL 21: validate file contents
>         diff -r a d/a
> *   ok 22: git archive --format=3Dzip with prefix
> *   ok 23: extract ZIP archive with prefix
> *   ok 24: validate filenames with prefix
> * FAIL 25: validate file contents with prefix
>         diff -r a e/prefix/a
> *   ok 26: git archive --list outside of a git repo
> * failed 2 among 26 test(s)
> make[1]: *** [t5000-tar-tree.sh] Error 1
> make[1]: Leaving directory `/home/vmiklos/git/git/t'
> make: *** [test] Error 2

  Well, it works for me:

$ git describe && git st
v1.5.3.1-109-gacd6917
# Not currently on any branch.
nothing to commit (working directory clean)

$ cd t && ./t5000-tar-tree.sh
*   ok 1: populate workdir
*   ok 2: add files to repository
*   ok 3: git archive
*   ok 4: git tar-tree
*   ok 5: git archive vs. git tar-tree
*   ok 6: validate file modification time
*   ok 7: git get-tar-commit-id
*   ok 8: extract tar archive
*   ok 9: validate filenames
*   ok 10: validate file contents
*   ok 11: git tar-tree with prefix
*   ok 12: extract tar archive with prefix
*   ok 13: validate filenames with prefix
*   ok 14: validate file contents with prefix
*   ok 15: create an archive with a substfile
*   ok 16: extract substfile
*   ok 17: validate substfile contents
*   ok 18: git archive --format=3Dzip
*   ok 19: extract ZIP archive
*   ok 20: validate filenames
*   ok 21: validate file contents
*   ok 22: git archive --format=3Dzip with prefix
*   ok 23: extract ZIP archive with prefix
*   ok 24: validate filenames with prefix
*   ok 25: validate file contents with prefix
*   ok 26: git archive --list outside of a git repo
* passed all 26 test(s)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7vRvvGr7W6HudhwRAusnAJsGIvGZDC9TFaoFl8/Q8dmspS4GUACfR4su
nqVFifgkGI1Dmq8xW5SqUUM=
=BIPv
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
