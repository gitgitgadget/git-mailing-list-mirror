From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: git grep broken in Fedora 21 update?
Date: Fri, 4 Sep 2015 16:18:39 +0000
Message-ID: <B27266ED-9A9F-4127-8166-8AC235492B93@intel.com>
References: <9CAA4751-D295-4ACE-8ED6-720D728D24EA@intel.com>
 <20150904140345.GA28675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5939BD9E-47BC-42F4-86CA-4F64AD9BB75D";
	protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 18:19:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXthk-00032i-5u
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 18:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbbIDQTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 12:19:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:6816 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932473AbbIDQTC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 12:19:02 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP; 04 Sep 2015 09:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,470,1437462000"; 
   d="asc'?scan'208";a="798354365"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2015 09:18:40 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.224.2; Fri, 4 Sep 2015 09:18:40 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.4]) with mapi id 14.03.0224.002;
 Fri, 4 Sep 2015 09:18:40 -0700
Thread-Topic: git grep broken in Fedora 21 update?
Thread-Index: AQHQ5qVK0he0Hk/ldka5r3SxtdrWqZ4s3RSAgAAlsAA=
In-Reply-To: <20150904140345.GA28675@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.176.101]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277322>

--Apple-Mail=_5939BD9E-47BC-42F4-86CA-4F64AD9BB75D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On Sep 4, 2015, at 7:03 AM, Jeff King <peff@peff.net> wrote:
>=20
> Is it possible that git _is_ producing the hit, but it is getting =
eaten
> by the pager or something like that? Does "git --no-pager grep
> enter_lplu" produce the same results?

Well what do you know. Adding --no-pager gave me the right results. I =
wonder if the output isn't getting flushed to the pipe or something. In =
any case, I can add --no-pager to the alias I normally use and I'll be =
happy. The root cause will just gnaw at me for a while...

Hmm. Doing git grep enter_lplu | cat - also worked.

--
Mark Rustad, Networking Division, Intel Corporation


--Apple-Mail=_5939BD9E-47BC-42F4-86CA-4F64AD9BB75D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJV6cRfAAoJEDwO/+eO4+5uvccP/jwqA8SusOsiymOPWWfLNPkD
lPx2ZCRnRXNWBW2NWwNfbL7oijFKvxND8+tUiPKNMGviXjjpIvAmsxo2gOYiiwfA
tx57DaPlKJSYZuvg9Vu9Q6Ot8EtglqvXbWaR4L/3kAqteW54N6iwXnrWcVLCIWs6
heQ7UHwy6pN/XcPxrr+J0zKHFNjtL0P2OLXPv+9ncDw95VjHD8HDtCObGHS88Mw4
qbKgINEY4AJLUe6mD5wdohhNXnW/yMUNVVQpSASZy5WQvbJ+0xR6X8tI5bRFLjCc
GLyEewi+RARAwRxkAz6kEJixsi1tVgE8ULNUDoofPX/AbX90b0LYTRAkz0QiU1zL
I8YidnX9lLVYuGftTCzbjfrqluQADcur6FDn0I0kUu/kNYQR78zAmO/l6XP2nDSv
2NLWkXLul+39GSLqiicVxlwoB7O206l/kIUzdkcVyQMDkH6SuSthOPqeQxDNeSrX
nxqOZueVOixugJnEjxwBSlpzRhwHZArBj4jVgKX71kAbL8Jo2dWOIqwUCY01d9M7
vwZe2/W5LRBK8SBQa52eHzz5BRZKxElOL5KrbJEZjMwDx9CDUUmKCsyFNfLncKEX
i1Unjx2fH/b9J2LD+TtCmZ6L7BHeR1CPZTAcSY2ywVyACF8As/FtiededyNwxVgF
TlzBZkUVht/0jLAFbzQf
=qASe
-----END PGP SIGNATURE-----

--Apple-Mail=_5939BD9E-47BC-42F4-86CA-4F64AD9BB75D--
