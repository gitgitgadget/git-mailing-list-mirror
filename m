From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 1/2] configure: Allow GIT_ARG_SET_PATH to handle --without-PROGRAM
Date: Mon, 01 Feb 2010 16:23:25 -0500
Message-ID: <1265059258-sup-1123@ntdws12.chass.utoronto.ca>
References: <1264990505-29578-1-git-send-email-bwalton@artsci.utoronto.ca> <1264990505-29578-2-git-send-email-bwalton@artsci.utoronto.ca> <7vwrywu08v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1265059407-863637-7546-3250-5-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:23:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc3k6-0006PT-Mp
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 22:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab0BAVX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 16:23:29 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:48315 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab0BAVX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 16:23:28 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:46273 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Nc3jz-0000Gz-W6; Mon, 01 Feb 2010 16:23:28 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Nc3jz-0003rf-Tm; Mon, 01 Feb 2010 16:23:27 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id o11LNRun014855;
	Mon, 1 Feb 2010 16:23:27 -0500
In-reply-to: <7vwrywu08v.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138649>


--=-1265059407-863637-7546-3250-5-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Junio C Hamano's message of Mon Feb 01 16:14:40 -0500 2010:

> Perhaps we can clean-up with-/without-tcltk part in configure.ac using
> this?

Sure and I'd be happy to do this.

I noticed (after I sent the patches) that NO_PYTHON is set in the
Makefile automatically if --with-python= is used (leaving PYTHON_PATH
set to null).  I prefer the nicer --without-python personally.

I'll fix up the tcltk option and scan for others that might need
similar treatment.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302


--=-1265059407-863637-7546-3250-5-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFLZ0ZP8vuMHY6J9tIRAt35AKC7ba1It1Wwo5iGqZuKATUeshDIrACfcIa8
wxGVYfhVgZGbzYL6eTtdsfQ=
=WMb1
-----END PGP SIGNATURE-----

--=-1265059407-863637-7546-3250-5-=--
