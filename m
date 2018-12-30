Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2373B1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 05:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeL3FIQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 00:08:16 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:34825 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeL3FIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 00:08:15 -0500
Received: by mail-it1-f181.google.com with SMTP id p197so31221227itp.0
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 21:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHIagpyGahI4gR/RGI0MGcXuSwWX57LvJQkvKEfb0T0=;
        b=KNbUXmS+WvCS06BAN9GOBw3gaJKZzd669MAwii0s0gNayYs07KbMdtriBsGh3qjfUF
         8VfL5YhTEbaeeJvcsbXYJZLhSuzSyp5FWdJyaCNgEWPFuD6tmrynvHjNDVwpw6GOpJGg
         EtQOQ9/bacUx9Adr5+lDiE1buTMxddhj+Q9ohiSkkNcdyUHIVEV7dKs8/aUBQvh6kORk
         mCzsip0huihnbda+838o8XGAcC+TLh98KobUgVSdrVAImdPD58r7FizxReVoDk7TvyqJ
         fqNa4iOrlthE4lhUar4nOFMHuXEPesv2vNrKaCuHNgWR2o1BtYfUEwTKIWirEHbOFaHU
         CeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHIagpyGahI4gR/RGI0MGcXuSwWX57LvJQkvKEfb0T0=;
        b=aeTXYs/h+oB1kC8zRp6XXmEPL2BLSg+/QIroWzzftMooEUgZfT/H9YFTv33CvmK9Dr
         l4h+mtwpUmE7O0h/MkmbjXswCjOKSAojNlET47iplmGYIf+DG6v7thwoIb7nKVJAgxot
         00rbiLOC+h5+byinaLUSvggcpULOiew3psYwT6UruTGzkZlXOf6saUY5kWX2tYzRFwZF
         98BMVzAYjvxms1+xQeHCH1thWbIPzFhauIuWsAmmVClLMQA4iVzZZkIqKK+uqUyLc4wI
         iROJZR5y76Aox+UwWW6p0M0vQ74pWKXEycIYHwf0Slo2JzCMK6D/15ijt8ZNOEZXt3CB
         hCxg==
X-Gm-Message-State: AA+aEWZl0DaRky/g7+xXblQRk5PjQbnG9GoPNWomgPrMARcFVqHzdxB1
        /IFFGlmpQ9DeSxs0L/2cBV7/0c0l1tvwaMGk3big2cwJOTEI5g==
X-Google-Smtp-Source: ALg8bN7B6v6/4uUo/dEBiFy+n0O11X7DkBtOwV1vgne0hS5Cu002lo+og+mBpbqg7mL4nvdMxPE0Kij9NHdbS98o+Qs=
X-Received: by 2002:a24:4606:: with SMTP id j6mr18039241itb.10.1546146494912;
 Sat, 29 Dec 2018 21:08:14 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8=zaL3ETrOSk_3xQobfG-z2VLMsGn8O-q0zCaqw6C_Bqg@mail.gmail.com>
In-Reply-To: <CAH8yC8=zaL3ETrOSk_3xQobfG-z2VLMsGn8O-q0zCaqw6C_Bqg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 30 Dec 2018 12:07:48 +0700
Message-ID: <CACsJy8COCZan=UVjK6P=WXdtK+pD=_PY-HhEZzEOhf=6kUicXw@mail.gmail.com>
Subject: Re: Lack of debug info from git commit -vvv -S -am "..."
To:     noloader@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 30, 2018 at 7:38 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> I'm trying to determine why a new installation of GnuPG is having
> trouble. The new install is in /usr/local. The other install is from
> the distro and is OK.
>
> Here's the new installation error message:
>
>     $ git commit -vvv -S -am "Update GnuPG recipe"
>     error: gpg failed to sign the data
>     fatal: failed to write commit object
>
> How can I obtain more information from git commit?

try

$ GIT_TRACE=1 git commit ...

That should give you more info and the exact gnupg command to execute
should be there too
-- 
Duy
