Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F3A1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 20:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933759AbeFLUZN (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 16:25:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38933 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933355AbeFLUZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 16:25:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id w7-v6so324274wrn.6
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bIQWb2DETLvWxc2iSwVtHcKDUnpXroDYoQofd/Qo9MA=;
        b=iRJ3vC0oZGbJgLuU0aBl92hBH1gd9BcdQGALbXN2xjXr4/IUs3aXdOgQm0M1e65QR2
         nathrToenFBmQReARGkJfNADvmYKJ/VV7cEGT6eZS1UsdHAoMiVE6V80ymYLmcTEP/Bu
         luEaejGAagc8Cf4P3blFjxBOZJKgCFJrla367vXKRg6KETaJHyviusjscySP6YStElTR
         reiWw8ed0zCD9fMhxcqn7QYbfMZsgrHI9zfRjJdJh9gCxjtiInfVOZQ1jbQkp4ho72cd
         kQAenBFcU4TlQ72nmWnaHxSVCpZHIBQLRdhNB5EITQIO5sAY4I31OdrCnEdiu6PeY3EZ
         UPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bIQWb2DETLvWxc2iSwVtHcKDUnpXroDYoQofd/Qo9MA=;
        b=KA9PtCbtHHY9rTuQmqvSZxYgKV18iep/fyJWNdb8pK0Dgj9YsedXzx6y6qJzswLc9w
         5QVm1DM+17cIeHV9W5NV8pMozb0GVYFjQyhDg2+x3FgqJeK2ZRbfT006RnYVIUltvZMp
         Nm+UWDUQSXkT8wJymoS1HfEuWEZvSxxHt3AS/5JYRQdLMm5S3Clbct3332APCUqPQV+q
         LJJBeFoBqZOZJXB2OOOU9hG4OYWohnx+jFOhN23EnaDS0zrPvYdcbfTeh8lGs+99KOqv
         d1MGgapWkUh3Lr3SIPi+EiXIriwrB5EDdjn0AsMqzHSUrWuFR0qROu0yskEVQHUwqP8P
         SUdg==
X-Gm-Message-State: APt69E2sDbEu0Qa1G43sGpICEa0Ze8iseIF5TZ51G9zGjCKhZr+n6xFT
        4mACNCW0YRXTPBa4NWU+ulyNhw==
X-Google-Smtp-Source: ADUXVKIvQyTpCAosKl1JORLYL/0SkT/DwwqQXfWa5hRcCENEl2wflXwAx05RKhVSLCuuxmGFpMt5FQ==
X-Received: by 2002:adf:ee0e:: with SMTP id y14-v6mr1497154wrn.63.1528835111621;
        Tue, 12 Jun 2018 13:25:11 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1010299wrr.3.2018.06.12.13.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:25:11 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Tue, 12 Jun 2018 22:25:09 +0200
To:     Steve Litt <slitt@troubleshooters.com>
Cc:     git@vger.kernel.org
Subject: Re: How to delete files and directories from git commit history?
Message-ID: <20180612202509.GA25677@esm>
References: <20180612154413.3df64441@mydesk.domain.cxm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612154413.3df64441@mydesk.domain.cxm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 03:44:13PM -0400, Steve Litt wrote:
> git filter-branch --tree-filter 'rm -rf docs/propdir' HEAD
...
> What command do I do to remove all mention of doc/propdir and its
> files from my git history?

Are you sure that you pruned all branches? I would have expected a
command like "git filter-branch ... -- --all" to prune every branch from
the directories.

Greetings,
Eckhard
