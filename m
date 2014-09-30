From: "W. Trevor King" <wking@tremily.us>
Subject: Re: What's cooking in git.git (Sep 2014, #09; Tue, 30)
Date: Tue, 30 Sep 2014 13:47:05 -0700
Message-ID: <20140930204704.GI3770@odin.tremily.us>
References: <xmqq38b8svrd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 22:47:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ4KI-0001YP-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 22:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbaI3UrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 16:47:10 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:46601 "EHLO
	resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbaI3UrI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2014 16:47:08 -0400
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
	by resqmta-po-07v.sys.comcast.net with comcast
	id xYmf1o00152QWKC01Yn7rb; Tue, 30 Sep 2014 20:47:07 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by resomta-po-09v.sys.comcast.net with comcast
	id xYn51o00f152l3L01Yn64E; Tue, 30 Sep 2014 20:47:07 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 59E6113DF033; Tue, 30 Sep 2014 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1412110025; bh=YaphetUealGiw/ktDY5/YpBkz1tdtUR6PBtdUJ3FgFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jE22h1AHEZcDkmnvbg6Bbd+x0cMjDOrRKEZveufGNBW/usGjS7/+XQNTZXORdfP5j
	 Bjqgo4oxrmWW9D2yQoJ23Edc0IiZ+5c/wryeb+kbR9QON4elpyILLuyco2tqDpFLKy
	 Y4VzxV2I+QCV0QbsEEu7VJ1mktuWNtgnWuLCxX14=
Content-Disposition: inline
In-Reply-To: <xmqq38b8svrd.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1412110027;
	bh=zTWNrntek4j9tY3r3sQHGH3hUlfQwTe50Q3825wsByw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=FehZnhbaQ4AL5dkr3n7XYbb73iMt2Ww1daKGFR3nCZjaOwpB1arY38JWUn1gTUIOe
	 GNtCto/a16mIQuUggcb6jqtltdb2YQBGGgdSo9yQbmtlLYiSF1QGumlnSL8Qwq06yJ
	 lEVtnJ7dG3Vq8fU8TsXDtoWcKP7A6GlH5Lf6bT+xqGi5U9hwnByN9D1eTWy5yaP4IE
	 LJhyiEhL9kkDYEXmJ1KPad6VjkO6p1ovwk8iIfpGNmPm9kgMyWwy23W2/VGx/Dt7L7
	 VHYLe9PVU8MW7wLC/uj6kEZ0T/duIdJa/a5u3jsxku/09VhPuzYjxJxPNMqzRwcNrT
	 XM2oeE1/xZmTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257681>


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 01:23:18PM -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.

It looks like my boring git-mailinfo doc patch [1] fell through the
cracks here ;).  Or maybe it's just cooking a bit longer before
getting queued?

Cheers,
Trevor

[1]: Gmane: http://article.gmane.org/gmane.comp.version-control.git/257460
     Subject: [PATCH] docs/git-mailinfo: Mention the manual separator (---)
     Message-ID: <28b04f1c17f2cc2fe252948bc0b7bb10df24b489.1411571629.git.w=
king@tremily.us>
     Date: Wed, 24 Sep 2014 08:25:32 -0700

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKxbGAAoJEG8/JgBt8ol8OHgP/1nH1kJvkxTVc20zl+ikt1DS
0ciMQ4R4k9MydeYz9Rwvk57EF8bicU5XxykWVQeYtlMUssChWmdEdyMlRGQEZLsk
y0eGB6uZLgOLMA14eJeFTy+aD6tT86VcW2zvTTAqjPSdFvUQsRtGawCH+eY8LHRt
6QR3dDdFNJmU/4Kz4QyGsYy92V4QcVnvj6sB1VrmjjON0hloSRiFVuKiq69yW19a
Hfr2pGVDCYWgk9SStTX9w8GMY2gdpo5SGguhb+Md9ufQSyD/7pZVM5V6LgvzTnLX
kVzIFwbhzKe2roIuyn09uLdJiQpOYYgFVUdWFBElaS3FR8I5ApVx9Yw0+4gJO36s
n3szQKT8gCeh1XguDjc2PpriKUITDuyxn+psm7ExagTRvSSyHee1gKFdh2u9a+FU
R72Rx3K51TF22bnkKVyIQwyNOSc7HDT6tG0LZECfmF1ai40pQvZ/tQfg0ZUtfCrX
as5tPr3DGAlh40//LbCQKpTyeNJ9Tls7UvddbesDKD5esQdzPi4+KpLnrMD9ORFr
aGrPnqxxdIB33ddubg4uAvD2QxwjLDYtTscjJaKnzvUcevl8902IpDp2GsgLJcXf
acCy+GVOKLBYzg20RR58ASOpZoIOrNu8CRMFxrqJxok3634tLkoPnUKyp9u5DOB4
FfGKKSIyrTHrI/ooFzqO
=Iskx
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
