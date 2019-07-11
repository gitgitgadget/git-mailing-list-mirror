Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102401F461
	for <e@80x24.org>; Thu, 11 Jul 2019 15:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfGKPqo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 11:46:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56568 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbfGKPqn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jul 2019 11:46:43 -0400
Received: from genre.crustytoothpaste.net (rrcs-71-42-118-242.sw.biz.rr.com [71.42.118.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7411D60436;
        Thu, 11 Jul 2019 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1562860001;
        bh=Elh+OLsJ3gx9+ixxmyL7bn/bHbGCAvLWu6TvV7WEJhI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KdY8e+NfR+wXNpq39uoPz+5iVGCAQteMx1kSsv3Rvdp3QPGBcf2/AQ8625ryOfOP8
         GsFc5KkR5mVtl+tuDNH1iqJFSg2KpX9VR/VLkbkzekW+J47xXN4wFXNwPYg+RsTNuD
         lQk4DFIwRPdSsI4XDXINEIZWGZW/0UPU+Sa4J62S6GjrMhjUhiiywAlV7bsvidHzTF
         mxBzFXptG+1Fxhim4ajIp3Ar/sF4oijARkFaKgZJFPcDb7ZmQu9ruTAAXhIHdSDTFy
         eSWwabnY4Qk2ZCHwl183kL44YOM7AAeCivXl44vwUzWjkGBC3Sp3LICCUHZQpdV0oE
         vAXmLjRyJA4LnMB0g+V7H/BmScrVPiujgpBTHUXS48hawftxtswp+7GosY3je9H4xm
         1M3+gDJ/x7XqxsD0mXocgE1P98UpoNixA1gHyIL18Kt7XjJVLcSsB0yG0pTQVMwu4Z
         cKt+7DNS/Is82ZQU0Y7gx8WTGnnpT5/MNizlZCYRli6Fo58R0H7
Date:   Thu, 11 Jul 2019 15:46:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
Message-ID: <20190711154636.GJ9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bryan Turner <bturner@atlassian.com>,
        Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <423596682.8516.1562665372094@office.mailbox.org>
 <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
 <1152121968.7459.1562688927235@office.mailbox.org>
 <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
 <275487563.12198.1562691633735@office.mailbox.org>
 <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
 <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Content-Disposition: inline
In-Reply-To: <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-09 at 20:51:39, Bryan Turner wrote:
> I think this is something I've seen come up on the list before[1]
> (Roland can correct me if I'm wrong). What I've seen asked for before
> is the ability to pass the combination "--ff-only --no-ff" and have
> that:
> * Ensure the branch to be merged is fast-forward from the current
> branch (i.e., to ensure no merge commit is actually necessary), but
> * Create a redundant merge commit anyway
>=20
> This retains the ancestry (as in, it shows where the branches were
> merged), but the merge is always effectively a no-op (no risk of
> unintended interactions, the sort of subtle breakages where the merge
> succeeds but the code on each "side" isn't entirely compatible,
> resulting in broken compilation and/or tests and/or runtime).

I should point out that this is scriptable using something like the
following:

  git fetch origin topic && git merge-base --is-ancestor HEAD FETCH_HEAD &&=
 \
    git merge --no-ff FETCH_HEAD

or, if you're just merging a branch:

  git merge-base --is-ancestor HEAD topic && \
    git merge --no-ff topic

While I agree it's not as convenient as having this built-in (and I
understand why people want it), it is achievable with an alias without
much difficulty.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0nWdwACgkQv1NdgR9S
9ot7/hAAkuHgtbn6D06VIalUKRodlgiFt3L5s3HWQcfHdM3HEP4Al13Lxh1Kewtn
aYBDYHTMn0feCqx9dc1VpODhid3noIX9Q1Npk8Qwk6dxXbEbePxtqRELagsER56d
Mr4aRMNDRFgAXJLATVboQzGk+2N+c2HVvg4//zNHSY9jN7esocOPcJ32YZGKfma4
OvSXLcZGBisWsYlf1/cJtXUpiqJQzKgWQljmRuD/VIjVDlaDcowvdCcqIW2/RPiB
BpJreGmDwcPYr0tRVt+fMaMhFDERMb+C9nPjtApop0wrgygMRaKTSudUyp5Sw8ER
wne29dPAa76+/5wRLcuiJ8di97S/78MZj44RlFPYndh/8f2zAKLkd5birz6eMGeu
tEE4hmakUIiKTtLhV2i/XoQm5LUvuXu90f1TZyIXZucdRFeztI0IRJH7zIGuMUXb
QHK0y9jkGPn+oFE3wD0BMUkRN453wHqUtLC8vmcmYTotA30zUWeNFkKrEbPFmIB9
YHET7yaMsJx/jSprD3eXGg5OVyV+scgQZ6Bd3EJn7x+PMjUPMb0810kNSfQJ5XTR
YVB25N0Yk4GJXK+XESWfNtRoTFw+ZUHdGLEG1B6tgrh3wAQlwxSm9zNzaKEiXrmK
Kyn/e91TCvS8fG4wfn7GwlD9SxJevVIl7Xp2rVKul+XHrlLBdUA=
=rY8T
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
