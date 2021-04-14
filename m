Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED68C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A996117A
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 12:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350660AbhDNMEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:04:11 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38460 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhDNMEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 08:04:10 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FL1N15gS2z1qtdY;
        Wed, 14 Apr 2021 14:03:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FL1N15BSVz1r18T;
        Wed, 14 Apr 2021 14:03:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id EgccucEk1pxO; Wed, 14 Apr 2021 14:03:45 +0200 (CEST)
X-Auth-Info: coZysIyRtbwTnNzMbRb21IgzZlJgzLBfAOPum9qaexzpX0/CG9UTYeawqkOHrwzT
Received: from igel.home (ppp-46-244-188-150.dynamic.mnet-online.de [46.244.188.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 14 Apr 2021 14:03:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 5ABE82C3625; Wed, 14 Apr 2021 14:03:44 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Sam Bostock <sam.bostock@shopify.com>,
        Git List <git@vger.kernel.org>
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
        <CAPx1GvdeNEyPEZ7GdRKeAevnvjyLmoXHjQP0W6iToDsJPAqDHA@mail.gmail.com>
        <87sg3t16ec.fsf@evledraar.gmail.com>
X-Yow:  I'm also pre-POURED pre-MEDITATED and pre-RAPHAELITE!!
Date:   Wed, 14 Apr 2021 14:03:44 +0200
In-Reply-To: <87sg3t16ec.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 14 Apr 2021 12:56:27 +0200")
Message-ID: <87pmyxjcnz.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 14 2021, Ævar Arnfjörð Bjarmason wrote:

> Nothing in git itself actually needs this remote HEAD past clone time,
> and with 4f37d457065 (clone: respect remote unborn HEAD, 2021-02-05)
> there'll be even less reason to pay attention to it.

Isn't that what git rev-parse origin resolves to?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
