Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F2D1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 13:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeIHSYf (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 14:24:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46617 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIHSYf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 14:24:35 -0400
Received: by mail-io1-f66.google.com with SMTP id y12-v6so3626339ioj.13
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjvO4w6q0EcaJr4Bl2/67/p9MMKByCst/CVFwEkIRMk=;
        b=VNqyh8WT2b6XJOcrkb46GNxc7hcxVtCDrAbKi+egbj8Qw9mkZ5rzI9dKEwf3rmpKp7
         JaO85H6Xw8ogGCtFSn0JDeF/JATCMDZab5KNhPeBZVnW1WAXAFawkjLPLRXwYySh5l/K
         5hKJ2ImNdZFPhuVNOdlSimx2v/m/i1FFxW7U6N3YaOoVlrOtNrhMfmTGjMBwm/dQPsgD
         +sERk//DMv81rIZaQ1BVL8Dv2ILhgJUwB+pybSxAz7w3CMLhstqmk2uwPmf2BmkyO82M
         YDEqHooIl3xDltCZGHujLDxBWjD7xSIgxwePFxPNv5O9zk/yjzoJIQq8N2QV87S+EYpn
         8Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjvO4w6q0EcaJr4Bl2/67/p9MMKByCst/CVFwEkIRMk=;
        b=tS6XrO0jqPao6dU9eKtZpsMo44p6bAzjZDoVKHD+nkL+JjjQViGzqZ+cUCebCPv3gw
         I0Dlbn9uP1lDAm+ize5Tt5pNfzJ23u7f1TaGmH5fOQQEziFpwUYSRPKeH+2Awwda33n8
         aeXQBSgIxE4d3IEkI/4CCjSLVs2f/mNtRSUcBNcbw+F/tOt7vTqnDUWqNsrgqGd/WD7r
         cpQkJ/6GoJ4n0d6x8MO7LFA1maZ5DG7UdDUtW3kbCLc0fYMUEvBJ2xDeBkjZYvnb0Jiy
         RExjFlmlpeFSr2MXFxAZXLg5jaZr2H/buwcnHozbpTYT5CDxAgvw2ubPTyHZfAQtczFq
         zP6g==
X-Gm-Message-State: APzg51DedOcXZOgll0AZ6aOjnPLjXH3r746l17Z40E5vvwBmtNStWj7Q
        KdwG7U0HoJHBXpsHyDErlc0+isszRrIcSphitJo=
X-Google-Smtp-Source: ANB0VdZ1aW/6EDiE9W4Y5DjxeG6XKLsr23lrePggfVaftEYbGSXxi7GS81GxTsW/MQbP4/jv3MJuOyl6k9vOLwkexic=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr9318680ioe.282.1536413925479;
 Sat, 08 Sep 2018 06:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180907181905.GA15897@sigill.intra.peff.net>
In-Reply-To: <20180907181905.GA15897@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 15:38:19 +0200
Message-ID: <CACsJy8CshOFNgHq-QQZp3GM3Ua+iuKMDvA+YaKKh1QGF5FrHqg@mail.gmail.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat-security
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 8:21 PM Jeff King <peff@peff.net> wrote:
>
> We currently build cleanly with -Wformat-security, and it's
> a good idea to make sure we continue to do so (since calls
> that trigger the warning may be security vulnerabilities).

Nice. I had this flag in my config.mak too before switching to
DEVELOPER=1. Didn't realize I lost the flag until now.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  config.mak.dev | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 9a998149d9..f832752454 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -14,6 +14,7 @@ CFLAGS += -Wpointer-arith
>  CFLAGS += -Wstrict-prototypes
>  CFLAGS += -Wunused
>  CFLAGS += -Wvla
> +CFLAGS += -Wformat-security

Maybe keep it sorted
-- 
Duy
