Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F07B1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 12:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeBSMU3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 07:20:29 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33871 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbeBSMU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 07:20:28 -0500
Received: by mail-io0-f195.google.com with SMTP id e7so11117843ioj.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 04:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uk1U18zh7m0QkVDyg+TNlaL+Le/IhoFuhl/DZBZnaHw=;
        b=COon4O2bOo6gwU9h85+HTQty4arHPHvR2EEsYOZyvmABpPkg0A3cBRqw7rEhwvyNV4
         fcbRzerOK2jEj3lUcgUaWl5EVgLkRqgxFoNO2Ji/KnHSn3NDo3qfVHf21qUX/FVX2mvZ
         1zAGphGKMh/tzDkJLEAGJ63pOYYjWTdvQlElxDx5Va2NR6gKMcXkPkSvoJBDlOUuBm3Q
         NY7RU8ld35h43F0xixO/AhCW05Eyzryn4lb0Fpc7FG1hhJF6ASuopkqZPPPRNfRHAIg8
         1BB0HNX+A6f5rSZm/yTKIGYM/Gn8UrrKeOLx4wIsdmseSxk32E/v2lzposq/yYHpFYSe
         9PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uk1U18zh7m0QkVDyg+TNlaL+Le/IhoFuhl/DZBZnaHw=;
        b=S/zn07N2DU4wXDajMo/xL8ImEQTfNBBfS0V4r6wubjuV7odTOxHltq/bxwg5zXZ4Ki
         DtxJGzUhBE7VTPgyOFEjw7sZnt7tNTgLrzTQYYjV3y2juSxg1f82hvcSWq2PKd/gQvnw
         oaxM26L68huKSfgqzY88dsFsQkcsBQsYH3ZYnk8u08OskSXtQ46hypvy7acNRM2cwbvp
         vrhh+aCPUdgVjKHLGVX2r69zhMMfOd8LiOqiv33wJkJw+p6578B9Q5+aL/peFknVs7XY
         NCmZN4P6HjHZLsNXJzT/MyoiFTAMWt+PTpGj1AK/YJJKw101lmdXK4CHB1IjTofZZkrL
         Lqmg==
X-Gm-Message-State: APf1xPCkNBT4safd6f9Tyj8iqI5U8FdpXi/W6ejVCTXTPbNR0TzlpaLg
        945irh4dQ2cO2Z3rGGPfcKS6Zvy5PU2ISC2gnsc=
X-Google-Smtp-Source: AH8x227Yz9cTmmQ1zHmJHPWkSevN16EJCZV+CH5+eXvgbGgx81xin+cFiejJNciRMcbzHhBmr1QkXoXNoZFvA6wEsmE=
X-Received: by 10.107.195.1 with SMTP id t1mr18910224iof.142.1519042827402;
 Mon, 19 Feb 2018 04:20:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.230.7 with HTTP; Mon, 19 Feb 2018 04:20:26 -0800 (PST)
In-Reply-To: <20180219113619.26566-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
From:   Gustavo Leite <gustavoleite.ti@gmail.com>
Date:   Mon, 19 Feb 2018 09:20:26 -0300
Message-ID: <CAEGv8HiRsS9N2nHBu8uwm+35GS+HRVc6Q0e1R+=-tZn7JcZ8BQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] add -p: select individual hunk lines
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-19 8:36 GMT-03:00 Phillip Wood <phillip.wood@talktalk.net>:
>
> "When I end up editing hunks it is almost always because I want to
> stage a subset of the lines in the hunk. Doing this by editing the
> hunk is inconvenient and error prone (especially so if the patch is
> going to be reversed before being applied). Instead offer an option
> for add -p to stage individual lines. When the user presses 'l' the
> hunk is redrawn with labels by the insertions and deletions and they
> are prompted to enter a list of the lines they wish to stage. Ranges
> of lines may be specified using 'a-b' where either 'a' or 'b' may be
> omitted to mean all lines from 'a' to the end of the hunk or all lines
> from 1 upto and including 'b'."

This is an interesting (and needed feature). Would be nice to see it merged.

--
Gustavo Leite
