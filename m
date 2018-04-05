Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9C81F424
	for <e@80x24.org>; Thu,  5 Apr 2018 08:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeDEIt7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 04:49:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:26167 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEIt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 04:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1522918195;
        s=strato-dkim-0002; d=aepfle.de;
        h=Content-Type:References:In-Reply-To:Message-ID:Subject:Cc:To:From:
        Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mKvOPpa0IqbCcArKWsI+MGMcjUUdPhs8OCrv1Xl5Tbs=;
        b=qY+hQL5AYX5KxZ0Ory2mKooc36MTDke395JQ/3akULaXMmAv28/FJ51tntYWIvyfTV
        ucAOBZwzVBn1MWZi29EM08P6KmJ8pzxQqS0yFRW23woxYsa9CvIcoCvJlZeIf/gTByDf
        ochazDebH2uPaRZkjUXBhKLIpN63hphgCrG+pb01djV8BpW9gK7E6wmziex1PXA/B2Os
        LLC0tyFUrT4nddUZseCmctz9wsCNyWY2kPfmojNit5tXwjBb3tW2EGK2pCwTwYThADI1
        2XqvD8MV+THX8WPnhWiYVIjOfSYv+tlhwpqJgg8xC7U6F9bwadbTClX7O34YkPRjbxot
        Qvbw==
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsBRtyRe2qcrldJj63vYUTRQR/0RqPSgWq+RVwc
X-RZG-CLASS-ID: mo00
Received: from sender ([2001:a62:816:91ff:a572:884d:f51d:1a86])
        by smtp.strato.de (RZmta 43.1 AUTH)
        with ESMTPSA id K08137u358nsVYZ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Apr 2018 10:49:54 +0200 (CEST)
Date:   Thu, 5 Apr 2018 10:49:48 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: How to undo previously set configuration?
Message-ID: <20180405104948.276de0ca.olaf@aepfle.de>
In-Reply-To: <874lkq11ug.fsf@evledraar.gmail.com>
References: <20180405092358.569e0315.olaf@aepfle.de>
        <874lkq11ug.fsf@evledraar.gmail.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/bqtRNrYvN31wSf=crJmpy5+"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/bqtRNrYvN31wSf=crJmpy5+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Thu, 05 Apr 2018 10:42:15 +0200
schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:

> I've been meaning to work on this but haven't figured out a good syntax f=
or it (suggestions welcome!).

Just prefix the knob with something like "no." or "-" or whatever to indica=
te that it never happened.

Olaf

--Sig_/bqtRNrYvN31wSf=crJmpy5+
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWsXjLAAKCRBdQqD6ppg2
fp1jAJ92wms8lFieq+plv4dmUMXeOW58RwCg0YLmX29Qa3QqJ2dBh/RL26mhZyc=
=4lbL
-----END PGP SIGNATURE-----

--Sig_/bqtRNrYvN31wSf=crJmpy5+--
