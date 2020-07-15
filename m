Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4DCC433EC
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 07:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30F9206F4
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 07:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgGOHAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:00:16 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57899 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgGOHAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 03:00:16 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4B67Yp2NRmz1qs3P;
        Wed, 15 Jul 2020 09:00:14 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4B67Yp1nPDz1qrDL;
        Wed, 15 Jul 2020 09:00:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id HTDbVtYEwIeO; Wed, 15 Jul 2020 09:00:13 +0200 (CEST)
X-Auth-Info: oCohSAwnn3bntSL9iIVqjGut8b9/MsQL2yXAZifBbCBxjp7KG73gmPhL0BHgdxMu
Received: from igel.home (ppp-46-244-186-2.dynamic.mnet-online.de [46.244.186.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 15 Jul 2020 09:00:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id DBB6D2C226F; Wed, 15 Jul 2020 09:00:12 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Larry Martell <larry.martell@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Can't checkout branch
References: <CACwCsY7YSn_mbtFv3QjL5dY80G6e_r-gGC3SGo5rO5b8LGXxVA@mail.gmail.com>
        <CACwCsY7P5NiQL5ajHMOWo2EPiQZKUj_m_AVbtGy=z=twChimjw@mail.gmail.com>
        <CAPx1GvcOpmpuPseAQDYk9pg+hfdF9KJSSSiB0fEHQrnUuPS4CA@mail.gmail.com>
X-Yow:  Hello?  Enema Bondage?  I'm calling because I want to be happy, I
 guess..
Date:   Wed, 15 Jul 2020 09:00:12 +0200
In-Reply-To: <CAPx1GvcOpmpuPseAQDYk9pg+hfdF9KJSSSiB0fEHQrnUuPS4CA@mail.gmail.com>
        (Chris Torek's message of "Tue, 14 Jul 2020 11:17:56 -0700")
Message-ID: <875zap8dqb.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 14 2020, Chris Torek wrote:

> To work around this in all versions of Git, you can just be
> more explicit.  For instance:
>
>     git checkout deploy --
>
> forces Git to treat it as a branch name.

For recent versions of git, you can also use `git switch deploy'.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
