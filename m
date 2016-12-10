Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D8A203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 09:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbcLJJlh (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 04:41:37 -0500
Received: from tschil.ethgen.ch ([5.9.7.51]:41046 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbcLJJlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 04:41:36 -0500
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <klaus@ethgen.de>)
        id 1cFe9u-0004MN-7d
        for git@vger.kernel.org; Sat, 10 Dec 2016 10:41:34 +0100
Received: from klaus by ikki.ket with local (Exim 4.88)
        (envelope-from <klaus@ikki.ethgen.ch>)
        id 1cFe9t-0000Eh-MC
        for git@vger.kernel.org; Sat, 10 Dec 2016 10:41:33 +0100
Date:   Sat, 10 Dec 2016 10:41:33 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161210094133.7htkb6cmjuhkdh4v@ikki.ethgen.ch>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org>
 <20161210082657.zjp52a2zdtqifmg3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <20161210082657.zjp52a2zdtqifmg3@sigill.intra.peff.net>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Am Sa den 10. Dez 2016 um  9:26 schrieb Jeff King:
> Yeah, I picked it arbitrarily as the common quoting character, but I
> agree it probably makes backwards compatibility (and general usability
> when you have to double-backslash each instance) pretty gross on
> Windows.

Well, I don't know of many people using the original git on windows.
Most of them using some graphical third-party tools.

The main git suite is most often used on linux where a colon is a valid
character For example using /mnt/c: as mount path for windows file
systems or /bla/foo/dated_repository_2016-12-10_12:00.git for dated and
timed repositories.

My btrfs snapshot dir looks like:
   ~snapshot> l -gGhN
   [...]
   drwxr-x--x 1 296 2016-07-30T13:55 daily_2016-12-10_00:00:01.270213478
   drwxr-x--x 1 296 2016-07-30T13:55 hourly_2016-12-10_05:00:01.372037552
   [...]

Compared to the backslash, although it is a perfect legal character in
POSIX file systems, I do not know any use of it.

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlhLzc0ACgkQpnwKsYAZ
9qy1jQv/Wcafo8nJuy/dNIpxN5tNaLEENrY6a2dkv379F2miEJYROlWO6UzG86hY
0WIZAm5BKK6SpPVztTMcs2GHPF0iCB4V4RyQFdFa73OhaAgHOJRdy50eaGSz6vt6
lDZkJZsG0FoXcT6Fapdl5xZeoNDXjPcYH/7yFQ7VjMD5HTpLDIs8E5Mb8V1jwehV
JKzQd136vksS2qB96jElAYonXFwImvYfTplH3nELJh/kKRJOT8Mzgj/+X7vxnQcC
NISiLysSxqPm5d9yDsfN1eofMNGn2zgJZStOP6jNV2yqldMgN0fJX4Mt449GpBO8
OSYjN828QsDYXCWdTCKxbLCxjfNxfvQgHHR7ugSlf9xPrro3MjQjg2cMhZ/fCzCm
XcC4X+Iyec2F0wHSQiXqlb7wiOXa1Oup6zmTRe/G5HkhlCap/+R2nOCfkqEEwhkB
moYTqfETqqTJUJiiYVM/U8LBFWGnBBCGWgRPzyNdFna+WnvD93s9JPeg7q9qFm6x
8flMJBm8
=M5IW
-----END PGP SIGNATURE-----
