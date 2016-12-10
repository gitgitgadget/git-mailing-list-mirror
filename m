Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B43203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 09:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbcLJJci (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 04:32:38 -0500
Received: from tschil.ethgen.ch ([5.9.7.51]:41041 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbcLJJcg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 04:32:36 -0500
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <klaus@ethgen.de>)
        id 1cFe19-0004JO-QX
        for git@vger.kernel.org; Sat, 10 Dec 2016 10:32:31 +0100
Received: from klaus by ikki.ket with local (Exim 4.88)
        (envelope-from <klaus@ikki.ethgen.ch>)
        id 1cFe19-0008I2-Ab
        for git@vger.kernel.org; Sat, 10 Dec 2016 10:32:31 +0100
Date:   Sat, 10 Dec 2016 10:32:31 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161210093230.26q7fxcrs2cpll6g@ikki.ethgen.ch>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Am Fr den  9. Dez 2016 um 22:32 schrieb Johannes Sixt:
> There are too many systems out there that use a backslash in path names. I
> don't think it is wise to use it also as the quoting character.

Well, the minority, I believe. And only the minority where the command
line git is used anywhere.

But for the majority of OS, where the command line git is in use
(instead of graphically third party git tools) is perfect known for
backslash as escaping character. However, don't forget that a backslash
could also be part of the file name.

Regads
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlhLy64ACgkQpnwKsYAZ
9qzYfQwAmVIR+bVOvOcZ+yu7HddC5mwo7st6w+vPcdLKpFWcHIhsG//cHq6he+mm
/Dmfhnc4Yp+dSy7Z99p9DV67hAj0Zxj2koxBo4eCdwWhnKrphCHSST8j2IxIg/0h
Y1axQEBc5hV9nImTYmOks0pa5c9wKkZS36aTjP63PKgIv46A8RDY/QXAm2uO4kjj
gfBEiDVkQA99QlvpP1qbuRCK3QUmfqxrP9ldiAhmuDBbNv2smiBxhoN3E6NgKTJG
fM6WjaZPUqpDUiky5gO0xfOpf6s2c/GMTEO1I5aWom6VKtrOoYUyMlyeMiqALWj7
KfN7TJfDqp3THo0AkLXuukrNMv9gdfgiAimGqYgSfFM9P60aPjGeC7nBt875PSae
jdVjIGyl0tHZzSIbBoSecQqx8h65eZaHLaS1uNf704m+EwIs1X2daI7Re3DcAyzL
EWJxtZyZbG/GooCdA9deywlEAtGNOdIg+p+YkThsmEGiaOir/fAMyviSP/jONTCq
OC5oHOcK
=x9y4
-----END PGP SIGNATURE-----
