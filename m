Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417081FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 16:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbdCGQiy (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 11:38:54 -0500
Received: from mail-ua0-f172.google.com ([209.85.217.172]:36641 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755692AbdCGQi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 11:38:26 -0500
Received: by mail-ua0-f172.google.com with SMTP id 72so11047494uaf.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GWqTx20X6hCrXVIYiasedEW1aK/mtMEpsVXQe7O09N8=;
        b=bKlucTgLX0r+N1Ujbi/XGP3Q+EydlveCMtLYqAPkxYQjcPox9CUzBQfn9yS9D2qPqc
         eMSMlpT/I35eVunJ2nGH0R45py7C0KID9O+gUW8NEAAVTKPoaNpMcmjHHgT8815tlOx0
         UzBTzYVVn7jhdW3l6EvsxLdQ0T95cPI4qXxMU3kufJa7vPuRQYR57aZotsbVgW23KMTF
         B8csUK4saRMCDBLYhsmyCp/dzuFZ+EW7hQpfIEmoLr8a9dMXZXfHsCZlrqcHpWGrXGJK
         noQABg9wrqb5J7tENsYif5o0zRZ4tFmhsS+RUIcFsPpbDg9odDfeQSgugvpkZiPrPCGi
         WQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GWqTx20X6hCrXVIYiasedEW1aK/mtMEpsVXQe7O09N8=;
        b=AlmmJ5JnYy1OOOKo13IGbMueQ3lhjGmcqTlWppDIHQisW/2LjDUHMQbUy+o3HO2X3P
         mi8hN6yLdro7j7CLC7sMEro5Voj2VFRlFNFnaoQBBisPYSg/w7vZBG0aV4NpYRew9/k2
         XeCYJQJ9iKNafK28yDi/E8L1rsqd8rPD5n2C0mHa9EBsye08GPCp1kCutXdl7kjmkhk+
         q6tAeBvRjx2ZfZEb04lkXKoPZI1fWeR3LkmEkJRU965H02x34w+5SXGjJZRlta58snD6
         jd/StzV8UKMn7HoPDXoWpBHUKwrVI8h8z7DecVgbP0JJPp6N7apuLAM+2J+EEWPaUU0b
         dpdQ==
X-Gm-Message-State: AMke39lgb+guoNdIrIt0g+ctB8JAeqHBbkr4a/QzytZc/Rt8rVWwemtNaZ+9KlTARZuvmTzqTbs2UyHVVECA2g==
X-Received: by 10.31.150.134 with SMTP id y128mr598974vkd.102.1488903026704;
 Tue, 07 Mar 2017 08:10:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Tue, 7 Mar 2017 08:10:15 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 7 Mar 2017 21:40:15 +0530
Message-ID: <CAME+mvUe7itzg7JLu9_131smzHHE0JsN-z7q8_dTY1qEdugYWw@mail.gmail.com>
Subject: [PATCH] t*: avoid using pipes
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I'm Prathamesh Chavan. As a part of my micropraoject I have been working on
"Avoid pipes for git related commands in test suites". I tried sending the
patch, but it got blocked since the mail contained more than 100 000
characters.
Hence I'll like to attach the link to my branch 'micro-proj', where I did the
required changes.

https://github.com/pratham-pc/git/tree/micro-proj

Thanks.
