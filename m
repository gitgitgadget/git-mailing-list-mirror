Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F6ECCA480
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 14:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiFXOnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiFXOmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 10:42:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1F6F48A
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 07:42:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 521992A0;
        Fri, 24 Jun 2022 14:42:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 521992A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656081745; bh=cBE8MjumXMkq1cDtH4vDz2vNWrkBsYNi4Q8m5v6yaBM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WqmvRGts8Gx1ottcLhJ6WuvC6u+qCl5YUGUBTs3oOJ2qw3hpVdpgr3aTi1sYb3HFw
         547IgI6xbT4rC1EmBaWgvVfvmwIjK/VbGVvplApDGiqk/zwlvq4PlQrf42BUV3+NgT
         2FqOxoIcEz2RaRbLeR9YEXgIXRJ0v6N5f+3pMp8Ofg5cultDi1j64fYyMS7QXIqeOA
         5gHxlLdxsnrUkUiV8TmDvBwL5SUgXcFN2knsyS0Tu4iLRrwLG2FjkOnT+iXWcnZZ52
         RLHxiiPr14mstmHR7uSS52PL9aI3N9F9hI4qjDQ1wb7byNx2IC0Jw+o4z4rjkZQtGS
         0jbuyqVY1ZyiQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.org>,
        Kyle Meyer <kyle@kyleam.com>
Subject: Re: SHA-256 transition
In-Reply-To: <220624.867d56kg04.gmgdl@evledraar.gmail.com>
References: <12011256.O9o76ZdvQC@thunderbird>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
 <220624.86fsjvj690.gmgdl@evledraar.gmail.com>
 <12140906.O9o76ZdvQC@thunderbird>
 <220624.867d56kg04.gmgdl@evledraar.gmail.com>
Date:   Fri, 24 Jun 2022 08:42:24 -0600
Message-ID: <87y1xm5din.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It wouldn't have helped, as I'm referring to LWN having written an
> article about this thread that you started :)
>
> It's part of an ongoing series they've had about Git's SHA-256
> transition.
>
> Given how LWN makes money I don't know if it's OK to link to it, but
> it's easy enough to find and/or subscribe to LWN.

Heh...it's not like it hasn't been widely distributed thus far...:)

  https://lwn.net/SubscriberLink/898522/68ddb300e7eba05d/

Thanks,

jon
