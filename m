From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 3/4] Add a new test for using a custom merge strategy
Date: Wed, 30 Jul 2008 19:25:32 +0200
Message-ID: <20080730172532.GF32057@genesis.frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org> <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org> <18a8b4aaf4cc4bc720bd673166d4a7722ed79556.1217372486.git.vmiklos@frugalware.org> <ee13073cd83ff4a3cffb926b21cc54583e67f869.1217372486.git.vmiklos@frugalware.org> <7vabg09rye.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z8ClTEX/oLDAc1wN"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 19:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOFRt-0005CQ-Cv
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 19:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173AbYG3RZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 13:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756119AbYG3RZe
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 13:25:34 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37477 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbYG3RZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 13:25:33 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 957F71B24FD;
	Wed, 30 Jul 2008 19:25:32 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C4E864465E;
	Wed, 30 Jul 2008 18:40:11 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 397071190A16; Wed, 30 Jul 2008 19:25:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabg09rye.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90820>


--z8ClTEX/oLDAc1wN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2008 at 04:43:53PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> By the way, this eval shows why "theirs" cannot be a symmetric operation
> of "ours".  You are taking the last remote HEAD even when you are merging
> more than one remote into the current branch at once.  "ours" can be
> sensibly defined for an octopus, but "theirs" has this "which theirs"
> problem ;-)

Oh, well, sure. But _if_ it turns out there is a demand for that kind of
git-merge-theirs, then I suppose we could still give up if we are given
two or more remotes, just like merge-resolve and others do.

--z8ClTEX/oLDAc1wN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiQpAwACgkQe81tAgORUJZ7WgCbBPlDlKjpxG1t3gCumIqkeTm2
W3sAnj3s6ez8FbHJ7fRthlqdi5khC0Mp
=HVnY
-----END PGP SIGNATURE-----

--z8ClTEX/oLDAc1wN--
