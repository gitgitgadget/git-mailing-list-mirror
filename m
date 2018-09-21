Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E05B1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbeIVElp (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:41:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36396 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725748AbeIVElp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Sep 2018 00:41:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:68ab:e3d3:c0a3:4717])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 885D660735;
        Fri, 21 Sep 2018 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537570244;
        bh=+yMfUYnb+5G8mLfGo6QLvklIchPkO3S8nyuAA4JA+q8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wGVgsrah59+q1ThnxIXuVWMvNYixhA4cN38zQAILbvvNui/z74df3l4P6SfotSozK
         CbJFvunxfszu+1dXEIS7IyfdITEM08+dz8K4sQgv5KRPeSgVuf5PAI+jKbg3mPd10y
         LF/pzO4U/2ZQ39+YkcdGOY4WQTqY2EqJHZPi7AUpyEV39L7iHQaFBMwGpWXnaJaweC
         PMsF9lKsQoIV+PeXLzb3NsNONSlIl88HIVNkjNCjoZGOyD5uJKww09qtyYKR1qzxy5
         xEAuszWJ3NYMVdVFFEDPwImjs5clDbwNzFJoQnjjYhcYhm7ywDmlv3RHS0wfDDtCUz
         sxXjMctWsioEQlR2UDHlEIjXQPEKO8fkBfwdUCzLONPJZv19dXZR0qNo/e+AqWSV6W
         +Qi0/5dOvLPSQCMyUiRr8rXZqs2O5YrvhR8lHeXmVtjRIycmzmqqVAUCdYhDOlM32h
         Uag+KraBL9nBz99RJrCe2moZAfH8ZEGWgUgItE/KEaihMyLk/Q0
Date:   Fri, 21 Sep 2018 22:50:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
Message-ID: <20180921225039.GC432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
 <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
 <20180920000013.GZ432229@genre.crustytoothpaste.net>
 <xmqqk1ng2rdo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rm5rkB9L8kG9H2n8"
Content-Disposition: inline
In-Reply-To: <xmqqk1ng2rdo.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Rm5rkB9L8kG9H2n8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 07:08:35AM -0700, Junio C Hamano wrote:
> My comment was that it would be confusing if they gave contradicting
> suggestions to the end user.  After letting EditorConfig to enforce
> one style while typing and saving, if "make style" suggests to
> format it differently, it would not be a great user experience.

Ah, okay.  I understand your concern better now.

> The ideal response would have been "Oh, of course EditorConfig folks
> already thought about that, which is a natural thing to wish for,
> and they have a tool to generate clang-format configuration from the
> section for C language in any EditorConfig file---here is a link.
> After all, tools like clang-format look like just another editor to
> them ;-)".

No, I don't think there's such a tool.  clang-format wants a lot of
format settings that aren't in EditorConfig, and EditorConfig wants to
address things that are not C source files.

> But that is a response in a dream-world.  If there is no such tool,
> I am perfectly OK if the plan is to manually keep them (loosely) in
> sync.  I do not think it is good use of our time to try to come up
> with such a tool (unless somebody is really interested in doing it,
> that is).

Would it be helpful if I sent a script that ran during CI to ensure they
stayed in sync for the couple places where they overlap?  I'm happy to
do so if you think it would be useful.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Rm5rkB9L8kG9H2n8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluldb8ACgkQv1NdgR9S
9ovfNQ//VZLKvDG7v02CSs2/C+ywFVuYBl92kqRuG23A7eyEh/eut70oB5JpV5k1
LHX+E0w80w4FpPofUJKSVeuf5EXqWfGjXhjfpA14brfIrvFmB4x5+QAJFbkWEyIj
wz2mGSiIuVtfm4Cf8FyOCOW0vl5wBpx/1OeFuVqPiHS1qt3/JiVF+bkdzgxLykJK
NwL2/c3BC+BPhdXTlXM8pj1MCHOcCzD1cmRgRdIjZNI4yP+1KKxnAN5ZQwUPp8uK
kl+o+YJ0B6fjYN1P6pss92nQ97q7yGyxLJijDe46e7aAeISuwsUy31GQbLzhYsNg
i3jXtOkElUlsF6AxumbRp8kbcXkXwSAgw4UrM7wp2p8fVAqpeP6Ol0RLE+WsbBVa
Bk/PhzVzO8cAvsNj/RuKU2E921/Gk+/7wHZRFcwtnuVIOq7XuA9q5ZliB+6Q9K5f
+rXvYz7bberH9DhafiCRVeKFbgdGCJd2VIPrHVuFO66W4InSVhCwm2dAeQxVf0sM
831+9XF8sPPbun07E5Hj3wbV6J5FcenvbgQDCTaM9Xu7uVAvJdP07k8BeK7rUXGk
4uTP1WBbnX4ocXfcsNAIKj4bzyVEeeQczTGTDSeiC3lsWtkVZTxp2/fAUaMKaEfb
J0XHYTJ+5CP+7O5qQyUpMBAFegnKQJzOzC9rhwbN65ALxIEftPU=
=cFsI
-----END PGP SIGNATURE-----

--Rm5rkB9L8kG9H2n8--
