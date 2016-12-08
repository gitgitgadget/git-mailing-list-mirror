Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE2B1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 11:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbcLHLBs (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 06:01:48 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:34269 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbcLHLBr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 06:01:47 -0500
Received: by mail-io0-f169.google.com with SMTP id c21so21025810ioj.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 03:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x8+YjoIen1KQWU0MUBQ5JBrfqvwFfccC3KdYJeKwHi0=;
        b=PcmhBAbLdoXqdcpEvWrDQzxyti+8UL1j8lM2EWHQ2/WszjbUQavlbxdjoms2q/XqUA
         NLoLfiluEyVhXNjiX5PxZ84rnDnkvYcrjkEWHr7was7X77RAvBIIHThM9HpUrIer3da2
         S7WS895Js8Al6S5SINKlvpbgLT0R2vU9/ejn2sgbabw57GErRRt0ovfHWqxSwWnVmgHC
         wh3HB/6v7iVUgZjhLjbV+QWMJfPyTcnzEuZu5nVX/IlkeUD20ZOARMuPJOM0I1zRiDV+
         /Q8WT2g5L8bCqgyuV1Yl7nzIC8I07vMAhzLT76D76gDk6JqrpbzqrBG3r2fTShW9FFYU
         oBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x8+YjoIen1KQWU0MUBQ5JBrfqvwFfccC3KdYJeKwHi0=;
        b=a8cwxDf4ZEWFBkR5yn+qQ0b0BwIsM4Krbb6bQJ1XipjnEAxMq0e8wlepDwI8x6bxHW
         6Lv5Ob3HPGH+TB3MBGOnMaR0oag7a18myR9n56b6lNPKJ1zqr36rmJ5581Lnxh1o+R42
         JupcXIhfYjeiDPRdrqGVMPVwA5qgc6FEId3NV7/9hJYqW3Y4n+qmzLSKuHy9Wre+z6ZS
         Wy/JTdjmti4FLnJe4Oiaafk+5MkfhlNNJRs/6hhVzD+sFRCNtvdQ1+8qFxKbCbSxW+Ep
         E8r05612STBMu3tbWPDGOXR4n2UP8BTHLVWrUMd6aBCdt1ynV3QUBWUlm86+YohWjH9D
         5Xrg==
X-Gm-Message-State: AKaTC00IV/Dwu5zOrX1/sHH/SASNi7IACD2y7VY7Vl9j9jmw0my7JoFKkTlThLKs7hNUunmiQTtwjxkI21oK/A==
X-Received: by 10.107.132.74 with SMTP id g71mr63994740iod.19.1481194906410;
 Thu, 08 Dec 2016 03:01:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 03:01:15 -0800 (PST)
In-Reply-To: <20161207210157.18932-6-sbeller@google.com>
References: <20161207210157.18932-1-sbeller@google.com> <20161207210157.18932-6-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 18:01:15 +0700
Message-ID: <CACsJy8CY7dj8p+oTL2ZrncO49r8BcoMK3CwdoFYZH3eJ47bc_w@mail.gmail.com>
Subject: Re: [PATCHv5 5/5] submodule: add embed-git-dir function
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 4:01 AM, Stefan Beller <sbeller@google.com> wrote:
> +/*
> + * Migrate the git directory of the given `path` from `old_git_dir` to
> + * `new_git_dir`. If an error occurs, append it to `err` and return the
> + * error code.
> + */
> +int relocate_gitdir(const char *path, const char *old_git_dir,
> +                   const char *new_git_dir, const char *displaypath,
> +                   struct strbuf *err)
> +{
> +       int ret = 0;
> +
> +       printf("Migrating git directory of '%s' from\n'%s' to\n'%s'\n",
> +               displaypath, old_git_dir, new_git_dir);

I'm going to nag you about _() until your fingers automatically type
"_(" after "(" :-D
-- 
Duy
