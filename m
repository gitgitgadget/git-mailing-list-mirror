Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85A01F404
	for <e@80x24.org>; Tue, 23 Jan 2018 16:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeAWQcC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 11:32:02 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:42295 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeAWQcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 11:32:01 -0500
Received: by mail-it0-f52.google.com with SMTP id p139so1662918itb.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 08:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/sneq1yu7IPYZYyTITEHJr7q0g+yftKq0gCs7H7XZp8=;
        b=JaCZORuyhFUtRewcll/eex44jjB7YU2V2AxvlQBg3hiJFR+EPaSwoOv8rAEgaLk5QH
         rCoQUHEd7vi7c0nKDtzUZQJEqzmpf0ggHne8r0F5DjpBdQIfIQWmFrzdTt7THfkVVXbM
         ukuqa+jMY+7uhwvt4FtuCguobFEH0ROzbra9e409ssOIBVlMbU4SDVK2CdpmysU2PkL/
         t9ZRm/WauyjzruXKmDwTiXdWA7dR1RH3tHmyGJsWrZHSDO5GXGl9Cy7xEyb92yathHjl
         QXiRzcZVihO3B95cmtkEp2Ogj+vb/eIo23htFCaGi1AVTA9gYFkxgVYigL4jyS89R7+7
         NKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/sneq1yu7IPYZYyTITEHJr7q0g+yftKq0gCs7H7XZp8=;
        b=Ly8hXc/hpog3b+CnimBmB3tZqJe0T1M8m15I2s3iIeqtV/DrEpkflD3MFf/8Lddpfu
         T42+ghehJiDAPDqleuMxEEJgrMqAWoU7rgKS1Yio8T6aSLfrjctwZWmU3ZQ9dSJMe7XD
         6ZMQmjVHpZbfHScK5dS/LqNn05IeGpyFia/IFdphk8nUhtjOVBzOzQCQ+FsPQ/OWJb7w
         mD3jfXf23dVL+jXkUqZ3fgd48hiCtpsb/1vup6EcU9e7yGANAOOTGY1i0X4Hm9No0ma+
         y4Izws8Nw8cO/Eh+iiBDPIAjRKE79X6p2lSEvE/wUS1FxbQQe8awZwKAr9bVHnIO0ElV
         ngMA==
X-Gm-Message-State: AKwxytfAvLtWdSfRNCvi5xGK7kMXxokQkfqUGXqNeDA60zVV27BslZ5H
        r2nhy70enPDKbBbcOIGsvxkWR9w0oNPP6UQ9nIVxWoF8
X-Google-Smtp-Source: AH8x224SAWoTdf5u85690gPSC3ORiFk+fKeAlppahCVPYHOmjGIh1JyRdJq7QPlmFhDCR5V9S7zs0A3kqlRn61KWC1g=
X-Received: by 10.36.253.204 with SMTP id m195mr4736406ith.66.1516725120931;
 Tue, 23 Jan 2018 08:32:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.224 with HTTP; Tue, 23 Jan 2018 08:32:00 -0800 (PST)
In-Reply-To: <CAMAMitC-iyH_YOAsJcPpLcUbmX-Zun4MCL89Pxn2rr7Lu_m2cQ@mail.gmail.com>
References: <CAMAMitCV3xvaSr00H574Pww=r_c3=0NqT1Ge13kc=gWJqDJ3Ug@mail.gmail.com>
 <CAMAMitC-iyH_YOAsJcPpLcUbmX-Zun4MCL89Pxn2rr7Lu_m2cQ@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 23 Jan 2018 08:32:00 -0800
Message-ID: <CAGf8dg+XPPrx+Fv5d2hTgBMyWDBavFvOmXzJiX+8PuHBSoUCrw@mail.gmail.com>
Subject: Re: The original file that was split in 2 other files, is there a way
 in git to see what went where?
To:     Aleksey Bykov <aleksey.bykov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 7:22 PM, Aleksey Bykov <aleksey.bykov@gmail.com> wrote:
> Is there an easy way to see:
>
> 1. what came to b from a?
> 2 .what came to c from a?
> 3. all extra changes apart from just moving stuff?

One way to do this is to use "--color-moved" - it will tell you what
in b.txt and c.txt was moved and what wasn't (although it won't tell
you from where). This was introduced recently, I think in 2.15.
