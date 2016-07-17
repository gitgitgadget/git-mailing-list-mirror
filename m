Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843112018F
	for <e@80x24.org>; Sun, 17 Jul 2016 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbcGQUg2 (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 16:36:28 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35045 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbcGQUg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 16:36:26 -0400
Received: by mail-lf0-f42.google.com with SMTP id f93so119187475lfi.2
        for <git@vger.kernel.org>; Sun, 17 Jul 2016 13:36:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=vxeo3S2joFn8c8SuUyC/DB83nc59Pv27bLv7pOqEYP8=;
        b=IZYBZZxNMZDK+L2q2XymMGhztWvLDttc0CPKlZABV9ceK9DC/cmur4MyOLytB7t0pN
         e/KhCW6CfG47eXuBrczdFknE9MmHR+7fAtjzF4atAOAHvgbqdftqTn0vyzTzGB/XVUq0
         UVCKt3OMvCGvJNFfPsdljz6Qb4rAMFDIWiNKgCEBzmY5JmiWWNQy5LGjfM+GsE31Q+el
         Up6fnZLqJwT4W+pWOn1l4z53FhjWtd8dMGGQrEpiJ2Sfvy0BgTriq65rVw1MCTj5ejny
         6XZtFj3vsgnEOdhozsoL+9xLQvODmTB3n+kx0tLCnxpIDy3FOQD84QuUPegUkrkzF/Wy
         CEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vxeo3S2joFn8c8SuUyC/DB83nc59Pv27bLv7pOqEYP8=;
        b=X3FtQ54HQ5LLSkqS/DyGg+eSA/xnP4BYdsiVHxCLcsxzwJqgd1/RJeLYHfZE11n7fW
         bN/t8qtnoNMNScSjJZ3CkGkbrsPZQGikb0WGDLnYI6hfKR62pqMDuYyy+bEZD8SOAmFo
         fBrOoanp8/rcnK0RcW4P408NqlSV9NSq0PyU6LyCttCM5wqUt1QMeoPzgcZW2aXYMxBQ
         EEuh0V1XaAZXpzI0fcXCVCqZ+zc3nOOVqv1sizszqI8yzw7nJEaRJFJd8egNUqaezWkm
         /R+4OXabGIl7Hl4a0WEwihQ9EPu/UwmlYDBx7qhEjXiTgV9ismqJliS1h82xDX1vta3a
         dLTw==
X-Gm-Message-State: ALyK8tI15R6edo3UszcN/2yQBwLALcTQtqpcpIA8bGeWuSL4Gw2diYWUIdqgHTgVjY4AWhNc1OZxoeqDt2fAzQ==
X-Received: by 10.25.17.70 with SMTP id g67mr14292274lfi.145.1468787785096;
 Sun, 17 Jul 2016 13:36:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.10.135 with HTTP; Sun, 17 Jul 2016 13:36:05 -0700 (PDT)
From:	Alexandre Bique <bique.alexandre@gmail.com>
Date:	Sun, 17 Jul 2016 22:36:05 +0200
Message-ID: <CAP737oJOGzcgd547R4Qyo832LtGQPZhLtCPS5tr3F8Ot+pxH7w@mail.gmail.com>
Subject: git-svn dies all the time
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I did by mistake report the bug here:

https://github.com/git/git-scm.com/issues/807#issuecomment-233200404

In short this is a backtrace of git svn rebase crashing in perl, and
likely because of an out of memory issue. It crashed on my laptop but
not on my desktop (4G of RAM vs 16G of RAM).

Regards,
-- 
Alexandre Bique
