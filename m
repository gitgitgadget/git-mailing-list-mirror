Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E507F1F859
	for <e@80x24.org>; Sun, 28 Aug 2016 18:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbcH1SYy (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 14:24:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35174 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbcH1SYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 14:24:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so6701574wmg.2
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7ZG10oXWw+Hl31lwIIB6RNoNEiDw2E3n1jqF5tcjyuE=;
        b=A1SSYZEJji4AAm09pBVWyTqx34xRtSbhEd3h7ikVXQNC7TyZZsPUIW/b2V9vi+hSfG
         khPdvL4Oua4EiaK0OSoUGzTPVU8xDzwRoO1DwLEnhEAxXQE3pzkDFE9Kpnb59p1/6aWe
         EbBjSSJQe2DTy3yv8gEGbUvCZw1vmgKWR4JjwCr9MOnbf7Ph+pd4aJrfYI+YePoTpmI7
         42CDgv7NJlfpMrlTTYh/46+YagumS6tf2KymUwfBQGLlDOUQvsifVEMtIE/6f4sjrwXy
         zSQuFr2VL7BkPtZ2ssPZKCg+9daJ14qoVgOqigbRu9xxxmf+uuZlVJhOqifzbWRDCgR1
         mVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7ZG10oXWw+Hl31lwIIB6RNoNEiDw2E3n1jqF5tcjyuE=;
        b=W/YHGr/E71bZEJTQRJpXdfbUgdKEa3hVfZ1D2YwWjlikT7PSMTBZEebSSWS6FD7NO4
         PfMxBd3MZpH9u2J8w+9/nHetBJ7f2N9hpwkiyFya3Yeqq8iplo73RpsSANIkoX5oXjEY
         esOWCO0Vxp/RaABx8ra/OAgt+Sd168yqM2nUpgm940kcsFffosd0LESOv2YgmauvGiiH
         JWalCCmXnWzjhMqst4D470YSA89oOcFGwcEYC8O9ZtzLbKEaJrMlmUqCtbFvo9lCHcYF
         oFS3bdjAOyRxuz6mk/e3UNGtO0jugC05cLldLFe+0pA/feZOaOmVzJ4IJfLMFTnjEL1H
         mj6w==
X-Gm-Message-State: AE9vXwMS7JbSTdjcWydSTGGHm3cVSZfgJiuPogYmeSgqHN6qaaAoEdV8JLaWjyY5R9FNtw==
X-Received: by 10.28.129.137 with SMTP id c131mr6715729wmd.79.1472408647813;
        Sun, 28 Aug 2016 11:24:07 -0700 (PDT)
Received: from [192.168.1.26] (adby156.neoplus.adsl.tpnet.pl. [79.184.24.156])
        by smtp.googlemail.com with ESMTPSA id us9sm30465041wjb.43.2016.08.28.11.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 11:24:06 -0700 (PDT)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox>
 <02c1c636-b0b4-8730-68a6-18f017ed3410@gmail.com>
 <alpine.DEB.2.20.1608251508280.4924@virtualbox>
Cc:     Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <60e7feda-5376-e1f2-1797-9e6dedf3c0b0@gmail.com>
Date:   Sun, 28 Aug 2016 20:23:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608251508280.4924@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 25.08.2016 o 15:21, Johannes Schindelin pisze:
> On Mon, 22 Aug 2016, Jakub Narębski wrote:
>> W dniu 22.08.2016 o 15:18, Johannes Schindelin pisze:
>>
>>> So unfortunately this thread has devolved. Which is sad. Because all I
>>> wanted is to have a change in Git's submission process that would not
>>> exclude *so many* developers. That is really all I care about. Not about
>>> tools. Not about open vs proprietary, or standards.
>>>
>>> I just want developers who are already familiar with Git, and come up with
>>> an improvement to Git itself, to be able to contribute it without having
>>> to pull out their hair in despair.
>>
>> What is lacking in using submitGit tool for those that have problems
>> with sending patches via email?
> 
> Where do I start? And where do I stop? Here is a *very* brief list of
> issues from the top of my head (and the history of my web browser):

Let me reorder those issues and group them into specific categories.
 
> - You cannot open a PR on GitHub and include the PR's cover letter as
>   cover letter: https://github.com/rtyley/submitgit/issues/9
> 
> - you have to register with yet another service to send mails on your
>   behalf. Would be nicer if the mails could be sent from a submitGit
>   address (moderated, of course) and did not need a separate registration
>   step with some scary permission granting.
> 
> - submitGit requires you to go to a separate website to interact with the
>   submitGit web app. Would be so much nicer if it were a bot operating on
>   PRs.

Those are issues about lack of integration (or need for better integration)
with GitHub pull requests.  I don't know if tighter integration would be
possible (without going the route of web browser plugin, like ZenHub) with
current API.  Note that many integrations require you to go and use their
separate site, like e.g. HuBoard.

Also, for some people registering on GitHub is "yet another service"... ;-)

