Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1BCD1F406
	for <e@80x24.org>; Sun, 13 May 2018 05:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbeEMFkA (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:40:00 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34965 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMFj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:39:59 -0400
Received: by mail-oi0-f51.google.com with SMTP id a6-v6so8033342oia.2
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a35VUhX20Uib+2elw03JjIMPgCT7Y7knaShzOl57dG0=;
        b=lZf6aVBfgcq/2OmpQffobZlEM2NGLBznZQtppAUZBkj0M211xNS//VKFRb2NzE/Kr9
         gt8jsF8DTNe2npNPmg1SejiCHvi+DnDa4Kh77woqLWwJQEYIHF/SH9P3NOGpDbTMHwuF
         XZr07aUzyGZBrLWwYpS9bMkeBEhER0md5AFonZD+6PQ8UfLVcn1b0GkulBOxnNtH+FAI
         iSzKYrtIjMna3Qooj4kngf1Tv0pmiQL8vk9xNdkJpI3FYHRL7QeqxACg7XG+1f+WyIFn
         /az/RZl9uaNIcFK5tSfEvyJzlom6aZytazvaMT2G42+qwt8M9LelfOSs/u2Ne80vwe9X
         rHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a35VUhX20Uib+2elw03JjIMPgCT7Y7knaShzOl57dG0=;
        b=djk83f+fvr/kbsF75Vj7RVlhcrcjYIolrTtiHHIluTMLjPTpWGnBsSaYqAOAf76U0A
         4ecirpuga0FVrcjj/tCHNGDKuAOVOvnqn1LBsM0vFoaP6fZ8rpEeex7HnHu73bHuWNr1
         J7LIdbEFau651+K5n5y/i017/pNg7hHDyM/9TeWsj4Xs3oHFrY6dLd58+bb3Og/KK1OU
         6kJN9f8Mhu8jO/82kwM+cpVHI3BqnUfyw1SoNu/iF/Ed7cjbwTl7mZ+ILgzsXydC5G8E
         PG0ENIB9R7W5P5M+SJyloOXPOYHZGWZQwWVHQoI9ygnGf+MW0/lIuXAr0/j6PMMqLD8f
         3AnQ==
X-Gm-Message-State: ALKqPwf/JaDFFtzepSRpB4gmAmXQPZP0lF8MHU+KKBRiEqFfSh2INY+o
        s+zFG04Z7dmyqyzwPsPkxeYddDZ0vUEwMyXf5uM=
X-Google-Smtp-Source: AB8JxZoUyGSS07mv9HWauHMfXYtBHzj46wRgQTLGpALQcHZrtVzr/viZFoHeJL0zIrWzFYVuzacOiS9qSK7yaGLaQjU=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr3566450oii.216.1526189999040;
 Sat, 12 May 2018 22:39:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sat, 12 May 2018 22:39:28 -0700 (PDT)
In-Reply-To: <86lgco3dzt.fsf@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com> <86lgco3dzt.fsf@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 13 May 2018 07:39:28 +0200
Message-ID: <CACsJy8AhKn2P2oA+tEn6OLTd8UNSFmtJGMQja-eQP8k2aD-qag@mail.gmail.com>
Subject: Re: [PATCH 00/12] Die commit->util, die!
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 8:50 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> I just wonder if most of those transformation could not be done with
> Coccinelle, instead of doing it by hand.

I doubt coccinelle is smart enough to figure out the convoluted use of
'util' pointer (but then I'm not a heavy coccinelle user). I actually
got it wrong a couple times and had to rely on the test suite to guide
me.
-- 
Duy
