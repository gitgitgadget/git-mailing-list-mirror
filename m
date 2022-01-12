Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1992C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiALTeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:34:00 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:42527 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiALTd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:33:56 -0500
Received: by mail-pl1-f175.google.com with SMTP id t18so5615184plg.9
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWzPT4en2qZNlZ2pCt3rdD0Q9Ot7lOvu3hbRtMJZ3ag=;
        b=vxx4wnjvtYDanUb6HOTJBDsbkmtacekuYcuxoeivAA5H9jlk7pnq5VBsCq88NUNjQf
         8X6NxsG6nemAymS+m/cjUBwgAMxjJ6uh3Fhz54rSYEN2QyrPCnLSjbk3se+rcBHsVUnb
         zO5GO0F9CnpQdELhftUM1AmIqQb6N/yfLPEki0Q1SncRYIuEJ7Pxk9psgtZ9a1jlnrMt
         S9utym6XBI4yiuavuukMBz+vl+HvHnJwj/CI0bIBkaZ2srwssC7YbBuV7lL20SaOH7nY
         VWbXpRzOaj85X4GKTKd1TUR/VAUSZmYjpKYzOxCqnVXsgfb+D7yjZSwKmpmdDT9CFoHJ
         2fLw==
X-Gm-Message-State: AOAM533jCoQfF9VJ6jUiWqQjcuIyI0NYeK3F39ChOy9rjDu8rFHCXSBN
        4UmjuRtv55nLa2/nEO+kNR8krXecMz/lKe2G+EA=
X-Google-Smtp-Source: ABdhPJwBKDzdnJDj5hcZS0EchihrIyJ1P2K4ophBTlsf6F0ER14ubnjY/hwAKNNhqNiQYuH7ovpCaBAvORGTyAMUvn0=
X-Received: by 2002:a17:902:bd94:b0:149:c926:7c26 with SMTP id
 q20-20020a170902bd9400b00149c9267c26mr998900pls.64.1642016036108; Wed, 12 Jan
 2022 11:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20220112134635.177877-1-jholdsworth@nvidia.com> <20220112134635.177877-7-jholdsworth@nvidia.com>
In-Reply-To: <20220112134635.177877-7-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Jan 2022 14:33:45 -0500
Message-ID: <CAPig+cQjK9e3MXu2J3OGmBy5V2OoNWN4f2iO2xFF6-mN9hjYiw@mail.gmail.com>
Subject: Re: [PATCH 06/20] git-p4: remove commented code
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 8:47 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> Previously, the script contained commented code including Python 2 print
> statements. Presumably, these were used as a developer aid at some point
> in history. However, commented code and therefore this patch removes
> them.

I'm having trouble interpreting the final sentence in this paragraph.
Did you mean "...commented code is useless, therefore remove it" or
something along those lines?

> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
