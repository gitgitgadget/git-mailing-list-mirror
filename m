Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6262018B
	for <e@80x24.org>; Wed, 20 Jul 2016 08:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbcGTIFr (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 04:05:47 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33716 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbcGTIFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 04:05:12 -0400
Received: by mail-lf0-f45.google.com with SMTP id b199so32508989lfe.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 01:05:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=b5z8Ih+7a+PRRt8dowXXw46ecurK+dzwx5K8fM/IYaw=;
        b=kG6jZng/AQ8R7ZW6LMv2LPUgYIgvTAGc0tOs7ZQHqkN0v73mV7dH/NKa2mTR/ZRenk
         10rYNAjMpOoFBFfWHA5KfLQ7MvhNBvfIlezFkRl/ba6K7qZFOQEoU8YMSOdpd8J0sxrU
         CvHBGI+k9Elw5DyT97OLAfjbu1P94yiCY8p2KNliyH7gqpfifJZ+6gkGM7f0CgaiZ79m
         pUOPKTKEWSuJhFUBP4AYj3P0Fzt+0fsE+LgU+Ii73PxjJBI4tXeKe3GI3B2H+HGF+nXf
         KNSf1XDH5rpk3h7sIZgIxS0No2vssJsYQsGMI3u9ZrZ2OPW6+o5UA6f5I00iNQezv/qI
         rGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=b5z8Ih+7a+PRRt8dowXXw46ecurK+dzwx5K8fM/IYaw=;
        b=b+GV/nwlPOpMf6z/VcQVzbvj77R3y7YBAxU5Hv1iRvnqcNTz8Aq6ATlqWwcTfjHe3P
         gadKkQ4s67CfeOB89DK3ftg0OEPUqM4OjSi0g6UpYSAMM58go3E0rihmETlTnmeWgq2M
         DpuNqG5LnxBSQ30OKH/hvxd7ggPLUmjCS9L3sMZS3TbdXKcf3hH9h1d9/jNwQm5S1txD
         7pJRWUFT74ozBj4SZkUkYXCjHPaIedwv+JM9xGjakB161YM7e0k7PlUjbzF4ueCUocdb
         6lCHlyCZo0aDQl/Do1eNUlUZ7lwA4sC3VOcLpMFdKysnehx4vbCWs2SRccOys0+UBfyW
         hQiQ==
X-Gm-Message-State: ALyK8tKis0Zt2i5BTZN2nFQ4yQsDG0thyFaq2FCKYkg9UHld2vhEYiYjxPs3D2+xTvbh4gq0XILwZB6whEWAcQ==
X-Received: by 10.25.168.212 with SMTP id r203mr22729074lfe.85.1469001910269;
 Wed, 20 Jul 2016 01:05:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.162.85 with HTTP; Wed, 20 Jul 2016 01:05:09 -0700 (PDT)
From:	Ernesto Maserati <ernesto.2.maserati@gmail.com>
Date:	Wed, 20 Jul 2016 10:05:09 +0200
Message-ID: <CAOHAwykGkfY7M30jT8t0k6Gsdy5QSBHmAPiWYoKibjUgS-G6hg@mail.gmail.com>
Subject: How to generate feature branch statistics?
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I assume that feature branches are not frequently enough merged into
master. Because of that we discover bugs later than we could with a more
continuous code integration. I don't want to discuss here whether feature
branches are good or bad.

I want just to ask is there a way how to generate a statistic for the
average duration of feature branches until they are merged to the master? I
would like to know if it is 1 day, 2 days or lets say 8 or 17 days. Also it
would be interesting to see the statistical outliers.

I hope my motivation became clear and what kind of git repository data I
would like to produce.

Any ideas?
