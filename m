Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0910202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 03:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760822AbdKRDhD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 22:37:03 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:37609 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760807AbdKRDhC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 22:37:02 -0500
Received: by mail-qt0-f176.google.com with SMTP id d15so9213662qte.4
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 19:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rcKqRZnf9jLwwfNRYdgzaMvnoudPkIiOiSUtkrbwWf8=;
        b=f8DMC5ZvjMURYIYr4Ys2F3YhEf67fUCo9UpynUSvxq3iZQt2BwufFOJyydTbaCd5cT
         1gVNm5dXJiS82vO8KI/xUw9ImHSzogZYDwYIU65PG/Wz2RrebToixQl1pow5xq6S2g9t
         Ujaxaf3ZK2AdcJX3GDcO9ROf6U4LXQAuLuZJjo8XuXRjE+qQZJDATMvL4Xxp3p7JMEdZ
         ebuJ6l8Ke1xm0p3jhoNR0qJB1vZk1LAf5nUNJ70LCwMqHQwZxDOv0Q5yV/d3VMY7wBYv
         S7C+OkSqSheLvSruzEwCGhuN2uXV1DIpGckl7q/XwU/iScIhPoGclyJx+Q4DfRoYbm/X
         x89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rcKqRZnf9jLwwfNRYdgzaMvnoudPkIiOiSUtkrbwWf8=;
        b=nIPhGHswGX9wvn9Jb2x9UgbNSyzYYT2j8bKzOo81IgXRWYzqx7Ces0HgHFUm1YOFh0
         rnPlRhMDUbBLP1JSPJolTJTvz+jbGMlww/t2KWuNMrXVT9S9jNJSVoDMnkStrd9u+SSv
         cgi33cOHs39h03XrXZrWeEW2f2k2r6MdUWF7L9ws9lTFZwXKMvBDQyRH73l056tKNvRj
         nmMDNxTqUSOCloM0G16jiCxSUF3WudWHwpM5L8LsVVw7n/dSM12SeKfLUoHE+QOvguJ6
         ewe9PvAwPehU/MBiMJbGeowcUrqakZwJs1krzIa2ycIAa8u/DP3eF/L0PPgFlsNUjMjX
         LNOA==
X-Gm-Message-State: AJaThX7Wq6HdnqcWElSrrvnkPQDq0fFxtBwDCHK4POxNhpqyv0e3SoA4
        clIP7Fuqa1WGw0pxoN2wOX7zmaWVvCrolBw8iIEsEA==
X-Google-Smtp-Source: AGs4zMaVnTOsWDo6iFeqWNT5nF3BvPfDCqB7avMJNd9wsO0p9zPSQk212ulvF1GlqxldqrnHPAdjJnMR0ok5LJQcZBc=
X-Received: by 10.200.34.239 with SMTP id g44mr12290965qta.11.1510976221789;
 Fri, 17 Nov 2017 19:37:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.54.4 with HTTP; Fri, 17 Nov 2017 19:37:01 -0800 (PST)
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Sat, 18 Nov 2017 12:37:01 +0900
Message-ID: <CAC2Jkr+brEKLy-z45WwP2iqssA14na9xpaCoKrNKbPcTvtUxJA@mail.gmail.com>
Subject: Is it not bug git stash -- <pathspec> does not work at non-root directory?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it not bug git stash -- <pathspec> does not work at non-root directory?
