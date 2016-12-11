Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501F81FF7F
	for <e@80x24.org>; Sun, 11 Dec 2016 11:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbcLKLCO (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 06:02:14 -0500
Received: from tschil.ethgen.ch ([5.9.7.51]:43057 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbcLKLCN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 06:02:13 -0500
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <klaus@ethgen.de>)
        id 1cG1tR-0008Nf-Rf
        for git@vger.kernel.org; Sun, 11 Dec 2016 12:02:10 +0100
Received: from klaus by ikki.ket with local (Exim 4.88)
        (envelope-from <klaus@ikki.ethgen.ch>)
        id 1cG1tR-0002Bk-5M
        for git@vger.kernel.org; Sun, 11 Dec 2016 12:02:09 +0100
Date:   Sun, 11 Dec 2016 12:02:09 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161211110208.642unp7c2i653sav@ikki.ethgen.ch>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org>
 <20161210093230.26q7fxcrs2cpll6g@ikki.ethgen.ch>
 <alpine.DEB.2.20.1612101918040.23160@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <alpine.DEB.2.20.1612101918040.23160@virtualbox>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi,

Am Sa den 10. Dez 2016 um 19:18 schrieb Johannes Schindelin:
> On Sat, 10 Dec 2016, Klaus Ethgen wrote:
> > Am Fr den  9. Dez 2016 um 22:32 schrieb Johannes Sixt:
> > > There are too many systems out there that use a backslash in path names. I
> > > don't think it is wise to use it also as the quoting character.
> > Well, the minority, I believe. And only the minority where the command
> > line git is used anywhere.
> 
> Please provide evidence for such bold assumptions.

How is it "bold" to see that the majority of widows users does not use
or even like command line tools. And as git is command line tool (most
of them), users does use third party tools instead of the original.

I know companies where the "developers" doesn't even know of the
existent of a git command line use. They look with owe when they see
that I use a shell to use git.

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlhNMioACgkQpnwKsYAZ
9qzPygv/ZZr+qW4y/JoTWP6BVu+qDFhean7mHoj5vCSgXwCPzZHSvWIDLdqcrboR
UR7K3oTz9yMaoMRiNq7pu/QBJlwRSJ8ByqSde8mzXOVTqvEC5kvLugU3Ehc1fs0u
ZpoQvXBy0SrpKcuNApMdTFMO9OmCwRNAt2JecCQqyQi6hs6Ws5xTCReOEry00wb/
RdLKOpXwOn5n3ESRAQcqLWhWGs9aUVrfQRCHR2rIYsjx1s/tt+NVWa0hzTnJZt3T
wcQDlGjgeXsu8gJHPNSxAJv5paiNK4JG5x6UUOUuAzmvIYmwd6kEiyNQctTRd0JM
ZCBEYnmZQhHbvrkyKsVvUYJhE9FT0hKMAJO791ZiLCN696EJR4BCOZ9I+7GePFtY
dxb3RNsI9imCXqAHyaguY5tQImzc7P5eQfvH4CdmI9DOmwMUlirvt7pjT94pLFNQ
pxFphD+gd5tUL6QL5fmoUFQVQacQ9Vfs2riTiHerWnBq8P1Hw4KWVYd6ImFo8u3o
aWvUfXFg
=1Yj3
-----END PGP SIGNATURE-----
