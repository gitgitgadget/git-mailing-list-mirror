Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2B42027C
	for <e@80x24.org>; Fri,  2 Jun 2017 14:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdFBOWH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 10:22:07 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35334 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBOWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 10:22:06 -0400
Received: by mail-io0-f182.google.com with SMTP id u18so5062653ioi.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aAeF2junRdNpl+/RQgYWuzoWQo0uwRM7ZryUL+cYqFQ=;
        b=HGDCrt5IdpeeRF08KeUaEGIXZdqOA1wlvDdTbxHr8lZpxM1i1ylfhKL2x0cQkwAho3
         VQS0Rx13YJCuC94ndiEV8/ycCD2YReP/ZdBeytI76Ru/jfjzR7ynqLn/hTzLzF7gcKY8
         mlEdd+zBdwYQtL2gGK+gMKi5mbD3ooCnputKMX0YJRZYXGEyMaDONDujKhREfzZQpXny
         MaRG3mmUbMqU2opBgRC72DcbAtMe+UCXav9zgEg+M5IZsS2X0EKOkMiAvWr9LU1Z8FfM
         e1KWMYD4MZe/njvxCaQCv7k2qHFUQ+r2ZDMLVzAv6sIi0EJl5zIPYSM3ZlpanuVshTYU
         J43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aAeF2junRdNpl+/RQgYWuzoWQo0uwRM7ZryUL+cYqFQ=;
        b=eTSQu5/7FkUKp+VdhVIO7+gbPU5utewPA6z8z2r8f/kXtXge2P2g23PpgfUvDQHGIx
         ZTCLb3Rw/vSbPjo5628iATmTlOBTubIJ3W/N5Lsgb5eTq8sqxdaLvQg1tbg3uD4aL5fq
         Kp+/FH8uqerpw7LQ/rh0QDclmePAoom75nDtiI+xP4Cc+f0VxAzEfFbumKWmhQKbGciP
         l3OfMA1C+3ZzFkYbilS0UijUYWhqICrOXidxOhFdOTK6Y9jKRnHZbInoOOhrrheNbuW2
         bm6dKQslWJUctR6P5nuNRjAlt/mcsyWya2Li/UpasfKffV0czSgMEGlcECqwUYyr4sd3
         GZoQ==
X-Gm-Message-State: AODbwcDi/8O4IMJl0vUEurYUSJmWCdbepIUkJXOEaXmjqy+eOlagTBJI
        OMr30kaa3lTk/p0h+7KX3p6liWBFAG3n
X-Received: by 10.107.201.206 with SMTP id z197mr9095838iof.85.1496413325968;
 Fri, 02 Jun 2017 07:22:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Fri, 2 Jun 2017 07:21:25 -0700 (PDT)
In-Reply-To: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Fri, 2 Jun 2017 10:21:25 -0400
Message-ID: <CAJZjrdUjAkmZY2mKuVjE58u_0C=o7BN0=Zh2egegSiN+j8jytA@mail.gmail.com>
Subject: Re: git-gui ignores core.hooksPath
To:     Philipp Gortan <philipp@gortan.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 9:41 AM, Philipp Gortan <philipp@gortan.org> wrote:
> Hi git devs,
>
> First off, thanks for your awesome work!
>
> I've been unhappy for quite a while that I had to configure the hooks
> manually for each of my repos - until I found out recently that there is
> the core.hooksPath config variable that (when set globally) allows me to
> specify a hooks directory to be used for all my repositories.

OT but you may also want to look into using Git templates.

> Now I was happy - for a few minutes, until I tested this feature in
> git-gui, and realized that it doesn't work there.
>
> This seems to be caused by "proc githook_read", which says "set pchook
> [gitdir hooks $hook_name]" instead of querying "git config
> core.hooksPath" first - cf
> https://github.com/git/git/blob/2cc2e70264e0fcba04f9ef791d144bbc8b501206/git-gui/git-gui.sh#L627
>
> Would be great if this could get fixed...
>
> Thanks, Philipp
>
