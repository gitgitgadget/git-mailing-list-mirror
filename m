Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3000E1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 12:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbdLMMyc (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 07:54:32 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:37921 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbdLMMy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 07:54:26 -0500
Received: by mail-it0-f65.google.com with SMTP id r6so3476312itr.3
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 04:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5YiZE/gM7GuwPN/+pDCOmUgk+OTvmYQqiFRDHGNAP9s=;
        b=K1JnhCtCRSOVID04cM65Z4snY9Y82ZDeSLplpHthB10HCpyE6uoFAFnqO0F+CUMxE0
         B0r0syiVy2buzVv/DibXSQxDHsNlgYIEC+KjeU5O756E07yt1neDWoU1aFnK3vi8Lqsu
         FE/Kb7peUnhSphchC96WpwvaPrvtt3Islmjj3iU1kSpTuO9GHGHIM/5pew7BTri9Tw4X
         tJo3Y4oq4yaMpXYy9ArQyoSigO36OR3jFpOAB0Vw6ZT1U/xU4/h3bgh76Ir9xT0EeiLq
         rJZIwJp/0Zs/bt/C8UFyAizWnvl1ykI3n5pyPJSdUFJOY+C2lFesE/NjyOqMHNw/9rJ2
         3A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5YiZE/gM7GuwPN/+pDCOmUgk+OTvmYQqiFRDHGNAP9s=;
        b=tvX0BM2Rd57b7nXWziMHGwI7XUSZWW0Wyr1dPAmK69f7Bx8nW/nx8PWvi2iZZxFDHQ
         k9aI05y0KVX68jix7ESSxGAHP9HIDZyZGdgKIqsAfCtRnMpNNP65qkE4QhxFbX5ZGInW
         v5T6t6jkMckQctLK5n9yCWKK3NckshxRXDtiURO2CV1ll6ML5TlLP5aFwjZIEoDfUXP5
         zBgSQxyWoDqNILPLtz0WZFEu91oD7j/1vmET8CUIJQFSb+vawMOcjfHCr4UmzKnGS5fM
         ycCVZtoII1lxwnD+spCmwp+80tqYzYSJU725i2P6xeLXreW+wb/+AZcwOM2cEI8ghY6V
         fDBw==
X-Gm-Message-State: AKGB3mJ7mZBXMRWFRkJK3QmhegAtufCTnF+xUbk53Aji+xKr8t2ZeYuQ
        0TL6gm3Im+YYHsaaeqtiBn8nGbpqMaZ6HKs7ZtJSlA==
X-Google-Smtp-Source: ACJfBosKfVFud+9s1+xUUi5Zbzr22bPfFAgUfZWjkBkXGxWb2ICCdgV8U1X78TnMXx2qlJr/HGauzUUj8h8B8qdn2Fc=
X-Received: by 10.36.175.17 with SMTP id t17mr2895066ite.66.1513169665545;
 Wed, 13 Dec 2017 04:54:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Wed, 13 Dec 2017 04:54:04 -0800 (PST)
In-Reply-To: <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com>
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox> <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
 <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 13 Dec 2017 13:54:04 +0100
Message-ID: <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
To:     "David A. Wheeler" <dwheeler@dwheeler.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 13, 2017 at 6:46 AM, David A. Wheeler <dwheeler@dwheeler.com> wrote:
> On December 13, 2017 12:40:12 AM EST, Jacob Keller <jacob.keller@gmail.com> wrote:
>>I know we've used various terms for this concept across a lot of the
>>documentation. However, I was under the impression that we most
>>explicitly used "index" rather than "staging area".
>
> I think "staging area" is the better term. It focuses on its purpose, and it is also less confusing ("index" and "cache" have other meanings in many of the repos managed by git).

After your patch the majority of the docs will still talk about
"index", is this part of some larger series, perhaps it would be good
to see it all at once...
