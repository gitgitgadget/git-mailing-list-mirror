From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 06/13] Add guide-list.txt and extraction shell
Date: Sun, 24 Feb 2013 09:51:13 -0500
Message-ID: <20130224145113.GJ1361@odin.tremily.us>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
 <1361660761-1932-7-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9Q2l3mYpK16UQ/iv"
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 15:51:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9cvW-0008AF-W1
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 15:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086Ab3BXOvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 09:51:17 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:65329 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370Ab3BXOvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 09:51:17 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIQ00A67BXDN370@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 24 Feb 2013 08:51:14 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 85AC58C0D1E; Sun,
 24 Feb 2013 09:51:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361717473; bh=rABGxnIwT2Z9nnoUYXsSvTSEONIf6yBDjOJfJpuoR+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3bAj7JF5dOvDRng7x0EbpTIW+jUQvLwMtF4dnCMYopl0bX8QIxUhSGfej4EksNPb
 rvqeMUVsL/bxeA65E5HB0p4ORrttMnGjeGx+aH/pgdLWF7OdJ86hYjwJNX+nhWnHrH
 dhC7syljb0HsFd4ec+5M63wS7pvqxqb97dPWF0K4=
Content-disposition: inline
In-reply-to: <1361660761-1932-7-git-send-email-philipoakley@iee.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216990>


--9Q2l3mYpK16UQ/iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2013 at 11:05:54PM +0000, Philip Oakley wrote:
> +# Usage: ./generate-guidelist.sh  >>common-guides.h

Following David's recent series, it's probably better to use a
lowercase 'usage' [1].  Also, I'd expect '>common-guides.h' would make
more sense than appending with '>>'.

> +/* re-use struct cmdname_help in common-commands.h */
> +
> +static struct cmdname_help common_guides[] =3D {"

This is probably just copied from generate-cmdlist.sh, but maybe it
would be a good idea to #include "common-commands.h" here?

Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/216961

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--9Q2l3mYpK16UQ/iv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRKijfAAoJEEUbTsx0l5OMMzwQAJKW6rX7/tTdjzgpxVM+fVMj
cl3Opx7+DKW9jFp+vogoOWr6Yba0x2pkEdMmiIE3iEbTskL8AhkjtehqRPqTbP5k
wXYm9vmXaAOVm1qTXg2IWyOSL7A3lnNjHfb8nTCrZuK1MwFLeP7zp1aS6rwb6JVm
MO3Kwrf++79llU97Axkq8llOJX2aRfWNkcWRY/oPbtRR+ap1gTcSNB/Rkfutoqvj
MrO2haFpuCPlDs+Y41ZCJgoX9t2CVxHmosCpjACj5WNOreTmqS+Xd5/KaCZLzT6s
VvWlAtMOTQd/jHrw65Frj+3gI2oCOL//V1FvP/6dMCiawnnAvDe225jHE87scH/I
NOJlBVZj/cfJhQE+liBcPNJI1PHLGh+86Olywc6hPqrGVJyqr3NPY1ySEY27a13Y
aG3C1UcanLWz/M5wuo0U2lanPOQ1+Wh+5ewwtFiFjIW+BbzCXd6ped+oRNSkJvgX
ZwOXrd+wBftdn2asAPXORIjn+SAGC5U0Ln9017g4gfUtxBrh7Eb+vB6WiejUnFHS
b30QWo+vo2hI7bSbF+LFgciE5j6i/+KuPPH+WJX6OP4EefFgSETvvn5k7oEUKCUt
ywbmBa5CJcyl/Jmtv4hht65oPSh8+Lzb2bIUCGbuczh6k4gqmA3S+zhNMFfFVhir
+Wv23B/+Lyk3xaOSW/G1
=HaTa
-----END PGP SIGNATURE-----

--9Q2l3mYpK16UQ/iv--
