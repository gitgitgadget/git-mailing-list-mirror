Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F54E2023D
	for <e@80x24.org>; Sat,  4 Mar 2017 17:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdCDRY2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 12:24:28 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34784 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbdCDRY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 12:24:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id m70so7545304wma.1
        for <git@vger.kernel.org>; Sat, 04 Mar 2017 09:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r1s/eY4bxuNLj0ImWrdWnvn+/QKSo/tHA6HXrl6QB4U=;
        b=k5JBFoS6J2P/F7l/m/rNzZZqaxQoRs5ToBL/R50ZesC6CobA8UUlw5WKBHw/J0pUE+
         smNFsYT91MJVEXlwftpWL51jvII7SQqPyooIArHycmBsEtvW7fjLyoV9eZxn/WLBaATh
         7LCws9JBsjnaoz6DRXvN0qRf1QOmUEmmQGKsxlrLOOUKPgjWlE9A2sEN1xn6ON79VRI8
         8r9ev/nOM1PMwGPalQ+hVSn0aZhyqdgP72ujjWyMtx/0EIWTbclAmJZjqi34A/eNP+DC
         ibC+i22Rmy52NaKNM080YUQOxVtUtCweC64cqBzlEL3x5R5445u+I0QzCTWqozcvhjuP
         2MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r1s/eY4bxuNLj0ImWrdWnvn+/QKSo/tHA6HXrl6QB4U=;
        b=hH+zcOVfeTIFSEOftWz79ES3oCSh9WbQfO87XAdAlJNXQeUoJiOBK7t3pLc93uPc+7
         VvgS8lSwS+2vC6XOHGuOLJqHkFdwG6Zgzx2kFyaEcdC+EaG9Ki5EldFMzDyEVCwGk7nr
         5TQfH/5wP3WDuF6d/Agzf1qFxdIQ34qCq7mvHlpa+CuSC/C4HPFc9qnkwaCHK1IzL91v
         UFR0bB/aZ19+hfhunliFFver3ICcTdFsLOBd9H07vAFXS88TH9tdhkLUv945vfGjLnli
         gPVLCHL5z6Fibhs5cU/rEgHG+4xpm/ATDhhawNIOIXSrBRzY0cCNKjaQFOM3+rm+0e/z
         ujGg==
X-Gm-Message-State: AMke39kp1OtP8aTb27DP2zRo29KYsHjSeeR4n3d7f3DGMojbUBMxZyXJnla8sfFrTPDWxQ==
X-Received: by 10.28.172.68 with SMTP id v65mr7023624wme.111.1488648211951;
        Sat, 04 Mar 2017 09:23:31 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB4C60.dip0.t-ipconnect.de. [93.219.76.96])
        by smtp.gmail.com with ESMTPSA id o15sm11774680wra.61.2017.03.04.09.23.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Mar 2017 09:23:30 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
Date:   Sat, 4 Mar 2017 18:23:29 +0100
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de> <20170302105157.59791-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703021210170.3767@virtualbox> <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com> <xmqqinnrd098.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703030315580.3767@virtualbox> <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com> <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com> <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, allan.x.xavier@oracle.com,
        vegard.nossum@oracle.com, Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Mar 2017, at 05:11, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> On Fri, Mar 3, 2017 at 4:03 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>=20
>> I only recently started looking at Travis logs, so I cannot tell if
>> it is just a usual flake (e.g. some builds a few days ago seems to
>> have failed due to not being able to check out the tree being
>> tested, which I do not think is our fault) that we shouldn't worry
>> about, or if it is a sign of a real problem.
>=20
> Tonight's pushout also seems to stall the same way. Dscho's
> unversioned one didn't exhibit the problem?
> https://travis-ci.org/git/git/jobs/206811396

Did Travis find our first 32bit bug? I briefly looked into it
and the following new topic on pu seems to cause the issue:

=
http://public-inbox.org/git/20170302172902.16850-1-allan.x.xavier@oracle.c=
om/
=
https://github.com/git/git/commit/aaae0bf787f09ba102f69c3cf85d37e6554ab9fd=


The "git log" call in the new 4211 test fails with:
*** Error in `/usr/src/git/git': malloc: top chunk is corrupt: =
0x09ff4a78 ***

More output here:
https://travis-ci.org/larsxschneider/git/builds/207715343



>> Unrelated to linux-32, the same build has hard failure with Apple
>> clang in t0021 with the rot13-filter.pl thing, by the way.
>=20
> This one may be a Heisenbug which may indicate some raciness in the
> clean/smudge filter protocol.
> The latest build of 'pu' https://travis-ci.org/git/git/jobs/207550171 =
seems to
> have passed OK.

I agree, there seems to be some kind of race condition in
"t0021.15 - required process filter should filter data". I try to
look into it.


- Lars=
