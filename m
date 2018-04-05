Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55BA21F404
	for <e@80x24.org>; Thu,  5 Apr 2018 13:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDENbq (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 09:31:46 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:17124 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeDENbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 09:31:45 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Apr 2018 09:31:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1522935104;
        s=strato-dkim-0002; d=aepfle.de;
        h=Content-Type:References:In-Reply-To:Message-ID:Subject:Cc:To:From:
        Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5oBAZI8Mk1Xst+POR0q7xGfRp1wGTaESVqMcU8/4wOA=;
        b=NWqH0iq0NYCyl4bOKASnGDY37YqvxJ1IsGQY+2U8JE5bhM42xQT2//Rs/zfwORBBIy
        5bwJk3wtf0b9CHxxXQfThXxJ+Y9E4GplUywgHVphwao/2ZZfN/VE6otNmrDcxrWvSlSh
        MnSiqOkIbC2d4HgMrQMhG7y2t0GePI8IW0d7W88Of6rt3jmKVIM3ZTuPCsIGn9pX8QC4
        8DdDHBmGHtknC7Be581P2O5o9iY9dgK016Pf6zOlJPHOjIbbVb7WJ/D8fChJzTLlz5dj
        ouGF7YFx45+338T98/OdC7LCVFYnrMaSftxWVQIXBdiCdSbVSrmiVPtjx4bNvs8cIPRH
        c0hQ==
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsBRtyRe2qcrldJj63vYUTRQR/0RqPSgWq+RVwc
X-RZG-CLASS-ID: mo00
Received: from sender ([2001:a62:816:91ff:a572:884d:f51d:1a86])
        by smtp.strato.de (RZmta 43.1 AUTH)
        with ESMTPSA id K08137u35DPUXHH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Apr 2018 15:25:30 +0200 (CEST)
Date:   Thu, 5 Apr 2018 15:25:25 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: How to undo previously set configuration?
Message-ID: <20180405152525.13d1c776.olaf@aepfle.de>
In-Reply-To: <8737092929.fsf@evledraar.gmail.com>
References: <20180405092358.569e0315.olaf@aepfle.de>
        <874lkq11ug.fsf@evledraar.gmail.com>
        <20180405104948.276de0ca.olaf@aepfle.de>
        <8737092929.fsf@evledraar.gmail.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/P5f_46X6GxVngKgPJ0QGGhn"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/P5f_46X6GxVngKgPJ0QGGhn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Thu, 05 Apr 2018 13:21:02 +0200
schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:

> I'm assuming you mean something like:
>         [user]
>         # This is an error
>         -email

Yes. Just some flag to say "whatever value this variable has from earlier p=
arsing, forget it in case it really exists". Just like "unset PATH" in bash.

I do not know the git internals, so can not really help with the case.

Olaf

--Sig_/P5f_46X6GxVngKgPJ0QGGhn
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWsYjxQAKCRBdQqD6ppg2
ft2GAJ4jt7Fum8Hy/x0zN/OlPevvdEc5dACfUNb/9f99gwOIWB6oNBZBgyHOZ4k=
=ByYx
-----END PGP SIGNATURE-----

--Sig_/P5f_46X6GxVngKgPJ0QGGhn--
