From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: malformed threads when using both --in-reply-to and --compose with
 git send-email
Date: Tue, 30 Mar 2010 00:49:32 +0200
Message-ID: <1269902972.3392.42.camel@kheops>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EwBq8Xyar2i1teURsj/H"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 30 00:49:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwNm6-0001um-BI
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 00:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab0C2Wtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 18:49:33 -0400
Received: from lo.gmane.org ([80.91.229.12]:50611 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562Ab0C2Wtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 18:49:32 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NwNlx-0001sC-UR
	for git@vger.kernel.org; Tue, 30 Mar 2010 00:49:30 +0200
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 00:49:29 +0200
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 00:49:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143525>


--=-EwBq8Xyar2i1teURsj/H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

I don't know if it's the wanted behavior but It seemed odd to me.

If I want to send a series of patches to an already started thread using
--in-reply-to option and --compose this is what I would get :

git send-email --to git@vger.kernel.org --compose --in-reply-to <Message
#2> --format-patch HEAD~2

+ Message #1
  + Message #2
    + [PATCH 0/2] My Serie of patches
    + [PATCH 1/2] My first patch
    + [PATCH 2/2] My second patch

I would have expected something more like this which is done when
starting a new thread :

+ Message #1
  + Message #2
    + [PATCH 0/2] My Serie of patcher (In-Reply-To : <Message #2>)
      + [PATCH 1/2] My first patch (In-Reply-To : <My Serie of patches>)
      + [PATCH 2/2] My second patch (In-Reply-To : <My Serie of
patches>)

Regards.

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-EwBq8Xyar2i1teURsj/H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuxLnsACgkQ+TklUoyVcyezDQCgmn+2ApyeMjxY2oSJqIdaxiue
DFsAoLqo2U02UvOnwzG5hVSJFrK0LhWE
=WGfD
-----END PGP SIGNATURE-----

--=-EwBq8Xyar2i1teURsj/H--
