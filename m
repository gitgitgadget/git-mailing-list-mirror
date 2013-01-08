From: "W. Trevor King" <wking@tremily.us>
Subject: Re: submodule name and path
Date: Tue, 08 Jan 2013 13:29:14 -0500
Message-ID: <20130108182914.GH4662@odin.tremily.us>
References: <CAHtLG6TuHtk2P3w70-vUVGkdrv7R3VWyMzkGA4sr=G8xiSuEjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:29:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsdvr-0005aY-N5
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab3AHS3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:29:32 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:60734 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641Ab3AHS3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:29:31 -0500
Received: from odin.tremily.us ([unknown] [72.68.82.220])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MGB00K13KOQ0V50@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 08 Jan 2013 12:29:16 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 594EE77F51A; Tue,
 08 Jan 2013 13:29:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357669754; bh=YUSx+3NfGb5EBaRUUXzSynjtiiKfk6GHVAaJdWA4DdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XHEtRc1eVvQOsYpgqvdgjxirzkk9B6tsmvwSSIONbLKgSeH3dFkU+362jehw2s81m
 Z2y3TTbV33lReYgQbgwUNU5AWK63ahI5Dd4i7AqqVBFMRBRTR/L52DGrIduyqVzDon
 Nka9LbavYhFWYqwPaIpeDaVpLkEa7Kt3fjL1KweM=
Content-disposition: inline
In-reply-to: <CAHtLG6TuHtk2P3w70-vUVGkdrv7R3VWyMzkGA4sr=G8xiSuEjA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212991>


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2013 at 02:17:42AM +0800, =E4=B9=99=E9=85=B8=E9=8B=B0 wrote:
> In doc, "submodule name" is not clearly mentioned?
> What is the purpose of "submodule name"?
> Must be same as "submodule path"?
> "submodule path" can be repeated, while "submodule name" unique?

The submodule name starts out the same as the submodule path, but the
name stays constant through submodule moves, replacements, etc.  The
constant name is useful because out-of-tree configuration (e.g. stuff
in .git/config and .git/modules/) won't have to adjust to submodule
renames (except for core.worktree in .git/modules/*/config).

See:

http://article.gmane.org/gmane.comp.version-control.git/49621
http://article.gmane.org/gmane.comp.version-control.git/206659

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7GV4AAoJEEUbTsx0l5OMQ3UP/RoG7ivhnxoG6cwqFP6L47bU
PGgk+mrLJtmSg/jC4dsYSHLd8MYAkmR3t6fUOozWEoiptIXE2ZuykHE8Fi7Z1gz4
9uqSsW5F9MH/+vD2hRFruwlhc91xlrxsYHhEHZiww5+6FQKWHrwL3P2esFqg2GrG
1entZ2y0fSTuZiyolL80ha7/q6KIh6bW/Z3YFpjp5VjIsR1dFqv1QESNp+utCN98
lHktYs3x14Kpj7vxUauncac6b3CCpPLtR4g6u+bidVCuNSN4koOy1EFIGAgfhvk0
N/EaEHwqq54rEJ6wlayXTAVsMi8hPTyiYq8ISaouAn8Jw5rP5uRI7PWuKixve+9/
ofFuIeb3+EfuZOlkbSmZYaM+CXw++jz0hmiWbpUgnyymfVLJH8hC+VNdpEMHwild
B1GxkcQICRYO0hn1S/5yQkghZlU4fciGMhqTmxrVjwUiY2KW9klOjO31j7847DUW
w6ly2FcYlu/t6mK/rdveAOoqaPmGKU2uZJn2R/W9QiJkiJLXB2o83yTb4B5PR4rI
JUFpaNqActGM/CVQdugYfBqmiQ8J5GQOW+gq0K+qwJ4igleF8MY9nTRekqi44Y6v
nt4yq6D2IdxyAP5oG0a4pJk59A/TG4dAJb6BbsoTMVdOSNNpHW/13PRT+tmZBAcD
uQbVC5OvPwWW17E4MbX1
=nAmh
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
