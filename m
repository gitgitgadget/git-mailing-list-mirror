From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 07:48:42 -0500
Message-ID: <20121201124842.GA32291@odin.tremily.us>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
 <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=bg08WKrSYDhXBjb5
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 13:49:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TemVZ-0003x9-FH
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 13:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab2LAMsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 07:48:50 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:58115 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab2LAMst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 07:48:49 -0500
Received: from odin.tremily.us ([unknown] [72.68.81.135])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEC00MRNRL7AK40@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 06:48:49 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id D0D1C6E3AFF; Sat,
 01 Dec 2012 07:48:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354366122; bh=UyLK22eNmz+yHRfU3etzMAS4i49Pw2+QhO20uyDDgbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WER38nikb/F07f1e5c2NWZP7+VoK7sbOQyz+q2naW2zSBfMINFoMV2uElUzL6PUrD
 qucNmxVBd7oxXN9PxEXGfvvm5xUhQAZ7WuhIdUTQ3G9EbjJRrk6SUm0dGHnHNo/8yM
 IFQCfYFhxDeBE4mSXeNE9x5L+GsK3hOQzdGhB8aU=
Content-disposition: inline
In-reply-to: <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210970>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2012 at 06:52:22PM -0500, Phil Hord wrote:
> If I never 'submodule init' a submodule, it does not get visited by
> 'git submodule foreach', among others.  I think some people use this
> behavior explicitly.

This is something I'll fix while working up a trial patch.  Currently
cmd_update calls module_clone if the <submodule>/.git does not exist.
This should probably happen in each command (in a wrapper around
module_list?).  It's possible that module_list itself would need some
work, but I haven't absorbed its implementation yet [1].

Trevor

[1]: I read Perl by sounding out each letter ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQufylAAoJEEUbTsx0l5OMUs4QAJ1fb1yhhrpdaClpN2mGGnGq
5d2DlqwDCyBE5rqntuXOmU0PGyt7hnzHioI15UwpJiSBGIWBK2j1i9bPvgOdifyo
uiOukWuDBoP7Vnj1KJQgto8WAC/eXoF9n9zewYKZV/xpvdoxI/fui2zvWqw4lz9D
d1cIvfKRdkVfiNyxmQIfTcMbXwBzbJpCxMxIIAxzg4nwausZtzH4UPqX81MDE3VQ
0D3wmtceBDsRHS1aOOtDJIYlppiOKKMLgZHP+Hm8hMx+ZkzXUijJMbqLdkMbmrH+
P+ZdwfxG2LRxXTi9v0Sz9ZAbfyi4auL9vJCDZBqXg/rJGh3c+wlA9pW3tsLXKfD+
3XmLBT8gZDHMJvTMSfqiXpsbHKeMfk/hw7KuvfVfxNKUXS+5AJdkzqK5Vu00n0xh
pWCWP5hPDIBfIajwX479cVj3MEuQ0fVyJkh3o3r/SBq1xRL0dpX7HVKQlM9QNsS5
j22PnFttDsk+oKkSPmqapBpX1YGXzxde66LNvtpCx9opxxQgp2U5wzEne7RGXo5r
6Fgv3FLAyiIm5kQ1IMZB90lOjsCTEsl7myvPoIc5Au4wkzbVhWl8L+asBQt3PTdY
mNagoa837uHauERbfC9gujt6tYFGFBl4AQ2LZGn3EyCKo1v5j0Pq1AifiiaXGnE2
CklvtsR9Q2PGm/LmtHQ4
=Kvys
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
