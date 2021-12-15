Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C13C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 23:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhLOXpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 18:45:38 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:54174 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhLOXph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 18:45:37 -0500
X-Greylist: delayed 71575 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 18:45:37 EST
Date:   Wed, 15 Dec 2021 23:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639611936;
        bh=bUNshF2o7+ScBp2J6XReVoEhzReOxQbYoc4Y+tNWDg8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=rSeapBnSfSEEOuyHXEqwtEgeURgzGsOKPR4XTYLPZoFBVOd2TmEz80PZEjKi8YN8c
         dD6kcUETyFLgEuShMEO6sAurFcIME9qcw/DjXmiDPv0QczElnTx7ddKoh3IDuX+SXR
         vFgds/xahcZ/Po/STwD43lNfQq/gK3VsEx3VCGD5Ziob7LD9aXnsq2mxuyvrV7qkIO
         r77HWOEL1couDukKaCeXFxH7KVgLPNo+9QCWq1qudcyYqofDZTS/0eoI9vgRZ3m4Ev
         OuKofka5nG+A5NoXP+wG7DkTdSVj/akOitM6vdunOOo0Ej4rlV+CPbFAW1Pi+RKkl1
         q9HpxJdoEctUg==
To:     Junio C Hamano <gitster@pobox.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim@protonmail.com>
Subject: Re: Fw: Curiosity
Message-ID: <hYaujy-hcnAn3EcYnkfxn2Iorjz5gjD3_0c1DZf_AztxWhLgmKSdLxuv3rrFKZOpRRGpdc8xAAA-ym4OrYg5iJ8STRvdChftNVYRzdYz4QY=@protonmail.com>
In-Reply-To: <xmqq8rwl91yf.fsf@gitster.g>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com> <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com> <xmqq8rwl91yf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jo=C3=A3o Victor Bonfim JoaoVictorBonfim@protonmail.com writes:
>
> Our delta compression does not care whether the contents are text or
>
> binary, so if it is not compressed well, so it can be a sign that
>
> the contents are not compressible to begin with, at least with the
>
> xdelta binary-diff-patch engine we use. Improvement designs,
>
> algorithms and patches are always welcome ;-)

Gosh, I wish I could do anything about it.

I am but a mere code monkey, haven't done much writing practice either.

Maybe one day, but that is yet to be seen.
