Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D939E2047F
	for <e@80x24.org>; Thu, 27 Jul 2017 00:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdG0AYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 20:24:52 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32778 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdG0AYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 20:24:51 -0400
Received: by mail-pg0-f50.google.com with SMTP id b8so13995101pgn.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=JlZAmP5zDpLtV1kUytPQ0VFyBZytz4fKhUIhSGMYrDs=;
        b=dw93P4JESKgMe1lXg6GCyQmW+n/MsympebD7ay7OfWufXlAut1CGSlYMzzt2//hsiR
         AiHxTrANSdG1Hm9/NtOaUyDXSlNwFhm/cYKuf1alyCMIOmGJX6HaUvVnjSkxK7nh40F5
         eHMts/wE9ltKOt88iNZYHfruh2w2FZb6lpCadMvcsMWwW2J4/jGh34wy/DJB0ZBOseCv
         75dgh3oGp2JCD8PRDJNAGnIaHCyumTs2cnk0qpUz67lFIXNgwTHKNShn9QnQ5lwEzt3z
         gmcuDece1v4WXj3eF0peseWVgY+jJmJnFKw3MasMPXFXu3N09GJrHDl9gwFLD2cdW+rl
         hMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=JlZAmP5zDpLtV1kUytPQ0VFyBZytz4fKhUIhSGMYrDs=;
        b=Xsv2xDr40JrizFz7bo0R/gBUftY/CBOPU+aMftauE752js6whZsD7YXLAwVqYfiHzz
         xyZHKWvjji3hZK8i3kgEZ7wK7yknpDJCjECK9s1zczTEBWZ8ckfdHReSjeNNskVbmpFX
         jLTM+K0fA7ZhPiT1SW5fFS2FiKt+teMpOXKv7HivIy/6NZ3/tut8HLSmcnLOyL8GC/EW
         ypL5CL8uQE0yKtGFR8VJ6EzE9mhYn5ed3V08lcqz44HiKKExArTdiE9qNSKerUXWP2jd
         sL99QVB3McnxHNCsSpv8GWuZ5/3FqiAWZqL/oZNSYB0CpbmILH2h8Nu/SQBS+OUue7G1
         Lp5A==
X-Gm-Message-State: AIVw111SnSiZdntZI7Me6FDyglNZpJCjL0Ui23wviTiMnVWXPFA1wGao
        Cwpa7oy+S0NjvXKvY8EnCvg81IdUxSqw
X-Received: by 10.84.137.129 with SMTP id 1mr2545230pln.251.1501115090695;
 Wed, 26 Jul 2017 17:24:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Wed, 26 Jul 2017 17:24:50 -0700 (PDT)
In-Reply-To: <20170726234238.2osugw2lheubmetw@genre.crustytoothpaste.net>
References: <cover.1501111615.git.jonathantanmy@google.com> <20170726234238.2osugw2lheubmetw@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Jul 2017 17:24:50 -0700
Message-ID: <CAGZ79kbLVor39Hs+OnhiFwXOpJtTGMiENvunCVv_Q-PB-Mfczw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Some patches for fsck for missing objects
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2017 at 4:42 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Wed, Jul 26, 2017 at 04:29:58PM -0700, Jonathan Tan wrote:
>> This is an updated version of my previous patch [1], but without the
>> list of promises. It is somewhat different now because fsck cannot just
>> mark all promised objects as HAS_OBJ.
>>
>> This could be adapted and incorporated into patch sets that have objects
>> missing from the local repo.
>>
>> I split this up into 4 patches so that you can see how the changes in
>> fsck are being tested, but eventually these should probably be combined
>> into 1 patch.
>
> I looked at this and I like the direction it's going.  It's pretty
> simple and straightforward, which I also like.

I agree.
