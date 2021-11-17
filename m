Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E920C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED6661C12
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhKQCAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhKQCAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 21:00:32 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B5BC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 17:57:34 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnACY-005PA3-4p; Wed, 17 Nov 2021 01:57:30 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnACS-009gi4-8a; Wed, 17 Nov 2021 10:57:24 +0900
Date:   Wed, 17 Nov 2021 10:57:24 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 03/23] Makefile: use "=" not ":=" for po/* and perl/*
Message-ID: <20211117015724.ts6ek3wap2ljyhy2@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-03.23-510499d18ba-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-03.23-510499d18ba-20211116T114334Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 01:00:03PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change these variable definitions from being simply-expanded to be
> recursively expanded instead. I.e. they'll be lazily expanded when
> used.
> 
> I added these in 5e9637c6297 (i18n: add infrastructure for translating
> Git with gettext, 2011-11-18) and 20d2a30f8ff (Makefile: replace
> perl/Makefile.PL with simple make rules, 2017-12-10), the reason for
> using ":=" over "=" was that I didn't know the difference in 2011 (I
> think I copied some POC code), and in 2017 I used the 2011 commit for
> reference.

FWIW, with those variables being used as dependencies, I don't think this
makes a difference in practice.

Mike
