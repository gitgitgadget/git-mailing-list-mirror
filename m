Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA88207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 09:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428335AbdDYJwK (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 05:52:10 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36448 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941520AbdDYJwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 05:52:08 -0400
Received: by mail-it0-f51.google.com with SMTP id g66so15346026ite.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TcBc+FVdXcxqD407FSdOKDYYblTbqpbcuqHMi5/pMHA=;
        b=YTgSTU3+RC2VgZH4kUdpN4sPk9gmn71s3bGWb2iEJIMGcKHgOyDTLoejbGMLeWeVdJ
         IgAHIBjhtFdrghOlekQrSZy9CCeT9RPV7FyljXoxInBrJxmVal3ETiPwooLudpsM0UGt
         n3GiK5CPzjLUe5cMxtllSi/VVtZeBCBP9q9ZqHRzWp8AWS7jrJoFmdPkRaGTeb0Tx1c5
         c2FEtPuFgEGwqPN4LYghZb0iqlsNh5eozcZh5ePKiSxK9yLC/pmLleSd/igM3Wu506ni
         kNtNC03Y8LDVB1QRx7zCqIp6WQylIgi2Vs8m7ik0fNmRAu3t6wG+3HcUVNYp3CdEvVBl
         n1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TcBc+FVdXcxqD407FSdOKDYYblTbqpbcuqHMi5/pMHA=;
        b=VVGKanJUD3GiNjyNHGWE3A0/WeVSLrOe0UtbmB0W6G/oX509ZK3p+HeIAFzP4DRWSB
         OGhTjtzwI03xpgjoQP9om/HBiLC4TmEcVzEzLvj13cl4f7klZvVA+MPUAkDEPj3EtM6c
         1c0TxD/ElrcT/RzNj90/MlRxLWGkAskuZzmxUdAqPb71AQGnCTZ0e1QdeETEHCMhMO4H
         sZKh5g5vYEDuSAtZBnJbLqNv0OQXUXwsChvymbLOXK/1PsMgyqmhwI6DE+5DY1/ZaEb+
         vq7XW1oxvMMftZdjc6dcI0/UWuLjqf0wVwxjI/U3oSgOmRnECg9M48ZG8XxyyCCZ/+I9
         Xipw==
X-Gm-Message-State: AN3rC/5GiwwYotuW7gqLVMsTMMTGgnaXqYLN5zqz5QiHNgR+7YP/Kyl0
        JK3q3jmNZoVGOZpIi3ZCbkVTOAQRJA==
X-Received: by 10.36.26.81 with SMTP id 78mr18791421iti.91.1493113927887; Tue,
 25 Apr 2017 02:52:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 25 Apr 2017 02:51:47 -0700 (PDT)
In-Reply-To: <20170425094453.9823-1-avarab@gmail.com>
References: <20170425094453.9823-1-avarab@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 25 Apr 2017 11:51:47 +0200
Message-ID: <CACBZZX7x0hSy5PTCo1Cf0Hp09jBhnSF0T=BseH68kwMRmqGJig@mail.gmail.com>
Subject: Re: [PATCH] test: remove unused parameter from the wildmatch test
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 11:44 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Remove the unused second parameter to the match() function. Since
> commit 70a8fc999d ("stop using fnmatch (either native or compat)",
> 2014-02-15) this hasn't been used, but was previously used to indicate
> ok/fail if the fnmatch() backend was in use.
>
> The "x" argument meant that the test would be skipped for
> fnmatch(). Support for that was implicitly added in commit
> feabcc173b ("Integrate wildmatch to git", 2012-10-15) by leaving out
> an "else" condition, and made use of starting in commit
> b79c0c3755 ("wildmatch: properly fold case everywhere", 2013-05-30).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---

Right now this is all dead code, but I wonder if instead we should be
partially reverting commit 70a8fc999d ("stop using fnmatch (either
native or compat)", 2014-02-15) by Duy to the extent of being able to
extend t/helper/test-wildmatch.c to test fnmatch() as well.

We wouldn't be using fnmatch(), but I think it's a probably a good
idea for the tests to support a mode where we have to declare
explicitly whether something should also match under fnmatch or not,
so we document the differences.
