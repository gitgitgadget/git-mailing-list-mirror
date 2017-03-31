Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72B31FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbdCaNDu (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:03:50 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34068 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933143AbdCaNDA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:03:00 -0400
Received: by mail-lf0-f54.google.com with SMTP id z15so43453631lfd.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=doUEKeS588GAuHyHGonobEK7tJRs2Vcf9JX/S3r1ijc=;
        b=pyAs4ZmquTvU04ucKIs3iMb/5t7byuSKC9bXYw2XelWjmNR3NQ3/cBiPl1EfycKDOq
         xDkIdP+fsaULXbmIPFwSHGP7fMkiciBBiwPDEXn9TybpKaTTVTFzhHuP0RPe9niDCA4R
         olQb1R5RhGcrgTI8WnlW07QZiBpSdy/C9v04phK3FVu4zxp7lAZ7oqTZMfVSB9UDnql8
         Ft217Tg2oOB8rJg2oiRT45XyU5x7ZliupNOyN7AqVAhIwQUukAwnvvUvQFht4/as0+LS
         GjwgESBTtM0A/GAXMxwew8EoazLjPMdc7oGALuyTNzCVrqX2Cxft6uZirWchNmGYpLS+
         O4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=doUEKeS588GAuHyHGonobEK7tJRs2Vcf9JX/S3r1ijc=;
        b=nZc1nreiAUPeR+lXuugaSDjwu9ooaPf/I6keMj11uy6gg5ZOW439GAzD58Jn8zMeWI
         bzklr4DohG8aoK3/Wz9UXbqsiY2CePReyuqVTXrvap7dIDq32jiuwz32nayr8XCHXZ/L
         9ipFR69KurkOHVToJkT6pb913t6SH4e5G6F9kIJjqPVtnPeDY4rUZjCtH8AfTlmGQ8Sx
         MDdBhDvQm5gayaNyUg7eE0bRpUsxn8hfYaDio/ZGEcDZnASMW6sbUxgBU3vA+uDSCQc6
         PgWa4Cwtx+LF104mpSl1CUwxC9wZdKyx6WYZvX1a+8Mq/KIHjYKgGZh9HZa0GFKAlAEJ
         FAwg==
X-Gm-Message-State: AFeK/H0nL+WAMkjtvN0f9Vi0i/NYzcd1Y5Y5bRtreQeZcfRS6CGRMdpRlIGgxadtVfs2iw==
X-Received: by 10.46.21.91 with SMTP id 27mr1119192ljv.13.1490965377689;
        Fri, 31 Mar 2017 06:02:57 -0700 (PDT)
Received: from [192.168.1.26] (ewi85.neoplus.adsl.tpnet.pl. [83.20.232.85])
        by smtp.googlemail.com with ESMTPSA id s5sm922996lja.48.2017.03.31.06.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Mar 2017 06:02:57 -0700 (PDT)
Subject: Re: Git Branching - Best Practices - Large project - long running
 branches
To:     "Mayne, Joe" <JMayne@LSAC.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <4bb4871d8a78402bbef91231134a613b@EX1-PRD.lsac.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d336369a-3b1c-c311-2155-1e08ae669cdb@gmail.com>
Date:   Fri, 31 Mar 2017 15:02:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <4bb4871d8a78402bbef91231134a613b@EX1-PRD.lsac.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 31.03.2017 o 13:55, Mayne, Joe pisze:

> Hello, I work on a team of 15+ developers. We are trying to
> determine best practices for branching because we have had code
> stepped on when a developer has a long running feature branch.
> 
> We have a Development branch. Developers are instructed to create a 
> branch when they begin working on a feature. Sometimes a feature may 
> take a week or two to complete. So a Developer1 creates a branch and 
> works for a week or two. In the meantime, other developers have 
> created feature branches from Development and merged them back into 
> Development.
> 
> At this point we are not certain if Developer1 should:
> 
> * Periodically merge the evolving Origin/Development into their
> Feature branch and when they are done work merge their feature branch
> into Origin/Development.

This is one possible solution.

Another variant of this would be to enable rerere feature (reuse
recorded resolution), and periodically do a trial merge from the
Origin/Development branch to prime the rerere mechanism (discarding
those merges after resolving them).

> 
> OR
> 
> * Stay on their pure feature branch and when they are done merge
> into Origin/Development.
> 
> We have had issues with developers stepping on code when they have 
> long running branches. We are looking for a best practices.

There is yet another solution:

OR

* Periodically _rebase_ pure feature branch on top of current version
of Origin/Development, or do such rebase (perhaps an interactive one
to clean-up feature development steps) before pull request, before
they are to merge feature branch into Origin/Development.

You can also try to use third-party git-imerge tool to help merging
long divergent branches.

HTH,
-- 
Jakub Narębski

