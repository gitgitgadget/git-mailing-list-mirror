From: Miklos Vajna <vmiklos@frugalware.org>
Subject: testsuite problems
Date: Mon, 17 Sep 2007 23:17:42 +0200
Message-ID: <20070917211742.GF19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 23:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXO0T-0003rO-Qc
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 23:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760982AbXIQVRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 17:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760974AbXIQVRy
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 17:17:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36693 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932669AbXIQVRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 17:17:52 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IXNyW-0002L3-Uh
	from <vmiklos@frugalware.org>
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 23:17:51 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CCCE71678012; Mon, 17 Sep 2007 23:17:43 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58482>


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello,

i was running 'make test' on v1.5.3.1-109-gacd6917 and i hit the
following issue:

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
*   ok 18: git archive --format=zip
*   ok 19: extract ZIP archive
*   ok 20: validate filenames
* FAIL 21: validate file contents
        diff -r a d/a
*   ok 22: git archive --format=zip with prefix
*   ok 23: extract ZIP archive with prefix
*   ok 24: validate filenames with prefix
* FAIL 25: validate file contents with prefix
        diff -r a e/prefix/a
*   ok 26: git archive --list outside of a git repo
* failed 2 among 26 test(s)
make[1]: *** [t5000-tar-tree.sh] Error 1
make[1]: Leaving directory `/home/vmiklos/git/git/t'
make: *** [test] Error 2

$ tar --version
tar (GNU tar) 1.18

$ diff --version
diff (GNU diffutils) 2.8.1

maybe these versions are too new or old? if i missed any needed info,
please let me know.

thanks,
- VMiklos

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG7u72e81tAgORUJYRAnQqAJ9YwfUs2Ko9/c5M6dMCA7JkcamRJwCfTIg+
6K0ypVmJRJVN4qxuhojrC/c=
=U4Cc
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
