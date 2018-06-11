Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043641F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933811AbeFKQpY (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:45:24 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33875 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933802AbeFKQpS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:45:18 -0400
Received: by mail-wr0-f174.google.com with SMTP id a12-v6so21129719wro.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VWmP9ge180tc1vEG4fs6U6Dq2DSSJvPc2TmU7YgqSDc=;
        b=h06N23usheB1bvL9Jjls9fTC/lt5NnCGC19sHTQ9ZYfMjcpfNC/CILknGLM9i0L1p+
         aHU0u5znfv968xRasOCCSnLpE8b5L8+akI9ndaj+qhNVnJPPxtN37fonQocmzmreJada
         7Z8rZh+SmeViaNx0t9Vxgfqw7XQxBSOKsPWAmOUBFlL5+aApgZEHTaJuA1JV3ieOpKRq
         /YmWtyEcrulB1r9h3YZYlxbKLJqd992vsSKxXe9pzKgJ99Zg/3jxUH4aZeY9Hn3nTlc6
         6/dyPn5uol/qCodWymBKTXGzcdnOnfyVxoKuFwiX2uthhPwiYw6WbBLvgN8nFvYGt0Mq
         PI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VWmP9ge180tc1vEG4fs6U6Dq2DSSJvPc2TmU7YgqSDc=;
        b=Z9K5D8s/CL570CebrkB+//R+X2FNcrXL0v2dS12nyH+G4R0XwuXsok/1va3AXrYQAR
         pz76y5WPTWagCWBifo3oMGeIz9MyxlwEXRiRjjlEKt8UbCEB/1Y2IJxVO+VcrqYK858g
         cCigntTIu0ctJU4sk4kFllwrU2txqlRhwg6aZimSoRhcc6g2wYNW5pwcip0Rtxnls6PO
         9y2fG0qq+MXhnJPnSgTb61uzFfzVzbvR2pwMOjGgpsJo4gskurknNmMPVJo/PTnyYIEP
         u0MywqtTIcPgO8GVu2TZxgDYgesp5ZMk+kw/9yGhGJBIrYn3c2CEe5qWj6LaP9bD4Jfq
         VXyA==
X-Gm-Message-State: APt69E0KG1YJGIQM3RrZFMAGKRYytRDwBKGHWxkuSMB9zOskZtyJgpGj
        kALLEtNsjX+JKIAhVk586Iyy/ubhpXrS/29VVyY=
X-Google-Smtp-Source: ADUXVKKyb/WuIOhYHXajerwelTHyA5rDutsQDfZdaYRJTDWCPdj7jqAk6hpY5SGlokJ1TWbHykH9cJqS872NVr6V9P0=
X-Received: by 2002:adf:e392:: with SMTP id e18-v6mr14218246wrm.94.1528735517132;
 Mon, 11 Jun 2018 09:45:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:43d2:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 09:45:16
 -0700 (PDT)
In-Reply-To: <bcb4a1e3-3e72-749e-dfb3-09acbd049b87@gmail.com>
References: <bcb4a1e3-3e72-749e-dfb3-09acbd049b87@gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Mon, 11 Jun 2018 22:30:16 +0545
Message-ID: <CAOZc8M9qEaXuy-cV2E8LU-6GXmMu=kGL8NfGp33-+YPTmv5SsA@mail.gmail.com>
Subject: Re: [GSoC] GSoC with git, week 6
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My blog post is also up.

https://prertik.github.io/post/week-06

And nice blog post, Alban. :-)

Cheers,
Pratik
