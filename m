From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] git-http-fetch: Allow caching of retrieved objects by proxy servers
Date: Wed, 14 Sep 2005 17:12:36 +0400
Message-ID: <20050914131236.GH24405@master.mivlgu.local>
References: <20050913153858.GB24405@master.mivlgu.local> <7vfys93qn5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 15:15:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFX45-0001aI-FF
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 15:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVINNMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 09:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbVINNMi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 09:12:38 -0400
Received: from mivlgu.ru ([81.18.140.87]:8641 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S965186AbVINNMh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 09:12:37 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 5C2E7180119; Wed, 14 Sep 2005 17:12:36 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfys93qn5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8523>


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2005 at 08:59:26AM -0700, Junio C Hamano wrote:
> Sergey Vlasov <vsu@altlinux.ru> writes:
>=20
> > This patch removes the "Pragma: no-cache" header from requests for all
> > files except the pack list (objects/info/packs) and references
> > (refs/*), which are really mutable and should not be cached.
>=20
> Thanks.  What the patch does looks reasonable.
>=20
> Do you know if we can use it for any reasonably recent version
> of curl?  I seem to recall we already do things slightly
> differently depending on LIBCURL_VERSION_NUM.

http://cool.haxx.se/cvs.cgi/curl/include/curl/curl.h?rev=3D1.1&content-type=
=3Dtext/vnd.viewcvs-markup
shows that CURLOPT_HTTPHEADER, curl_slist_append() and
curl_slist_free_all() were available in Dec 1999, curl 6.3.1.  The FAQ
entry about disabling "Pragma: no-cache" is from Aug 2, 2000.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDKCHEW82GfkQfsqIRAghBAJ0UKaqeSqgSURbmhTDhWHJLokzuKgCfULF2
EGfaSvQuEyC76Qto5HzhDUk=
=X/PH
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
