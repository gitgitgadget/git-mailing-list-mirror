Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E72C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 11:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FFF60F37
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 11:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhGZLPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:15:32 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:54321 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhGZLPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 07:15:31 -0400
Date:   Mon, 26 Jul 2021 11:55:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1627300556;
        bh=Fl6wOkxpfEzBvpY/cnGq3pHbHmIpbdEwg5T636yrWtU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=SgzGtlSMv66Etsb8TaQt7tH/XSTbhBvWxaU1BhbeAc8mzQ6ZGuUxSaEXGYFImYWWq
         S9hhqDBjxKcTwZDXJNh7/mUpT5DEJ0iQkJ81aLi9KKjH8nIyXOh1arhZNFDe39PE92
         XRrRHor3nrsz258awC1UmoZ6k6SBLGL6A6dQDU2jfkAE2hnYq+C5/74c/B9aEvhmj2
         9mAOiWA9/KEfuX8jKpGlDHUHk/0WbVopW8z8Mpu60qzEuAbUubu5EJ2rCvLraCq/hY
         IwUBz36WET217NYBUtC6cyFbFFisMqpohAGlxzpAKsalyVoc2373TE00yBnShCHIJm
         c3C7HP2vUXjcg==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     jonathantanmy@google.com,
        "bwilliamseng@gmail.com" <bwilliamseng@gmail.com>
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: ref-in-want does not consider namespace
Message-ID: <pMV5dJabxOBTD8kJBaPuWK0aS6OJhRQ7YFGwfhPCeSJEbPDrIFBza36nXBCgUCeUJWGmpjPI1rlOGvZJEh71Ruz4SqljndUwOCoBUDRHRDU=@eagain.st>
In-Reply-To: <CD2XNXHACAXS.13J6JTWZPO1JA@schmidt>
References: <CD2XNXHACAXS.13J6JTWZPO1JA@schmidt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> Running `ls-refs` with a namespace-relative
>
> `ref-prefix refs/heads/*`
>
> will work as expected

That turned out to not be entirely true: it does work as expected with a 2.=
31.1 install, but fails to select any refs with 2.20.1.
