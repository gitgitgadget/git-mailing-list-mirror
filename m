From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 3 Dec 2009 10:03:23 -0500
Message-ID: <20091203150323.GI23717@inocybe.localdomain>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
 <m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
 <m2d42w5fqq.fsf@igel.home> <4B17D078.6080000@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 16:04:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGDDm-0007DZ-PT
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 16:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301AbZLCPD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 10:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756297AbZLCPD1
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 10:03:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296AbZLCPD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 10:03:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8FA985983;
	Thu,  3 Dec 2009 10:03:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=K0pXiuBdlTwGe+ysfmM/jhueh7g=; b=paMh000
	1UWDcNvB5mLJQzgpCRlfMbJf63SPxvXQPhVuNke2F5lrf7mGxnuG69CZuZ3RqfOw
	65H1I4iIjuEUgyp/EmoTnkAqJr6+7BORjoeNyPigl9Z9PpS5UczR9hr8hHGQC4F6
	TCHqnCMHMFWHoS2wHIdXWY3cx/7zEx0KVZOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=BpWJUkSK7XQyAG2CPhMinu1MocdHTXzDh
	HTQO+XsPg/yotwNksLLMaFVSBVtiLANY01b07tTFhamv3+NcqYxNVBQuLE+KgRxp
	5juSam5orsxPeThyqdhI2IzoI5di9frUJfIAoWt82/n8plawm8P3N3evKmiDdZP/
	3JzE2UCSws=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B426E8597E;
	Thu,  3 Dec 2009 10:03:29 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F19238597B; Thu,  3 Dec
 2009 10:03:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4B17D078.6080000@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 042E7BC4-E01D-11DE-B619-9F3FEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134454>


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Michael J Gruber wrote:
>>> Andreas Schwab venit, vidit, dixit 03.12.2009 13:03:
>> xmlto version 0.0.18
[...]
> Now that predates Git quite a bit (2004-01-21)...
> I think we can require at least 0.0.20, which is in Debian Lenny and
> Fedora 9, for example. I think that should have it. (I'm not sure, they
> don't use a proper vcs ;) ).

xmlto-0.0.18 is what's in RHEL/CentOS 5.  It would be nice to be able
to build git docs there, which works pretty well in general (I
believe).

I built 1.6.6.rc1 on CentOS 5.4 last night with Junio's first patch
for this, which only called --stringparam if MAN_BASE_URL was set.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A common mistake people make when trying to design something
completely foolproof is to underestimate the ingenuity of complete
fools.
    -- Douglas Adams


--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJLF9M2JhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjaQAH/30URq5BEHRMn6BXKKrv5NIvQ2T1ueGp0zTY
+d2Xmjpuuxd5n4w2LaVe2EMGWzJw30rs/20XcArAbxbuU/eXoaDMilOU/lmCswOg
PETsVOUffajjOxNxGf+z0M6G7G08T540md1hJp3Q32KDFm2+Xm7OlIlV+Os2ymwv
ujVFjg4DBUIUgA4Be9ijVRjt4WkVesnoc42KeO0jHssA5j5YXIReXYfCHvIGHcZJ
URvg9lpevx4gcx53C7QehFXyay1Huw22ABbKVBrmJMhVMakSsa8a/TXjSwljuTgu
DjaMbVsaaHHKc5pL+MDca/gKP/PwKXLvwLvzPLjD3Vi5+BCEYms=
=OKQv
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
