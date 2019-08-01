Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61CF1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 20:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389025AbfHAUwq (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 16:52:46 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44037 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfHAUwp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 16:52:45 -0400
Received: by mail-lf1-f54.google.com with SMTP id r15so34300728lfm.11
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 13:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=r/Y1FJf4QNLAytHZEOreVnqnaQpqH+qMvN0/gwy4tCE=;
        b=u3wVCUiRynHNOhd483a1+HkO/8pZdBFK08wCsInxFh5gKgpz91e9GhrqoaXsDAJws/
         W3snvEYV0NIkzb7FBhHfPCFjHLtJnYohVBQ4jjuOWZRIklQWZhIu4DK78+xbXB8Tpq/t
         sWgpmmVpJK3WaGH5ejrKT0a1JkXWyF57LpdqgvALYA+sMrdHtXzLb0CSG7uV5fZUhQB0
         5IeuPbbGmBj5cu4xQKyJ4+qTqByasO+TwH4L3qkCgpk7kAE0OKbtYZvht5QmAzX7tooq
         +jq3ioCsZhil18H2R6U2TtsTrojqDQfYQ6psZD4PGR7OtXtQFTLTXUCxTS6jg3pZS3u1
         DYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r/Y1FJf4QNLAytHZEOreVnqnaQpqH+qMvN0/gwy4tCE=;
        b=bMfoR94JTEoGrln7XRiodTOR4U//UJ3ngeK4bKMktiXoUgQyxiQq9Q6GiB55VwHLL9
         kP0+XEz24tIykz/HAOtaReJrqe3MVdXZaigGzhbK4R7ZcvR502ivipWb4QyM0aFH0XDD
         8iNeMN3hj0RMs6r1VkeO7JL1xj3uD51JbYhR38bfNC22TK7E8Fya8Iznur44Z39G2jXW
         LW9sjqaILIBK4Zgz2M4O33e4WIA8PrCxenYoHhuhTCUosgqkvDM8W8K0Xb66UFrG66BU
         jn2XExHEWbqTr22QMN+ys6NeFgKmPRX4qOlgzcArVNCe4Z4+goah4Yyb98r4fajaPAWY
         NAOQ==
X-Gm-Message-State: APjAAAWV86KmuBx+p8qxExTBOcFV5gLnx7R7nvnv3FuXLmBUVwSH+TOt
        5Dtua4c0n0C9wxyTeII6V0MN5AJt8oWD+q5Gr1Dod4qL
X-Google-Smtp-Source: APXvYqwoJ4LHseA11waYPbEet/fXsql1A+14ji9qbcVADI+D+bEOpGxUOEbVZ6jAFBd1rvOzr3v2W6qJnG89Qnm+Yuw=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr52079803lfp.61.1564692763475;
 Thu, 01 Aug 2019 13:52:43 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Thu, 1 Aug 2019 13:52:32 -0700
Message-ID: <CA+KyZp6mYx4C22syAu=W2Okf7tDwtQ+7vVUBaQ-2D70PTS+GaA@mail.gmail.com>
Subject: cannot clone --single-commit instead of --single-branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking for help with this problem:

https://stackoverflow.com/questions/57316783/git-clone-single-branch-does-not-work-for-sha-commit-ids

Essentially looking for:

git clone --single-commit

since

git clone --single-branch=<sha>

doesn't seem to work?
any help appreciated.

-alex


-- 
Alexander D. Mills
New cell phone # (415)730-1805
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
