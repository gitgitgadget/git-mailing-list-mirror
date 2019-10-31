Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05AB1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 13:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfJaN1b (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 09:27:31 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:36595 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfJaN1a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 09:27:30 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 09:27:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1572528448;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Wfb/sM0fKzxr/jSPdJ4QqLe78Q9+iucEzSkpOAr2O4g=;
        b=GU9ZtcJ+16jVs0N+wEqvtQNkuR9Q6Z03g3PlR+A2OuEeooOf4Ul+KgyHwXjoBKLC2D
        ZB+jvoM2ES88yg960eowKYNTeEqmQws0mV+tUdYy+aBxU5Itow8FBDNX/KeEgH45g0Yh
        Mk0/sindgMCrYH/HbKw2uFqZTgYcFQP7oldsU6dO7TPdshJQyGCiHNt9ifCe4q5Z/0tW
        lkg4zV9pZ87Ep5Y8XgfR/yRrV4AYuGfZVCjiaw63jbZYMgTMMUTccnR75AVSTJ/KcdEX
        Xuenggh8HRFzHkbVXzbDADOZ0O2ZBORag+dVPRdliy5QlDXgJ1bR+EwejpGDKtqWUur9
        nOuA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX92EW4mFvNjTRB"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id 20735bv9VDLPBAO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 31 Oct 2019 14:21:25 +0100 (CET)
Date:   Thu, 31 Oct 2019 14:21:18 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git fsck, badDate: invalid author/committer line - bad date
Message-ID: <20191031142118.747693c1.olaf@aepfle.de>
In-Reply-To: <20191031101539.GY4348@szeder.dev>
References: <20191031092749.074ed112.olaf@aepfle.de>
        <20191031101539.GY4348@szeder.dev>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zcoT5ilJrK4E_ZPWZ0ACnuA"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/zcoT5ilJrK4E_ZPWZ0ACnuA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Thu, 31 Oct 2019 11:15:39 +0100
schrieb SZEDER G=C3=A1bor <szeder.dev@gmail.com>:

> However, I don't know how to tell about the skiplist file to GitHub,
> or any other Git hosting service for that matter.

Thanks for all the details.

Is there a way to "replay" a git repository, so that all the commit contents
and author/committer data are preserved? I think it is more important to ha=
ve
a clean repository than to preserve irrelevant commit hashes.

Olaf

--Sig_/zcoT5ilJrK4E_ZPWZ0ACnuA
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl26384ACgkQ86SN7mm1
DoCLgRAAgi41KoL26Ahuh9I4O8t2kQEWubDuXiGxSE9l4Q4mL/R3uCmA5FwGlaWy
a/Il15IVKJf1NSEvRRFeT03RUo9LDQd0CTjXLUSC5I8R9zCXnMXx7V6eO3k6HiaL
8vp4Sic5Ji8UJK3PheaGnotrnWhI6EE2j51JH7rKft0Jk1jiTIXT6TfqWJZ83zzu
Gkjh9lxyaQ7refMrqDLsBl5nGy/KJudgL/1tgpQqY6WzlGIUIPs7VmnT0ecV1Gxg
D1lW5XvRyagUAYJo1OW0Eu1N1X5e98eJZ+y4RYE8cxm9ZsDMiDMB+ZSUesywUyti
JpZBruanQQBNc1xHOvYoPI6qHr5afMOVhl6nb7Zg4XcycDzE6y4bF4pYhdMvpaf0
IAnS2RFxy+ao4XzIh1R7tKwGfGzCOhqL7VN1ao9iqXQH4ddJ7eGAxWq3ZMXkQ0Uf
H/SlO70Gq6n3vbVwtxoAubGUkX1qxlhgZGpjbQlR4QZslkUhBC8Wau4La+lNkAF2
/5/FsXEE+plCo1B2B9NPL2pvDJbJ0FQNaWIOu8en6qsmNsA37rSxEm3AY4pU1l3Q
MhBdVaSMlOpTwke3E3ywDWV0rpk/5kFUy/A4GbFGFQmwmbrTVZ70jpLaAz768A6b
lrF4agcAB5mnVhojjj6D0zPPDeebGp2/5ZDomPtMysyOlKqCvxw=
=nJgF
-----END PGP SIGNATURE-----

--Sig_/zcoT5ilJrK4E_ZPWZ0ACnuA--
