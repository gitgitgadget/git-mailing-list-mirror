From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Fri, 23 Nov 2012 11:30:24 -0500
Message-ID: <20121123163024.GG2806@odin.tremily.us>
References: <20121123160301.GC14509@book.hvoigt.net>
 <20121123155521.GB14509@book.hvoigt.net>
 <20121123162329.GF2806@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=iAL9S67WQOXgEPD9
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 17:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbw9P-0000LJ-GY
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 17:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab2KWQaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 11:30:30 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:26628 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab2KWQa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 11:30:28 -0500
Received: from odin.tremily.us ([unknown] [72.68.108.36])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDY00E8S8IOLT40@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 23 Nov 2012 10:30:25 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 7D05F6DAF20; Fri,
 23 Nov 2012 11:30:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1353688224; bh=aHwdqbSKZiaN2VO5bF/zyRPGEdUcU6+NsJigC/js4RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=imALOv/mnrDGPQ2POE7fOVOYXUFuc5GXe0+VG3VF2m2G60dqVecjWEG6OXriFPhVy
 QbX5ux0BnWmxjFs8vyhyJ1XC7erqRbptPBm02P+wOQ8Uam7pCIW9+y7S006RajXrYW
 jXGT05edOJAa/6jJk5KwKfxCrpD60/xBPRIfrerE=
Content-disposition: inline
In-reply-to: <20121123162329.GF2806@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210266>


--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 11:23:29AM -0500, W. Trevor King wrote:
> On Fri, Nov 23, 2012 at 05:03:01PM +0100, Heiko Voigt wrote:
> > There is an important question still unanswered here for me: How does
> > the submodule get the configuration what the local branch tracks on the
> > remote side?
>=20
> A good point ;).  I'm actaully using submodule.<name>.branch to store
> the submodule's local branch name.  The remote branch name for the
> pull is implicit, and defaults to something setup according to
> branch.autosetupmerge (I think).  If you want to get more complicated
> than this, we'll probably have to add submodule.<name>.branch and
> submodule.<name>.remote sections to augment the
> submodule.<name>.branch setting.  I'm not sure this is worth it.

These settings are currently stored in

  .git/modules/<name>/config

What we're missing is a place to store them in the .gitmodules file.
I'll poke around in the module-config initialization and wait for
inspiration ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQr6SfAAoJEEUbTsx0l5OM3oAQAKa6qn6on7ELH9/b9lBzzypj
qHWCpJ9z/Obo3oQ//fDBBltgaG6AHsJEuwLLgd3CrN19vdmF5CBCS5cq35FNhBnw
65oKGNZN3g+8ZbtmBYmBh452WbdW0N87xJ1crdEmWmjfwIjp/deabjUeYp4/c8rJ
x+8pBGwojUvYdi2OSLCMRpiPWqIWUy5gGnvoLP5I7fxpRAunttnzFic6OA4GNTzx
/InTJxptQUs1yerOgSfCRMg4CtfLTTi01q0pmMSMav0iVr6TfdyEkNoCFPS+Jcse
AeHlf2l1h6pESjYwDChIWZ/l3PHsCgkrbQ9OfV2vxBruw82fczh1TL5EUNFkWWeT
9pAYkI7EI0j56NqLXh4+BxY6qqqiBW796dhDaYGWxo0bnfxyBJAyjD1znS5J9Rqr
w+w+Wc2ddK19m4L9mNktS/Csch8YtT+IAEs6vm6Eh3Evsqxnz9Jqghhr/YM6GDo2
IociWcN0pAap5/bHuU7zNo3+SHtVcMfpq9uIlXj6wfduNuJKURX2cjnjb0BPUeTc
eFB8IDh+eIJMzSWx/1q+eDKIpB3PTXLdxmrqM1RIu/BLJApE5Q6oCT2jeUVzJckH
FSKhST/1tcVgk2jcVle9m/8jDXClM1I295p7MGrZG0vWlSksThwzGV8Ix5A8VR4I
dO6lH4lJ40WCrb1c/lx+
=Av3V
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
