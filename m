Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1805F1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeI0BNa (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:13:30 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:44880 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeI0BNa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:13:30 -0400
Received: by mail-ua1-f48.google.com with SMTP id m11-v6so2082uao.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qn3zyg6h3ai1ZXjHlDk0P30wf/qKsVRM+qo8orucsTo=;
        b=IvepRXz7W2i38GiboHdyIi/VzLvlies42Q4PQIx+rBhtvlikzDAMmMHd73Ium5PKAZ
         YcfvUnzQSTFPcDBn1PSi23WLM3Yld5z2+baQRGvhnKdji3oH9xP4oY+yv0K9yk55OCYm
         8ZuuDbUtHPh8uAEbgINeZksIu9VPqTc5ZOl2ErhkiC1Xvfn3CyQmG2RoRX4h+jtVsa4Q
         dyyWUZx8OJ4HxsK9/2EcPRf1nErz6yYDuK/b7Dt7iM6QZMRaPGxPgoaUJnzUmKsHqOaU
         DDt+n+arEtrz27iNv94XPdyCVvzYTIe1ButULT2ik+0gz7RZC8xk2e9wnEPaJNtdDl5v
         WDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qn3zyg6h3ai1ZXjHlDk0P30wf/qKsVRM+qo8orucsTo=;
        b=s3d4IXwvZBqGhUnyw737PTTaQYZFYk8tUQsAVaClTNW9NymR6VGaOr9SpE6/4V3R+M
         bYDWXkQkdFC1GdiMhIMj4s8pCpkd2IOokG/pGQAx+MoqIO27F3tY6SpQ9r+EJS2HAbez
         CFrY1/wfUex+ItixWciW4drRo6RbJkbHM5fqGHkVvbmn8CWwTclayaVz3hj2yJ48QjJG
         3ngmdNjWqEi1vJFlm0kKXIVRQujgqUZUGE8U+BuB/LbqusX1t+nxobYyw5gd4aiT5B6O
         dEwqlHJnCW+f0Xm2Rv+LsWOKhGOl3LQqi/XY5H+VC4ZPmvn95uLGlor2diSQKAg9t7ST
         ylkg==
X-Gm-Message-State: ABuFfogLNSHfIScq9nQYXB2Fa81dioK2dkrpDlLYlSveCkBfCiEZv805
        eUnMmd6tyriW5H9Sg5qLJIgIX4YcIUr0su/AtAo=
X-Google-Smtp-Source: ACcGV62U3b91PrlTVnzw7xLYYBhgFA+R/w0Fl9kNY+cduWbWE56jAmh1fItQ/RPEhawEbj60W7tZn9Bsb1mga+T2HuI=
X-Received: by 2002:a9f:35f1:: with SMTP id u46-v6mr2382365uad.20.1537988349103;
 Wed, 26 Sep 2018 11:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
In-Reply-To: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Sep 2018 11:58:56 -0700
Message-ID: <CABPp-BFzNR__8ycP04gFjJYqKfBWoq_p1VhyagsYnvJn9O4TuQ@mail.gmail.com>
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 11:44 AM Derrick Stolee <stolee@gmail.com> wrote:
> c3b9bc94b9b     (Elijah Newren  2018-09-05 10:03:07 -0700
> 181)            options.filter = xstrdup(value);

I blame Duy; he was the one who wanted me to look for and remove stray
semicolons in additional places[1].  ;-)

All joking aside, and even though I know nothing of remote-curl.c
beyond the fact that it used to have an excessive number of
semicolons, I think it's awesome that you're running a report like
this.


Elijah

[1] https://public-inbox.org/git/CACsJy8Cf5+3+6yDwe4Y4wYLze4Y6naW-pj134KTpXM+wyWbFVQ@mail.gmail.com/
