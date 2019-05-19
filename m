Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F651F461
	for <e@80x24.org>; Sun, 19 May 2019 17:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfESRSl (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 13:18:41 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35912 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESRSl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 13:18:41 -0400
Received: by mail-wr1-f50.google.com with SMTP id s17so11986859wru.3
        for <git@vger.kernel.org>; Sun, 19 May 2019 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=erWik50OBnq9utUQlWhPwIABNrr0UqOnJ6C81m0deRw=;
        b=rOWQOJJPGRlOUxmzS2DKlue6XeZOBIFuGxR3Z1xR8bhggihLmMrH+HfFBuMl5smLfA
         r+sm8iUOz8iL5uGwN0pu47vItLxHIZeYqkVmzckaumtazMX+QlPgU95uq9fe+fbdb4VG
         t+FPfWUswTvCItZxHqRaiyVLCKR7WAj5WG2iThJybIJ3mOb37UDAjUfsFy8T/CwWzwj6
         ctu5eRLrD3g4ysyWHoePnNlVxjstk1ZZlthkhhEyBE0mDwYwwk7c04tGmdZIkFqUGKAv
         RGrQpkn0mm36G7vxZEEKmLZ7KqGHiqUagvwTx4hop6QziaLMIXYeFjB3QDf3W5eKhAmC
         Mjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=erWik50OBnq9utUQlWhPwIABNrr0UqOnJ6C81m0deRw=;
        b=txy/NhpFW0xMWzKCQLV60SQCPlMdZsSshsmQ7X9WQtKVarULWT6L0qU/mAU63Ru/4m
         dJyqRNA70Mco5QhuhLYGn4t5XhHpKrX3vjG7vCEzCrooyR1ZFKPZy9NhZJk04zywPKBP
         yp9IKTl0pgPaArVE4ZO0tcxb+jO7J4+nx+JdsWdUt2H3p+loQZ182auGe0T7xN8fyeBX
         mOYoaoDWr72A2qjsAf6qcQqYa7/sM3sgm3QX0IVUl6f35PxzkGXB0760y7vjWC555GBD
         UguxvHzZ3Fgqq5sQVkRFpXueGSQJv9Pa+qHmF1vkm9CxJrCPgsvxv2BDEqB/H0YtKZqI
         fwbg==
X-Gm-Message-State: APjAAAXBqj/4ao3wMKfybvALhpMkQNZnp8pBeZsBTCVzPZppHd9ZtcNA
        CtJB0eCVwtmlYd+t1IqB3wre7emvTnh/armtpe9iGd9/XUc=
X-Google-Smtp-Source: APXvYqyz9DymcoMMjKdOi1d2ErZ2lrWFGy53PZfOwwOHQVrHCGP//L8c7YN4BkzSD6YSod32wtYQtEUnR0CQK84rQmw=
X-Received: by 2002:a5d:5192:: with SMTP id k18mr27220640wrv.229.1558245802413;
 Sat, 18 May 2019 23:03:22 -0700 (PDT)
MIME-Version: 1.0
From:   "Olegzandr von Denman (ORESoftware)" <alex@oresoftware.com>
Date:   Sat, 18 May 2019 23:03:11 -0700
Message-ID: <CAMsBkhmt0Xxe7EHSXJjxeZa4-CmF8oVgJiTFo2uHQOMcyKfCvw@mail.gmail.com>
Subject: improvement to pre-commit hook
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was expected an env var like:

GIT_DESIRED_COMMIT_MESSAGE

to show up when .git/hooks/pre-commit is run

but as described here, there doesn't appear to be any args to the
script and the environment variable isn't there?

https://stackoverflow.com/questions/56205170/retrieving-desired-git-commit-message-in-pre-commit-hook

-alex

-- 
Alexander Mills
ORESoftware (inc.)
