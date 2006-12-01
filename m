X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 20:38:02 +0100
Message-ID: <20061201193802.GI18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <20061201165418.GD18810@admingilde.org> <45706758.2020907@b-i-t.de> <200612011917.19252.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="14PCYtZiSn5RZRtk"
NNTP-Posting-Date: Fri, 1 Dec 2006 19:38:28 +0000 (UTC)
Cc: git@vger.kernel.org, sf@b-i-t.de
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612011917.19252.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32959>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqED3-0004vM-Qi for gcvg-git@gmane.org; Fri, 01 Dec
 2006 20:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031758AbWLATiG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 14:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031759AbWLATiG
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 14:38:06 -0500
Received: from agent.admingilde.org ([213.95.21.5]:29649 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031758AbWLATiD
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 14:38:03 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqECw-0000nr-7r; Fri, 01 Dec 2006 20:38:02 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--14PCYtZiSn5RZRtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 07:17:17PM +0000, Andy Parkins wrote:
> In fact, why should the submodule commits be even visible in the
> supermodule?  That tree->submodule commit is sufficient; there isn't
> any need to view submodule history in the supermodule.

Well, but there is a need for a common object traversal.
You need that when sending all objects between two supermodule versions
and also when you determine which objects are still reachable.

The easiest way to implement the common object traversal is to have all
objects in one object repository.

It may be possible to use two object stores and still do the common
object traversal but I do not think that gives you any benefits.
You still don't have a totally separated repository then, because
you can't do a reachability analysis in the submodule repository alone.

--=20
Martin Waitz

--14PCYtZiSn5RZRtk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcISaj/Eaxd/oD7IRAuYFAJ9gmM7eIiW2J8XBRzQYtMV39HxpKQCfd8Fi
5xDinxlPo5tivRt4Qxezuf4=
=OQ3A
-----END PGP SIGNATURE-----

