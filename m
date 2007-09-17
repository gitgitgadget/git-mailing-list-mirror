From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: testsuite problems
Date: Tue, 18 Sep 2007 00:48:28 +0200
Message-ID: <20070917224828.GI19019@genesis.frugalware.org>
References: <20070917211742.GF19019@genesis.frugalware.org> <46EEF6A8.1030308@lsrfire.ath.cx> <20070917220408.GG19019@genesis.frugalware.org> <Pine.LNX.4.64.0709172337470.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPPE-0007mh-Ag
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875AbXIQWsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 18:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756853AbXIQWsl
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:48:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42246 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754770AbXIQWsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:48:40 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IXPOO-0004bF-AT
	from <vmiklos@frugalware.org>; Tue, 18 Sep 2007 00:48:39 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 55DC01678012; Tue, 18 Sep 2007 00:48:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709172337470.28586@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58489>


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2007 at 11:40:27PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> Ah, that's my friend GNU diff again... Try running the test with "-i -v",=
=20
> and it will pass, if I am right.

* expecting success: diff -r a d/a
diff -r a/l1 d/a/l1
1c1
< simple textfile
---
> a
\ No newline at end of file
* FAIL 21: validate file contents
        diff -r a d/a

it still fails, so i don't think this is that issue

- VMiklos

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG7wQ8e81tAgORUJYRAs8UAKCllcvYFlk+wCumdR8SP3lEEK/mggCdEqmd
gLRXB0+7hpHrRvWM1lz9G98=
=5tp+
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