> - You cannot Cc: people explicitly:
>   https://github.com/rtyley/submitgit/issues/31
> 
> - submitGit does not include any interdiff

These are, I think, mainly related to lack of support for series *iteration*,
for sending new version of patch series / of pull request.

I don't know how well GitHub pull requests deal with iteration and
refinement, and what is available as API to apps such as submitGit.

> 
> - it is really hard to get back from mails to the corresponding commits
> 
> - comments sent as replies have no connection to the PR *nor* the commits
>   they refer to (making submitGit basically a pimped up git-send-email,
>   nothing more).

I guess that turning submitGit into two-way bridge between email and PR's
would be quite difficult, if at all possible.  For one, it would have
to parse emails to turn response as email into comment on diff in PR.
For second, I'm not sure if all features of email workflow are possible
to represent in PR's: cover letter, comments for individual commits,
commits about commit messages, commits about changes, free-form comments.
But maybe they are possible; the trouble would be in translating back
and forth.

> - submitGit would require a substantial effort from me to learn how to
>   extend/fix it, to run the web app locally and run its tests. That is a
>   rather steep hurdle.

Well, you cannot extend/fix GitHub at all yourself, isn't it? ;-P

> 
> This is an incomplete list, of course.

Right.

>> Submitting changes in Git comes in three phases:
>>  - submit email with patches
>>  - review and discuss patch
>>  - apply patches from email
> 
> You forgot a really crucial step. Maybe you did not go through dozens of
> iterations in your patch series as I regularly do, or something, so it is
> probably easy for you to forget:
> 
>   - find the commit in question, run rebase -i and patch it as suggested
> 
> This is something that costs me quite some time to do. It is easily the
> most annoying aspect of the mail list-based approach for me.

I probably don't have as many topics in flight, and maybe the number of
iterations is smaller, but I don't remember having troubles with that.

Well, when I was most active doung Git development I were using StGit
patch management interface instead of rebase -i; I think it makes things
easier.  Perhaps git-series could replace it, or augment it.

>> Pull request via GitHub / Bitbucket / GitLab is easier than sending
>> patches via email (pity that GitHub et al. do not have such submitGit-like
>> automation built-in).  But I think email, with threaded view, careful
>> trimming of quoted contents, multi-level quotes is superior to exiting
>> web-based solutions.
> 
> They are not exiting, but I know what you meant.

That was a typo: s/exiting/existing/
 
> The thing is: GitHub does not need such an automation. Because most
> projects are pretty happy with the process centered around the web app.

It might be that they don't need features not available in a web app.
It might be that it is only way they know.  Not all projects are happy
to being on GitHub even if they are happy with using hosted git.

And they were probably created after GitHub / GitLab / Bitbucket were
here. Also - citation needed.

> It is only projects such as Linux, Cygwin and Git itself who refuse to
> allow for tools that would let the majority of potential contributors
> stick with their favorite way to read and write mails (I am talking about
> users of GMail and Outlook, of course).

Those are projects that started before GitHub (for obvious reasons), and
which created a good enough workflow based on email.  It might be that
they are ossified relics, or it might be that they don't want to trade
advantages of email based workflow for advantages of web app based workflow.


First, email clients and Usenet news readers support threading.  I haven't
found a good web app that supports threading well (though it might be
a matter of small set of such apps examined by me).  They allow marking
and labeling posts to return back later.

Second, email allows offline work, and handle well sporadic Internet
connection.  As far as I know web apps do not handle breaks in net
access well, but I might be mistaken.  Hopefully this problem would
vanish with improving broadband... though there always would be places
without constant always-on Internet connection.

Third, email (or rather conventions around email) allows to provide
 - description of the whole series (in cover letter)
 - comments for each commit individually (outside of commit message)
 - make commit or series be a reply to discussion (useful with WIPs)
For reviewer it allows to
 - comment on the whole series in response to cover letter
 - comment on individual commit
 - comment on the commit message
 - comment on the description of commit
 - comment on changes
 - start a discussion based on a commit
 - propose improvements as patches

Are all of them possible in PR's?


To reiterate what I have said elsewhere in this thread: while it is
a good idea to lower barriers to contribution, especially for new classes
of users (like MS Windows users, without a way to easily install and
configure MTA so that git-send-email and/or git-imap-send just works,
or with default email client without support for preserving whitespace
and monospace fonts), it is reviewers and maintainers that are sparse
resource.

Best,
-- 
Jakub Narębski

