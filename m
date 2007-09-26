From: Miklos Vajna <vmiklos@frugalware.org>
Subject: question about git-send-email
Date: Wed, 26 Sep 2007 09:51:25 +0200
Message-ID: <20070926075125.GM18370@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 09:51:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaRgH-0004to-Is
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 09:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbXIZHv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 03:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbXIZHv2
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 03:51:28 -0400
Received: from virgo.iok.hu ([193.202.89.103]:58892 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503AbXIZHv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 03:51:26 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8637D1B2525
	for <git@vger.kernel.org>; Wed, 26 Sep 2007 09:51:25 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 642996FCE9
	for <git@vger.kernel.org>; Wed, 26 Sep 2007 09:51:25 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2377413A4129; Wed, 26 Sep 2007 09:51:24 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59217>


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

maybe i do not use git-send-email as it's expected so here is my
workflow for a patch:

1) git format-patch

2) add additional comments between --- and diffstat

3) add to the patch

4) add cc the patch

5) add in-reply-to to the patch

6) invoke git send-email

2), 4) and 5) are read properly from the edited patch, but it asks again
for 3). it seems it asks for the to field before it parses the mail.
even worse, then it sends the mail with duplicated 'to' header if one
was in the mail already.

i tried to fix it but it doesn't seem to be so trivial to me and i'm not
a perl wizard :)

also i'm not sure if this usage is ok or not. just i think it's a bit
confusing that 'cc' is read from the patch, but 'to'.

thanks,
- VMiklos

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG+g99e81tAgORUJYRAq67AJ0YJcLk9d/I7ftqe8MWEqOUQmkEuwCglUuy
eCzqfOVDmGox68B2qafjBT8=
=jFm+
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
