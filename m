From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 03:25:42 -0400
Message-ID: <4338F3F6.8040401@michonline.com>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <20050926212536.GF26340@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0B67FE4C66B10A193FF574A1"
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 09:27:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK9ql-0003mV-QJ
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 09:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVI0HZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 03:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVI0HZ7
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 03:25:59 -0400
Received: from mail.autoweb.net ([198.172.237.26]:4031 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S964848AbVI0HZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 03:25:59 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EK9qU-0000JO-SL; Tue, 27 Sep 2005 03:25:46 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EK9qU-0003L6-00; Tue, 27 Sep 2005 03:25:46 -0400
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.52)
	id 1EK9qU-0007S2-7X; Tue, 27 Sep 2005 03:25:46 -0400
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926212536.GF26340@pasky.or.cz>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9377>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B67FE4C66B10A193FF574A1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:
> So the strategy I'm thinking of now is to manually (I think no GIT tool
> can do that for me) dereference the possible tag chain until I end up at
> some non-tag object. Now, if it is a commit and I don't have it yet, it
> means that it is not interesting to me because it does not belong to a
> branch I'm following, so I will just ignore the tag (won't download
> anything else and won't record it in the refs/tags directory).

git-rev-parse $tagname^0


--------------enig0B67FE4C66B10A193FF574A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDOPP5fhVDhkBuUKURAjq/AKCl7nY2RN5NBG8FgcfuIPJSiEMejACgiuj1
UilvLx4husjZT3djoOa3sbs=
=3C7k
-----END PGP SIGNATURE-----

--------------enig0B67FE4C66B10A193FF574A1--
