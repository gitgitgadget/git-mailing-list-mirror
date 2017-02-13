Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077792013A
	for <e@80x24.org>; Mon, 13 Feb 2017 06:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbdBMGMm (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 01:12:42 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33206 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbdBMGMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 01:12:41 -0500
Received: by mail-lf0-f42.google.com with SMTP id x1so44945876lff.0
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 22:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=KSrefMuO5FpaQ7H6zkqW0TrcYEkO+3nBXC5YYXI00UU=;
        b=Ue/yqRte8xvOLv7Lhhs52QjKjegdYPFTCIcrSoEPzHFtdHSHhf/rZqZeMEzdA5Ea42
         t8tLZHj6O0l0G+XVHVdLogcanTkRqku0Vquwk9eXSNSBzc5zS2Z05F7P4WU7qr1m9kKm
         p7BWeqbC0VnX/hCoLMCK6rlk4ij3fA2f5HcVlrf6ThhbULMtU1W1/0JMNlyFgXh1Mz/Q
         XKCLLsCHF08hN9IOOrr5GxdrMpfcKx1C1kRXbmC8W0N5mY3NEbPAfaiEcEXRnjPuJr53
         oT6WKMABTlEWp0OPuMEP522OdFJgBBg4wnFsifgBV87Myu+3WZty7GLROtIKq5QGrC9O
         pSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=KSrefMuO5FpaQ7H6zkqW0TrcYEkO+3nBXC5YYXI00UU=;
        b=kpdhaXpNPWhYCcDfv7Enod+V9Lolo7BZTnKoJLS4OYXPy5ogg9c3dT/100uHNiz5Mb
         FReSPHZp2iTtHCqZ1pilMhDeUbvpyUzo9JXfbH5VIMchmws2GxIcEeMN4J3L7w1noXJP
         MAKJvdQGFqDiBAm3YUX5uhnFe1gz1RbESGk3BkoGc1oKxWiBpwvAfql4ctoJlBwwbXO6
         UwZ0hsqwlf26LypoxebSuw9jejgS9yraxhGwTYUTHUgbGwe76GYc3tttBA07yPfppJDX
         5D6hYqLBIRzG3NTgsiZFXxV0srwasN9vmAZxOZ0aWA7Ej7KJey4fjtNNx+MBOT8Rg/qw
         E2kg==
X-Gm-Message-State: AMke39lMSr8+zRAC4H5O0Boyp8S/c8xX5indfNifEHybEYQ6Jhh+qsq7O6rEGAd2XMLIfjc+FyORTABaly6Xgw==
X-Received: by 10.46.81.18 with SMTP id f18mr494963ljb.136.1486966354431; Sun,
 12 Feb 2017 22:12:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Sun, 12 Feb 2017 22:12:34 -0800 (PST)
In-Reply-To: <20170212164650.u7frv234kmu5hm7r@genre.crustytoothpaste.net>
References: <CAPd6JnGC3yeDo_sB+H+UKvh-PbiC2qySC=EbaRNLbkkwYkJM4A@mail.gmail.com>
 <20170212164650.u7frv234kmu5hm7r@genre.crustytoothpaste.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 13 Feb 2017 07:12:34 +0100
Message-ID: <CAP8UFD2Ve4WvyBg-DDye4Bpwb=MjB8P6V6mQdWDPbiwnVKovzg@mail.gmail.com>
Subject: Re: Git status performance on PS (command prompt)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mark Gaiser <markg85@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 12, 2017 at 5:46 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Feb 12, 2017 at 04:53:47PM +0100, Mark Gaiser wrote:

[...]

>> I did a bit of profiling in git to figure out where this slowdown comes from.
>> Callgrind tells me that "read_directory_recursive" takes up ~62% of the time.
>> Within that call the function "last_exclude_matching_from_list" takes
>> up 49% of the time it takes to run "git status --porcelain -b".

The core.untrackedCache config option may help.
