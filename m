Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB92520A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 17:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLHR2h (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 12:28:37 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:53681 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLHR2h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 12:28:37 -0500
Received: by mail-it1-f178.google.com with SMTP id g85so11662494ita.3
        for <git@vger.kernel.org>; Sat, 08 Dec 2018 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1OXLm20fmKwODsKUGDtzZQthcal8t7tA07pHPVKI3U=;
        b=TvPNTaczRxKDKemzqp/VZrQ4zkkDYVet0GkKmS7h7RSXe4ciGa87cEIz2dy1sMKqXM
         OPMvgc08vaxQopGIK0Plj3Ytz2rY68a2BX1cPZmWBzoMIv/FN/aOj87e47WlzLacVWdL
         2se1vfSVOxTLjhkLNFH9F1dhfhY5gypddRIfKtspMlas/PyFHiCJvfd2ymV/rY0gyFVs
         FYbZgMfdE5FL+5TR1grR58AybQV+qMx7z7hE0FUnokWm4ze+m6v//ODtG46k8WNEObDX
         8kDR0aPiUgbjEE384UAwqpkxszUg0Yh5UfH6pFpHivypt3VHvB9yHyUCjMgzXWkI7g/H
         kq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1OXLm20fmKwODsKUGDtzZQthcal8t7tA07pHPVKI3U=;
        b=dD4Zb1T5vp2KECo8IUZSbV8x15j0aDfOlsxqvW+HCh1IF20zopHgrERX3mBCGsudD3
         9weSA07ObnF1Mq9K5q4dBnuLJEyGgmts31zaXXEAhSi4IpjrRko2o5e7k6qTCdgu2KGi
         RCicBjhWtWbhyqP92v0bK6USFKKAN9g/pMIyiwIKRgf57us8d+DO0Xk/nHyPXGPy9zhx
         +a5qgt6FOzuP4I6QJhPRH2Ay4ua5Zm4mbMaFlbz9k0NrceKWNi7f0mfVEgQDxJsB4YI+
         k0cksT31IRScDRQSFHgN5JYOQs3Th6uiYMkLOSBohO8fzAF15tuk0aeoKOPBzVqE4N0c
         0+Ww==
X-Gm-Message-State: AA+aEWY4mosQ1xkK2oH2+HiwSwggAgLceLRrRLrRzSblEQ05SCwOO++t
        69ILAZaYjbmCvHO0ZV7B6Jkw7DV3lGhPN+P3YkKFhw==
X-Google-Smtp-Source: AFSGD/XBOLKvqeLSBfJNmB0/mFVpMM4NrOfHmOGdLNWayUfX2h2uiaG1NLarGziVAt5o+gXfmEWr/+gvFhyEy8k9XQ8=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr5927624ith.123.1544290115496;
 Sat, 08 Dec 2018 09:28:35 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Dec 2018 18:28:09 +0100
Message-ID: <CACsJy8APyyAWM+L=HU1XM4V+qdTWqjto6x=Q06By8DbgtYfpCA@mail.gmail.com>
Subject: Re: why doesn't "git reset" mention optional pathspec?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 8, 2018 at 5:08 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>
>   from "man git-reset":
>
> SYNOPSIS
>   git reset [-q] [<tree-ish>] [--] <paths>...
>   git reset (--patch | -p) [<tree-ish>] [--] [<paths>...]
>   git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
>
> oddly, the third form says nothing about possible "<paths>", even
> though i'm pretty sure they're valid in that third case (at least for
> "--mixed"). thoughts? is that just an oversight in the man page?

--mixed prints a deprecation warning. I don't think it's worth making
the synopsis more complicated for that. All other modes reject
pathspec.
-- 
Duy
