Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196041FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 00:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbdFTACM (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 20:02:12 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34801 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbdFTACK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 20:02:10 -0400
Received: by mail-qt0-f180.google.com with SMTP id v20so6531274qtg.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z7Dd7bTT3+bnWmuKCFFQdVXBBuUPo1/SF5dpbzPTXEA=;
        b=VFBEo16KZOKYFPR7F9y46+hNzfEFPGiRTje5PxxBFdS7gg88Ut6sFCoyxh6R8k1/fj
         StuFsX6JsI1HJ9EFaVS+0XxdRd2Fsj0LeS//le5WGNMZJYIFxg5c3Q3BUhcakx+022/Q
         qlN+rs6bCsN9vQrtpIIHxnRRI2hh5ZbUP2XnlDAriCvAp5hJPYyXtOnuZ4uqrHYKjaDO
         X+4e9Y5Enn4um49PcPsfPf1k0y9zlGxnO4pOjuecOZGvMry5ouETJPnHq2AaHT/VwntY
         B4ocJVx65JenJ2YbaPu4LQR0hDpPo9EvYsWmI+aztEBrOyhQVqi5AonXRLHiO8p55B3C
         AP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z7Dd7bTT3+bnWmuKCFFQdVXBBuUPo1/SF5dpbzPTXEA=;
        b=pUeFTaXLZeq5xe6HqGRAMGfKlEojuQhqwd1jFavQDVDxtiN7MRK15Oi4CZAtFBFnfJ
         rU791nsshHZ83kIAc2aHTpcWV4DGRfkFcWAGjJICjNnd2MLJW5qxilvGfh/8/kHu19FT
         V08pGwC4/kkGOBC634luZAkzKhrZY2sr080P9xPVRKKkQhaUCVbbW6MHTw3XQ8N/iNVm
         7l51J76XCE18cQGLdsXUX/Mc35Ha+YGyrevdFsBiBN/6dHx+dQjzdBVekHFUqbtyNOr7
         0vIbzR8ZBmjIb/bEcXee/QfJSYIhyh3GNWCu+f8F1+9Gl5eftqmr09+++mGC/lYrIuPn
         Y6NA==
X-Gm-Message-State: AKS2vOxDZBSsuoHKgJmc5XvozCYwEXRgd35IFDa8TqJ4UHZTse1HvhQV
        N995IvRiSD0KYMxwzle0jbOOdLOfLA==
X-Received: by 10.200.47.60 with SMTP id j57mr1743050qta.175.1497916929589;
 Mon, 19 Jun 2017 17:02:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.36.147 with HTTP; Mon, 19 Jun 2017 17:01:29 -0700 (PDT)
In-Reply-To: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Tue, 20 Jun 2017 10:01:29 +1000
Message-ID: <CAH5451n4XDdeAz4T7aAsaSC00hnZ53Gb7j0CSiTg4QLUZKvxXw@mail.gmail.com>
Subject: Re: [GSoC] Update: Week 5
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 June 2017 at 07:41, Prathamesh Chavan <pc44800@gmail.com> wrote:

>    But as communicating between child_process is still an issue
>    and so there was no simple was to current carry out the
>    porting. And hence, a hack was used instead. But after
>    discussing it, instead using the repository-object patch
>    series will help to resolve these issues in this situation.

Just wondering, does that mean that your patch series is dependent on
the repository-object one? I saw some discussion around it recently
but couldn't see it in the latest whats cooking so maybe I missed what
has happened to it.

Really enjoying your updates, by the way, they are very clear and show
what looks like great progress!

Regards,

Andrew Ardill
