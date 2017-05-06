Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD7C207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdEFSXm (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:23:42 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34170 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdEFSXl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:23:41 -0400
Received: by mail-io0-f173.google.com with SMTP id k91so31664269ioi.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ECnZKLz7bc7dDWKF9esd9zeDVGSS11K2fWze2V3xUiM=;
        b=cgPIn7jFVvAkeDoZo5bSEZh8wsOqxNyipAWPcfRokwOLPQApJv9TkNT0b2Dy9z3aHh
         T7pm44VY9jjpqp3XkRGOv10vTVH86gCERIN8qqNkJ5ZvWKD/fxfvwo5m3w8Fl040jEiL
         2K2+qH6LFLAmpKvNYUa7G0m+pPXiXTkQVs1aClQCF3l/aeEm/HcmNC7ZLyLSszt1itaF
         HbDO5yXtLTAL8X1QPKpv+ZM1i2rYD98DLeph8j2XjkB+3kkxPolW1omyBoozjuTU7jhm
         GzbM1YxEJBqy9XQuEbOmJRUZ4XwYZW7yi/nNleAOQRq3RM9n9EEXI52co54nqhTSKSU9
         q9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ECnZKLz7bc7dDWKF9esd9zeDVGSS11K2fWze2V3xUiM=;
        b=d+0vvvEE93YCG2aZ6eoZLI5HJuvybP+bJm93a6dn1gvDGJhXg3U5xkIj8pr4teiPF/
         TWp5fohXaKmIVaTY+rh56i7f13bK0+ROrI3Qnop4FBVwFtV+HFttVH5n2yt0gsxf3YX9
         tMSBG9MpW107Zd9T3ZtMSRh1/CHQpYOvVZ3ZTeiWaSJ7eccmS5WhyXO8jvgjQTPMkDbi
         aCQFK+21RwYizaL4SG69iauOkHWj9Bh2vQVDRRClgWTx43vKb0p3Fa6XmQxhIVlW6wy5
         DlrbuOH676F7CIjLjw//Vd11bAqIBceqHD5UvRsV8gx/VfulhPOM/p9mVyAEh0XFCeHN
         Ek2w==
X-Gm-Message-State: AODbwcBEUAWK9MD/UFRGFNX6i03j6+Kc+qN5+YnGW4sioWfRC3zOEDoL
        sRrQvKwge59mbt4c/gDTbFakkgXC+w==
X-Received: by 10.107.35.75 with SMTP id j72mr7646064ioj.180.1494095020606;
 Sat, 06 May 2017 11:23:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Sat, 6 May 2017 11:23:00 -0700 (PDT)
In-Reply-To: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sat, 6 May 2017 13:23:00 -0500
Message-ID: <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
Subject: Re: vger not relaying some of Junio's messages today?
To:     Jonathan Tirado <tiradojonathan32@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yep, I see these on public-inbox.org/git/ but not in my gmail inbox:

- Brandon [RFC 01/14] through [RFC 14/14] convert dir.c to take an
index parameter
- Johanne's Coverity patch series
