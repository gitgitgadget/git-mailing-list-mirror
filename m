Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCCB20248
	for <e@80x24.org>; Fri, 15 Mar 2019 21:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCOVXQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 17:23:16 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:39141 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfCOVXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 17:23:16 -0400
Received: by mail-pg1-f172.google.com with SMTP id h8so7292545pgp.6
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wYEq2hlqGnLbbDJ6YOmzoVSx8Py2n1gXuVBxANg6zlI=;
        b=JnqIMdmAwL5R7OniO5x2UWp7iENSf+FPqZBqj9Q6RibbV3+Ja/XleFcw5uqSfx9crf
         ExRmoL2JUaI5vaskGboRTTl0PQp9fnJAKD/P1yoWeTOel7mGPZwLt/z79bpGmca9qEsr
         FN8Nv6QGkaJsm9QMYI/b8VFuHsMXEDUzH9C8SLT5V4asErY/SNgyz4Z+MVDFlXhcVnTA
         sm1kBuuJo+17Wd74jhGh2ejGKCoVMt6CPyPwTeeL6pzq9ExdnbGjvC9hTV3p0OzbDio5
         dSHH8dS9zDUQ0GpoNrP6yNyH99tcbLQC34kF9sow6bod8qwaYQUeh2qlbJhxdaCCbvI3
         z4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wYEq2hlqGnLbbDJ6YOmzoVSx8Py2n1gXuVBxANg6zlI=;
        b=D5vdbNPa53oU6drnn8WlIRVajyUuG6q9bFNO9cCbjNDpcQ4VF1PSPsrBXu3+/ZGLUH
         iVb087XUHl6AiDAI59gGwp6ISLb92jDZHgnCsODblnmhseVmr825121pZfI1EVSGJfvE
         ks2YbtntdUnpuzoTianFpxjaaFHBR2isAUhdFGGHw5rv3VIrG7wAyhqeJMtJsOIaTYdM
         tIExeduyAGS8ChPKy2CYNOeYadYQ0DOt3X+7eq3lRhFMokeyhPke7Ag0+3NedMxkMJxM
         VJ/TI8U9et0UJFreXKu1CldylDXURzv9ufOyk09KIrYKfZXp+0LXvy3j5oXbbHPhvkrP
         uAgA==
X-Gm-Message-State: APjAAAUx/6ELvkRj7rE0iVSfoANyIBcozKYlyBaWXYAhX7mnuMi1DD8T
        UTeLWYiEAaoYgZwRiSOwqXk=
X-Google-Smtp-Source: APXvYqwCrVRYrAnCcYKKZQnZTbwJVbC2oRsy1wUdY3mPkGXAP5dzgzutO7W/JAeuliTYgrjLcwDs4g==
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr6394405plb.258.1552684995031;
        Fri, 15 Mar 2019 14:23:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id z6sm3498363pgp.8.2019.03.15.14.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 14:23:14 -0700 (PDT)
Date:   Fri, 15 Mar 2019 14:23:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Shorthand for "$(git merge-base A B)"
Message-ID: <20190315212312.GA51592@google.com>
References: <CAJdN7KiS+6y0a3sj0yuGuJ+URJe0SBJJTRg2ZpA2upN2rwZXCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJdN7KiS+6y0a3sj0yuGuJ+URJe0SBJJTRg2ZpA2upN2rwZXCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

John Passaro wrote:

> I find myself fairly frequently doing something like "git log $(git
> merge-base A B)..C".

Hm.  Can you tell me more about the workflow / higher-level operation
where you do this?

Curious,
Jonathan
