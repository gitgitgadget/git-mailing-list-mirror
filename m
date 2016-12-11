Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2C11FF40
	for <e@80x24.org>; Sun, 11 Dec 2016 22:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbcLKWYe (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 17:24:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34215 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbcLKWYd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 17:24:33 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so7410644wme.1
        for <git@vger.kernel.org>; Sun, 11 Dec 2016 14:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YVLZSkCspC+CECDU/34AegEVRcVsqEP6mcXXVJTqFy8=;
        b=GnHFKAE+RdcGLWws+xeO6MDg+tTtvZlmnY9GnEXS3vwRjq4IpCN6t6OnueRUq2IFHL
         BtWtDSGi5yv+CrgpXYNnBWmTy21O1p8vaPyWw89IXtDCxTMz8lL7/Inu2xUL3DH4Mi9/
         WfpLkQLkKwrMtZxLrR8kl/GfutzO+x7AtVi8Ji9BuL0xoXMmMLxE9Td1QKqeTMkY8Q8U
         jCv3it+gyRYK5L8u30DRrU64uZrR9L78SmddLRR9nniJGI4+LSYkpPK/FoYsOCo/Hc1C
         Y0JxwGQu5oAWNLmW7ReT5MIJkrDQSQ5OHAD6p/Uv9zEGYOQmkac1sitTuRrFlTFzWyoM
         j+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YVLZSkCspC+CECDU/34AegEVRcVsqEP6mcXXVJTqFy8=;
        b=KXduIaqFNx4OyEEVinwzUvOIwrhwNgVVv9ZLclh0fuYML++GloYW6zulbUgCs5eZzn
         z0DzXYsc/OHf8iottIDCEa9dXXAVdd/LaIFQJp1bv62g+Z0+EOyBIv9ToV1AGXubm3N1
         eklC8JOIKWIOdahCkMm55hAedmWmDpVw6PlIrqI0sqfVUuaZhIjTY9xbfQaqic/Hv07g
         VkjI85LOSHzT/uNUEh6CgL90Sq9Ct9Q7V2fMOFSXQkzL/yYtER0zd6/UMJlk0UvGtq4K
         85k/Szdzgy9rV3JhQDFMgBLeKhMZIrovYacGzl5AUOBXsLYpsSU8ZK83buQZZJr5fR1K
         bLew==
X-Gm-Message-State: AKaTC02hbUs38A2ONXFguKmv/pG91jU5vIxIUMmT5FHJDtT22nZovzTPqYx+HXGAw7Qe9gV6fJTG/r6ai+p1hg==
X-Received: by 10.25.209.73 with SMTP id i70mr22828297lfg.24.1481495071540;
 Sun, 11 Dec 2016 14:24:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Sun, 11 Dec 2016 14:24:31 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 11 Dec 2016 23:24:31 +0100
Message-ID: <CAP8UFD0LOkZ8Kt7LEH-A8gPuMq4vmrXDfjde6tL8MwDo7dX=CA@mail.gmail.com>
Subject: Draft of Git Rev News edition 22
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Aguilar <davvid@gmail.com>,
        Dun Peal <dunpealer@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-22.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/208

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus (who is now part of the team, welcome Markus!)
and myself plan to publish this edition on Wednesday December 14.

Thanks,
Christian.
