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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7456F1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 13:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJINXv (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 09:23:51 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50458 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfJINXv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 09:23:51 -0400
Received: by mail-wm1-f43.google.com with SMTP id 5so2606788wmg.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l3e3k0wfJjOjl8eoRQD+BIm1NGV5RXvlwXsBJPKWu/I=;
        b=fBedXya+d0ZX9vAxD7J0fQ8QhOblXb1pQX3kp8Nxk8+fSlAGZMFwxqpL1b+KIgQxPy
         wujGJ+mbXmT6mO/6eEd4WogZA7i+km852A/k2SNAmc3jFjna5pVP9I93ZAIHTx6NoBDK
         7KOX169SJlmJKHqO6XvCrIKSj7rHFsWbD9IDfzLfJtV8RaIsf+vcP85NRp5K4ZsFzNgo
         IB01VSbsSqluTlf5jsdhRV8Mqa/NQ1X6A/rXAnJDoYvqKjCeBzEodD/EJ9/2/nOMisBi
         gpe8KM/0hKstcjL8WRDkvDWr6THXCtXn9U4IMdKS0V2/93Tw5aohjLtSaWj6oyTN2QV7
         nGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l3e3k0wfJjOjl8eoRQD+BIm1NGV5RXvlwXsBJPKWu/I=;
        b=GLAG+XJv10sJzRW40Rwg4HzcQyZZxgUcyF/LMFBwdjA+9MNBxt++7eeV6pWccUyQzH
         iM64cOcMobyrRJEnDDLQWOR8WGCnA+Axez/ljoGUOlFCYV+/awMWVwNc+xCSVKZI7/mS
         ijqrhVXc2pe6udB000im8b/quRXKzqlO5wTt6gp/00N6/BlRKWbgRZU/A5YkNI8NsoWt
         XKBoGTRLvnlRJOaHzKOCaTA1K9MoPjywdjze3EgtkmUK0Qov4P5KyUzbqvU5LGoMErP5
         LgcC/yXpjHeLT0MmK3QN7hwv1s2puGI6vnIPomfMtcPTQA3ZtpX7+3b5lfF8G8oXgRk0
         aS1Q==
X-Gm-Message-State: APjAAAWmf1DgQKSHwLMQpXSz6G+EaEqmzk/qFpKOrQYCJurQxi9mbXTj
        WKM980I+RdqVzKmrO1r656lQa8A5
X-Google-Smtp-Source: APXvYqwi0r2L25768XfWe+dYqgaHzk40P+vbt8zqLESCWk6pTEzcYf2PuoAEHCyuSYr4Jm6hRLCKKQ==
X-Received: by 2002:a1c:444:: with SMTP id 65mr2646223wme.73.1570627428861;
        Wed, 09 Oct 2019 06:23:48 -0700 (PDT)
Received: from szeder.dev (x4db349a5.dyn.telefonica.de. [77.179.73.165])
        by smtp.gmail.com with ESMTPSA id r2sm4515064wma.1.2019.10.09.06.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:23:47 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:23:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     git <git@vger.kernel.org>
Subject: Re: I just pulled, and git log --graph does not show all
Message-ID: <20191009132345.GH29845@szeder.dev>
References: <87sgomyows.fsf@mat.ucm.es>
 <20191008230130.GE29845@szeder.dev>
 <871rvmsaxn.fsf@mat.ucm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rvmsaxn.fsf@mat.ucm.es>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 09:13:56AM +0300, Uwe Brauer wrote:
> Could you please try out 
> git clone https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-hg

This repository contains two branches: 'master' and 'strings'.  From
these two 'master' is the default branch, so that is that 'git clone'
will check out for you; note the '*' in front of 'master':

  $ git branch --all
  * master
    remotes/origin/HEAD -> origin/master
    remotes/origin/master
    remotes/origin/strings

> Then you will see
> 
> That 
> git log --graph
> and
> 
> git log --graph --all
> 
> Are giving two different results and I don't understand why the branch
> is not shown when using 
> 
> git log --graph

Without any ref parameter 'git log' shows the history starting at the
currently checked out commit (in this respect it behaves the same way
as 'hg log'), so it only shows the history of 'master'.  'git log
--all' means "show the history of all refs in the repository", so it
shows the history of the remote branch 'strings' as well.

As far as I can tell all Git commands above behave as they should.

> Funny thing is when I use the hg-git plugin and run 
> 
> hg clone https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-hg
> 
> I see this branch, converted to a hg bookmark.

For some reason after cloning that repository with Mercurial and its
hg-git plugin it checks out the 'strings' branch:

  $ hg bookmarks 
     master                    170:6c03da83e522
   * strings                   195:b2396f3ceca3

Consequently, when you run 'hg log' without a branch/bookmark/whatever
parameter it shows the history of the 'strings' branch.

I'm not sure what to think about 'hg clone' checking out a branch
other than the default branch.  In Git this would definitely be a bug.
In Mercurial, I don't know; given my limited experience I don't want
to outright call it a bug.  I think it would be worth reporting it to
the 'hg-git' project.

Anyway, in your first email you asked how you can merge that branch
into 'master'.  The command 'git merge origin/strings' will "merge" it
without actually creating a merge commit, because 'strings' builds
entirely on top of 'master'; this is what Git calls a "fast-forward
merge".  If you do want a merge commit, then run 'git merge --no-ff
origin/strings'.

