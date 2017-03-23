Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F282095B
	for <e@80x24.org>; Thu, 23 Mar 2017 07:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbdCWH4J (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 03:56:09 -0400
Received: from kerckhoffs.g10code.com ([217.69.77.222]:43087 "EHLO
        kerckhoffs.g10code.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdCWH4J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 03:56:09 -0400
Received: from uucp by kerckhoffs.g10code.com with local-rmail (Exim 4.84_2 #1 (Debian))
        id 1cqwhF-0003NP-Es
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 07:58:09 +0100
Received: from wk by wheatstone.g10code.de with local (Exim 4.84 #3 (Debian))
        id 1cqwbd-0006tg-Uv; Thu, 23 Mar 2017 07:52:21 +0100
From:   Werner Koch <wk@gnupg.org>
To:     Peter Lebbing <peter@digitalbrains.com>
Cc:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Stable GnuPG interface, git should use GPGME
References: <201703101100.15214.bernhard.reiter@intevation.de>
        <201703131350.00139.bernhard.reiter@intevation.de>
        <13c66211-9671-5bd3-f3eb-96ffd5c39975@drmicha.warpmail.net>
        <201703171056.10468.bernhard.reiter@intevation.de>
        <87poh9p70n.fsf@wheatstone.g10code.de>
        <bec6098f-3016-0a41-02b0-a4e541a66bc4@digitalbrains.com>
Organisation: The GnuPG Project
X-message-flag: Mails containing HTML will not be read!
         Please send only plain text.
OpenPGP: url=https://k.gnupg.net/80615870F5BAD690333686D0F2AD85AC1E42B367
Mail-Followup-To: Peter Lebbing <peter@digitalbrains.com>, "Bernhard
        E. Reiter" <bernhard.reiter@intevation.de>, Michael J Gruber
        <git@drmicha.warpmail.net>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Mar 2017 07:52:16 +0100
In-Reply-To: <bec6098f-3016-0a41-02b0-a4e541a66bc4@digitalbrains.com> (Peter
        Lebbing's message of "Wed, 22 Mar 2017 19:46:28 +0100")
Message-ID: <87mvcco57j.fsf@wheatstone.g10code.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=constitution_Steve_Case_MP5K-SD_22nd_SAS_Centro_colonel_TWA_Adriatic";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=constitution_Steve_Case_MP5K-SD_22nd_SAS_Centro_colonel_TWA_Adriatic
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Mar 2017 19:46, peter@digitalbrains.com said:
> under the impression you are actually answering the question "can GPGME
> be used in the same way regardless of the GnuPG version" instead?

Right.

> 3) is because GnuPG 1.4 cannot update a secret key at all. Adding a new
> subkey fails with:

Indeed, I was not anymore aware of this limitation in versions < 2.1.
There are even more conflicts when PGP-2 keys (to me the only valid
reason to use gpg1 along with gpg2) or ECC keys need to be considered.


Shalom-Salam,

   Werner

=2D-=20
Die Gedanken sind frei.  Ausnahmen regelt ein Bundesgesetz.

--=constitution_Steve_Case_MP5K-SD_22nd_SAS_Centro_colonel_TWA_Adriatic
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTX/8BjtAoilLlm20f/gK6dHew1jQUCWNNwoAAKCRD/gK6dHew1
jXjBAP9IIj5ehfghdo/nhnCROVUnBmkQeubDVcKZN90zexGR8gEAxKAwJMWv02Eo
1/fi0SgFTPIH6xjfRuH3VxHmPT6oLQ0=
=WKZn
-----END PGP SIGNATURE-----
--=constitution_Steve_Case_MP5K-SD_22nd_SAS_Centro_colonel_TWA_Adriatic--

