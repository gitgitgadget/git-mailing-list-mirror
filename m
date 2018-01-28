Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0311F404
	for <e@80x24.org>; Sun, 28 Jan 2018 18:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeA1S6i (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 13:58:38 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:52990 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeA1S6c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 13:58:32 -0500
Received: by mail-it0-f46.google.com with SMTP id u62so5804548ita.2
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vJ5yFFGS/fuLH/731VKNmjxE1ZS6C3huV+yvk4yqKlI=;
        b=AYWk5J1HjpSk16lB0u3Xdul3I0N8dL3T1u9W5tgE854kkOORTYb0U7XV1scWgnVUgW
         NG9B8C8910KjQ+ZiLh8VnZnCYwBCDrZ3WuP7wtTQpVwCH6qM7B4MaMviH7b63g0yDil9
         9KzbaRHsCEWmGSCIcRXbANOjhJcTY0EwqOQcyMnKYPDMp2RQzdZXw1w9d5RKYZt/y++p
         dKaHyP9uBKw4sBKtlpvtxJwV/ydNc+hYMARexBL8zdnN4o+HDVcl9sg6+sXZQcJHkX8b
         IpTw+W9OAzt2fPeJjw0e8jn/iF4DczoShxn7TfyS8RM2FWucaUCReJJI3wkab1cK85rt
         +aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vJ5yFFGS/fuLH/731VKNmjxE1ZS6C3huV+yvk4yqKlI=;
        b=kjSaGSmOuxhRqCtOjq99wSNqSX4sM8mrzm3T3cz6v5BgF01glrj8SVT9tQhX9sUOKh
         rACm9Gkc7mIiOu++/rnworI0J25L0786xdyFoV0YSM5eKVgZxmPz/tfx/erBsFSaORqq
         X+MJUhsdjdo4FJL3WSzwq8Exfw++I5ayWGxjrhOaqONGTMfP2pVpMOLCajLFxXBcsky6
         HfaepyZhrKGsBaed7eaQKgKjSh9opcRRrRahI+DDmvxOoIcWV1nFr7uTQCOTGo1PBTEw
         d6MDP0w1rU0dlBYZlWDgnp7y9Rvqmb0YDvB3+rScDFclLdCNHKPoNPLiTHhO911gB3Xi
         ssHQ==
X-Gm-Message-State: AKwxytf2hBEW/DCkYz0RiTVTjPh3rvE1hUoTnWrImw0dBQW4H9tjjJ4M
        T2KSrYLJDV03Y6rn08lydfaBIwicNH+B7QnckOqlFw==
X-Google-Smtp-Source: AH8x225T0uwl0KojsjZrYncHz8RiSRfsp7T9kuD/b3E0+lkHRVxjbYV5WD71Bbjb9DjESnrME/8FlJspYUtoKfRut2U=
X-Received: by 10.36.2.16 with SMTP id 16mr24526722itu.81.1517165911487; Sun,
 28 Jan 2018 10:58:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.47.11 with HTTP; Sun, 28 Jan 2018 10:58:10 -0800 (PST)
In-Reply-To: <20180128170639.216397-1-sandals@crustytoothpaste.net>
References: <20180128170639.216397-1-sandals@crustytoothpaste.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 Jan 2018 19:58:10 +0100
Message-ID: <CACBZZX4TRuPV8j9XV=8gAMirQNTpEJBO8bmE9KBnnmoJ7b_m1g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] alternate hash test
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 6:06 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> For this test, I picked BLAKE2b-160 for a couple reasons:
> * Debian ships a libb2-1 package which can be used easily (in other
>   words, I was lazy and didn't want to add a crypto implementation just
>   for test purposes);
> [...]
> This isn't an endorsement for or against any particular algorithm
> choice, just an artifact of the tools that were easily available to me.
> Provoking discussion of which hash to pick for NewHash is explicitly
> *not* a goal for this series.  I'm only interested in the ability to
> identify and fix tests.

If the goal is to smoke out hardcoded SHA1s in tests, isn't it easier
to instrument SHA-1 (e.g. our blk_sha1 copy, or our wrappers) to
pretend that whenever we ask for the hash for STRING to pretend we
asked for SOME_PREFIX + STRING?

Such an approach would have the advantage of being more portable
(easier to run these mock test), and also that if we ever move to
NewHash we could still test for this, we'd just always set the prefix
to compilation time(), and could thus guarantee that the hashes would
change every time git was built.
