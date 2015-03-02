From: Joey Hess <id@joeyh.name>
Subject: Re: weaning distributions off tarballs: extended verification of git
 tags
Date: Mon, 2 Mar 2015 14:12:30 -0400
Message-ID: <20150302181230.GA31798@kitenet.net>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
 <CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>
 <1425316197.895196.234425829.536E6C06@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
To: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 19:19:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSUwF-0005jk-V7
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 19:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbbCBST2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 13:19:28 -0500
Received: from kitenet.net ([66.228.36.95]:55138 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbbCBST1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 13:19:27 -0500
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2015 13:19:27 EST
X-Question: 42
Authentication-Results: kitenet.net; dkim=pass
	reason="1024-bit key; unprotected key/testing"
	header.d=joeyh.name header.i=@joeyh.name header.b=QA+SIqGH;
	dkim-adsp=pass; dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1425319950; bh=7cS3i3eJ1E0MdDVgaOeuMu1p/8g9tseC1gLCcd6A2Q4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=QA+SIqGHPwehygCOKSzlKEIjDoL+b4jrILVwnMzMGMjmiu2GXCA211WGJKujGfqqJ
	 7UbhwSxCwZtDUuvykuxalnn1/prezA/5ITIuach6zXYzVbMFfbaL89iBoas+ULCpR4
	 5F+svZElYAQpsb1u9zKl2/AIDvAplnn6fp3HJbNc=
Content-Disposition: inline
In-Reply-To: <1425316197.895196.234425829.536E6C06@webmail.messagingengine.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-99.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264607>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I support this proposal, as someone who no longer releases tarballs
of my software, when I can possibly avoid it. I have worried about
signed tags / commits only being a SHA1 break away from useless.

As to the implementation, checksumming the collection of raw objects is
certainly superior to tar. Colin had suggested sorting the objects by
checksum, but I don't think that is necessary. Just stream the commit
object, then its tree object, followed by the content of each object
listed in the tree, recursing into subtrees as necessary. That will be a
stable stream for a given commit, or tree.

--=20
see shy jo

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVPSoDMkQ2SIlEuPHAQJ3Aw//Q5dLNAsp/64TA/ea6H4YgGd9SbsUPWjO
gxTt2NQCML+DaQPVaDje60lx3MGVPfoC07DHvLDHLC6eN4V2LKRlPmS97z8XDgbK
2OhFfuWozpw3rwvcxTcum/XvRDJD9j3+aRvnz3ehtGS3pVx/FP7gjmmUZNd7/eut
leLSnC6gugIZWlYS94XSP6bczCHGx9u3ZQ6WK2fVJg6YFBMvXeXZ0lTAlts5Jpx0
K/56t38ovf0HvHmGYTriMuujjKVOXTOiFu5xq1z2u4NRAaUkS9nijsqAdOMZy35+
UqdIKe/Z2vJm3LESSL7DM3ePGyGDaTgM3d47Z4Vg54XyUWgpXODCeqvwFk3s9BYT
nrl2GHn82hyDEpNyYWO0wptH3iPV566aIdlwmPikWUSQ6zVDacfMGj99fYZeZAp6
XV/Vi90JJI9leW5ReF0m6Q3glD/VtiqAr0GOJ1vXSQHZn0xUi8981V8hvJKroTDE
Gc0rlamNg60+OtJTPYhWE8zJHSARBo1DXq41IuHoy0zaRj4jFpMLEF1ArkqLrx1I
EkR0nCKWXng/8WYuKIVGdlFGfAkIPufbTnDFGh+ObniGCa262l2Yiuqwv55IJ8hM
25+k86xuh6UWfEbgk27bfBe8wMJN7RJMHl1rr3U1h3UoKqUPuGDHKfjJ6NK6YlxH
NajPfSygF0Q=
=49s8
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
