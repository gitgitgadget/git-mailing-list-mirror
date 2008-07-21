From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] checkout without arguments does not make sense
Date: Mon, 21 Jul 2008 23:44:59 +0200
Message-ID: <20080721214459.GJ32057@genesis.frugalware.org>
References: <200807212206.32818.johannes.sixt@telecom.at> <20080721204955.GI32057@genesis.frugalware.org> <32541b130807211436h77bf5985xa61ed7b4941c47dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 23:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL3Cp-0001cU-2N
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 23:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbYGUVpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYGUVpH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 17:45:07 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54032 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbYGUVpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 17:45:06 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B11801B2528;
	Mon, 21 Jul 2008 23:45:03 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A7F404465E;
	Mon, 21 Jul 2008 23:04:37 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6E47611901B3; Mon, 21 Jul 2008 23:44:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130807211436h77bf5985xa61ed7b4941c47dc@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89408>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2008 at 05:36:59PM -0400, Avery Pennarun <apenwarr@gmail.com> wrote:
> Eek, are we using "checkout" to get status information now?  If that
> goes wrong, you could be blowing away your locally modified data by
> accident.

Hm, let's say I have uncommitted changes to Makefile, then I'll get:

$ git checkout
M       Makefile
Your branch is ahead of the tracked remote branch 'junio/next' by 1 commit.

But it will not drop my local changes.

> I think "git status" reports this information in recent versions, doesn't it?

Right. But that shows other infos as well, for example the untracked
files, etc. So there are cases when git checkout is just better.

However, you are right about it may not be the best habit from my side
to use git checkout to get that info. ;-)

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiFA1sACgkQe81tAgORUJaUDQCeJYpPv9EuvOG/DqulGkXgsK5i
WE4AnjbiTOYPtHc+36LtlWMJoJXlQH5v
=e3+o
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
