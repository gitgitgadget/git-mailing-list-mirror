From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v7 0/3] submodule update: add --remote for submodule's
 upstream changes
Date: Wed, 12 Dec 2012 17:44:25 -0500
Message-ID: <20121212224425.GA7729@odin.tremily.us>
References: <20121204001717.GA17375@odin.tremily.us>
 <cover.1355251862.git.wking@tremily.us>
 <7vtxrr6d2f.fsf@alter.siamese.dyndns.org>
 <20121212152437.GB5157@odin.tremily.us>
 <7vzk1j3zgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiv2w-0007ec-2o
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab2LLWol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:44:41 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:54948 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab2LLWok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:44:40 -0500
Received: from odin.tremily.us ([unknown] [72.68.110.234])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEX00IYMWI1NX90@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 12 Dec 2012 16:44:30 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 5B2B271CBE0; Wed,
 12 Dec 2012 17:44:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1355352265; bh=rbc9A8AQiec/6Es7ApSNgzPWP6paIEl0FloTAUaVUXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m7P+wm397LXSBuHBWcqDQ1UKpZ3b/HAUqKuObOKGKNSjgCQWh+GFEBVtF4m7C+d9Y
 PfEXgvoYsTS0Swuyzd1ECehwF1QidWfdI/1uOswG6OFjZC21uGMRdFP/cWUuPvlfzL
 DV9Zjo97GvolyiqgT0K0d6tjuRznE5dQ1wC65Icg=
Content-disposition: inline
In-reply-to: <7vzk1j3zgr.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211406>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 10:19:32AM -0800, Junio C Hamano wrote:
> In any case, I ended up applying them by editing the patches, and I
> should have a good copy in 'pu'.  Please double check the result.

Your 'pu' branch looks good to me.  Most of the differences with my
initial patch are due to irrelevant context lines.  I would change
patch 3 (commit 2f507f9a in 'pu') to use

  git config -f .gitmodules submodule."$sm_name".branch "$branch"
                                           ^
instead of

  git config -f .gitmodules submodule."$sm_path".branch "$branch"
                                           ^
to match the nearby changes from 73b0898d.

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQyQjIAAoJEEUbTsx0l5OMmhsQAIckKzQienn6Jyz1A2s8QD+F
PYTyyGQZzdvfcbL4H7Rppaef1bm9Wp4S/cIRXvx6kjEh57VWFmdLV7D5I7cUpZVE
0U3f3VixnO6kcaCCKLxpXzCMkcJsE6y5dkoZBh2LF0QED7bGOBkF6toVbGtKakNI
zJnOdNSKez3lwxZd+R52vrSecX6WoFyQHIHmRXwWUAyw2gHj7/SdGUPCqXMRkrjL
lJagxsy0/sk6GbYtUE/E1T8mZDM1qXHlGvz0R1YCQE5vTi7Zrst2BBAXz5gc6Qmj
hzHq0J3OpaRn2VAY3CMja4KDAlH2W3Dk7LF78JW2Gg8RbmC0LmsnvK7OlvfbB9gv
+eF34b268N16M9q+AcRqkPtm66NJy5BAXCVqbM3jTcDnnRWjWVuc1O4aN9HWL6kU
Yd/4RHJ1E9vM5juX0x6c0hW7YLjjj+AP803SRHHNxGPZJ3T3Pd+2/AB+4cSuVByQ
IKnTwOfHi/CaLXNTOfpwQeY3gH/Bnq1Y50b/kCSPt0johApWTYP4fO3kdqAHogHt
5MaOSNvfEx1EtlnYVpUTpQNCaQom2FNRYwPOwcD6xG6Ryzjwo8Gd3+qynXydTbZZ
tvMEwNJDA6L+m97uOZhr5zYfmHgtyrtSZ752mD7x/QJ7AHR25uu59+KMfFmVNcoV
iYmgCCjLj0nUr37Nugla
=ZiNV
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
