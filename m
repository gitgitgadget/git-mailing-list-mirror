Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8083F20372
	for <e@80x24.org>; Tue, 10 Oct 2017 04:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbdJJEnF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 00:43:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38580 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbdJJEnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 00:43:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id k31so4976439qta.5
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 21:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jya9WKV81gvis27xPhnnRnQcLbm4zon9g1nVxVT8Z6Y=;
        b=O9iEipnXx0YJJnIX++pBfcDJpTyMfQ9fbiDrzXX7fZuzec1uYWmRByG8anANs+g3+i
         HRcPbJzLRpkHnwPt9EW84lOUQ7Y2IaRAhfyEmJU0IWskYREpdZkgTR1iVAdmblNJRquv
         LE1+B7bRBo7gevRP81Kvf9Y/BXwQUsQQS08WWB5Pbee92Re14ZRdPdywRztybGHAPb2c
         fNm2mga+xg0paom+MAUizToSbh6jxkOnrXqAMtPKUVxOUCt4EJg5plesJbxFQG1W46Vk
         ZRvoypqv3Rc9V6KzxCkpeOVQZQPr4DOgeZQP4oVEGNcffEFMnmOJictGqVmvmH4lAcfb
         vcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jya9WKV81gvis27xPhnnRnQcLbm4zon9g1nVxVT8Z6Y=;
        b=lf3m/k2CJyKqRhyHMHheTCWRCWtSHGFZAmrwevxXuQtcYR3X2ZfdxbFceWQk1xWBAU
         hPwZBpd7ToMdYtKiHqnkKjignQE2CxqGqXZ3kF9DYQBmkpcWx0k5FIKsJEuIcTXDvBVg
         f+NtizRfMzn05+Vl2ZKRqU1L61RA8mPcG+Mc4xU0ObKbLMQqV7UL5MRB3KA8S0stpA2n
         yprD3dyUKaB33mO/y0trP4gGohOKvQrTvC1Y/Zw7LHniEGdplzdoR9EU0oG0lOIlwq6U
         L9rDdo9u7vb8GQbIz8IJOrSNgLCbojPBuF3VU8ZQ3Q5lokWO0epks/JR6/qdzk1F/WmQ
         K4Kg==
X-Gm-Message-State: AMCzsaV2iffnvgdIiosskNi6KJ/NeVakFl6J5tjYJuQxlaGEN73Gvdfr
        S44h7jVTsaRG/s5LuN8gT+FR6igbTq2Zv7Y0jQ==
X-Google-Smtp-Source: AOwi7QDfTk4uH+kgKIYjoYBlvHs5ydCN4axCIeGo5SvUqZHpfHUJb5cHJm/5ENB7bQ8IwKtuD7rwJAIGyEIcvQsmJVk=
X-Received: by 10.55.185.67 with SMTP id j64mr11373929qkf.37.1507610583702;
 Mon, 09 Oct 2017 21:43:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.19.8 with HTTP; Mon, 9 Oct 2017 21:42:43 -0700 (PDT)
In-Reply-To: <20171010005942.GO19555@aiede.mtv.corp.google.com>
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
 <20171010001619.GL19555@aiede.mtv.corp.google.com> <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
 <20171010005942.GO19555@aiede.mtv.corp.google.com>
From:   Nazri Ramliy <ayiehere@gmail.com>
Date:   Tue, 10 Oct 2017 12:42:43 +0800
Message-ID: <CAEY4ZpMKE6yf2baaJt+x6c_esorFnyWvLZ=_KS1iRs6XbL42hw@mail.gmail.com>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>         commit 6be4595edb8e5b616c6e8b9fbc78b0f831fa2a87
>         Author: Jeff King <peff@peff.net>
>         Date:   Tue Oct 3 09:46:06 2017 -0400
>
>             color: make "always" the same as "auto" in config
>
> Would you like to take a stab at adding it?  builtin/commit.c and
> Documentation/git-{commit,status}.txt would be my best guesses at
> where to start.

Perhaps, seeing that that commit intentionally "broke" the color
output of my tool[1], because it parses the output of `git -c
color.status=always status`, which now no longer work the way it used
to. I know, I know... shame on me for parsing the output of a
porcelain command :)

But this also means that I will have to modify [1] to cope with this,
given that it may be used with an older version of git (parse
git-version and shell out to different git command - either `git -c
color.ui=always status`, or the not-yet-exist `git status
--color=always`), or make it use the plumbing output of `git status`,
but that would just add additional work that  I really don't look
forward to doing at this moment.

nazri

[1] https://github.com/holygeek/git-number
This tool (naively) parses the porcelain output out `git -c
color.status=always status` in order to insert numbers for each
filenames that `git status` prints.
