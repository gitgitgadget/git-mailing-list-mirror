Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882EC1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKLXtW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:49:22 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36768 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLXtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:49:22 -0500
Received: by mail-ed1-f46.google.com with SMTP id f7so271461edq.3
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=01J9ZTuZMa6pWVAJa7UzJIgsBhrujRJhtoS67V0VcM8=;
        b=GxvumzJ2xvb1WXBDD2xx5C4hkAxx+s0BKSPnLc9BGFzgjyy/Q3g9JtBbo47Ufrb72d
         C/gNuC/9mwIR0Qatine51JOwG4iULK80pKk8RjTFkkORsR1GFrRx/bdFkj59s3Ea62mZ
         yiMwPRmv91e4ktXuvcblo+kdWDbYwUOiTluPVIAyYsPMP8bR1fF9lG8Q2yazbmodRe/E
         ouVwdVPOhxC/JOYKBKQgltWi7PkVgnoW8tB6yr5yKA1pLqRuKxG4SjKoBLGWBnVKUsUK
         kgzFp7zRr0+n0+N4MPOY3h/qepfXiYZEvIbIBCbt/vQGO5quFUh4HGwzDSJaDEJyVuX5
         7rPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=01J9ZTuZMa6pWVAJa7UzJIgsBhrujRJhtoS67V0VcM8=;
        b=lvAONZL72TVpJLzffAw55qapOIug1EBYVbVfHwLMjnZd4D+QyVH8tKkc6RJblV8Uxn
         Zs96HX2vfow2Poj0CBDDacuqzsmBaNEEb8HLnrJajok5567YvRzplJbfCvklK1PA7ksP
         XAIg/EmcK237UrtXMtlJOxhFvius8j9ZxCZCVdg+tQX26hodyXT0wP4WDwdGGKAvsdAu
         zsKzHSBRI9NocI5xM5f5mhmaa3QfiLbpJdH6BE9qUqvooYPUXCWjwppLBsXKqdlYdhre
         JiZHcldeu/ZIM6p/9Y+Dzg8aW6Hpso0jmK1I9sDf5GepWYxw5Lqvdlv+dTxTGVSXWiOo
         bOxQ==
X-Gm-Message-State: APjAAAVGXZn+mVDHxFUl9ymH5e+6bu2rOS8GPpQRNRUc0GokmcAJ3tJe
        CJF5ObqJshvats6EDycDh07Kj+AdUoDWykR5US2Hz3afXB9l6g==
X-Google-Smtp-Source: APXvYqxQO/tBMtNvscqwTuyvtyQq3blPHibaior55dDvgBDqx/Ny359YFjzyDlJD1LRbAGseVZbTWEx/SIsFTJokDB0=
X-Received: by 2002:a50:fd95:: with SMTP id o21mr380482edt.283.1573602559696;
 Tue, 12 Nov 2019 15:49:19 -0800 (PST)
MIME-Version: 1.0
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Wed, 13 Nov 2019 00:48:53 +0100
Message-ID: <CABUeae82_qQrR5s_QYsDzkVX6CeVM-B7pT5DZt_BjpL=KJdtBg@mail.gmail.com>
Subject: Merge commit says refs/heads/<branchname> instead of <branchname>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

After setting up a new machine with latest Git and
I noticed commit messages for true merge changed from

   Merge branch '<branchname>'
to
   Merge branch 'refs/heads/<branchname>'

Nothing changed in the merge workflow or git configuration

I'm failing to find in the docs what drives that change, what
configuration option controls such (default?) message.

What may be the reason of that change?

Best regards
-- 
Mateusz Loskot, http://mateusz.loskot.net
