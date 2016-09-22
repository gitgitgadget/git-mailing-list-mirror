Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEA11F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 21:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941198AbcIVVIR (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 17:08:17 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36587 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935992AbcIVVII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 17:08:08 -0400
Received: by mail-io0-f180.google.com with SMTP id m79so99380418ioo.3
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kve2qUxwfSjV9ZNmS7wYndh+rtTO9AVGei8MUzFbD2w=;
        b=LzIc/mhvlka+7neJpGxAxXP5ZrGsLHF+NosgWW/VcIRinlgJWZhN2q9XA+/8oVlHAE
         VTzbxxgvqjOzdn4nje8YO/WPW1kokOd+E6ZEFbIT6gz7awVpBZa3CPko4BeTjaRF0bmm
         kiuuaGNqmjw/W8/1o+NtysF6kAjD3L9s6vShx1UHIVQlhYLmffYE9GaBnqAQ4h9eGtq0
         CgNOVHlQXV6u0tKeivnp25J7KTx4K7wdgxv0+e+khsuYKHcAcXaY+i3uETlAl5lLE7Y+
         Iksdrk/YZeD4/folYBzEZHuLT1C59/dAkC1HyliX5dgjzAGEqP83iUFAPRGYCluXqG+v
         fwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kve2qUxwfSjV9ZNmS7wYndh+rtTO9AVGei8MUzFbD2w=;
        b=FV/zzr5f+cGA5j9jxG49uD7tK0uwQk7/ffSnPryxR3jiX09qrfJ9bnKaq8+J9NLFT7
         9+Yn94JfVbDCDZwPqH9p90Tm5eeQ/M1yC83BdBGuWXKC/B4uB9KeWO3yEvWvMqwH4y1l
         RzJC3lGpCTa0XYWokkCbf7BEGn8rLQvQ0x+IGZPVagG3gnss58wt8Opwce2gIhFzbg28
         lMQE0u14LcZtIyH6pXleMEBr+U9lo1JkgDLGQRm3U9gGAELkJAQyvgjYYoyC8guz9qrn
         2GfCi4LCRCobxMYBBLZ8NATl3A/uQDty7lcdkRHWDtMdP+hww9qHit41RdPSy77PTavF
         tL8g==
X-Gm-Message-State: AA6/9RkeuYiBCF6w32SLu0uTyiIGnGDvPw7hX4J32XiXkpn7PT6RXV6P/WXsfGn1FuB0JwZhngOYqEMKDgiXXcfb
X-Received: by 10.107.180.11 with SMTP id d11mr5849370iof.203.1474578487522;
 Thu, 22 Sep 2016 14:08:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 22 Sep 2016 14:08:07 -0700 (PDT)
In-Reply-To: <ns1gr4$pjs$1@blaine.gmane.org>
References: <1mtveu4.19lvgi1c0hmhaM%lists@haller-berlin.de> <ns1gr4$pjs$1@blaine.gmane.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Sep 2016 14:08:07 -0700
Message-ID: <CAGZ79kadpe5wG0gSpk-oasxCGuUp+3bSv-A4vhyFC+y0oL-+ww@mail.gmail.com>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
To:     Anatoly Borodin <anatoly.borodin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 2:01 PM, Anatoly Borodin
<anatoly.borodin@gmail.com> wrote:
> Hi Stefan,
>
> I've also done some archaeology and found that the original version of
> the merge preserving code was written by Johannes Schindelin
> <Johannes.Schindelin@gmx.de>, see e.g.

I think it would be helpful if you'd cc those folks involved, not just
the mailing list.
