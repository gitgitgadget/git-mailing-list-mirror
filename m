Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1EBF20323
	for <e@80x24.org>; Wed, 22 Mar 2017 23:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754791AbdCVXzM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 19:55:12 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33661 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbdCVXzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 19:55:10 -0400
Received: by mail-io0-f179.google.com with SMTP id f84so73286616ioj.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DkEzZ0BuhA5InLX61inAdp8IkKo+3aRuWi0Sv07vJp0=;
        b=pFyTOTxykhpiV4TBTijL2+6FKLOd5PHfoPs0XYnz9hCh8mnhSZ9RPHQzv6sSrrHI8u
         tO5yKDFolgDpfe9przhB3Pu9+puDQ+DvNSzzRrx0wrghd1wY3y6K0glRQZ94PWZuCFg3
         ER6nE9Cj1RBgwwYpv7Ica3qLU21GbCeJel32t+J66dODhnANfPbWFFZ8+9MJPVmUBG4w
         gUFGUI19zSTtU65XQ1dWyxvfNnxnIb7/RfT4FCV8TwloTF4bcnuqEyatI1Mz+5yg5QkW
         Nxtewk4pR5LLiTzRTv1FoKqa1WmfQz8ppYq4p7/Gf2p7qv/lgNTk9fAQ+6ut72k/VHA1
         4Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DkEzZ0BuhA5InLX61inAdp8IkKo+3aRuWi0Sv07vJp0=;
        b=tH6OwqKAH6UtKyICf3V3hKWoYA0rVEjoQUR2NCNnSWmQ9XO4JuD8KlBc2PxAy5yKzf
         lfQEmj26fWdggIZDignZ5a0ln5URYxSN+0Q7T6HyNIUIgP5ikqFt84yHRMcf+nvNltuh
         0p1pHpiidrifHBdBPqzbyIkfZjDh/jKEPv2NQf0Y3g7//XFlffFNig1SF54sI+No5NX8
         70zM2ovUk3m1gr0gojH4xAWg5FI9F5vmsTtYXjHgZzNNps5LKI3kKRODkra8LdpO5xy4
         rj2vWmlLfuHtB8POOyf/tN2CPNQVkpK/mBBxBbJzYpFZEpDW9sTpFtQ5kxJrceqSTXsv
         ARVw==
X-Gm-Message-State: AFeK/H11ma9PIYunLDSrfwOR7C9hZcr4OVDyH5FlLECenlH3BxT0r31WkXAzcVx2Vl3Obl6L5lKvdImPsDEElQ==
X-Received: by 10.107.150.201 with SMTP id y192mr107007iod.33.1490226909447;
 Wed, 22 Mar 2017 16:55:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 22 Mar 2017 16:54:48 -0700 (PDT)
In-Reply-To: <20170322225800.3h2mnnmmj2hbo36c@sigill.intra.peff.net>
References: <CACBZZX7NDa5o1xSu4HgZ4=kG3mx3U6ja7f3E4yAkFOHDsLdMjA@mail.gmail.com>
 <20170322225800.3h2mnnmmj2hbo36c@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 23 Mar 2017 00:54:48 +0100
Message-ID: <CACBZZX47euh-K8-DUjDKr6i=g8MzmivOzA5fFTyPQjZhkzM2uA@mail.gmail.com>
Subject: Re: How do I copy a branch & its config to a new name?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 11:58 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 22, 2017 at 11:46:14PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> But both of these are really just a limited special case for what I'd
>> really like, which is given branch "foo", copy it and all its
>> configuration to a new name "bar". I.e. both of the hacks above only
>> set up the correct tracking info, but none of the other branch.*
>> variables I may have set.
>
> I thought that's what "git branch -m" was for, though I don't know how
> thorough it is about finding config that refers _to_ your branch (I know
> it handles config _for_ your branch).
>
> There might be room for improvement there.

-m can only rename "foo" -> "bar", but I'd like to end up with a new
"bar" with the same config as "foo"
