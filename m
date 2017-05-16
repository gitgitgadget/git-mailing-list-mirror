Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A228E1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbdEPRut (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:50:49 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:34991 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbdEPRus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:50:48 -0400
Received: by mail-it0-f41.google.com with SMTP id c15so66984900ith.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LpnbIaonugYzIakx+Lh/zS3IoHUZUa82k25u5CnbiLw=;
        b=kYApMIXHEUi05mTEZoqaVsMY7u2yxkJXRrPNsv4h1F2HhOOqjxsRfmvKePyw1z0jl+
         64lb0I9Nm7Y6nmoMXcNDdJ2zHopeQS6HiBYGjO/yH2Noq/c6PbAAn3G782ofRLQPbBSG
         Zrcsxlmj1yH7HN1P22XtzbDvbAgNAYgYLvHATDiDfhWQH7q+OAlY22a2qQ1h9T93dCHk
         o8fqBBv/86kaU6IF2tVgcG8R7zqkyGPYLmK2uyyIWEkwKt9QkEXjmzjOPlraTltm/PGz
         nXbpNXU3+Nj2WaPxpS8J+509ZPLBAwKJlSelO5S8RES1R4oHjYb0wT9I4gnENaSpMnoZ
         rTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LpnbIaonugYzIakx+Lh/zS3IoHUZUa82k25u5CnbiLw=;
        b=SwixSYk8wo7R0iTfPX+X33sUow4YpGwxZ4sEnsF2c4l5oJVoF2Vsrx4Khil0gkkPuQ
         w9csMWU9ZrZSkFDmO6h9iTtnr3lKlYemG1+dNTk0/zsYlOTknG8kOQEy2OdS5R8oJwAm
         Qdrx3k7bpLqm05Y5kGcIVVRlKkBqvhScXW6+Kan5ghKZIyx3YB2TvTLlcFtzCJJKGcr3
         L80OPERGVjj9iyrk2HHNxt9X4DdnA6WZkye0WqgWZXEzfjCMKnbYFkjKuwVaKfbk55VD
         Q9pY4YXRT9CWMSgUvBfHOhR6Q3pkhlcWn++S9q7AdnqnNp18aUhRxSgqLDtcNbZZjuko
         UyAQ==
X-Gm-Message-State: AODbwcAOq8fz698HDHl+neUmyPAPsl6YSLTR/h0X+v1v9udAA4J4by89
        wVgMneV+ckMS79+dXhOBLJUe6oPbDD7PNqQ=
X-Received: by 10.36.37.78 with SMTP id g75mr11631126itg.94.1494957047760;
 Tue, 16 May 2017 10:50:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 16 May 2017 10:50:27 -0700 (PDT)
In-Reply-To: <20170516171028.5eagqr2sw5a2i77d@kitenet.net>
References: <20170516171028.5eagqr2sw5a2i77d@kitenet.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 May 2017 19:50:27 +0200
Message-ID: <CACBZZX5AgdMTceBAVftNp0goHpf2-hqx8GzvJshx2n1FtCGsBw@mail.gmail.com>
Subject: Re: reversion in GIT_COMMON_DIR refs path
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Peter Simons <simons@cryp.to>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 7:10 PM, Joey Hess <id@joeyh.name> wrote:
> Bisecting this test suite failure
> https://git-annex.branchable.com/git-annex_in_nixpkgs_fails_with_git-2.13.0/
> I landed on commit f57f37e2e1bf11ab4cdfd221ad47e961ba9353a0 to git.

That links's broken for me. Looking at your wiki it looks like you
mean: https://git-annex.branchable.com/bugs/git-annex_in_nixpkgs_fails_with_git-2.13.0/

I have no idea what this bug is about, but side-question: It looks
like this is git-annex's own test suite that's failing with 2.13.0, is
that right?

It would be very nice to have a test in git itself to test with
git-annex. I.e. some optional test that just pulls down the latest
git-annex release & runs its tests against the git we're building.

Thanks for annex b.t.w., I use it a lot.
