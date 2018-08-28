Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D8E1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 12:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeH1Pzg (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 11:55:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:56959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeH1Pzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 11:55:36 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYP57-1gPAI60GkD-00VBAS; Tue, 28
 Aug 2018 14:04:03 +0200
Date:   Tue, 28 Aug 2018 14:04:02 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
In-Reply-To: <20180824014703.GE99542@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1808281402510.73@tvgsbejvaqbjf.bet>
References: <878t4xfaes.fsf@evledraar.gmail.com> <20180824014703.GE99542@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1824816372-1535457844=:73"
X-Provags-ID: V03:K1:6Hc9jq8zoQHVW93iLqUm/aIwtg2v71GuB/6uFwFw8If56BEWudG
 w+85CF1aBeiZdCqh5gj/I88spWKyEALAMxWVLohISCMv9PsOZ8HzSX7msWN2xEmZ5KQDdcZ
 UZq4BUZIr45FFKQIdkZM6ysEQaagMXHx1fqcceO2VZ1drAGJ10a1LosHxXfqvRg3ObN6THa
 8aqJQI1oLJd7GcWsPzXVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xptPIPpjs2Q=:EJsjjTlaUHgYe9xcpI/DX9
 0eYqPN+XJIHaB8JS3wkqFkom0G3QwkT6ETrv6WgPPE5vb7756TgvV6Y0SQj64AvPZ5vti+ZPI
 WtVv5dNC+GSnWucjK2Hx9s34cmE2/GA70tZoejn60+ZdOpsR3VL29RLVAIMjZ7NCyOg+Zfunl
 1e30RUmRXBnp+VYMVeNIoMKD+kDHbTEMIi9/xVKI5wFssR7cmeN15LDWKCFHJZ5UBqFQ+63rI
 74/9jU7adV3rStmeLU7zdqpXoFXHqEwYZRdBM0CF+7eexvXe44yYeucpK/u6CIPdP0kMIVZcC
 lzVJCJr+H6q6tmTpHjUUNfgaa19x7J36EZR0WaIaM0SIu5TWUGMZwZzTIgG5Q+qG2DsQ2YY1c
 QJeBSHI7UobuoDxpt6biZzsZDyRBKk63nLmsPda7IV0xN0bNcrwi0pCkTrbKtXdemesYn3Vwv
 mwJD9rl8MmV1o2OCA/5nH4eEmq6cpAmEN1Rn2iacrjkMDJ6VJIF08LpSAeAv++aQjRAN6Oddq
 S8hMpmPFrCrOudtwOdcXH6gGKVt+ot/nY3FJhUTeWubZ+zku6JOPD4OZhUr6K97IJiu5235jM
 4xWrgme1L1y7vj61B+CL0s6TfjqFwTA3RPpOnChYRvIHzWsnV+jlK9MMFtoPATtCmpwAnuFnN
 Gi+COWE+5dhF2UmXcyK62Ah0uup52hUbY7T4DLawNz5T3cOTL0lM0ZMKCTqAAAYoTB4PhtrZG
 T0cJW8yq97aVFapu34phQSUGPRwlpxZ0igBabljnR45v1Gi7UbSksCKFzu2gd/gKWYPqqfQpK
 uurgxRF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1824816372-1535457844=:73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 23 Aug 2018, Jonathan Nieder wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> [...]
> >> Since all operations that make new objects (e.g., "git commit") add
> >> the new objects to the corresponding index, this mapping is possible
> >> for all objects in the object store.
> >
> > Are we going to need a midx version of these mapping files? How does
> > midx fit into this picture? Perhaps it's too obscure to worry about...
>=20
> That's a great question!  I think the simplest answer is to have a
> midx only for the primary object format and fall back to using
> ordinary idx files for the others.
>=20
> The midx format already has a field for hash function (thanks,
> Derrick!).

Related: I wondered whether we could simply leverage the midx code for the
bidirectional SHA-1 <-> SHA-256 mapping, as it strikes me as very similar
in concept and challenges.

Ciao,
Dscho
--8323328-1824816372-1535457844=:73--
