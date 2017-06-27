Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F701207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 05:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbdF0FmC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 01:42:02 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35261 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdF0FmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 01:42:01 -0400
Received: by mail-ua0-f181.google.com with SMTP id j53so12518179uaa.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 22:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R7pV2PVJoLFFN75pamuvU9fVzk6OHJCljyk+UjbjCs0=;
        b=QbXZJCKtFs8BqVWw3ucAU8gFdoXRnngi6+CJVFxtU14rF/3RcWb35nGIMittlBt7kU
         wxZKCt61LEVTJLE565oj+j+cyzvDEkghqZFh2wAYDsmpg2buzNQv+adJpLkJuO2WiI8+
         n1zzB30oGjYuJnpDGom2AIQWcl3nUnpBqusvO+9yvnDgxTmuQP1GWedUMBhLlKTZFEX+
         gMnMIIGF7w39kFIvlBGnrzw6UxxC5nTfhgd/auA6oSIm7THOXcHzSNqU2HlZzyCoOPDE
         aiLJNB3Js0v+VuKsmD0ZwTDzAaa2SZAFLfl2yTPPypsmzAypy11qQyFU2Z6cZ1A2VRh5
         TzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R7pV2PVJoLFFN75pamuvU9fVzk6OHJCljyk+UjbjCs0=;
        b=Pc5xZ5D89C5E3wD5W8iNil7+AXBJWP4Ht9z1/eisCyZmICDkgBsZP3fB1Dx43WpeZT
         UcWpdzn2ezC+SVQg88WHkW599esYPoTN6OT8nCIZdKWnxVv3LGsE3NSqAe2BYbaZQE1L
         Vh8zkCyS+uGKnR+rxB9F1QO91Qn/qWzJ39FQHG1TVNNkG3K8ULoHupK5Osj+0hXjPs8E
         qY9Cry3T8c0Ocg0Ifg6HuSejUq7fkH47x48IfsS06nC1lVuijpg4qZpCda/Ba5O+zx2s
         iDm6jQ/iRH40n4VlcPICLPmUZDuA1WLmWQTKw+DWnlX4jjEFwK+H3d0Ba9adgblP6eMZ
         UbSQ==
X-Gm-Message-State: AKS2vOz0qElnkIsXe8VYb8D9tiOKXOSGTwcOcv7vnsR3piZockvNhHP0
        duUXmPIbU78zyjIxsotdEIQgsVkDVw==
X-Received: by 10.159.36.209 with SMTP id 75mr1491889uar.72.1498542114985;
 Mon, 26 Jun 2017 22:41:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.13 with HTTP; Mon, 26 Jun 2017 22:41:34 -0700 (PDT)
In-Reply-To: <87fuem7aw2.fsf@gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <87fuem7aw2.fsf@gmail.com>
From:   Michael Kebe <michael.kebe@gmail.com>
Date:   Tue, 27 Jun 2017 07:41:34 +0200
Message-ID: <CAKKM46vr2Y_Zs+EJX-nxw7XH0nbpmTyubR1jibYoiieNCDns4Q@mail.gmail.com>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Marc Stevens <marc@marc-stevens.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-06-26 22:27 GMT+02:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>:
> Could you (or anyone else for that matter) please test it with:
>
>     git clone --branch bigend-detect-solaris-again https://github.com/ava=
r/sha1collisiondetection.git &&
>     cd sha1collisiondetection &&
>     make test

Still no luck.

~/sha1collisiondetection (bigend-detect-solaris-again *)$ CC=3Dgcc gmake te=
st
mkdir -p dep_lib && gcc -O2 -Wall -Werror -Wextra -pedantic -std=3Dc90
-Ilib  -M -MF dep_lib/sha1.d lib/sha1.c
lib/sha1.c:63:58: error: operator '=3D=3D' has no right operand
 #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER =3D=3D _BIG_ENDIAN)) || \
                                                          ^

Running Solaris on sparc:
$ uname -a
SunOS er202 5.11 11.3 sun4v sparc sun4v


The isa_defs.h is available here:
https://gist.github.com/michaelkebe/472720cd684b5b2a504b8eeb24049870


Greetings
Michael
