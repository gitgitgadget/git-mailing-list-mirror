Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0271F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeJKHPp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:15:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50102 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbeJKHPp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Oct 2018 03:15:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E98CE61B73;
        Wed, 10 Oct 2018 23:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539215474;
        bh=V9Qeq9PM7LfRmitUieSA4zWYgS8LOYAXOr9CT64pa3M=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fwrNm6YyNqGjedTqqkKsuMT+LD0n3TmIJ6I12nIx+a5f0bdH0KXUq7Hzdk/ZETeVf
         5JKG4NA6Lkkyr1hzcQvW/x3cXfVr3L3kZLfP1TCd/WMjA1yeI9SIOzAAz7lskHPAmI
         dKHb5u2/lQ2BpQni23StdoT/ESP+t5FtWsKf+5K5WhLF02Ft0jWYeRXzP7U1TJGHWn
         vpx0+WcW5lNRJo6KEt8ckOmOHTCZHpowpYBS8x4PJ7Flsaye11GRamAj5/JebzzzFe
         tY8aHszbcctEYTHAADcMIiPxbWy+XmoT80BkUSoiEfxJEnOK8XxpCCzrt9yuWT8tPC
         OmIEkUC8R7T2uEsCFlM2DptkUH+xdcCmHnjjshXpWuW/MPZpN3ppQna6H62S3IzIKW
         lYPAAFC/u4/0EKpUuw0wWnzAKCYZOHwbbjzmprzVBv2La6lFkDQeZEdRb57HPluJNt
         vQgz6LME589hD4UHoRjYNARv7jPpKwxRIgXC9g7WoX6iIRi7QP4
Date:   Wed, 10 Oct 2018 23:51:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] branch: introduce --current display option
Message-ID: <20181010235108.GW432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Daniels Umanovskis <daniels@umanovskis.se>, git@vger.kernel.org
References: <20181009182006.9446-1-daniels@umanovskis.se>
 <xmqq8t36q1k6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SlNwLc1tujQOaj7L"
Content-Disposition: inline
In-Reply-To: <xmqq8t36q1k6.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SlNwLc1tujQOaj7L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 05:59:05AM +0900, Junio C Hamano wrote:
> I do not offhand know if we want "show the current one only" option
> that is "command mode" sitting next to "list", "delete", "rename"
> etc., or "limit the operation to the one that is currently cheked
> out".  If we want the former, the name of the option must *NOT* be
> just "current".  Have a verb in its name to avoid it from getting
> mistaken as a botched attempt to do the latter.  Somethng like
> "--show-current", "--list-current", "--display-current", etc.

I had considered sending a patch with this option spelled "--show".
This is certainly a highly desired feature (hence my intent to send a
patch), and I think there's room for both a porcelain (this series) and
a plumbing (git rev-parse --abbrev-ref) version.

> Even if we were doing the latter (i.e. focused "this is only for
> listing/showing"), if we do not want to close the door to later
> extend the concept of "current" to the former (i.e. "--show-current"
> becomes a convenience synonym for "--list --current-only") we also
> need to think about what to do with the detached HEAD state.  When
> the concept of "current" is extended to become "usually an operation
> can work on multiple branches but we are limiting it to the current
> one", detached HEAD state is conceptually "not having any current
> branch".  We could fail the operation (i.e. you told me to distim
> the branch but there is no such branch) or make it a silent no-op
> (i.e. you told me to distim no branch, so nothing happened and there
> is no error).

What I would suggest is the same thing git status shows: "HEAD (detached
at...)".  I'll admit it isn't strictly a branch, but that's what most
people will want to see, I expect.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--SlNwLc1tujQOaj7L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlu+kGsACgkQv1NdgR9S
9otpxw//X+QQgGH/e8+MerdnD6600bb+J4stdDeGTovXHRfOZHJbjjjx/PCUPBP4
KgnCb2268xj9/wM9zRoDCYjMUxOD9oEUHQ8Y+S6mmiKRt3hCJTurPLUKa5YGYKz1
LVS6LA2HO+AJ8hU7NeOWv8IigTjMbEiD40fg+mYgLHobs6IK5imFIpeoV2SsdL23
qBTNRYnHXO8p72SYZEFgj/CssmVS12TTHrBCeiHsPnDOKzLAmsvqBuSJ2b+03SYO
vFtbIta9Vu9LJ4fZ8//dcin/SEW8W4O2vhdQsaqzb+ZKM9zLvIrH5ntyrXM3bwo+
RrtDtg6pLd6wCsJ9zgTXRWtwTHwxK8yaVw6Bh9vc0jB6c5byV+asai9cCwbvbtYr
gZ6mB2AJhN4T3pzlqZhlqbkkXzX26JIBC0bqOTjU2pgTwYYJ6TRrjLFbimlQE1Eb
YOp5/WjADLBkgzT2guEPvdGmEKUUiJ0rLe3WKp8kqH31UiSrFx77T1mr9DjIAase
akAjSgLSHM5DnX+6BGeknH43G4M3tKN7deNTw39DNWVg87/8jqTQqdfvrVbws6gT
8nfujoivT5mwnhrl0+arUiHMyrrGKPeQsP+U6jCQe0u3dhFt95hFHctctQ9bPPr8
b/sc49dZXxLYe1AnEy48MLnhDcfYG/w9/NaP8lurHZLS3yHJFgw=
=5yk7
-----END PGP SIGNATURE-----

--SlNwLc1tujQOaj7L--
