Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7184FC433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 19:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E64220657
	for <git@archiver.kernel.org>; Sun, 17 May 2020 19:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEQTXl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 17 May 2020 15:23:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40369 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTXl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 15:23:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so9319393wra.7
        for <git@vger.kernel.org>; Sun, 17 May 2020 12:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iHx7JMxvvuaWks66x3PVttStQHglYLeUZU2aDwhwjNs=;
        b=DjUBeY5ZE9x8GovIUl74FBYKGyESvDkikj/AGtO8+YYxLkru7/9/8OP0cmlTwJFbbV
         U8JVqD6wbDkEOcO5naiUTgDNNScZKTMmbL46KI424BsiK4vfZ1KMY4TXAPxerE6ZvdIr
         t+5azKcspQJo9w9xva9y2aGnaLixoaZdc2dLioYrA/HUqW8qacSVGM03WFm4DAdwEf2N
         Uet7W4upGm1wyttG0IP5lgM8lFQl1pQehPhsTLriMEkroPzAFdTBcj67XdNRDDw9t4/+
         rwciQBBZ5qZ4SAiUiX2O7upmtFQrW7K6c98yg5Egkg56z+nA+/D3b4+iiqlg8m47sQPh
         i4wQ==
X-Gm-Message-State: AOAM533ghBmo0yAeea/c7vMV+HHV4o7kgv5NpV0UxIa0SY8jOKmWjq9x
        ydDXvnsklz3LK6twpG8TUMAXYsRsCz8iWQRfBkTuQmyr
X-Google-Smtp-Source: ABdhPJwOtGqRgcQa7gnmMmzS5YfLDWUJH9ToBKSD44p3UqAP3eOjsk3hyMfL4UPQLFKXKic1lE7dWeNImvslCG4itpE=
X-Received: by 2002:adf:fccd:: with SMTP id f13mr16091822wrs.386.1589743419527;
 Sun, 17 May 2020 12:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589739920.git.martin.agren@gmail.com> <4753804d23ba7b1b267b6557077c80f3a8891712.1589739920.git.martin.agren@gmail.com>
In-Reply-To: <4753804d23ba7b1b267b6557077c80f3a8891712.1589739920.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 May 2020 15:23:28 -0400
Message-ID: <CAPig+cTMrdeBLzUKKpkuZgSbXULhQb4epNC5qMMTUgqfZ1a0bA@mail.gmail.com>
Subject: Re: [PATCH 2/7] git-bugreport.txt: fix reference to strftime(3)
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 17, 2020 at 2:52 PM Martin Ågren <martin.agren@gmail.com> wrote:
> When we say "link:strftime[3]", it ends up rendered as "3[1]" and we
> produce a footnote referring to the non-existing
> file:///.../git-doc/strftime. Make sure we use gitlink, not link, to get

s/gitlink/linkgit/

> the effect we're after.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
