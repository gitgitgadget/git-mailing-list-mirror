Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9681F597
	for <e@80x24.org>; Wed, 18 Jul 2018 11:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeGRMbN (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 08:31:13 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:43177 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeGRMbM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 08:31:12 -0400
Received: by mail-oi0-f52.google.com with SMTP id b15-v6so8188572oib.10
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=eEaATMh7qsHZU6dog5RLiv9NHSHUmXLKlNQGwYJwcK0=;
        b=HcTsEvALz8WxFNfpZ2oEx5nbu4AKtXVCHAfqY6KPJimTREcuTDX0k0cR9AhBmct3fS
         LBKsGqTDdS1ge1vfJIrgAieZ5F3O9zlmcjpmdV0o4BxP3aJ4UJeG1Jh0R35NIrgpOV4v
         Tgf9UhNalUdA5dKRbxf8m+FWqLrMvfPpS23FhgTtKIpnMGRBa/nyyNGKE4jNwn764PiE
         17OMQw+XG6woF1/3v8ERTVE6zBZicvoV2KbuCTZXFz7e3+cPomivvIn1LBWo4lQrLe8Y
         JRdbLohLcVyPhLxFIPL8O+BjCzxgyeSJw/y06z2a12pY1YFGitHTZKntY/GU2d8JvNhu
         jjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=eEaATMh7qsHZU6dog5RLiv9NHSHUmXLKlNQGwYJwcK0=;
        b=G+e7n3/nn08IHZN8wXZTFppAp7/gpB263uoxDU6NqfFh97pCgYRbLYxuYzrfedUeEK
         FQylxk2NTacyFl3igWCmy5HxEnIL79yEijlG39tq8MV1D8BGq4iSJdBgnQ8lE9QQuhXZ
         Gr7LK6FQsMagTDqpQ3u9FVJO1zHmOOMax4sUHHeKr8GyhOdYrU0AleHIlRm/TTZpD3GH
         Ee3XHdbZSNHziDEKa8Meoxhno3241cnRcN8BWY5sRV3QGSBT3ObxJITjJ1t9ajHjMSQS
         mKZ0Qsx6dkmDJdbHDEhLvfGLK8l6+92/P3og8zKPpeJ6AY8T4ltOWcxdAsAxznG0WcZJ
         j5vw==
X-Gm-Message-State: AOUpUlHSN6hPq48DhE/uizMxHTe5TbaroXA8kbLLKylSqFe5lIfzV0Bp
        kZL9TTIwBwFZc5Ppmi69i1SWTx9z54HNdFDdibPiutCE
X-Google-Smtp-Source: AAOMgper1ol6ONG+Wcn4EXIO9/xAoCRdT59TAZIOlZAjevBP+cHfHCoMcGi2jx1p0xEC7+ykcG8rhj91JzmKaIb4UFM=
X-Received: by 2002:aca:30d4:: with SMTP id w203-v6mr5753881oiw.8.1531914819285;
 Wed, 18 Jul 2018 04:53:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c689:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:53:38
 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 18 Jul 2018 07:53:38 -0400
Message-ID: <CAH8yC8nef0iPVLqnkcJ2fh=N8jCM=tK1DXJJe+nx8cOL8K9D6A@mail.gmail.com>
Subject: sed: command garbled: rGIT-PERL-HEADER
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to build Git 2.18 on Solaris 11.3 x86_64.

$ gmake V=1
rm -f git-add--interactive git-add--interactive+ && \
sed -e '1{' \
    -e '        s|#!.*perl|#!/usr/bin/perl|' \
    -e '        rGIT-PERL-HEADER' \
    -e '        G' \
    -e '}' \
    -e 's/@@GIT_VERSION@@/2.18.0/g' \
    git-add--interactive.perl >git-add--interactive+ && \
chmod +x git-add--interactive+ && \
mv git-add--interactive+ git-add--interactive
sed: command garbled:   rGIT-PERL-HEADER
gmake: *** [git-add--interactive] Error 2

And:

$ perl --version

This is perl 5, version 12, subversion 5 (v5.12.5) built for i86pc-solaris-64int
(with 7 registered patches, see perl -V for more detail)

Any ideas how to fix it?

Thanks in advance.
