Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1C21F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 19:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfAPTJP (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 14:09:15 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:36400 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfAPTJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 14:09:15 -0500
Received: by mail-it1-f176.google.com with SMTP id c9so4277789itj.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 11:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2y1h2guN6IHTcxQXZ9OWB6M2f7aCR8HqwWxoYjnn7kI=;
        b=uXjflLWDH+V9SFDMDRgkQ7K/iPeoX2TF7myLWNp5jJc8uSyT8eoS0xbwJhqByKJDZd
         rdrm6Ddm0EJ37W3Q2khG5sA4tOmFJhJg3KEwXR9XMUUDZQ4dh7I3hbMIbJTLZOmwMw8l
         k2PYS49bNN/lakmtCjAOYQCbMSe/qlJlwllhl34anfK/wyRck6zHduAeyPHem5TCOWwP
         XmeNZdiSYMxgA+ZwfZ1BdezP8gADm7m4Ns8hnYs+hIj/8uqLkXiurBWSZFpTHQ1LXVBV
         CkHO84od0WG/ib7bfUwLmHNBUu4KkmYxTdtvpJsP5Zqgs5xMsoxHc1k1DgBu6zUSIVoQ
         2S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2y1h2guN6IHTcxQXZ9OWB6M2f7aCR8HqwWxoYjnn7kI=;
        b=kAWXii59mc5R/WHeYYIOIcZWCzxgrok1LBv17nIFfUZeq/LBev9sa8GDOZlHWUiKss
         1Habu6Ghmsqa8ldhwdxFuTeEuvkSHR+nwyUT80H9EFb3w7Lg+UDR5KXTKUJNeT85pji3
         5pQqIy7C9U1ZBg/ntNOibKIsgyhfzDnhoBPVJhtBJGZI7bUGH9/J/kB7afqtgNk/n24C
         IdKMA9EJDVIfHcOc9iHa6gQ47/jJE0tCcWlDTmv1wuXVUywPsG0eOfcQtKLHrCJ3EJBu
         kQrkTDFwuGq/w0TUFeyf/SH4rU6Fefk3w2/iFPF53iz1dk1q0B7PpTzHuCV5v/oi0sHe
         4i1w==
X-Gm-Message-State: AJcUuke17e2iPgmjl1Wqdwb700GQwh/VzESszhy2/jaoNRYAqRsLoafz
        Bcr/9bGgJzd/qlhDKDobCMTL6m0IJpn9DT+sT/nXqh1g
X-Google-Smtp-Source: ALg8bN4OMVhqx+sO+4g+nSqX25mQv/ARGX5Frz25m5y+vrNCmsKkrd4h6YpIfYsDDBXyjj+HRdRT5nGh4U3v8Pv7Pjw=
X-Received: by 2002:a24:4e0d:: with SMTP id r13mr6105795ita.140.1547665754362;
 Wed, 16 Jan 2019 11:09:14 -0800 (PST)
MIME-Version: 1.0
From:   Cameron Steffen <cam.steffen94@gmail.com>
Date:   Wed, 16 Jan 2019 13:09:03 -0600
Message-ID: <CAAVFnNminTx_z9Y=jhzDnT0n5_zGD_k2SA84HQqMvKHJSvKcSA@mail.gmail.com>
Subject: Stage or discard a hunk at a time?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have this feature idea for git. There should be a command that
effectively combines git add -p and git checkout -p so that I can
navigate changed hunks and either stage or discard them.

There is already a SO question asking about this exactly...
https://stackoverflow.com/questions/11538650/simultaneously-git-add-p-and-git-checkout-p

Has this been discussed before? Is this a reasonable request? If so, I
might look into contributing the change myself.

Cameron
