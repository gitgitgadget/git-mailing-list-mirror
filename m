Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27EA820954
	for <e@80x24.org>; Wed, 22 Nov 2017 15:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbdKVPNV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Nov 2017 10:13:21 -0500
Received: from cisrsmtp4.univ-lyon1.fr ([134.214.188.147]:60154 "EHLO
        cisrsmtp4.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdKVPNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 10:13:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp4.univ-lyon1.fr (Postfix) with ESMTP id 6DEB5A0427;
        Wed, 22 Nov 2017 16:13:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp4.univ-lyon1.fr
Received: from cisrsmtp4.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp4.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O1Ak4b2bTtav; Wed, 22 Nov 2017 16:13:18 +0100 (CET)
Received: from BEMBX2013-02.univ-lyon1.fr (bembx2013-02.univ-lyon1.fr [134.214.201.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp4.univ-lyon1.fr (Postfix) with ESMTPS id 2E0B1A003F;
        Wed, 22 Nov 2017 16:13:18 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (2002:86d6:c9f7::86d6:c9f7) by
 BEMBX2013-02.univ-lyon1.fr (2002:86d6:c9f8::86d6:c9f8) with Microsoft SMTP
 Server (TLS) id 15.0.1263.5; Wed, 22 Nov 2017 16:13:17 +0100
Received: from BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd]) by
 BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd%15]) with mapi id
 15.00.1263.000; Wed, 22 Nov 2017 16:13:17 +0100
From:   ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr>
To:     =?iso-8859-1?Q?Martin_=C5gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>,
        "danielbensoussanbohm@gmail.com" <danielbensoussanbohm@gmail.com>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>
Subject: RE: [PATCH 1/2] Documentation about triangular workflow
Thread-Topic: [PATCH 1/2] Documentation about triangular workflow
Thread-Index: AQHTX75nW1NbRUFw+0OfOC4ezq/91KMZARWAgAeEv5c=
Date:   Wed, 22 Nov 2017 15:13:17 +0000
Message-ID: <1511367199220.88867@etu.univ-lyon1.fr>
References: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>,<CAN0heSoLbnkfJLqStvR2nfy4LAAc3KEkRH-_kE-QAQoM-4iqGA@mail.gmail.com>
In-Reply-To: <CAN0heSoLbnkfJLqStvR2nfy4LAAc3KEkRH-_kE-QAQoM-4iqGA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.214.126.172]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>On 17 November 2017 at 17:07, Daniel Bensoussan
><danielbensoussanbohm@gmail.com> wrote:
>> +- If the maintainer accepts the changes, he merges them into the
>> +  **UPSTREAM** repository.

>Personally, I would prefer "they" and "their" over "he" and "his". I'm
>not sure how universal this preference is, but see also 715a51bcaf (am:
>counteract gender bias, 2016-07-08). I realize that "he" is already used
>in this document...

This could be a good thing in order to be neutral.  We can change this in
the whole file.

>> + ... The contributor
>> +was forced to create a mail which shows the difference between the
>> +new and the old code, and then send it to a maintainer to commit
>> +and push it.  This isn't convenient at all, neither for the
>> +contributor, neither for the maintainer.

>"neither ... nor". That said, I find the tone of this paragraph a bit
>value-loaded ("forced ... isn't convenient at all"). It does sort of
>contradict or at least compare interestingly with how git.git itself is
>maintained. ;-) Maybe this could be framed in a more neutral way?

Junio C Hamano told us the same thing about the motivation
section, we'll change it the next patch.

>> +The goal of the triangular workflow is also that the rest of the
>> +community or the company can review the code before it's in production.
>> +Everyone can read on **PUBLISH** so everyone can review code
>> +before the maintainer(s) merge it to **UPSTREAM**.  It also means

>I think you can drop the "(s)". Your example workflow could have a
>single maintainer. In a multi-maintainer workflow, the workflow would
>still be the same. So no need to cover all bases by sprinkling "(s)" on
>the text. (IMHO.)

We'll fix that.


Thank you for your review.

Timothée Albertin
