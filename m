Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228EEC6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 09:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiIMJIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiIMJIS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 05:08:18 -0400
Received: from mailproxy09.manitu.net (mailproxy09.manitu.net [217.11.48.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C651550B0
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 02:08:17 -0700 (PDT)
Received: from localhost (p200300ef4f07e90026418cfffe37d02a.dip0.t-ipconnect.de [IPv6:2003:ef:4f07:e900:2641:8cff:fe37:d02a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: u16723@rkita.de)
        by mailproxy09.manitu.net (Postfix) with ESMTPSA id 349EC1200084;
        Tue, 13 Sep 2022 11:08:15 +0200 (CEST)
Date:   Tue, 13 Sep 2022 11:08:14 +0200
From:   Rene Kita <mail@rkta.de>
To:     =?iso-8859-1?Q?=D8ystein?= Walle <oystwa@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] blame: Make --show-name negatable
Message-ID: <YyBIfg06kBtuZCmL@t480>
References: <xmqqsfkwftd0.fsf@gitster.g>
 <20220913085631.4031-1-walle@fryseskap.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220913085631.4031-1-walle@fryseskap.localdomain>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2022 at 10:56:31AM +0200, Øystein Walle wrote:
> Hi, Junio
> 
> > Not clear to this bystander what exactly is going on.  Is the patch
> > Rene relayed is your rough attempt that was incomplete?
> 
> Correct! I am the nice IRC that was mentioned in the cover letter. My
> improved patch is the one in the e-mail you responded to, apart from
> GMail's text wrapping that was unaware of until now.

That's my fault. I saw the corrected patch, but somehow used the old
one. Sorry!


> > Thanks.  Let's see if we can have an cleaned-up version with tests,
> > then.
> 
> I can send a corrected (and correctly formatted patch) for review,
> optionally with the docs squashed in with Rene's permission.

Of course.

> Maybe Rene would like to take a stab at writing tests? I am in the
> process of moving house and my usual workstation is not exactly
> online, so it'll be a while.

Yes, I can write a test. Will need to investigate, never worked with the
code base.
