Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1143F20248
	for <e@80x24.org>; Wed, 27 Mar 2019 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfC0Xct (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 19:32:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34891 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0Xcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 19:32:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so10450416pfe.2
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0WqBvR8RFDXaI08pUQ5cUFxf7Mnw5mzr8tFbJWh8DLk=;
        b=Y5sfQ42ywv+fEUbIHT3grMJYvmgFquY16y8CBpsjFUka44cFQx8v2na3g6/emPYZsC
         HP4BUoDKmm5p6yWrEqe+C+2zv30WV+1ig7dQZD2tOM8vi6DMH3fP1SUEg4xv9XaqmcNP
         UxF28D0Lf1ZmoDoPq07h+zTu2iOn0KuxenqQsO/WSTOXwl35YUYZJ4UiTyoefMj7hzze
         ku1h+bqrtHgYa/Kdj1lbLB5rKvilBuOhLA+2Q/sCq3eAS7Gr3ehW+BLz8RtSWTPoF+L2
         sZKFS2XPH6giaG8UzIpDfWVOI/E5jFDJRwP5Ndc8Ig7OMUGo1o/kj1ww99eMbgq/TVRZ
         F9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0WqBvR8RFDXaI08pUQ5cUFxf7Mnw5mzr8tFbJWh8DLk=;
        b=TABzJ6qb6PULWo1jMUdAv6+r6uUuMmGhEqxvw89AeapW49vSOHBGDttm9NwYk5/c/G
         3R+wkr0J49msyt0vQUz9Hsve8HlAm3PX5kZMS5vaEKq7S0w+B9P7xQIXjYRmrmlaj1Rf
         NgeyKyYCu8h3OyYfKMgSGVwBBKgKnGKCk9CFBtO5VlyATuJ/XE+I5CpT4nnXCHTSrZda
         v+ld/QqHI/+iEZc9b0U0f0z8VvX/WQ2Jytpgl3KT6D8n1aEd1WVKfM6N/oueCbgvN+w6
         d8Jp+/9Q5a7GFGrCNijRN3F4CV2QX7O0oh61RaKW/IhF+W4U2WOSRa2Y/MMl4cm05BsJ
         q8IQ==
X-Gm-Message-State: APjAAAW0x7NLKJ6mIQyiD4ClWx8fSLFW6LSYKzbREcZSnc8n4cfM3n3T
        rXoVutGjKSVuxwtQsNWwW6c=
X-Google-Smtp-Source: APXvYqzP8TF7kqyIxkqCQCC1uWWd+Im5ZYdEcPsXzY5No9UEQrfLBB6L34YOtKEAt7OV4eExmcSDSQ==
X-Received: by 2002:a62:1318:: with SMTP id b24mr35446515pfj.201.1553729567685;
        Wed, 27 Mar 2019 16:32:47 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id i64sm33414462pfb.112.2019.03.27.16.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 16:32:46 -0700 (PDT)
Date:   Wed, 27 Mar 2019 16:32:45 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Julian Cheng <julian.cheng@utoronto.ca>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GSoC] [t9803]
Message-ID: <20190327233245.GA30401@dev-l>
References: <7BFDFF1D85B3B544BB69BB9AB23D479D01F4534A@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
 <20190327211050.GA4062@dev-l>
 <7BFDFF1D85B3B544BB69BB9AB23D479D01F45370@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
 <20190327225120.GA9277@dev-l>
 <7BFDFF1D85B3B544BB69BB9AB23D479D01F45380@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7BFDFF1D85B3B544BB69BB9AB23D479D01F45380@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 11:01:38PM +0000, Julian Cheng wrote:
> I'm running Ubuntu 16.04. "sudo apt-get upgrade" tell me I'm up to date. I hope it's not just that I'm not running a more recent Ubuntu.

I am running Ubuntu 16.04 currently as well, so that shouldn't be a
problem.

Admittedly, I'm not too familiar with curl or openssl (and Ubuntu for
that matter, I typically use a different distro) but I believe that a
workaround would be to replace your libcurl4-openssl-dev with
libcurl4-gnutls-dev. I believe this should work unless you have a strong
reason against it.

> ________________________________________
> From: Denton Liu [liu.denton@gmail.com]
> Sent: March-27-19 6:51 PM
> To: Julian Cheng
> Cc: git@vger.kernel.org
> Subject: Re: [GSoC] [t9803]
> 
> On Wed, Mar 27, 2019 at 10:04:46PM +0000, Julian Cheng wrote:
> > Denton, thanks for the pointers!
> >
> > I get the following when I run "make" in the top level directory of git and I'm not sure how to deal with it. Any ideas?
> > $ make
> >     LINK git-http-fetch
> > .../lib/libcurl.so: undefined reference to `SSLv2_client_method'
> > collect2: error: ld returned 1 exit status
> > Makefile:2434: recipe for target 'git-http-fetch' failed
> > make: *** [git-http-fetch] Error 1
> 
> What OS and/or distro are you currently running? It looks like you
> either have some out-of-date libraries or you're entirely missing some
> libraries.
> 
> >
> > ________________________________________
> > From: Denton Liu [liu.denton@gmail.com]
> > Sent: March-27-19 5:10 PM
> > To: Julian Cheng
> > Cc: git@vger.kernel.org
> > Subject: Re: [GSoC] [t9803]
> >
> > Hi Julian,
> >
> > On Wed, Mar 27, 2019 at 07:26:12PM +0000, Julian Cheng wrote:
> > > Hello Git Community,
> > >
> > > I’m new here and hoping to get to be a part of GSOC 2019. I have questions about the main project and the microproject
> > >
> > > Main Project Quesctions
> > > I was hoping to work on “git revert --drop” and “git commit --reword”. Are there any mentors available for this project? The ideas page lists mentors for other projects but not this one.
> > >
> > > Also, “git revert --drop” and “git commit --reword” appear not to have been discussed yet in the public inbox. Is this correct or am I just not finding the threads?
> > >
> > >
> > > Microproject Questions (test_path_is_*)
> > > I would like to improve t9803-git-p4-shell-metachars.sh
> > >
> > > On the microprojects page, it suggests I should run the tests to make sure they all pass. But if I’m making changes to the tests, is it really adequate testing just to make sure they all pass?
> > >
> > > To run all tests, I assume I would just navigate to the tests folder in terminal and call “sh *.sh”, but that doesn’t seem to work. Also, when I call “sh  t9803-git-p4-shell-metachars.sh”, I get “error: GIT-BUILD-OPTIONS missing (has Git been built?).” Git is definitely installed on my computer though. I’ve been using it for months. I cloned this repo with Git. What am I missing here?
> >
> > When the tests run, they don't test your installation (the git you're
> > currently using in /usr/bin/git). They test the git you've built in the
> > project directory.
> >
> > First of all, you should build the project. You should run "make" from
> > the top-level directory of git. This will fill the directory with git-*
> > executables. These are the actual binaries that will be tested.
> >
> > Next, go into t/ and run "make" again to run all of the tests. You can
> > also run individual tests by doing something like
> > ./t9803-git-p4-shell-metachars.sh, for example.
> >
> > For even more details on testing, see t/README.
> >
> > Also, some other helpful documentation to read include:
> >
> > * Documentation/SubmittingPatches
> > * Documentation/CodingGuidelines
> >
> > Hope this helps,
> >
> > Denton
> >
> > >
> > > Best,
> > > Julian
