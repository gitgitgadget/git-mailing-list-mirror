Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68DD1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 23:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeCZXWy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 19:22:54 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:42976 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCZXWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 19:22:53 -0400
Received: by mail-yb0-f172.google.com with SMTP id i13-v6so6982417ybl.9
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFq2gjNZvGcs1o50lklti7QCTE48DocqJTewqdwH8ME=;
        b=ViU8/zWuYyMfSMAB1j7JwwM9v86dsUNHsKSOiVj5Bz+GynaN+1sEEghakbtJ4K0Esv
         KDMj8WggECyfttCkAXt9wEaS8POd7PzIpH7GD4gRko9HkKTv9rgFNtPRGH1prv2qS7EY
         xAzL7sYzuuqMJr1ZKASRCf/eKpTWcylZHj5SENazhex1SJARrZx/pO6/YWhIAAM0voSW
         otIS/IIOoD/gCshDLoie2A4+mnTglVGXsJhJJxMJpqafnRv1AI7yA1K0iQLtHtRKtwPH
         UDnIkxd7II5Uj1/fPqdkJiNZXq7OXR8/jhOwqk4KY0K82+UmhUGdpxtNd+gtdU0+er9T
         3eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFq2gjNZvGcs1o50lklti7QCTE48DocqJTewqdwH8ME=;
        b=qCXe5RQllYvNHftrfAm+rB5KzSqOOfjkci2KEaYF24bpeNXCNUi4b2F7vosUP+Zeb7
         eAotNNwVsiZCf27gYgM9c+Kd/KZzL+e58G/fD3M8ugCGScmg1R0uamRqcCJL90QxOJNr
         JplEgspy5HxoNUrBo8bg1PilFIVhI8T2s6S2RMedwo/lmSBiBsTaU1tOswTLwkADvyvV
         aMdjUYn+uhcwrQ03rz+NOs9rDLpQqmKImBHtQOdWzOKPGS0c+Odm7W/oQH9X3gHfnjhU
         rT7rRH6ihvKiKENqnVtmjIU00Y2nma4Fc2cIwE89x8QnYBZJoooH11j+qB3EsYuK9IC7
         xAqw==
X-Gm-Message-State: AElRT7Eor6TWfjajM2k345HmV3g5KdvO1CMlfVZvAMoBoX92jDcWJGek
        D5dubKtNvnu4hWa7o87Sx7fWy6gx6Bg9x2CYY7uRww==
X-Google-Smtp-Source: AG47ELuqDjbr/RYeuPkLGfbPMqXcH9GNhErH3cS5Q5W/cfKIvKUOilZBT8DY2JhQP6PV96PrG//nmk/4EWaDwfXtrjc=
X-Received: by 2002:a25:9841:: with SMTP id k1-v6mr24855771ybo.352.1522106572814;
 Mon, 26 Mar 2018 16:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1803131457310.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
In-Reply-To: <nycvar.QRO.7.76.6.1803131457310.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 23:22:42 +0000
Message-ID: <CAGZ79kZRSKnS_ChC2eYRyrk4FCjE6vxstezvBWuhYfZxX_9Fhg@mail.gmail.com>
Subject: Re: Will Coverity for FOSS be in scheduled maintenance mode forever?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     sig-scan-admin@synopsys.com, git-for-windows@googlegroups.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 7:00 AM Johannes Schindelin <
Johannes.Schindelin@gmx.de> wrote:

> Hi Coverity (now Synopsys) team,

> I probably managed to miss important mails such as announcing that the
> Coverity service for FOSS projects would be unavailable for some time.

> Since February 20th, this seems to be the case (all attempts at even
> looking at past results redirects to https://brb.synopsys.com/ without any
> helpful further information), at least for the Git for Windows project.

> Is the deal off? Or will Coverity for FOSS come back? If the latter, when?

I noticed that there was an off period, but right now I can access it again.

Thanks for writing this email, it reminded me to check for the setup of Git
as well, which was not executed nightly since Nov 20th last year.
(the day when I migrated to a new machine... duct tape everywhere)

Thanks,
Stefan
