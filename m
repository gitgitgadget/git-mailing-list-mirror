Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DE7C3524A
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 12:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EF320679
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 12:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSWUMpF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBBM1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 07:27:08 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:40577 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgBBM1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 07:27:07 -0500
Received: by mail-vs1-f41.google.com with SMTP id g23so7199716vsr.7
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 04:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=y+69v6MqLy2AfT64pl+XJW7N9pncoJR8txPv4yTmTEQ=;
        b=bSWUMpF7FvgovqJ5aywggmHeNckNb4EoTbtCS7lnaieaf9uNFJXd/yBQviC6eCI1b7
         STZwPrDHbBIJit6RZ5N/ReL55Y4n0gsMqoT2fdOscinGMj0nJqV0VicYHK+gYot36Z/N
         vBGaX5TGcxebdfIeDD05UonaRw/eFPEdbVsMGfhhEF7AbPiqfsHt4DSbArxBMSSZ1Bf7
         9R94a8RQFFSViUWyWUI9vAfj6dtoHTxL/3h9fB/HbkRm8wLV5S/MQEFHQetBQsQ+iWGR
         bZHFjyJluhl2tX6OFkxm4tDL6hfiqGoqUVlI6SVxoAnZTYZNQTAJQZA0PcWx7jl6IDuG
         gbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=y+69v6MqLy2AfT64pl+XJW7N9pncoJR8txPv4yTmTEQ=;
        b=gTIUxfFqJNKhUa+jlV/g+P3GB687BPN/8UnmqdlyZgyFBgRmLPAKm9EPpdMBVRACdF
         dktbfPdPEjh2KvHV+/lWa9wY4Erx0EVYQ4mXEjIiY56n9Jmmcx9gsNvERnqVGqUycWYt
         DY5axo6wG5EuxO5mpfNAfLZcYSfRo3gi1UPxUkrPyycLHNDGEwvCp++/BT8JpdSlByyz
         uKuecvrnK0Z3KOM/nLaCTIGCEnJCoHM/IUYFrugftw/Tghhe1FgiE8AaErknS8MMMY7K
         MPyKeeZ5KH4ixWTv77Nj7LpN9arKjU5Eq4Jx4roL0wae2pEl6+30yTHAIqPGoiwyoZ0F
         u1AA==
X-Gm-Message-State: APjAAAXzrfvzt8fXfQMb8OBPWH2QNGNmPBJKbJr+yzT3nfYfw/sATSST
        QYVmeEX+4xzgd4XHodByIBoZom51ni6D+h9CRVPk/G7d
X-Google-Smtp-Source: APXvYqw2wDgE1tPZC9VxLcmMX9qmNCgRDShgX5FAFKR8v16uSnIwTslzWqIhA3XCFqYU2IRRc+/Fx7eVJRyjFY3vvqg=
X-Received: by 2002:a67:ebd7:: with SMTP id y23mr11744434vso.127.1580646426316;
 Sun, 02 Feb 2020 04:27:06 -0800 (PST)
MIME-Version: 1.0
From:   Manav Agarwal <dpsman13016@gmail.com>
Date:   Sun, 2 Feb 2020 17:56:55 +0530
Message-ID: <CACbxD0AG_eX4kH3SyY7FWZLcd4FymuOQ6Kii0czHFJ8SPyEdcw@mail.gmail.com>
Subject: Need help to start contributing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there! I am a shell script and Linux kernel programmer and looking
forward to making contributions to Git. May you please help me out
with some getting started links. I would be very thankful to you if
you could help me out with that.

-- 
Regards
Manav Agarwal
