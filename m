Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C911FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 09:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCOJvd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 05:51:33 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:40155 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOJvc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 05:51:32 -0400
Received: by mail-pl0-f43.google.com with SMTP id ay1-v6so3427976plb.7
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SwpuFq1z/fDOWvX2dD5kjyD7cOTZkcqxZhQBkvhxlbw=;
        b=g3DQNyx/lM7xmLWo7PIpk+T+mQ8dOHqLckaqRWcJgW5j9MvyFDpZFvW33YybCGmMy3
         O2ySDCsl9iqvPUDWg//BvkpcDSGT87dmOzMd980iJ/73PBWJL2IxA7jMYQkfOhWzgQ30
         J3z1x18Mj2yTNpRgvU8cfNS2sBswJpLcZFehonpKNqfkRYK3p+40xAYlWB4nQIN/7uE3
         4vnYJCW/7XkpIFzON7DnE4RSLVe6g/vi4Qk28cgCLV5lLfM1J/UYhNleC6WscfEBnxRt
         KZG57w5d3wQspA/rHLtjxBm8hlXxJGpXG72uowXcfaRbQxbrBcZiyG9PuElncq/DVlAu
         Yatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SwpuFq1z/fDOWvX2dD5kjyD7cOTZkcqxZhQBkvhxlbw=;
        b=Q5qRJrY4dHIfZXGDrY8eSpcViWEBEHX05JSxN5vCQ5nme8Bx6+AVs7h1nnwdbSceh0
         qIzytx4jNhSh+78m7IbA3RHZRq12tdbCvbROGOeymCzfTt7ixg7yVltGKPYi57Jpv/UU
         tsgO380CBl04PpDjr1ImJf7c6quIELxpnUCgucRbd/2EBn4sYaOJf6w94JXaIl9rJybq
         W8lMfP7dW4PCavTs525PFLkA6V5aDhpox6Kv0+aZdfGIAQEqT5XrvxTfgFoQUriDpXTn
         zUI+fRpye+tTeU6mt9dluGJmZhNq8APK1yLoWbBayszRAYP1sAgNYxmIc5m53qRf+AFf
         /RJg==
X-Gm-Message-State: AElRT7GK+riR/pgoziQAcIulWHhIDSKYk5vs4gijvuUEKQlmzz8wHveY
        dfiNm+9KbX80jfhutzp1FVg=
X-Google-Smtp-Source: AG47ELtXLFLn6NmWoDfxgjF/VJuybLul8AipoxEoP/keGQzTnzEpIv7iOLGyc/Oz11trsEnOHlDk+g==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr7295719pls.267.1521107491760;
        Thu, 15 Mar 2018 02:51:31 -0700 (PDT)
Received: from rem2ua0031cfw.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id q2sm7747021pgp.70.2018.03.15.02.51.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Mar 2018 02:51:30 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to debug a "git merge"?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180314222028.GA20977@sigill.intra.peff.net>
Date:   Thu, 15 Mar 2018 10:51:27 +0100
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1632E897-B434-4ECC-A236-49C03398DF55@gmail.com>
References: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com> <20180314222028.GA20977@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Mar 2018, at 23:20, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Mar 14, 2018 at 05:56:04PM +0100, Lars Schneider wrote:
> 
>> I am investigating a Git merge (a86dd40fe) in which an older version of 
>> a file won over the newer version. I try to understand why this is the 
>> case. I can reproduce the merge with the following commands:
>> $ git checkout -b test a02fa3303
>> $ GIT_MERGE_VERBOSITY=5 git merge --verbose c1b82995c
>> 
>> The merge actually generates a merge conflict but not for my
>> problematic file. The common ancestor of the two parents (merge base) 
>> is b91161554.
>> 
>> The merge graph is not pretty (the committers don't have a clean 
>> branching scheme) but I cannot spot a problem between the merge commit
>> and the common ancestor:
>> $ git log --graph --oneline a86dd40fe
>> 
>> Can you give me a hint how to debug this merge further? How can I 
>> understand why Git picked a certain version of a file in a merge?
> 
> Maybe a stupid question, but: did you make sure that the merge does
> indeed pick the wrong version of the file? The other option is that
> somebody mistakenly did a "checkout --ours" or similar while resolving
> the conflict.

No stupid question at all. That's exactly what they did and I did not
realize it! Thank you!

Next time I won't stumble over this. I wonder if this is a common enough
problem to do something about it? For instance what if `git log` (or just
`git show`) has an option `--verify-merges` or `--reenact-merges` or 
something? This option would perform a "default recursive merge" and 
show the diff between the actual merge and the default merge?

In the most common case there is no diff. If there are merge conflicts
then we would just show the conflicting files. If there is no merge
conflict for a file *but* a difference then we would show it. I think
this would have helped me to realize this kind of problem earlier.

Would that option make sense to you?

Thanks,
Lars
