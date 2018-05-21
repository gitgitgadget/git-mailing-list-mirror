Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B2B200B9
	for <e@80x24.org>; Mon, 21 May 2018 15:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeEUPSl (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 11:18:41 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:43087 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeEUPSi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 11:18:38 -0400
Received: by mail-oi0-f46.google.com with SMTP id p62-v6so13308605oie.10
        for <git@vger.kernel.org>; Mon, 21 May 2018 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/QYW/P9k/8afVj9DmzhwnalO4xxeO/gwEUsCKW1kVuE=;
        b=WzY87W+lzxWTw1oA5pay1lv5Zs3Al7nGgW3Ox2JEeiJHr25TgpfABH0+urlurCtdR0
         ZbBwZw6l5idEIfSvuh2vEwR6qBiHbq3DViZHSUwX+uH8Q9qevfrourNBRsuvVMqjSpjD
         TEAU3Og3+HuRMa4w+pzm+bv6ENN+Q609ANQskXMG5TJiryzrFNlYZAe/D9keLrC74IDa
         PSumkOd9Mn0a7Uc0C92u7aZug2Gfgz0LL14Sg5UBlLfPs7AX3Ryy8OHeGbcaaG5Fkr1L
         8jIYAbn8OkavRPJbZqsokwncTj1h+6IXRWwWoBo1FMuhD0blz8nZdkPIVzbG3vmonIlm
         VjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/QYW/P9k/8afVj9DmzhwnalO4xxeO/gwEUsCKW1kVuE=;
        b=f309t75ZNcdTxO7XIJZMUoPH0BqtWCbXY+Z99P6I2iQFhBLIerKD2lkIjVSCTwugPg
         tyGvqXtctfQEJINbWz5kWW7gzYel5RsuV0Yrz4CzoadrhCt3/a9kMW24yA8ygiIHPU1f
         THHCW7RqxWyMU8TXvyNiEqZ3lXysGP9UG/w2WibZE4+DFuI+ss6cQRf3zr9EbaafE5NT
         8Y0OmFtsIeTGgrHmlIac87s4CoH9LZf24kJ/ka0FHWdkEKh/N2Wo8XXR5cm4kbQCjkyL
         hCCAe7vOB2WCeIawnFC148bqia2nfz7NnLyQbcNN99AcD2RYJx4EaVIEOpKsFJJnG8j4
         ghVg==
X-Gm-Message-State: ALKqPwfksUDbzHw9izebhRrwI8tBg1oKe9Zu67z5r9uiUar/pfVNlfhM
        4zAhvHRHFWqXz/IPDqqhbiSnIKOCFskKYdWhlDg=
X-Google-Smtp-Source: AB8JxZoHu9zdFfqBykbJqQ9ekPV3IKOmc/GciFrGLJ+FaZHGPl91xhyA5q4dZWQ2kWnnazD0aemYN9UTasxNzHlH1T4=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr12378721oii.216.1526915917833;
 Mon, 21 May 2018 08:18:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Mon, 21 May 2018 08:18:07 -0700 (PDT)
In-Reply-To: <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain> <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 21 May 2018 17:18:07 +0200
Message-ID: <CACsJy8Ay2Oos7s1Lbczdf+jUsvn0F+NsHPLF6aKxxBhMb39Q3g@mail.gmail.com>
Subject: Re: which files are "known to git"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 5:09 PM, Elijah Newren <newren@gmail.com> wrote:
> Robert, since you're working on documentation of sorts anyway, would
> you like to propose some patches to fix things here?  I'm not entirely
> sure what to suggest, and we might need a random suggestion to get the
> discussion started before we figure out what we want here, but it'd be
> nice to fix this inconsistency.

Make sure to fix Documentation/glossary-content.txt too, Robert, if
you plan to improve documentation.
-- 
Duy
