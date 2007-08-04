From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sun, 05 Aug 2007 01:03:09 +0200
Message-ID: <46B505AD.4010009@lsrfire.ath.cx>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com> <46B4DF39.2070506@lsrfire.ath.cx> <Pine.LNX.4.64.0708042232390.14781@racer.site> <46B4F923.3090604@lsrfire.ath.cx> <Pine.LNX.4.64.0708042328000.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 01:03:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHSed-00027L-EP
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 01:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbXHDXDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 19:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbXHDXDQ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 19:03:16 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:57339
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932150AbXHDXDQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 19:03:16 -0400
Received: from [10.0.1.201] (p508EBCE0.dip.t-dialin.net [80.142.188.224])
	by neapel230.server4you.de (Postfix) with ESMTP id 0FECD8B008;
	Sun,  5 Aug 2007 01:03:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0708042328000.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54919>

Johannes Schindelin schrieb:
> Then you make an untracked directory called untracked/.  Tradition=20
> dictates that when we're in that directory, we get the prefix=20
> "untracked/", because we might add a file, or reference a file in ano=
ther=20
> branch, where that directory is _not_ untracked.

The test is modelled after the install script; Documentation/ (the CWD
during 'make quick-install-doc') is not tracked in branch origin/man.

> So it is expected that checkout-index and ls-files behave differently=
=20
> in a subdirectory (even if that is currently untracked).
>=20
> It seems a bit counterintuitive that read-tree succeeds, but really,=20
> read-tree is only a commit -> index operation, which should not care =
about=20
> the current prefix.  So it is fine.
>=20
> Checkout-index, instead, is an index -> working tree operation, and f=
or=20
> most of these, we care about the current prefix (so that you can say =
git=20
> checkout-index file1, where file1 is in the current directory, which =
is=20
> _not_ the working tree root).

OK, makes sense.

Thanks,
Ren=E9
