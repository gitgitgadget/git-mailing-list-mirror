X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 12:45:46 +0100
Message-ID: <20061217114546.GG12411@admingilde.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <20061216230108.GE12411@admingilde.org> <200612170015.24162.jnareb@gmail.com> <200612170101.09615.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
NNTP-Posting-Date: Sun, 17 Dec 2006 11:46:20 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612170101.09615.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34686>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvuTC-0002c4-Sy for gcvg-git@gmane.org; Sun, 17 Dec
 2006 12:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752478AbWLQLps (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 06:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbWLQLps
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 06:45:48 -0500
Received: from mail.admingilde.org ([213.95.32.147]:39264 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752478AbWLQLpr (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 06:45:47 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GvuSg-0003Hd-FN; Sun, 17 Dec 2006 12:45:46 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Dec 17, 2006 at 01:01:09AM +0100, Josef Weidendorfer wrote:
> IMHO it simply is added flexibility to allow a checkout to be separate fr=
om
> the .git/ directory, same as explicitly setting $GIT_DIR would do.
> So this .gitlink file is on the one hand one kind of convenience for users
> which want to keep their repository separate, yet do not want to specify
> $GIT_DIR all the time in front of git commands.
> The .gitlink file simply makes the linkage to the separate repository
> persistent.

I can see the reason for wanting to use another object database,
but HEAD and index should always be stored together with the
checked out directory.  So perhaps we just need some smart way to
search for the object database, but keep the .git directory.

--=20
Martin Waitz

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFhS3qj/Eaxd/oD7IRAkDRAJ0TnZIIzLL6nhKiBeDelH/Ge0dISwCeJyD/
1Qsmyv8qbg+NuIRf8nGjCbk=
=xc1c
-----END PGP SIGNATURE-----

