From: Martin Waitz <tali@admingilde.org>
Subject: Re: gitweb / cg-export
Date: Thu, 17 Aug 2006 00:40:00 +0200
Message-ID: <20060816224000.GE14459@admingilde.org>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org> <44E2F911.6060002@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 00:40:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDU3V-0002Sw-Ap
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 00:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWHPWkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWHPWkE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 18:40:04 -0400
Received: from agent.admingilde.org ([213.95.21.5]:30664 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932290AbWHPWkD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 18:40:03 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDU3M-0007Uk-WA; Thu, 17 Aug 2006 00:40:01 +0200
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Content-Disposition: inline
In-Reply-To: <44E2F911.6060002@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25538>


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Aug 16, 2006 at 04:23:05PM +0530, Aneesh Kumar K.V wrote:
> @@ -1334,6 +1335,7 @@ sub git_shortlog_body {
>  		      "<td class=3D\"link\">" .
>  		      $cgi->a({-href =3D> href(action=3D>"commit", hash=3D>$commit)}, =
"commit") . " | " .
>  		      $cgi->a({-href =3D> href(action=3D>"commitdiff", hash=3D>$commit=
)}, "commitdiff") .
> +		      " | " .$cgi->a({-href =3D> "$my_uri/$project.tar.gz?" . esc_para=
m("p=3D$project;a=3Dsnapshot;h=3D$commit")}, "snapshot") .
>  		      "</td>\n" .
>  		      "</tr>\n";
>  	}

Isn't there some other way to tell the webbroser how to name the file?
I thought there is some HTML header to explicitly give one file name.

--=20
Martin Waitz

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE456/j/Eaxd/oD7IRAqqVAJ4kynS0GVb5tTdVTO6/l7dg3n55NACeJR/5
hvcBaT1Ml9n+rK00b/XsRdk=
=rTg6
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
