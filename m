Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25AA52095B
	for <e@80x24.org>; Thu, 23 Mar 2017 07:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932445AbdCWHi3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 03:38:29 -0400
Received: from kolab.intevation.de ([212.95.107.133]:44151 "EHLO
        kolab.intevation.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbdCWHh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 03:37:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 3441E62684
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new at intevation.de
Received: from kolab.intevation.de ([127.0.0.1])
        by localhost (kolab.intevation.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QzePCEa9Vj3Y for <git@vger.kernel.org>;
        Thu, 23 Mar 2017 08:29:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 57B7B626E7
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:41 +0100 (CET)
Received: from ploto.hq.intevation.de (ploto.hq.intevation.de [192.168.11.18])
        (Authenticated sender: bernhard.reiter@intevation.de)
        by kolab.intevation.de (Postfix) with ESMTPSA id 1F98A61F6A;
        Thu, 23 Mar 2017 08:29:41 +0100 (CET)
From:   "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
To:     Werner Koch <wk@gnupg.org>
Subject: Re: Stable GnuPG interface, git should use GPGME
Date:   Thu, 23 Mar 2017 08:29:31 +0100
User-Agent: KMail/1.9.10 (enterprise35 20150610.75555ff)
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <201703101100.15214.bernhard.reiter@intevation.de> <201703171056.10468.bernhard.reiter@intevation.de> <87poh9p70n.fsf@wheatstone.g10code.de>
In-Reply-To: <87poh9p70n.fsf@wheatstone.g10code.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2015006.M6idIfG0sW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201703230829.40741.bernhard.reiter@intevation.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart2015006.M6idIfG0sW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 22 M=C3=A4rz 2017 18:15:36 schrieb Werner Koch:
> On Fri, 17 Mar 2017 10:56, bernhard.reiter@intevation.de said:
> > As the command line is not a stable API to GnuPG, there were changes and
> > there will be changes to the command line over several versions. It may=
be
> > in the
>
> That is not true.  The command line interface has been stable for the
> last 19 years.  We only removed a left over PGP-2 backward compatibility
> in 2.1 (-kvv).  I doubt that this has even been noticed.

I was under the impression (and I do remember you telling me a few times)
that the output of the command line interaction did change a lot over times
and using applications had issues. I've experienced a few of those over the=
=20
last 17 years. :) Still I would have to dig up the examples.
You seem to refer more to the existence and principal meaning of command li=
ne=20
options, which is very stable because of your efforts, which I've mentioned=
=20
before. Contents of the resulting input and output strings has changed thou=
gh=20
and gpgme does this parsing for a using application in a more stable way.

Best Regards,
Bernhard

=2D-=20
www.intevation.de/~bernhard (CEO)     +49 541 33 508 3-3
Intevation GmbH, Osnabr=C3=BCck, Germany; Amtsgericht Osnabr=C3=BCck, HRB 1=
8998
Owned and run by Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart2015006.M6idIfG0sW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJY03lbAAoJEDxD9Mjv9dQq3uMH+gNf0EFYSWl8npZt6S8gq6wQ
X17Yx99XSN6LgWdDI798rUdulP4taJRFmv0f3lEYNzolF3o8M4YBTfdOL6N+TDzg
JsRanqCkvXDVZqaeLiAqge9EsN1Oo5I56GV9ee4uJrpkiof9NtzTpjD98eBwOphJ
8mMuQBerOwOunj+z+74tN2sqHZXGIc6fftF/64A77igzmg3bWb4EaT8tf/ReKNc8
5drJwYbzI3B9hUyEB2HcEyqeIhkfcWPKZXBbRwGgs8u73hF8L8r7SXYR2NmjXwxC
NqphV2+iphfqBZ9Sw5GeDRcGOMtuHVMn2UWf0dkZHbLXu62eaZOh1Gh1a/O8ocw=
=OAgY
-----END PGP SIGNATURE-----

--nextPart2015006.M6idIfG0sW--
