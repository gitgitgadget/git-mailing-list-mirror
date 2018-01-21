Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6E41F576
	for <e@80x24.org>; Sun, 21 Jan 2018 16:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbeAUQgc (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 11:36:32 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:39151 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeAUQga (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 11:36:30 -0500
Received: by mail-it0-f68.google.com with SMTP id 68so7193267ite.4
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 08:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=PEF+rHGWx03j6a/lXLR5ZzcRE8lUUIfOc8RU2YBGOAQ=;
        b=OMsKolSM3NIuulrj43OA4iOpiHkdeu+ugot+mpjhIisIb98eyMVquDvZgk77+Jdl8D
         RFza/LHFDX23dP0UVBPjB+A59Vxi6PzKNLMhinMWqOCQYDxDV28JfZcfetA4dRHCvFdN
         nLB2wjweT0dvozpmp8MhhgZPvhgjf8LncLD0MZcO7ozfevruuEUI6+PYZesDX+RDGaR6
         whyNwBeliKCe9wHgZVQm4lvRUHK0zJokg6xNTbD4u0z3iDoat1/cIwwoGxmkLa8eS3/p
         B3002j1RLy0cZMK9TLaMVxgYa4h5Eg6F0+ME0VLC8Xm0JDxHySZvMBxkVKakb8ggK3I9
         Xbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:content-transfer-encoding;
        bh=PEF+rHGWx03j6a/lXLR5ZzcRE8lUUIfOc8RU2YBGOAQ=;
        b=kHZXLrZmHwGjBbZQBxSyPwmZB7XujeFSA3HKFq6pxQs5agOEIoLJz8q2DU8koYQlb/
         f/HdBZ5Ag/E6J1RQM/DtD9rpTzMNSUhWsS9iWyd7vBIRFcDDZ/QmE+d+ClVLdSmJv025
         4D+jSsGRldBWEg/JJ8d7y/hmKu2+Ruore65TdHPatfMJiHV3woeu+BHDOQmi/c/myzYy
         AqMIx+StDfKBlAKZKIgLcZIiOBEGUiDVgkGKxG0cPvlMkXCuzBZ25VBJWI1XTDrj2sRR
         302GAAyH/HAz96n9muDTPhYEQRfGQQaW5LRGQHhq7zW/9jMyTz6oS2CM/UJpj9uWi7ae
         Qk1A==
X-Gm-Message-State: AKwxytcLOzGlLr++xne7q9lLC86Y9D8n9+KJJtWdaewXDuwLroBZNqRj
        tuJ0wZp9sfZOssrS6eIphyMStLcnsDXG7dPffEc=
X-Google-Smtp-Source: AH8x224a/y7JORB676z+q8mCkyuFQky0ZmWicJg0WZhlQeHp/OtmgTXbPwVP/CY0wyoMmiPZkWTr5akOkNfCjanWJlI=
X-Received: by 10.36.216.8 with SMTP id b8mr5095386itg.107.1516552590217; Sun,
 21 Jan 2018 08:36:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.140 with HTTP; Sun, 21 Jan 2018 08:35:59 -0800 (PST)
In-Reply-To: <20180120205830.GC8965@genre.crustytoothpaste.net>
References: <cover.1516282880.git.patryk.obara@gmail.com> <20180120205830.GC8965@genre.crustytoothpaste.net>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Sun, 21 Jan 2018 17:35:59 +0100
X-Google-Sender-Auth: 9zep9cvYLWSV5duQeiKm5LJV3Fk
Message-ID: <CAJfL8+SU79RVbDVQc-feNvFtpcGdP8VRNyvhE3bfaMb6_OZuqQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Some fixes and bunch of object_id conversions
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 January 2018 at 21:58, brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> When I've made changes to the sha1_file functions, I've traditionally
> moved them away from using "sha1_file" to "object_file" to ensure that
> we make it a bit more obvious that they handle object_id structs and
> aren't limited to SHA-1.  For consistency, it might be nice to make that
> change.

I will address this in V2 and add several more conversions, that
are sufficient to make git hash-object -w work with sha-256 (which I will
send as separate RFC thread).

I started converting functions needed for cat-file, but number of places,
that still needs to be touched up grew quite rapidly, so it'll take some
time :).

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
