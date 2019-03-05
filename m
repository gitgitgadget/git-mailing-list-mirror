Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6104820248
	for <e@80x24.org>; Tue,  5 Mar 2019 14:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfCEODq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 09:03:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35604 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCEODq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 09:03:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so2689996wma.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 06:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aX3q95oQxQ8YGXJsEJwJskdgn/R2HkzMK6CIjMcHbRk=;
        b=YsOBStECiXUK50G1CaVJQ+c22ZheHNeX2E97++yFHcci19MXunOxibBP3bQYZodJIo
         jrmr2CTIs5FE+dtfcOPusupnUzB1Gw+YZeo/KJBSIbIXWmjQm+l+uZ+9ymRZ4X6m/K/0
         B+cmiU7gfj6Yzgxya1Ny6SESNikpWA6wo+v51OTuRkyrser+o7SrFiUDoVQmZc1W2njM
         qLd66rLC3LNLaUF4Dnsna1bvGPIXETxVJcOGUP8/GRum94ix688NjR8J+iVKNNOuF1uk
         asQXSz7K8w6tfvSUylxxQJcXlUom9bbqiiPB9z/f+wjr3EkKHy46n78xILDt1cIYCMtS
         q8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aX3q95oQxQ8YGXJsEJwJskdgn/R2HkzMK6CIjMcHbRk=;
        b=CP0KK37PFL2hMMM1d4H7+Qxa4phsz8Eyt/77fxePU1a/UdRTIQp6RXcnXq94gAsfKy
         sv+guZMqhag/xgnkoRH3x38F9jX1ui+dsaYmVwvpDjRkuQrUP29sG1Ydt8AeiqLfSeot
         TI91xGofarBWSJDGE00Yg4vyAR0pvPTI7QlUSVWChwb6gImG/7drt/sjpZBUnQcgfpz9
         MsoD/yugvLDdEnB1gjqwK3k6oK9+U9WFFaiGuTU5pdqjNLqWm/V4qR0hSeUmRZh7iboa
         CDCKmhswQA8qsJU8xlesXefYehCKwPUx9XZQEZqGUNZhkgMu8IHKrZkNhTCn4aN/rBVp
         QJ1Q==
X-Gm-Message-State: APjAAAWSXmOOqEABMyPQSQajN6aVY9RwamsHLQ5stLzHtgF+hZ/eGQ6n
        1J+utd3xelk8zz9ISbRjkpFPZXDzIrg=
X-Google-Smtp-Source: APXvYqyGDWxBjlUQuQYI0yMjqD4XFxabSJHCSYBiWgf2juMCl2MczRgxmRdlhZg/EJVdXsFw9h4jEA==
X-Received: by 2002:a1c:4889:: with SMTP id v131mr2817150wma.146.1551794624222;
        Tue, 05 Mar 2019 06:03:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n129sm10651000wmf.21.2019.03.05.06.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 06:03:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc/rebase: extend examples to show continuing branches
References: <alpine.LFD.2.21.1903050545460.24324@localhost.localdomain>
Date:   Tue, 05 Mar 2019 23:03:43 +0900
In-Reply-To: <alpine.LFD.2.21.1903050545460.24324@localhost.localdomain>
        (Robert P. J. Day's message of "Tue, 5 Mar 2019 05:48:28 -0500 (EST)")
Message-ID: <xmqqr2blto3k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> Currently, all of the examples for "man git-rebase" show rebasing from
> a branch that has had no further development, which might mislead
> readers into thinking that that is a necessary condition for rebasing,
> so tweak the examples to show further development on such a branch to
> clarify that.

We state the status-quo in present tense to start problem
description, so "Currently" is a noise word you can and should omit.

As I already said, at least one example that rebases a branch that
was forked from the midpoint of another branch, so the problem
description is already false.  If we apply this patch, do we lose
all examples that rebase a branch that purely builds on top of the
tip of another branch?  That would also mislead readers into
thinking that you need to advance the base branch before you can
rebase the forked branch ;-).

