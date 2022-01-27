Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4F3C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 06:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiA0GAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiA0GAT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 01:00:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD1C061714
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 22:00:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 192so1728643pfz.3
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 22:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=uGSdUFlYkIcgEUIPidxA2jWr9j3U6vrdptclr5/SuHA=;
        b=nDuZ8fAWQMvt6+THYmFp23eUOKnfRPiMEphHctUhZa5/K/ZLw/MVM/6lgUbC5Jk6n/
         SZt5ek3jUZ+7VqxaGuz+UVwqFm07xtGSyERDLiTrrgswaX+23IgE13Qb7NZl0lc3qaUe
         rVQeVjLbvQL+HTk0BamZh2Or5sAVYk5yrzEjjnu9j03RiN+qet0sZ5KuvzomPgz6mi78
         ee/6kkChRDhbrN+RkHO4uzC0CvaepI1s3Ise9ojxBML2OWudvnOZTHjVQPptNpQZA3Hn
         ffsjrRh2nfe5KAL2wo8yLIg2GJEk/OT3ud8bk2WxdNDM0t+Ydh/DWShg+dyyF6/XT3gA
         n4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=uGSdUFlYkIcgEUIPidxA2jWr9j3U6vrdptclr5/SuHA=;
        b=y9XG32Sidy1sAAvZYRsgRyR1AFOf85SEA1xm89Vbykrqp5RL5yVV3oWBmJ1nZGMcn8
         UCtRz12bojhhxnn0q/TGdmh1rjSXruZa0iROiaD9DSzRo7YRHBHIe39yVyDNuDTG9gYz
         IMZeAd79jo5H3CuMiEn5gUYD5Pgpb1Yoe5+a4iHccdgb6nEhYh5cjsTpa2kfgwDKSjiK
         T02LMfXFaAPvZHC5u41rtEJ1acHAwWMOZq2aaQjaJ1Btp/zl/RpV8Gf7JhMysPMklkY2
         Ujx9IcE3wJJnrzvY3yVCHSw3KmcDy7oEdW5h0fpNa42gEC4IWoeTiZppCTVfV4NT8oAN
         oG9A==
X-Gm-Message-State: AOAM5325YbRA2m88P7L4XbfV/KRk1cpbsR3/TwzGQdmxGyiedWahBN81
        rWaUqPSIWo6SOusnjbJvmco1qgHo8DPkAPZl+bwTClpQKqI=
X-Google-Smtp-Source: ABdhPJwzGv8pntRulU297wZtFY4TD0wrpwE5EaZ9TVjT1Mu18Paz9tIZKoUTvkLZR8s9V5stXSLH2Cf74QMhGa6d5+o=
X-Received: by 2002:a65:6945:: with SMTP id w5mr1703883pgq.235.1643263218073;
 Wed, 26 Jan 2022 22:00:18 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 27 Jan 2022 01:00:06 -0500
Message-ID: <CAH8yC8kYP2Sth+vUZMzHujKQZC6r1kFf+Lz=6_WRs4GFR65B9g@mail.gmail.com>
Subject: WARNING: terminal is not fully functional
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I needed to install Git on Ubuntu 8. Git seems to work Ok for most
task, but this is unusual:

    $ git diff
    WARNING: terminal is not fully functional
    -  (press RETURN)

Here's the terminal:

    $ echo $TERM
    xterm-256color

It seems like loss of colors on an old platform is not that important.
However, the message being printed creates an actionable item that
needs attention. I think no message would be a better option.

Jeff
