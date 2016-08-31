Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A26E1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 21:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbcHaVKY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 17:10:24 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37948 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbcHaVKX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 17:10:23 -0400
Received: by mail-it0-f43.google.com with SMTP id c198so9087562ith.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AVP/nI/uKW7WVwqawnStZt/Lq4oljzm+Ijt0QVCYu/A=;
        b=I5ZMrzib8LGuLrCaKjt0M7lV6/WiemLKnaGL1CbVnsNCAEHLufwgMnYasMJVCumIQ3
         RxTNjZg2tnukhkCxCFT05R5EJw3dpXL80VxAfIOI/nP3FlZFcPKsMdB+8tYMFVyjF55i
         Kovb8zufFncsLqFTZZmnBEQw/IOEn16MzU2dvPhyzj4xiT6Pw66kTA3WcvRiS5J3HyvT
         0EE5EYlOrutZDPhF4BMdcS7VesUzednTDEuAizpp6n9yoBWZDahxZAVU7ki8xc//Gk8u
         WSnV9wdAYIy7bbchkkeqMXSso79uJAS/z9RaWScwjT71Ha7HKJfTw4Jxy1Ou1G8mX6ru
         z+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AVP/nI/uKW7WVwqawnStZt/Lq4oljzm+Ijt0QVCYu/A=;
        b=jrMtex1q86mEzC/Lm8OPymHGI87xwu3AI8eJe8XE7AHO4uzrIXihO5+k5CVVG85pJC
         xPVP2KBLHzRFKhyr8REorEuNEeHrpGwxHaKiK9OGOw+S2ar3clrAQJQQgrqSpyttmSmJ
         xQ9y3TSMsVi1APS6OMNHTGKJxTGj14doZqjqTponDmLyOsIkM7qUTu9TEgQM3tmIMQXM
         4fh5nFnIs2eBCdCreOEHntQjWK+8WiIjiDDAc52aGVLOuR24O1X2TbSJ9KdZ1xXWIRPH
         n4BcsmZAcRfOWQ3GKUny0D7Ti06Y/TMAMmRZKU5k49EB1q3VmHzQ/uIxBP/LXqajoUFA
         UI1w==
X-Gm-Message-State: AE9vXwPrU+G3Kt/R2xgMzUtXZKwIt8F7pvEjS/7dI/aVI+iAuHZbAqV4qWoC3xmsnSpaakEFNYOKN4Ux9NHvwopG
X-Received: by 10.36.137.9 with SMTP id s9mr15587296itd.58.1472677822248; Wed,
 31 Aug 2016 14:10:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 14:10:21 -0700 (PDT)
In-Reply-To: <CAHG0eJVk6HF5Mz3wz08sjgL05zB4cAjmZ=FR=jf5G4kh-ChV8A@mail.gmail.com>
References: <CAHG0eJVk6HF5Mz3wz08sjgL05zB4cAjmZ=FR=jf5G4kh-ChV8A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 14:10:21 -0700
Message-ID: <CAGZ79kbOMa5e5pUi+pA1JUSehFYMyCot+ZRWbORgwq2xCqvnZg@mail.gmail.com>
Subject: Re: Literate programming with git
To:     Ben North <ben@redfrontdoor.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 1:41 PM, Ben North <ben@redfrontdoor.org> wrote:
>
>     https://github.com/bennorth/git-dendrify

So looking at the Readme there:

    * Add printing facility
    |\
    | * Add watermarks
    | |\
    | | * Allow choice of colour
    | | * Add known-good test cases
    | | * Emit watermark 'underneath' main output
    | | * Drop-down for common watermarks
    | |/
    | * Add actual printing via PDF
    | |\
    | | * Submit PDF to system print service
    ...

This reminds me of the workflow of git itself.
(As a literate consumer) You get an easy top-level overview what
the community is interested in via e.g.:

    git log --first-parent --oneline

That would be equivalent to showing only
    * Add printing facility

If you run that command on "* Add printing facility"^2
you would see the headlines of the section.

However in gits reality we do not have these nice sections
building on top of each other, as many people are interested in
different things and build where they see fit.

> The hierarchical organisation is helpful when reading the
> history, and also allows that history to be rendered into a structured
> document explaining the code's development.

How does the linearify/dendrify work with already non-linear history?

Thanks,
Stefan
