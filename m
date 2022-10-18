Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C0C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 18:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJRSzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJRSz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 14:55:28 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34783A2AA5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:55:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r142so12541151iod.11
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nkCvHpfe+y1LfSLfVdrHD6ciG8F2tyyZAheInqf+Do=;
        b=tvKYTeMD46A7XeJCI6xG5wLJGx2cc6uERPOR1kHjoxHGAOfMGaTCahI+6tbncKV3MO
         xtgDo2CJhVxO9ftSzzmjknlsacZi7+fTf4TezCh7X2Zk1vh1qGxNn+PzFcHzq3fNzm33
         8FfNl6Iu38tEaCfJevM2D0LsJ33QKWJREUsDEC5Eo3qJBKqzjpVVcp1b/aPS6KLQKdGD
         3ZQU5YaZ+3YQhOeEP0elKxB5iH+EBTRZ2MHkk5r0ENrFnxORv9JN3zZqWWcJmEmMiGZE
         YwE8XqaH+KFABKCvHu1nWcG8ypzNxJulFfPaLSNO72Rl+dDSHAPsJG2ZNj+vrkz+5dzD
         mYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nkCvHpfe+y1LfSLfVdrHD6ciG8F2tyyZAheInqf+Do=;
        b=neoh1DcYKwlMB1M7QWKUomWxKUwq8oubxOL2JXycAVuhBknsI6NcKhkw/0IFChaasQ
         xRoLtEidp/jSemdVtUlqEQf/8D9CgFzs4+UvfSSqyYVcsrzNELxnnz+5SE0v2g2HHtpX
         0O5KmPT/9CPFNP25BqMqjcXJnBPuawcx4erzc4oVgwmOCXHBiwAeICdnaDJaH1CohBDF
         gBRlyZBzBb/JdUfkkrNKGUqJJyhjW5uu93VB+BLIYkywjgnwBvBRkjQMU3iqFr+Uf8tf
         6YIl4JlUiFOn1nqTCSUAnCRy/i8AyM/TWQ9OZTLveyGKkhFJkYXi+FMd0XOuWhtxFqE6
         hFYQ==
X-Gm-Message-State: ACrzQf35d8sIJHlDw7GnutJrMsxvwzl+FkWsL39FwyyusbFwbnZ6pf7C
        qYTsiNfWbasfOl3l97uHEHlmlolZQ741rcEL
X-Google-Smtp-Source: AMsMyM6Wr9Y7NYKcAJjfElHMc7s46wHjtpEyd06tagP94idbPhc2uoGp5IYC4qI9yvbPlsjAflqYag==
X-Received: by 2002:a05:6602:2b94:b0:6a4:7b57:ecfb with SMTP id r20-20020a0566022b9400b006a47b57ecfbmr2577839iov.8.1666119324906;
        Tue, 18 Oct 2022 11:55:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r13-20020a02b10d000000b00363966db537sm1319756jah.46.2022.10.18.11.55.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:55:24 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:55:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Merge 2022 videos available
Message-ID: <Y072m8pW4RC7p0bi@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

The talk videos from Git Merge 2022[^1] are now available on GitHub's
YouTube page here:

  https://www.youtube.com/playlist?list=PL0lo9MOBetEGEAs1D28ExRQONnX-uZ3Wf

Thanks,
Taylor

[^1]: With the exceptions of Emily Shaffer's and Martin von Zweigbergk's
  talk, which we are still working on...
