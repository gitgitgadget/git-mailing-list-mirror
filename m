Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD42920193
	for <e@80x24.org>; Sun, 30 Oct 2016 17:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756957AbcJ3RDc (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 13:03:32 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36941 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbcJ3RDb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 13:03:31 -0400
Received: by mail-it0-f54.google.com with SMTP id u205so63965439itc.0
        for <git@vger.kernel.org>; Sun, 30 Oct 2016 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+EMqwsmtgMRjmrlvEPF2vRgWLXzq1RkWPFkv/h9qXKU=;
        b=sioWycrimmH4Ga+7MQlSom8QntJhij1UXsKU5ARey6KbBdzgJ3qBX4TmP+MPKHwbWw
         1I+lqHD5WURKeXq7Ruu7JbQuTuq+PaIkYXuQRFoB+eFf5/Em/Z/v4Ke4s1ypFCT4TDdx
         2GSTI65UIptAR6K1Lw0Davp2o9mRuZl5kw2eovRsQZ2+Zlbie/2NXIzvrDu26WkdBL3V
         91l0V9lqsWrrAmE9To3+ZQsfRqv9RvoA76eyJold+dSZyL/Q21FKIzmljkSzYmw/nj8p
         /R9yR0wlA44fPski1sNSQUaK0cP1RZIH6MpK9hTZMMs+GADFeBQQ8EL8oBu/okyb6ZgG
         FQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+EMqwsmtgMRjmrlvEPF2vRgWLXzq1RkWPFkv/h9qXKU=;
        b=E3hNtupFSUjAWqB4a8W6Mtoz1ZSielto0EArQW1ScLXWFac+50P7096UJTt5kjFENc
         jxGG1MbK91PpOQ2K1qM3D8S5Emhclhb1tMwVhdT/ZpErcRX2RKpXx0IvNLdARRJjcfuE
         +AzU9+qxnUpufMXsprZ8u+efBWVqlpTiKVpi8PaH8KqKYJ5FID3NtCqSEWJG4hshUdxJ
         DwKya1vIVnSG/diqBwliJDuwj4yIO3g+fOhSTPMjqfIdWSkHuxsAi/rXY3IfDCRsDjET
         EWEgIjBEWb7M7XhcYdIaLf1i7vg6WCwbFzDbntkLeqH/FNY2wCbilfblEJUwJzEFtk1T
         SP0A==
X-Gm-Message-State: ABUngveHwoI4PAkZvLRwqGzzJSplEbEkmihh4u8wCFyG0IrEOn3Z1vznQaiiQMfr9S79r/WJpeSFj6KWPeFNQA==
X-Received: by 10.107.131.16 with SMTP id f16mr4263834iod.91.1477847010664;
 Sun, 30 Oct 2016 10:03:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.48.20 with HTTP; Sun, 30 Oct 2016 10:03:10 -0700 (PDT)
From:   ryenus <ryenus@gmail.com>
Date:   Mon, 31 Oct 2016 01:03:10 +0800
Message-ID: <CAKkAvazX1gDzwhQLTbRvxc84sjz72ONy2-P7qWijQUnQqJ+K8g@mail.gmail.com>
Subject: [git rebase -i] show time and author besides commit hash and message?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would help especially when the commit message was written badly.

Or it might be possible to customize just like "git log --format"?

Thanks
