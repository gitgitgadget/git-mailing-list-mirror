Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4921020966
	for <e@80x24.org>; Sun,  2 Apr 2017 22:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdDBWvB (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 18:51:01 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36736 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdDBWvA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 18:51:00 -0400
Received: by mail-lf0-f54.google.com with SMTP id x137so63705266lff.3
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=72VfV1rGdF8zG7qPYy1UMwvte11nx4AXU26Zz1w30ZA=;
        b=aGc2kfAnDAAim59h5srRq8rAOVb9Kn5dU+nFPG5Z6ntdfF9hN/wnu/PkeTNyh/qTRv
         nR8tF3Qp2DzdKOmLqpRbl9CBTFl4iysMccwm8U3ACdFqbn4GrR8m1Rp/AtEuzvKVflLB
         2yx+f1Vuz/uq9CSq2b77LZ+GBQIBK+j/AOx4EoSDboxjwwQm5OguHTIooUPn7Y9RJ6IV
         LqYf3UD2SRl3R4LYzV8OmLYU9woy4oyaglsdaQVMBvb2cjZD6l6b8ewbEHArqjvRXH4d
         s/WZhQRBK7vRZNtfrqumaYBvCEWyH78oczQUh7Vxs3QrFLxMUpI53bp4XTgi86vz6Xuo
         v/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=72VfV1rGdF8zG7qPYy1UMwvte11nx4AXU26Zz1w30ZA=;
        b=oC9h0JWpzhckemcuMXEx9PQSHyX8bVegu+2/4F2L4DLnLoGCyd2Iyqc7WRksw7T8XM
         AjUTDpvOwUI/zj0sP0GVbfrWE2kwvNtjiIYlXyMLPxIWXcMUcl3H5C8P1Hra112Wokc9
         xlhpqVA58NefiTAphLFSMdRM+/H88wJF82lNMxt4hTY1ghCz51OMIxK2GBm2Wq/m8B7y
         cTwKwQcLRwKI0jJY49YG6VR69euepOfujs+ab8kXYqLfQFJWrB3tb7imroE9BzE32DD1
         1kUN7QsxyJrFk1I16m34Qynj5d7f+w3V8XP7KzM2Fpfo/gZFmfEBXVl1CcHcC3BcIttE
         xSYQ==
X-Gm-Message-State: AFeK/H1xaiOnHXbmkjI9RmJK37t/1WacrWD8uW+JKHJ2F+8eq7nLrlN/FIz8Kv0nWB5JNmMTriWpf6Tj61UesA==
X-Received: by 10.25.18.169 with SMTP id 41mr3929342lfs.129.1491173459027;
 Sun, 02 Apr 2017 15:50:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Sun, 2 Apr 2017 15:50:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704022140420.3742@virtualbox>
References: <CAEA2_RJEf4vjgcaux8a1KWh1-vxLLmv1--Vjf9wiEQoF+gVDtA@mail.gmail.com>
 <CAGZ79kbyW79wToWqoL_F5n+jOFwFH=z2jY3Du2YTyv9tS9L=JA@mail.gmail.com>
 <alpine.DEB.2.20.1703300142230.4068@virtualbox> <CAEA2_RLX+0Yz-wcdAaEj3Pp0qOKWdHu32T9Vvkk2KSFkzUx7Cw@mail.gmail.com>
 <alpine.DEB.2.20.1704022140420.3742@virtualbox>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Sun, 2 Apr 2017 19:50:28 -0300
Message-ID: <CAEA2_RJ31r-9ROWKKQY8JwWF0iQk9d4hdLJZdkZgRHaFGphzfg@mail.gmail.com>
Subject: Re: [GSoC] Proposal: turn git-add--interactive.perl into a builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2017 at 4:43 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> We ask to accomplish a microproject before evaluating the proposals for
> one reason: to have a good understanding how well the students would
> interact with the project if they were accepted. As such, the
> microprojects really are about the flow of the contribution, not to tackle
> the project already.
> Meaning: I would recommend staying with your microproject, in particular
> if it is already in full swing.

Oh, when I mentioned these bugfixes I meant I'd be willing to do those
*plus* my microproject before the coding period begins as a "warm-up"
to the project. I'm certainly staying with the microproject until the
end!

-- Daniel.
