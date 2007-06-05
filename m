From: Stephen Touset <stephen@touset.org>
Subject: Re: [PATCH] git-svn: allow to specify svn branch for commands
Date: Tue, 05 Jun 2007 00:16:42 -0400
Message-ID: <1181017002.27463.3.camel@megatron>
References: <1181014957993-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pZ9dysxsEdwuTFAps3/e"
Cc: Eric Wong <normalperson@yhbt.net>,
	Git Central <git@vger.kernel.org>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jun 05 06:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvQUT-0000Bc-0D
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 06:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXFEERs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 00:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbXFEERs
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 00:17:48 -0400
Received: from sumo.dreamhost.com ([66.33.216.29]:38162 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXFEERr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 00:17:47 -0400
Received: from spunkymail-a14.g.dreamhost.com (sd-green-bigip-207.dreamhost.com [208.97.132.207])
	by sumo.dreamhost.com (Postfix) with ESMTP id 5A83817EFF4
	for <git@vger.kernel.org>; Mon,  4 Jun 2007 21:17:46 -0700 (PDT)
Received: from [192.168.1.52] (adsl-211-17-118.asm.bellsouth.net [68.211.17.118])
	by spunkymail-a14.g.dreamhost.com (Postfix) with ESMTP id 2A781190E3E;
	Mon,  4 Jun 2007 21:16:43 -0700 (PDT)
In-Reply-To: <1181014957993-git-send-email-sam.vilain@catalyst.net.nz>
X-Mailer: Evolution 2.11.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49155>


--=-pZ9dysxsEdwuTFAps3/e
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-06-05 at 15:42 +1200, Sam Vilain wrote:
> "git-svn dcommit" ends up making an arbitrary decision when pushing
> back merges.  Allow the user to specify which one is used, albeit in a
> rather hack-ish way.

I've been thinking about this. I'm rather new to git internals, but if
I've created a local copy of a remote branch (git-checkout -b
local-branch --track remote-branch), can't git-svn use the tracking
metadata to determine which part of the tree to dcommit to?

--=20
Stephen Touset <stephen@touset.org>

--=-pZ9dysxsEdwuTFAps3/e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZOOq2DJ4VUTiY5sRAswUAJ467KCbnCLmcVuAQHE3f/j3lZEligCfaemh
4AOJWKntyEAsy9UypIdD820=
=cW4T
-----END PGP SIGNATURE-----

--=-pZ9dysxsEdwuTFAps3/e--
