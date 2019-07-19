Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E261F461
	for <e@80x24.org>; Fri, 19 Jul 2019 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfGSSlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 14:41:50 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:44123 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfGSSlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 14:41:50 -0400
Received: by mail-io1-f49.google.com with SMTP id s7so60331550iob.11
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=HiWwtATGWab2HZlK4T7TFj0IqiNkA1jG79dljjWB0lI=;
        b=okumSsaFBzHxYRXNa5xjDhvhRyC9m0WyNnG0ONV2tCh2kaPQwCh8ICDRppAvsyXQQX
         kZnuCyvUui8qfRprXokiXTzObpbbpH0zYVUnZVCWfVufE+wDE9UglWltep5OJuhYsM3T
         vOzX53wLHSQQX033UAd1Y5/h2oTWQb7LOJk/nDKmEJ04weEpw+DnEqrYKTzU8ckwVXg7
         0We7ntGvPwZo3NWJQPiYcxvF66bJ3F1fRhOL9elsC2eAirE1M7T+lrNaAvArRRDiTe5Q
         hi4YFAEFUXKRJLLghAMz8SGCfZwfPD3k/qPl3qma0sNdPNzE4jt4n13HbasOk+blkrqu
         IOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=HiWwtATGWab2HZlK4T7TFj0IqiNkA1jG79dljjWB0lI=;
        b=ArF0gr5FNWxWZyB2ncXItCXTz90YsZOHSy1j57kgohjjhNklpP6bJ6CfASrQ8UT6j+
         IaOZ9ATxemWNDeZ21Z+16YcGbKyy0HHRvZgWVaBCKv/t0IHspFKHvSPZ/3PJawYMFywj
         adZsHRcyTkXDv9Tyz1NlMjzIpz95EWSIFaTAbFc3wllHoT8psOFMRN195m3ccJ4A3PIV
         1TD7O7wdL1IeeZ/h88YFpihSCtq/bHl3BykW7aGY4cN3tDSw+dhfcvofLdx9b4137xZj
         yusFuXFW+S+LqNr4dUE2x1A3ivvCB9ImV64K2KyE4EDdT0wk9f3PDcyqUhgxa24Ly9Je
         u1bg==
X-Gm-Message-State: APjAAAXI/7Izbyz+TqDSJdZM/DM2qhz46lRPpmCoB0Z19NeRJKo0X1ux
        9fiUYuIDEn2zFXVRVAgcQ8t/9p3E7CtmxBUC/D2HgtKF
X-Google-Smtp-Source: APXvYqx/ndhF2AdnKGwUqeb4X78m2UjirDS+QR605POm9srNkTacUdWjZ20Qf2A+Xxluq9octYbnfQaESM217E2Civs=
X-Received: by 2002:a05:6602:219a:: with SMTP id b26mr28559296iob.55.1563561709546;
 Fri, 19 Jul 2019 11:41:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 19 Jul 2019 14:41:31 -0400
Message-ID: <CAH8yC8mcgMh=rjASqePeNZSRoWxBHz7+bKpDoK7ojP=DyOgrtA@mail.gmail.com>
Subject: Fedora 1 and Ubuntu 4
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

Just wanted to drop a quick note and let everyone know that Git 2.20.1
builds on both Fedora 1 and Ubuntu 4. I use Fedora 1 and Ubuntu 4 for
regression tests for some other libraries. It is easier to use the old
distros then building old GCC's and glibc's on modern platforms.

Git has some problems with some self tests, but they are few. For
example, 29 self tests fail on Fedora 1. I don't think it is worth
pursuing Python 2.2 or Perl 5.8 problems.

All the basic commands I use, like clone, checkout and pull, work as expected.

Jeff
