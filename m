From: David Bryson <david@statichacks.org>
Subject: proper flags for make check ?
Date: Tue, 7 Oct 2008 08:46:43 -0700
Message-ID: <20081007154643.GA5774@eratosthenes.cryptobackpack.org>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/ZYM6PqDyfNytx60"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 17:53:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnEmz-0005Uf-7Y
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 17:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbYJGPqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 11:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYJGPqp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 11:46:45 -0400
Received: from cryptobackpack.org ([64.105.32.74]:53944 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbYJGPqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 11:46:44 -0400
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 5071210D0271; Tue,  7 Oct 2008 08:46:44 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id C47FA10D01EE
	for <git@vger.kernel.org>; Tue,  7 Oct 2008 08:46:43 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 8C72514464; Tue,  7 Oct 2008 08:46:43 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97718>


--/ZYM6PqDyfNytx60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


After the recent discussion about make check I decided to give it a try
and see what happens.

I installed sparse, took a look at the source and it appears to want
something along the following lines for a intel processor:

-D__LITTLE_ENDIAN__ -D__i386__=1

I then type 'make check' and get about 30 seconds of errors printing out
for kerberos headers.

The errors look a lot like this:

/usr/include/krb5/krb5.h:1166:18: error: got *
/usr/include/krb5/krb5.h:1167:18: error: Expected ; at end of
declaration
/usr/include/krb5/krb5.h:1167:18: error: got *
/usr/include/krb5/krb5.h:1168:20: error: Expected ; at end of
declaration
/usr/include/krb5/krb5.h:1168:20: error: got *
/usr/include/krb5/krb5.h:1169:1: error: Expected ; end of type
declaration
/usr/include/krb5/krb5.h:1169:1: error: got }
/usr/include/krb5/krb5.h:1173:17: error: expected ; at end of
declaration
/usr/include/krb5/krb5.h:1173:17: error: Expected } at end of
struct-union-enum-specifier

What is the proper way to run sparse on the git sources ?

Dave


--/ZYM6PqDyfNytx60
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkjrhGMACgkQLfsM4nS2FiA9zQCgqW+7o2y/gHbegGxnfklKZBaz
gcwAn3Y1jCg6F//2etNfcbMHXAapBLfO
=wWO/
-----END PGP SIGNATURE-----

--/ZYM6PqDyfNytx60--
