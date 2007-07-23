From: VMiklos <vmiklos@frugalware.org>
Subject: having problems with building the manpages
Date: Mon, 23 Jul 2007 20:23:19 +0200
Message-ID: <20070723182319.GQ31655@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0LFOk513GRb+T2w"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 20:23:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID2ZJ-00054J-3J
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 20:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760930AbXGWSXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 14:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759900AbXGWSXf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 14:23:35 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:48527 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759153AbXGWSXe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 14:23:34 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1ID2Z3-0002wh-4J
	from <vmiklos@frugalware.org>
	for <git@vger.kernel.org>; Mon, 23 Jul 2007 20:23:33 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0047B186824B; Mon, 23 Jul 2007 20:23:19 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53457>


--i0LFOk513GRb+T2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

the man branch of git.git contains the following lines in git-diff.1:

EXAMPLES
       Various ways to check your working tree

              $ git diff            (1)
              $ git diff --cached   (2)
              $ git diff HEAD       (3)

              1. changes in the working tree not yet staged for the next commit.
              2. changes between the index and your last commit; what you would be committing if you run "git
              commit" without "-a" option.
              3. changes in the working tree since your last commit; what you would be committing if you run
              "git commit -a"

when building the manpages myself i get the followings:

EXAMPLES
       Various ways to check your working tree

               $ git diff            \fB(1)\fR
               $ git diff --cached   \fB(2)\fR
               $ git diff HEAD       \fB(3)\fR
           .sp \fB1. \fRchanges in the working tree not yet staged for the next commit.

           .br \fB2. \fRchanges between the index and your last commit; what you would be committing if you run
           "git commit" without "-a" option.

           .br \fB3. \fRchanges in the working tree since your last commit; what you would be committing if you
           run "git commit -a"

           .br

what can be the problem?

i have asciidoc-8.2.2 and docbook-xml 4.2 installed. i'm building with
ASCIIDOC8=YesPlease.

if i missed any required info, please mention :)

thanks,
- VMiklos

--i0LFOk513GRb+T2w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGpPIXe81tAgORUJYRApHaAJ9Njjf1xQr5a94bAXzBJrzvIkm53QCfZ7d1
EMVrct5r8VeilA8ybimGGQI=
=eaO5
-----END PGP SIGNATURE-----

--i0LFOk513GRb+T2w--
