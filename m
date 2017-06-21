Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325AA20401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdFUSlm (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:41:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36131 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdFUSll (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:41:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so32327126pfd.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=eTvSH+HBTq/SaIem3JHcLC9cqCCLjPdMBM2BkqS/MW4=;
        b=ukko3GsoIpNc1Kk/xJ6NlZfvJC6DmrWvVVWBOETvB3x6nITZmcHYFdgEOPaplCyLem
         NBPIVS1RbVn2ggagAmG+FPHbGxUmDWdko0vKKn/P1gFU4qP1nP8pWyHUtZC1Gyoaj7eC
         LATNKlYuoWFvBWZFTBQy4T+IT0lwqsjBNVzlq/KZLjKuKoBVHFs2nGsQgjT3/KtBc50+
         fHv95TSB6ZRhY4hvwsdC19RF4lrLTxF8YK6V25PTww1jwBfMHVbSE6a+QK7sGb+ltvCx
         LE3focVJPOTKVSk/t3CKBWuvx0eFHpWzC06Z6mSUpNTeVb8MJEeOEH+Z4XtOe5lWDG+/
         iypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=eTvSH+HBTq/SaIem3JHcLC9cqCCLjPdMBM2BkqS/MW4=;
        b=fz6OAfB5ktQ0JxPKiDjSP1uFKXfd5wO7AJ5JCpj202LKwkg5AaE8rYHOHhXoLZf5v9
         UsaIGrPzs5kfOR5BEEVdZada2NJJuJbMzRRYwtu3ADWXB/nY1jKozIjumo7ZUQJqYJqL
         c9WovSso1WgxjgaKTRWbYeZNgAjmLTwG4KrTHRczZ8XSVzFvYfqLt+KqZU+sXw/lsdTC
         4DVwG3Db4IEPYV0aDzqfhzWFAwWxD/+tWJZmALy8SjavG2+2PPzMK+s84J9HyzHDZRCD
         FQJXtgdnj0t8vpZBmRhob326W5/VzbLZmHpsL9wdU0rO2J8+SqmeYjyZ6QGPEcnq+qtn
         EIaQ==
X-Gm-Message-State: AKS2vOzlchgU4JaN+J/pXEGN34zAf+nr0lfSwuDQyWM/n4bYPx2vIOs3
        sV7qheM2OaMxpVoJ7FcCfw==
X-Received: by 10.99.218.69 with SMTP id l5mr38332268pgj.88.1498070500431;
        Wed, 21 Jun 2017 11:41:40 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id q14sm22505085pgr.11.2017.06.21.11.41.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:41:39 -0700 (PDT)
Message-ID: <1498070489.32360.14.camel@gmail.com>
Subject: Using '--help' for aliases
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Thu, 22 Jun 2017 00:11:29 +0530
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I am yet another user of 'git alias' (who wouldn't ?). It has become so
natural to me to use the aliased version that at some point of time I
tried the following,

> $ git co --help
> `git co' is aliased to `checkout'

That made me wonder. Git is able to inform the user that 'co' is
aliased to 'checkout' but isn't it possible for it to take one step
more to display help ? Just wondering if there were any reason for not
doing it.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
