X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florent Thoumie <flz@xbsd.org>
Subject: Problem with git-push
Date: Tue, 31 Oct 2006 14:48:18 +0000
Message-ID: <1162306098.41547.4.camel@mayday.esat.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Cw1y4yRwSBULWhzDYeHT"
NNTP-Posting-Date: Tue, 31 Oct 2006 14:48:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.8.1 FreeBSD GNOME Team Port 
X-Virus-Scanned: amavisd-new at xbsd.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30585>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geuuo-0003kG-2l for gcvg-git@gmane.org; Tue, 31 Oct
 2006 15:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423441AbWJaOsb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 09:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423450AbWJaOsa
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 09:48:30 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:30678 "EHLO
 smtp5-g19.free.fr") by vger.kernel.org with ESMTP id S1423441AbWJaOsa (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 09:48:30 -0500
Received: from smtp.xbsd.org (unknown [82.233.2.192]) by smtp5-g19.free.fr
 (Postfix) with ESMTP id E8587619 for <git@vger.kernel.org>; Tue, 31 Oct 2006
 15:48:27 +0100 (CET)
Received: from localhost (localhost.xbsd.org [127.0.0.1]) by smtp.xbsd.org
 (Postfix) with ESMTP id 7B43411AC1 for <git@vger.kernel.org>; Tue, 31 Oct
 2006 15:48:27 +0100 (CET)
Received: from smtp.xbsd.org ([127.0.0.1]) by localhost (srv1.xbsd.org
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 46969-09 for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 15:48:19 +0100 (CET)
Received: from [193.95.134.156] (mayday.esat.net [193.95.134.156]) by
 smtp.xbsd.org (Postfix) with ESMTP id EC02311A46 for <git@vger.kernel.org>;
 Tue, 31 Oct 2006 15:48:18 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--=-Cw1y4yRwSBULWhzDYeHT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi list,

I'm having some weird issues with git-push lately (1.4.1 on both ends):

: flz@cream:/tinderbox/portstrees/xorg-modular/ports; git push
updating 'refs/heads/xorg'
  from 6d1e4fce0a22da799175ec8e168dc0767f1131ef
  to   496cbd4c75220c204aac4fd1ef9912e40e0314b2
Generating pack...
Done counting 16 objects.
Result has 11 objects.
Deltifying 11 objects.
 100% (11/11) done
Total 11, written 11 (delta 4), reused 0 (delta 0)
Unpacking 11 objects
unpack unpacker exited with error code
ng refs/heads/xorg n/a (unpacker error)
unable to write sha1 filename ./objects/2d: Is a directory
fatal: failed to write object
: flz@cream:/tinderbox/portstrees/xorg-modular/ports; git push
updating 'refs/heads/xorg'
  from 6d1e4fce0a22da799175ec8e168dc0767f1131ef
  to   496cbd4c75220c204aac4fd1ef9912e40e0314b2
Generating pack...
Done counting 16 objects.
Result has 11 objects.
Deltifying 11 objects.
 100% (11/11) done
Total 11, written 11 (delta 4), reused 0 (delta 0)
Unpacking 11 objects
unpack unpacker exited with error code
ng refs/heads/xorg n/a (unpacker error)
unable to write sha1 filename ./objects/d7: Is a directory
fatal: failed to write object
: flz@cream:/tinderbox/portstrees/xorg-modular/ports; git push
updating 'refs/heads/xorg'
  from 6d1e4fce0a22da799175ec8e168dc0767f1131ef
  to   496cbd4c75220c204aac4fd1ef9912e40e0314b2
Generating pack...
Done counting 16 objects.
Result has 11 objects.
Deltifying 11 objects.
 100% (11/11) done
Total 11, written 11 (delta 4), reused 0 (delta 0)
Unpacking 11 objects
refs/heads/xorg: 6d1e4fce0a22da799175ec8e168dc0767f1131ef ->
496cbd4c75220c204aac4fd1ef9912e40e0314b2

Any idea what that could be?

Cheers.

Florent

--=-Cw1y4yRwSBULWhzDYeHT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (FreeBSD)

iD8DBQBFR2IyMxEkbVFH3PQRAiazAJ9ee9lTFXdIzcjzT/tbweXXXmY4PQCeJiLR
qkNo/GTXkgDKN2/dTOnKU6k=
=BBSP
-----END PGP SIGNATURE-----

--=-Cw1y4yRwSBULWhzDYeHT--
