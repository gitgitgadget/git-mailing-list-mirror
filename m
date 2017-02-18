Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1956201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 22:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbdBRWg5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 17:36:57 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34174 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdBRWg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 17:36:56 -0500
Received: by mail-lf0-f42.google.com with SMTP id o140so21535409lff.1
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gAVqFoTFwGHDgPJq9T5n1C1TXzozyvU08jtyOX7AfNI=;
        b=ah4gbBzZ+0jfd25HzigkenCMyYnhmQJBaHb0VLhirBgY6qIPxqFfvNJsFRdP7+KON1
         ZpNHd34+L10Ogs4pwGPnzLg5PExFhu8SIdaLnjJjbt6cWHN1CNWW93NRUihJ5XTJU3rw
         F7Y2wLv/pGNRBZIMocVU0Jpr7OTw9Zp6k+ywttknXKu8Ps8MJlpZiQH7/7CzpuHKT0oL
         3YUzjzv0f5iKHv1+TqCl1tFafGS3IerWC2GP2iDewgKDtC6YtCwmH+Fgtb4tzmKn+7f/
         rDyIprTYbog9XpNDGnHWOlR+7nZyg0j8444GTuZZxMJqXWf+bddRjc86WYb52PD92Ahw
         vVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gAVqFoTFwGHDgPJq9T5n1C1TXzozyvU08jtyOX7AfNI=;
        b=NaqhW+f6Exs/PjLbOQ4dGC0nIVz1ppq//9cyTWWnvy2LYnQdhpXrIej7SV9hwPwz+a
         9w4y2yp7Hu1TXp4NYIgAH1KEd9a3HbEIggqN8aa4qjBZqH2Ybbqdef6Z1lUDMWUI854t
         PLGIemKix6YVBaMoyA94hHKPvKCiUlciP8x9gc/OEtVUX8qEaauL0I0+I/vDMjzgYyoL
         t4t4i/zv/Y6M3mqIKAMB9HbG7pHydkES+RkWO4sjVw++N3PUlRVdswNJQpUTqwtcLdSP
         8ap5YOEDhDyNc5Eq95Fxgr/xtZ7rORc0Ou2F7jXQVG2qrNHreOz9b9DvxLgrcUEUAvi6
         sjVA==
X-Gm-Message-State: AMke39mn4guroxb8ygig3BJg1NTVayzAnIPrtop3IUuq3i9Np3mG9PAiTYWg4H0tbTRtNDGyRcTSBmOnJ/7iDA==
X-Received: by 10.46.83.67 with SMTP id t3mr3617348ljd.102.1487457414729; Sat,
 18 Feb 2017 14:36:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.115.210 with HTTP; Sat, 18 Feb 2017 14:36:34 -0800 (PST)
In-Reply-To: <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Sat, 18 Feb 2017 14:36:34 -0800
Message-ID: <CAE1pOi0rsY1eCS25fFsSiCZoKxfCJHfaxcauKd_dDxnG8u6DhA@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>
Cc:     Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 February 2017 at 10:36, Alex Hoffman <spec@gal.ro> wrote:
> You definitely convinced me that git MUST search more than only in the
> paths between good and bad commits, as the good commit G does not have
> to be the first good commit (thank you for that). My problem/confusion
> is that it returns something that does not make sense to me, because
> it does not make sure it returns a transition.

If multiple transitions from GOOD to BAD happen, then I don't see how
binary search is useful/possible. The same is true for a simple list
of numbers, say, 1 5 6 2 3 4. You can't use binary search here because
you can't "throw away" all numbers to the left (or right) of your
pivot. Or am I missing your point?
