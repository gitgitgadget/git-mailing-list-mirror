Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895B4C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF30206ED
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 12:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HpSZwxOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgBNMHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:07:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:34483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgBNMHO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 07:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581682022;
        bh=I5qwSYAhzjchNZUZymFjPP6WWsb/Lrvf16qsGLtCgJ4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HpSZwxOmeZXDPCb6vBGhmkGugHjYyhcLD+dZciLRqAsp4z3PbT0XCx3giSMN6ldbk
         EjBMkeyuNUt8OsQ8ydxMsMX1cbNyW9eO50xWMxOqRs/iPmx+nege1e7LlWCN5py1/n
         idpraK8tZxznQGYWRiRWzw5jAjtz1xjx3zI00Kmw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([89.204.155.13]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKHc-1jPbsg1WYe-00yjPI; Fri, 14
 Feb 2020 13:07:02 +0100
Date:   Fri, 14 Feb 2020 13:07:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Git representative on AsciiDoc Working Group
In-Reply-To: <20200214062335.GB605125@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2002141306350.46@tvgsbejvaqbjf.bet>
References: <20200212002129.GB6464@camp.crustytoothpaste.net> <20200214062335.GB605125@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Tqfr1AuGb6gvj9ZggIPWliSI19ZFvz0sESC9i9QoRb10GCjs7FZ
 nzHC1rzpK9thzFOwO/WQ1PNbiOFSgx0jklX0P+pj+ob44ze2mdvY6WAnSwaEHXT+MA1RLxi
 eH8f2/RERThQdm90I3M6RDDQyB7K6eXx8Q1yBKtkp2uOpd0Cj4ryFRburq1OXIIjxMfEyoB
 +fTNY0wRPgdY49ZnJ1AAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ki9bBJW0kgk=:iqvRmzo2LRN9wI1Axzftkw
 Y9uSysU5t1PMlRHnV5alSpVBCEs7Y9q+FSF0rxzgHlgHfOzxh9rMXhHXGsdf4Jv3BLqH/gVcM
 N7TwjzTdFOXq8LJCg3TA9/vATB9JnwjcX7Rf2D1E1XylNor6JJTobNpdw0pbE/YSKLoMnLSZM
 ccea4tshtpg6QdgX1AqPtN9dGuO/HjxapujO41DM8XE/Jwr02pKcoHHif0pp8Fp6YgKGVkJEL
 uKkz8ClAfF7+k+uEnkDJzaEsy1vC6EhNG02SZ7mxtrbl9iPwNS09cZ9PvHIOoB2Rypo7JQeLR
 BKjtubLaddU7oaPgM5bPPoEhj9ie4KtKyIZiWYz/B1eEz/JTZYQgSmjfQh41w2pAhM05apVQI
 FFcrMwMpitnOCV2YuZNdgLyGANtZ0UFt1bm116uU09jKmi/c08mGtNxUKRjZWGxvTueJRjsek
 S7WY1UvLNLa7mSR+f01Y8Gfenlfpmzs5mA3X3vhyzgx83GQkAe4fb7ytwLrMUkz6q0skYj4bS
 uT5orZecA9e0pb25JYrRSdbHOA0UR66lBq9P2HF4vXLZzKWoWatU+/IYXwNj7K2jl3SOzK8Qm
 DClhgjo0Qz2d2YYgJxWbe3PNO1Xn5cCsbbpDHX2H2uDW0P5t44fcmrvSnVWJ3Bf+Gap6j9JG/
 q5muNcPVAf8zA8imtKhFNseiNOTm3hOrWglZiOhcBzmemXwIjP2HDETEBaF/Kea+h0jUGa4Bz
 drhsRigG5JsM/qA69SwBL5OSOWTQLnOPt3ThoDQO8ODL8Mfi8UxVn/2KbuEh01QimiTa1VIRm
 E7lP5l91A7U4/tuBdh/awgxrbm/s92mSkmocUldKtMTE4/BHAzXZBSMdOaSc8GL2TFbDxyrk1
 qV5I2zatibyOd4r3GChxmV91qMoWKrA6SjCJ1YNxYcKr4TGyzpJ2TrP0UwstaguhavuAGiN7L
 v7pdUfaBTE9oF/d1Gh3Ss0edtqCWBsqGKnIAo/gZe1ho8DA/Iyx0hJtOMRwBqUvJr6e0+yGTl
 9408zHOyQjPY8Jp5auklvTPMmiUnmCicdMe9Bhu3v7bx74qXpvXkNKCieKlwIoiYzT4vR0E4N
 AYe5gk5r/zxdTbW6rpCj0dQh+BgR6P0k2FII7wXehLHfyDGpteWM6yg+IzGdbi1nNxQAzhPlN
 MwyyO2RUkfbvSKkPCKQPEf6EUw13X7JDKz6NHGDEzQG8lSLyH9SfzXXjSqm8CYVN/3vEtGn4L
 +ZVMG3BvM2z0yrj0S
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 14 Feb 2020, Jeff King wrote:

> On Wed, Feb 12, 2020 at 12:21:29AM +0000, brian m. carlson wrote:
>
> > I've had folks from OpenDevise reach out to me and let me know that th=
ey're
> > launching a standardization initiative for AsciiDoc under the Eclipe
> > Foundation's open standardization process.  The goal is to standardize=
 the
> > language, ensure compatibility across implementations, and provide a r=
eference
> > implementation, with input from implementers, users, and others.
> >
> > They'd like to extend an invitation for the Git project to send a
> > representative, since we're a significant user of AsciiDoc.  I'm sendi=
ng out
> > this email to see what the project thinks and if anyone would be inter=
ested in
> > fulfulling that role.
>
> [...]
> As far as choosing a representative from the project, I'd probably
> nominate you. ;)

I'd probably second this. ;-)

Ciao,
Dscho
