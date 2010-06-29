From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 4/5] merge_recursive: Fix renames across paths below
 D/F conflicts
Date: Tue, 29 Jun 2010 09:54:42 +0200
Message-ID: <20100629075442.GB31048@genesis.frugalware.org>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
 <1277773936-12412-5-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k8r0khnpBuGu0wUi"
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
	spearce@spearce.org
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 29 10:11:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTVuZ-000778-Pe
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 10:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab0F2ILB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 04:11:01 -0400
Received: from virgo.iok.hu ([212.40.97.103]:44404 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab0F2IK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 04:10:59 -0400
X-Greylist: delayed 974 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2010 04:10:59 EDT
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 125F458094;
	Tue, 29 Jun 2010 09:54:43 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6C7BC44659;
	Tue, 29 Jun 2010 09:54:42 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4CEC512D90F0; Tue, 29 Jun 2010 09:54:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1277773936-12412-5-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149890>


--k8r0khnpBuGu0wUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2010 at 07:12:15PM -0600, newren@gmail.com wrote:
> From: Elijah Newren <newren@gmail.com>
>=20
>=20
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> I'm a little uneasy with this change, mainly because I don't fully
> understand the rename processing logic (I was actually kind of surprised
> when I made these changes and it worked).  Although I verified that
> these changes (and my others in this patch series) introduce no new
> breakages in the testsuite and even fix a known issue, I'm still not
> quite sure I follow the logic well enough to feel fully confident in
> this change.  I'm particularly worried I may have neglected some closely
> related cases that I should have fixed but which may still be broken.

Same here, I touched merge-recursive, but not this part of it, so others
will give you a better review, I'm sure. :)

Other than that, I like it, thanks!

--k8r0khnpBuGu0wUi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwppsIACgkQe81tAgORUJaJngCeIDit4FvYidR9F07kEyRcRvbb
+moAn0XhMzAYanxSbz2WviX8MP0biGiI
=jzXK
-----END PGP SIGNATURE-----

--k8r0khnpBuGu0wUi--
