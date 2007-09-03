From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
	make stat use that implementation too.
Date: Mon, 3 Sep 2007 13:21:10 +0200
Message-ID: <20070903112110.GE14853@genesis.frugalware.org>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709022133190.28586@racer.site> <200709022342.42733.robin.rosenberg.lists@dewire.com> <46DBB2BE.8030505@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS9zv-0005AL-Mw
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbXICLV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 07:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbXICLV0
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:21:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48904 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754921AbXICLVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:21:25 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IS9za-0004Wi-Am
	from <vmiklos@frugalware.org>; Mon, 03 Sep 2007 13:21:21 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E843613A4153; Mon,  3 Sep 2007 13:21:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46DBB2BE.8030505@eudaptics.com>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.0.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4508]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57467>


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 03, 2007 at 09:07:42AM +0200, Johannes Sixt <j.sixt@eudaptics.com> wrote:
> >$ ls -ld x y
> >lrwxrwxrwx 1 me me     8 sep  2 23:36 x -> Makefile
> >-rw-r--r-- 1 me me 32164 sep  2 23:36 y

> And if I understand the documentation correctly, then

> $ mkdir foo && cd foo
> $ cat ../x
> x: No such file or directory

> Right?

correct.

- VMiklos

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG2+4me81tAgORUJYRAp+sAKCYhLs4nPdmiH1yjSSqlHQadSoWMQCfTzd7
1doJUwa+0tDwHp3X6wV5atI=
=WcU6
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--
