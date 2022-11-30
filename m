Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A0C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 16:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiK3Q34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiK3Q3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 11:29:52 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2847286A0D
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 08:29:50 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1p0Pxx-0007fW-QU; Wed, 30 Nov 2022 11:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:To:From:
        Subject; bh=7l/iIiDI58RcZnX6jlN/P8meeKdRHogm2ESHrVG/VXU=; b=jIX9H2vGrMRzG2KuY
        QdJPz/5Fxk0qpHXvNzYBrSsDvH28iErl05xn5E94z5sGxmd96hu7XprAZYa9rEY44PMK3A6ZWlRjR
        wddqn4kKZB+axualUsKMnUNeQnVNyHJ1zEa0P9VJWT3EXqMOUuB1s6kqEIAu4CQxwhHYNEpiGGKbU
        qGjjdGzirzYDABs8jou7607EtTRGdTa5yvI8KLqbbsQtcuAXknLplRCV2QRDORp6DNcUZZCpjqBcB
        WkD1WuqZIQG8LR7NtnjN0QuX27kRnXwoTEbSF0HMzwJI3JZjUJ1qRamUQD+eK7mA/Zm3uW5hXYHNN
        RPVlt6tWMS7nu9lPQ==;
Received: from [160.231.0.90] (helo=llin-psh13-dsa.dsone.3ds.com)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1p0Pxx-0006Ui-1L; Wed, 30 Nov 2022 11:29:45 -0500
Message-ID: <006f10e84c9108a7be7315fec753316ca743386c.camel@gnu.org>
Subject: Re: [PATCH v3 1/1] Makefiles: change search through $(MAKEFLAGS)
 for GNU make 4.4
From:   Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Wed, 30 Nov 2022 11:29:44 -0500
In-Reply-To: <patch-v3-1.1-432518b2dd7-20221130T081835Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
         <cover-v3-0.1-00000000000-20221130T081835Z-avarab@gmail.com>
         <patch-v3-1.1-432518b2dd7-20221130T081835Z-avarab@gmail.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (by Flathub.org) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2022-11-30 at 09:23 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:
> Since GNU make 4.4 the semantics of the $(MAKEFLAGS) variable has
> changed in a backward-incompatible way, as its "NEWS" file notes:

Hrm.  I did try to look through the other makefiles to find similar
constructs and get them all, but apparently my grep fu was
insufficient.  Bother.

Thanks.
