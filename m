Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09886203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 10:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbcLJKv6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 05:51:58 -0500
Received: from tschil.ethgen.ch ([5.9.7.51]:41133 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbcLJKv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 05:51:58 -0500
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <klaus@ethgen.de>)
        id 1cFfG0-0004lU-CT
        for git@vger.kernel.org; Sat, 10 Dec 2016 11:51:56 +0100
Received: from klaus by ikki.ket with local (Exim 4.88)
        (envelope-from <klaus@ikki.ethgen.ch>)
        id 1cFfFz-0008FT-Td
        for git@vger.kernel.org; Sat, 10 Dec 2016 11:51:55 +0100
Date:   Sat, 10 Dec 2016 11:51:55 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161210105155.7kf6jgrojfxa47qf@ikki.ethgen.ch>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org>
 <20161210082657.zjp52a2zdtqifmg3@sigill.intra.peff.net>
 <20161210094133.7htkb6cmjuhkdh4v@ikki.ethgen.ch>
 <20161210102657.ateotzowgek7bjuc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <20161210102657.ateotzowgek7bjuc@sigill.intra.peff.net>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Am Sa den 10. Dez 2016 um 11:26 schrieb Jeff King:
> On Sat, Dec 10, 2016 at 10:41:33AM +0100, Klaus Ethgen wrote:
> 
> > Am Sa den 10. Dez 2016 um  9:26 schrieb Jeff King:
> > > Yeah, I picked it arbitrarily as the common quoting character, but I
> > > agree it probably makes backwards compatibility (and general usability
> > > when you have to double-backslash each instance) pretty gross on
> > > Windows.
> > 
> > Well, I don't know of many people using the original git on windows.
> > Most of them using some graphical third-party tools.
> 
> I laid out options for addressing the problem elsewhere, but I want to
> make clear that this line of reasoning is not likely to get any traction
> here. Git for Windows is a non-trivial part of the user base, and we do
> care about avoiding regressions there.

I value that.

I just wanted to point out what my observations are and too I don't want
to see that windows stuff (what is the minority in this case) will get
more attention or more priority as stuff on linux (which pretty much is
the majority, I believe). Don't get me wrong, I see them both as
important.

And even on windows there are pathes with colon in it. (read c:\...,
d:\...)

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlhL3ksACgkQpnwKsYAZ
9qznAgv+IPrgt2yvFE9m/YpZv7viSlV9SsIyr6DjvK1C06N9IZes69z4yywTSjVf
L5x4ecWEg+k4N7ET+qNp1iaFS70juNvWg0hysbteczxElNGOerR8pEWXxKA+8xpN
tcY55ZcbBgihPDlQ+ztHAGlngD7E3wwMbzSC5kGCPYYe7Kw9mhLrXzX/MN5V2H/k
60XXsTkW05kUg01ofFATNppFLJHDTFJhEHiZmytJ5se5fTAUXM0gwFkCYEcPh+72
d6GsodVNRW++i9ojAEqglPbAaEAAFg1MOULa3KN2xsIYhvyZ8P4hNc2DzPcAsdtr
8ngoJb80XQ+gLzwJ80RjUnUNFLE+BFUzLrCRxgYyjk3kD7rewLUFHJkte05WBTRv
t21V/AudDC8i8z7XnQtAFpV8QHjTv00nMqV9e2iaTqmd7QJ8bPvDQmSu86/x3MMM
/2aFUcPmRu1Pp+XGm8KUDOF+kba8IJAi7Zs0UCNdyj6domjZBsE9N3pKkcbxsNBJ
0+5Ln4Vi
=twtR
-----END PGP SIGNATURE-----
