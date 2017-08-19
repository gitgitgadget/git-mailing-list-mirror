Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D62E1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 15:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbdHSPK0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 11:10:26 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34416 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdHSPKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 11:10:25 -0400
Received: by mail-oi0-f47.google.com with SMTP id x3so121092240oia.1
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=p26Nh4sxcJHmGceL9t2G3e7bJtQ/R23lS7f4D7SnfRI=;
        b=OyA8V9g/4pAyFwDlme7yZhGUT81ZmTTTxsPriTMYl9RxbiMKA+L4ZbW6m3fiRiz94a
         w4r41r1YMRlOc7aAid5wo0ubKI8FyGr3PCBchz6kpzBqseEYMcfHHDFmAU8lSHPSENSn
         9xEk0lX+As/wM765F9c9sRrXzCbTd9Gqc1vWAjY6407jr+sdK2l1T4aKZrXOLLr/w1wX
         ol1P9j/C8KKhF8jBkPc3Rvku3w9hLOtHqFLYT3r7hAKCBdYMoZxypUSvax/iXyf5ydcA
         CCkNU1S5vgnOyQUcrotrN9dyokgLIPpQaTSfO2pJMnlIqdwrdaO9IKvC18i/MzKcDvLy
         68VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=p26Nh4sxcJHmGceL9t2G3e7bJtQ/R23lS7f4D7SnfRI=;
        b=r3AVvG8v9yUbAKLNlUaLz/8NshOl7KHU3d6RiF/D6JxEqxQ7qNhM7Rs6j4AfwlLcqp
         nbO6mUGrbx2lldlFAVmvT5loO4/nANkxm7Pq3nrd2zqdl/gVNmJEBEGdEtHXhpKZfxxX
         /Q+A7xlMDmthG0ApyKh2TtyDRJ2URHw14VIat+B+IAh//klxapW2kXxA0Bj5TE49I7w/
         SyrV4vkVnecKLHl2iJyTLLNwDXvo4Mx0SHih8tcuGT/IPH00QTMgztABaoOtTo6AzAdj
         kgc/2QMSq5wmhLC14gpaeKu/HLf7wG7yhfhT78lienAUQcrIfYUjPAEknr77rSQmLKd+
         KTeQ==
X-Gm-Message-State: AHYfb5j+LGUEMmGEmsrTyUSW2yxZlUtW5Le91iXcZrbeS0vIU4kigwoF
        2/36PXAAn6qQtOoAhBjfRSjZBxQHmyARZYs=
X-Received: by 10.202.81.88 with SMTP id f85mr2183616oib.101.1503155424430;
 Sat, 19 Aug 2017 08:10:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.98.28 with HTTP; Sat, 19 Aug 2017 08:10:23 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 19 Aug 2017 11:10:23 -0400
Message-ID: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
Subject: Please fix the useless email prompts
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it possible to fix the issue shown below?

I'm on a test machine. All I do is update to the latest code, build
the library and run the self tests.

The test user account does not have a name and does not have an email
address. There's nothing to provide.

There's no reason to break my workflows for useless Git policies like
"please tell me your email address". Its not my policy, and there's
nothing critical about it.

Jeff

**********

$ git pull

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'test@via.(none)')
