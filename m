From: Lanny Ripple <lanny@spotinfluence.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Sat, 2 Jun 2012 11:37:10 -0500
Message-ID: <FB665BFF-9661-4624-A9D3-597AE5FF65AA@spotinfluence.com>
References: <7vehq18c82.fsf@alter.siamese.dyndns.org> <20120531011911.GC5488@sigill.intra.peff.net> <7v62bc97w1.fsf@alter.siamese.dyndns.org> <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com> <7vtxyw6ypx.fsf@alter.siamese.dyndns.org> <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com> <7vd35k6w0i.fsf@alter.siamese.dyndns.org> <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com> <20120601093039.GD32340@sigill.intra.peff.net> <B0BB0BD8-EFB5-4A3C-A6F7-00A1C7DE0509@spotinfluence.com> <20120602160904.GB15017@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: multipart/signed; boundary="Apple-Mail=_365DABAF-80E0-4778-BA61-A4B930FE4713"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 18:37:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SarKM-0001wP-B8
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 18:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759443Ab2FBQhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 12:37:15 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46291 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758345Ab2FBQhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 12:37:14 -0400
Received: by obbtb18 with SMTP id tb18so4541537obb.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 09:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:x-mailer:x-gm-message-state;
        bh=kPSGXAL7Of0bye+uKSH5us+oc5LmMiCdHPSbqLeTxuw=;
        b=Pr8QjueGDQPti/xzKpNZFTR8V4SwgLENA39zucMpQC+48QSn3+wtXy7e73rKgehZ5o
         //YHYZUGNjBSoZfuWTYj5khB0oMXOpCfBP/CVSYdshSkzYAnVqfGvf6rD3ca5KQmXDh2
         Q4u1Nhjgsx7HjW3hXgHjPIhQhFEE8Q2iOzjtI5T7Px8MYEC/5m1C2LYfiSX9HMnALIdJ
         Z/FiV2EuFylvAf6KBlIM4v45vQlwWClOg9asGpb4zpJ2iMicwyuwfTuZaXfL3jqZp0HK
         ImGYirkWj1gmQcotvGs0XAVQldSOzrdKRBWb5+HbAl9B6Cr0VBC0jV+fvQOJh/XUdxVl
         fGug==
Received: by 10.182.74.42 with SMTP id q10mr6732206obv.52.1338655033797;
        Sat, 02 Jun 2012 09:37:13 -0700 (PDT)
Received: from [192.168.1.4] (c-98-198-192-29.hsd1.tx.comcast.net. [98.198.192.29])
        by mx.google.com with ESMTPS id h5sm4168631obo.21.2012.06.02.09.37.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Jun 2012 09:37:12 -0700 (PDT)
In-Reply-To: <20120602160904.GB15017@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQntaMoe71aYI1s8UC2bD3++n939MpQE0geGzAWTp4tgMcrKWrSxWJAiWNjiovNReTrCsKg+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199049>


--Apple-Mail=_365DABAF-80E0-4778-BA61-A4B930FE4713
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

At a guess (I haven't tested) every Gnu sed from 4.2.1 down on Darwin =
and perhaps FreeBSD.  The fink developer looking at the sed giving =
problems (Gnu sed 4.2.1) says that it gets its charset idea from =
nl_langinfo() which reports US-ASCII for LC_ALL=3DC or POSIX (on Darwin, =
derived from FreeBSD).  Since US-ASCII is only 7-bit chars anything =
accented will break.

  -ljr
---
Lanny Ripple
lanny@spotinfluence.com


On Jun 2, 2012, at 11:09 AM, Jeff King wrote:

> On Fri, Jun 01, 2012 at 08:56:01AM -0500, Lanny Ripple wrote:
>=20
>> I did show that sed was broken and have provided a minimal, =
reproducible test.
>>=20
>> I have reported it to the sed maintainers and they are working on it.
>=20
> Great. Do we know yet which versions are affected?


--Apple-Mail=_365DABAF-80E0-4778-BA61-A4B930FE4713
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iF4EAREIAAYFAk/KQTYACgkQ+owW65SoXfizxAD/SjgPGvQQLp1u7i90Wux1ZDjw
0plS8e6LUZPaMoJ7L/gA+wYY/zkJMaBrVSozoHLMUy1vWAaKz1f1WhdEYgzr+x7S
=uM5q
-----END PGP SIGNATURE-----

--Apple-Mail=_365DABAF-80E0-4778-BA61-A4B930FE4713--
