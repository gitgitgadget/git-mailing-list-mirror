From: VMiklos <vmiklos@frugalware.org>
Subject: git log vs git diff vs --name-status
Date: Thu, 23 Aug 2007 10:43:15 +0200
Message-ID: <20070823084315.GA31174@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 10:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8Hs-0006vz-Q8
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 10:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbXHWIn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 04:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755434AbXHWIn0
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 04:43:26 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:57873 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbXHWInZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 04:43:25 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IO8Hf-0006Lp-8O
	from <vmiklos@frugalware.org>
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 10:43:22 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E2D9B186803F; Thu, 23 Aug 2007 10:43:15 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56473>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

$ git diff HEAD --name-status
M       dir/foo1

then i commit this change, and git log says:

$ git log --name-status -1
commit c9128f447c614d5b085286d9d7e84a643fbaea92
Author: VMiklos <vmiklos@frugalware.org>
Date:   Thu Aug 23 10:41:38 2007 +0200

    foo

M       dir

only. no /foo1. also is the file is dir/subdir/file1, then only "M dir"
is shown. is this inconsistency expected?

yes, i know that using --stats this problem could go away, but i speak
about --name-status

thanks,
- VMiklos

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGzUije81tAgORUJYRAlKYAJ0ZaSHd5z9V+8e3ps6DBO5AomWhmgCffBF6
S6HHHEuqJyGsVSDu7xnD3RM=
=kG4t
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
