Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F141F404
	for <e@80x24.org>; Wed,  3 Jan 2018 09:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeACJ0b (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 04:26:31 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:42731 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeACJ0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 04:26:30 -0500
Received: by mail-io0-f177.google.com with SMTP id x67so1476142ioi.9
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 01:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=sH5DWqLEgIUuZRyN8oeROy4w+qlswaB9oK+WEao1v8o=;
        b=sSXPjAQSeEfF7kabfYEpwsgq3hGNNSg4V+FXHdKB/kE1j1E8RZiZQahRRBB89xGB1f
         sQ+PdlgK1GTyCE5K/A/AucLnGvojuMM5z9JGv5w4rERr0snLAeHGFbVWtnW/JXiWRHqK
         VTZUZbegAhfZmvWoMQ8Fq0um24PiZYlgiFCXjAoLRo4yxZcf1fYRZuyNBRXRGwsiOxVI
         /xhIWMoLL5rhGD4wBsfkWmCYeE038EBeOyNresVPH5ErO0dMb70boD4x4AFN6mbso56c
         tiIRcTVXcBLy3TNtiC1A/bHiHznbj/W79aeBSgRDaO4ILyOFms6mtkbFiCO16pjFbHzM
         ovoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=sH5DWqLEgIUuZRyN8oeROy4w+qlswaB9oK+WEao1v8o=;
        b=TD9lY4US+nDd6wP2bPdr17V3ndpUJViQ3zxLNDv/6RHnbe4oiextI6U0jDPb75p60e
         hiihcRDH8BdW0IB2nULrYcvVr0Nyhm3ABnam8bkyGXPImgeSfk8qhVu9zMfTbgt0ej9I
         OwiCebe1jATOf5N0vHX43fZ+eem5bkTUGEIUa3tK7HEYSOKpmSta+F9jANW/5UAPU7Ne
         On2pkzQu2pGvltETi3G4K430+9M/DCeuVTvszX8vx0dHkzmCcHEBokdFot2TfNzwtYFh
         j97ftOtL1CUGjmj/01UWOOwr6w0d1N+Zb3L5DrLHIB+GmC1EEBECXc4HD7huvL+KS9U5
         88NA==
X-Gm-Message-State: AKGB3mKzo+LcAgt2tFErVYuxrsM/2R4rp3T9KIFXTz/OL/xzdVSXTpts
        FlO4QTr3bfiXavm8pBSR5eEC+4guaeTbq1+dlhE=
X-Google-Smtp-Source: ACJfBotx8W27cgdq3SF5mBj0YWwweqYNXIr/ujglMDcFlgLamhGUncoXkFzUF6YpsyKHNLYf82JxOnbrRJtWw3KA31Y=
X-Received: by 10.107.129.40 with SMTP id c40mr784980iod.169.1514971589511;
 Wed, 03 Jan 2018 01:26:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.109.73 with HTTP; Wed, 3 Jan 2018 01:26:08 -0800 (PST)
In-Reply-To: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com>
References: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com>
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Wed, 3 Jan 2018 10:26:08 +0100
Message-ID: <CACx-yZ3MPN1Fw4s=mV9n=zibVm9Z_OE1eSg+4PBtUsqxTTvwXQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2017, #05; Wed, 27)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 10:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * dk/describe-all-output-fix (2017-12-27) 1 commit
>  - describe: prepend "tags/" when describing tags with embedded name
>
>  An old regression in "git describe --all $annotated_tag^0" has been
>  fixed.
>
>  Will merge to 'next'.

Shouldn't this be merged to 'maint' since it is a bugfix (for a long
standing bug)? Or am I misinterpreting the meaning of the 'maint'
branch?

Daniel

--
typed with http://neo-layout.org
