From: Joey Hess <id@joeyh.name>
Subject: Re: proposal for extending smudge/clean filters with raw file access
Date: Thu, 12 May 2016 17:02:27 -0400
Message-ID: <20160512210227.GA10786@kitenet.net>
References: <20160512182432.GA27427@kitenet.net>
 <xmqqvb2jf6dg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 23:03:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xlE-0001nJ-Nx
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbcELVDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:03:04 -0400
Received: from kitenet.net ([66.228.36.95]:46040 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbcELVDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 17:03:03 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=ROEw/3q4;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1463086947; bh=3t4w4kASDnZUBE0ashIYFyEgclHTXuM+OM/vJSR3ejc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROEw/3q4qfKFtBszUoZQuzN2YCGMe/hwJx+2fsNNTMlQGzdLOrsvd9qvRuwFdMdyp
	 TzZEtUNlYO2+g128SW739MPcfTHgeJrxu7T3NcUUi40TAnyTimNH+GDL51vbYlGOrD
	 go1CvMqdvRQXqdXHDG3NDjfAv/SFYoSdg5daWx+Y=
Content-Disposition: inline
In-Reply-To: <xmqqvb2jf6dg.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-95.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_DYNAMIC,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no autolearn_force=no
	version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294476>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> The smudge happens to be the last to run, so it is quite true that
> it can say "Hey Git, I've written it out already".
>=20
> I didn't check all codepaths to ensure that we won't need the
> smudged result in core at all, but I am guessing you did so before
> making this proposal, so in that case I would say this sounds fine.

Well, the idea is to only use smudge-to-file when the smudged content is
going to be written out to a file. Any other code paths that need to
smudge some content would use the smudge filter.

So, try_create_file would use it. Maybe some other places I have not
found yet could as well.

--=20
see shy jo

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVzTvY8kQ2SIlEuPHAQIGnBAAgn+vVGxl7p/7JDc4dqLI+M2oRNVUpzTG
A5DNtuD+3Wuy/TT1HAF9sCCdw7lxTGVHgmnAbvGeuhymsq4+7GEgk4I1UAP+21ZA
px3+mHTHdYNmoC7xHDfCytyl4SxVOs8wocWZ5m7SzL3n9r1Kpmpeuy0jnu9HP5/q
r6PScplVk91Ggmcgl+VVsZWGDw0pf1WZblJKW8BE5s9CkCAEsA5HUPhOYX6oc2Wz
b+RhbwttGDfi6Yt70jdphN3tpI7MTiXufiA88xNYvZrlGoyiwvRJICt2cU1MvgyR
ZfPtuXc6LXREYmnaR2ljlHxvLfmRXQlB9nBJz4Ha226zsJ+hO716GFxJ4vsmP/H7
RA0p3IAfEuFMeR9eQha4QFnk2i6Wf+5DXCrNpio2Ol41UNldXX1SS9Ld1A26zoFw
wQAifrdhcb/PyupGlsxUpjH9O2xFgPuTCoVldovot2qcJCmV7Dr/ed8ZjdNrkrOo
z0egJGJeVTIm9JpNGo2WjjYcjwaMcsLRR2Sp8+FUT4EyK3L7EgLLsT2y5zokhk31
ZruhcLp8DqRRy5yXEgOzkdTG2e1GfhGw30V2AM15CBZ5ZDBZ1uG49Q7H2SGFNJwr
R5zOuHU2sdx25uh7cSTaZYWOSuVShiZcHMO57mGy7g4bD5kgJYSKbH8uEVgrCpWb
+WjnQ8r5VYw=
=a0Z0
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
