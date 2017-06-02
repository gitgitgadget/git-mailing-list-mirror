Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4879420D11
	for <e@80x24.org>; Fri,  2 Jun 2017 06:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbdFBGCY (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 02:02:24 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33171 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdFBGCX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 02:02:23 -0400
Received: by mail-oi0-f51.google.com with SMTP id w10so79901425oif.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 23:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zFhLK7CPALje1PFwoSFmziem/k8WZtjBFuDLxkjVqWQ=;
        b=lOeuTSopIYYtK6amWCio/VV+WWkEU3luuVBmwA4BkhLHY8BEpSzP/aoiw/k10KHjl7
         AoQikUcqkQ6w2D0QfZnmh8R5Pu+aRexdJBNISepYajGy6bCkPubLGd6815h4Df5EHjXI
         T01WqpW6cdXpHISjH8GJp1Hxbz458+MyhTJBBe7VcCPwsZ7DVGCccNtOao5bQvf6C4jj
         c6hRtV4bfWzmgv/DCoym+joc5H0y82lH5+gNj7V71ylRmtF/sdb1kV8LgFA4HsEYb8ie
         uFzacqpAucdK54PxzhLAjS1dL2oArFszLJSJwap5JmBgxsJWy7sdcP/Zw/+iJwhrv1NI
         Cddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zFhLK7CPALje1PFwoSFmziem/k8WZtjBFuDLxkjVqWQ=;
        b=TC/b71vVKgmHKFuMo6M6sWQqG14Ztn9+Qix6m3qMZ5pkZn+0zKZN79iZqZrRRUx6QP
         qs28OgswEuajUe4Q3JPUysT/5KpIdpbsJIX42hGcvNV2RdBJpw0hSPST//89518ZwNqm
         vmeFXHZNLiM2r7m+2UTGof2vB4OYtET/2X+1vCMPbsErqmLEUcJP680zfbjeOpLZA6+J
         aFMPvgNLCGcon90kj5NXNYBR9spkS9EkV+grNsv3JA6HZ2MSWx6Sl3T5w5o/JIq0Pfos
         lSkzy5FYKxpT/jMSwRVsYjtStgSCmJBWN5lsk6uvOeglkdM0LJqRYQwwNnhHjrcYtf79
         gxng==
X-Gm-Message-State: AODbwcDWhwM7fQ1y2TIPWP44b6XTxXyrLF9g1zw0o79+vn8/jBENltlW
        HWTee3MlwabpGwQ+TO5yZFdze1m0GTdy2YI=
X-Received: by 10.157.27.135 with SMTP id z7mr3434722otd.133.1496383342934;
 Thu, 01 Jun 2017 23:02:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.22.199 with HTTP; Thu, 1 Jun 2017 23:02:22 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 2 Jun 2017 02:02:22 -0400
Message-ID: <CAH8yC8mjTXQ_5uRedHi=fytKtQttyq_WemGFNQTP9C3PK4x5cQ@mail.gmail.com>
Subject: How to avoid "Please tell me who you are..."?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm working on a test machine. It mostly needs to be a clone of
upstream. On occasion it needs to test a particular commit.

When I attempt to test a commit it produces:

    $ git cherry-pick eb3b27a6a543

    *** Please tell me who you are.

    Run

      git config --global user.email "you@example.com"
      git config --global user.name "Your Name"

    to set your account's default identity.
    Omit --global to set the identity only in this repository.

This is a nameless test account, so there is no information to provide.

How do I tell Git to ignore these checks?

Thanks in advance.
