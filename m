Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920621FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935027AbcHJT5S (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:57:18 -0400
Received: from mort.cihar.com ([77.78.107.252]:37240 "EHLO mail.cihar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933767AbcHJT5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:57:16 -0400
X-Greylist: delayed 5395 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Aug 2016 15:57:16 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cihar.com; s=20150416;
	h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=lKSops3W+VvLWKzodKVYM6nEKrW78yCEE5aQX5+L1nU=;
	b=VFjeH7nq8G7mEF4u42jCLiXEOFjgunEnE1SJiUVuSBHYHdmILxsW8DqYtTY6wD3xq+EvDiMZ24FURpjdFJuWxgbrrl8OT40YpiOFTf5TORj5ZM8dnoGBKZJ4zzgySbGASc4iNiQDLbqdapepNOyWE0X5dUlXyDUpZ8rzk1gKaM4=;
Received: from 127.0.0.1 (helo=authenticated.u-s-e-r)
	by mail.cihar.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.84_2)
	(envelope-from <michal@cihar.com>)
	id 1bXWB7-00033E-PA
	for git@vger.kernel.org; Wed, 10 Aug 2016 18:16:25 +0200
Received: from [::1]
	by nutt with esmtp (Exim 4.87)
	(envelope-from <michal@cihar.com>)
	id 1bXWB7-00015I-Ot
	for git@vger.kernel.org; Wed, 10 Aug 2016 18:16:25 +0200
To:	git@vger.kernel.org
From:	=?UTF-8?B?TWljaGFsIMSMaWhhxZk=?= <michal@cihar.com>
Subject: git svn --version requires working copy
Message-ID: <8b881bf6-0b53-f917-fbe7-db22fe4910b8@cihar.com>
Date:	Wed, 10 Aug 2016 18:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l2mMLwxQ4CvAKe9FEMEj0foVOlHVHANaA"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l2mMLwxQ4CvAKe9FEMEj0foVOlHVHANaA
Content-Type: multipart/mixed; boundary="TuCCu0pATujFc5KVq9KOh03qAl0cag20U"
From: =?UTF-8?B?TWljaGFsIMSMaWhhxZk=?= <michal@cihar.com>
To: git@vger.kernel.org
Message-ID: <8b881bf6-0b53-f917-fbe7-db22fe4910b8@cihar.com>
Subject: git svn --version requires working copy

--TuCCu0pATujFc5KVq9KOh03qAl0cag20U
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

I've just noticed, that running git svn --version requires working copy,
what is quite ugly to require working copy just to figure out if git svn
is installed and what version.

$ git svn --version
fatal: Not a git repository (or any parent up to mount point /home)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)=
=2E
Unable to find .git directory
 at /usr/lib/git-core/git-svn line 347.

Is this expected behavior?

Thanks
--=20
	Michal =C4=8Ciha=C5=99 | http://cihar.com/ | https://weblate.org/


--TuCCu0pATujFc5KVq9KOh03qAl0cag20U--

--l2mMLwxQ4CvAKe9FEMEj0foVOlHVHANaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXq1NZAAoJEPSqIp1NWMJFey0P/jGzowKMb6YbQesx1rQE4YS6
lvcnPzS2VFgSiLm4kJOmtfNUrcjBNT44NSnN06461FFw03zGe7YOiskQQnelgho2
/69sJbZtxIvVEYkCjekihQHM4GtuqbbojtrIydvJ53Nv+Mm3DmT6DVQbdBwvb2Rs
2BBFMh8+iPkT/3wCgZUvMz2dLVTChfSR65peNlZxuqYBjXk9bTWb2hzDfiTrOEzq
qdshHD3YSYTrgQE0PJ4/zMlJaFrc/ZtkzL//84+47pxupIbI0FlGFtRvFCR+cJTO
4FZyHFLPU9RoNWqmZDsUpDIRFJwSfTXv2DXC0ZKO8szYQ8t49Z9Z5AcH0QqwRRH3
YxEeSkpRzgn/p/bBjxxSDyXrbz09jaPDgCVcVIEYiRuriKMlaw5v76C2I08W+4Ua
QV2mUH5Y6fGebcMwl6LxCh+/qOSRXC5lJ/giMdHwYhtVLZqYe+wrB/ARS+JwzQ9a
WHaqdeq8MD3sWeOv4RCNbp4fyCK4TkTkpUcBeYqvmnVVEN6yyUqcXtTfi5Rd7xxf
TT9NK5u5fz60FNB5IAzOjh+KeydqQ6sgSA7tLSFxUJ8ij9RuPBvsYwjM/vLCA6TR
Hy3/Z+PqewEXymsnPU0xXhAA5z8vU/wP1a++0apjSZ+aJGzVcDh20pC5X2h/g2lY
SSoMB8iSSJbhN+wRkjMe
=Y3/o
-----END PGP SIGNATURE-----

--l2mMLwxQ4CvAKe9FEMEj0foVOlHVHANaA--
