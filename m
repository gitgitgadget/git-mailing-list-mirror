Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5543F1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 01:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeFTBto (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 21:49:44 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:44061 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeFTBtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 21:49:43 -0400
Received: by mail-pl0-f49.google.com with SMTP id z9-v6so819555plk.11
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 18:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rmckkDUMo1Sm31HJPL2JOenmHCozzG8Whyv3X7U+Oi8=;
        b=dStxlpEUo5q3F6F+2EMEWv9zqXwLp5Ilc8OHlRiOSY2xAloItXgn/bm8HFNZNAO7rq
         2/f7u9l0W3AkW6fUEvVaw62/IZLhlCDtR1jYO/hDAy1kEVU/rHEPDg6vtbsbe7vJS3H5
         yT7I3xyKmfNhVFmhLNVYd8z8ZS8VCnEfXG5wO/2jNVhyWhFDO9XHT8KsfhH1y6P4jp9w
         cLcbHAnJ1nC0xnUYbFCPme5C3WTwokszdN3l6wz/e/5ZBJJabNpvsVuyPeay+t8zqbzy
         Ljhh56QnaNAW1Rmq2AnSGw/mlvboXcpI+9gP7qm1+S4s0StF5eDdDZEakYjF0dDWeoef
         VLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmckkDUMo1Sm31HJPL2JOenmHCozzG8Whyv3X7U+Oi8=;
        b=FFMauiRZgg4Dj/zI0BQwJHK1ZUoVWVyGfZQS1DeU6gVa0yaDERqa9YC785GHaspP/0
         5R+vBjO84/VCa1ezHVh66bxofrSv1m61qhhiJO6PDIrv4kROsJMpDlYH/V/a9Yw6sIW3
         2Mx/+ROuuhSjUKASSZNkCN34T16t1HBV9JAKo/zeoAj7ddpJSzPgOb6DKxU3/Y/h8yeG
         s2rnuXaeliVuySjpIx/j5Wu3JYfGmWm6/DVMoj9+NLZqTJQrIsDk6uYfdzXqrMfHqoUk
         TTEHpmLUE3rKdFgUTbOLFW5JWIofejT5X6Qv0hb9rghqrcfnIpZf1XLITQw/Q5KzOALw
         AY+g==
X-Gm-Message-State: APt69E1pTsx7Pv9D/iSvP3K5GIGK0MrkmCkjvyvUaSiO058bIqlVHvjX
        DndWXA6bDB8XLl8raC0SJKRquPPn
X-Google-Smtp-Source: ADUXVKLneLlp5AAPL7rZHqq9vnylRwbTTYioz9eexQO98QCoZvS2/z0/IpZLRSV9f+YSb8lnlha0qQ==
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr21473240plx.318.1529459382445;
        Tue, 19 Jun 2018 18:49:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g8-v6sm813071pgq.69.2018.06.19.18.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 18:49:41 -0700 (PDT)
Date:   Tue, 19 Jun 2018 18:49:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
Subject: Re: want <reason> option to git-rebase
Message-ID: <20180620014940.GD122284@aiede.svl.corp.google.com>
References: <23335.52730.475955.861241@chiark.greenend.org.uk>
 <20180619010655.GA173168@aiede.svl.corp.google.com>
 <c5fc1505-9847-25d8-02f3-c0e666afdd1d@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5fc1505-9847-25d8-02f3-c0e666afdd1d@kdbg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 19.06.2018 um 03:06 schrieb Jonathan Nieder:
>> Ian Jackson wrote[1]:

>>> git-rebase leaves entries like this in the reflog:
>>>
>>>    c15f4d5391 HEAD@{33}: rebase: checkout c15f4d5391ff07a718431aca68a73e672fe8870e
>>>
>>> It would be nice if there were an option to control this message.
>>> Particularly, when another tool invokes git-rebase,
[...]
>>  From git(1):
>>
>>   GIT_REFLOG_ACTION
>> 	When a ref is updated, reflog entries are created to keep
>> 	track of the reason why the ref was updated (which is
>> 	typically the name of the high-level command that updated the
>> 	ref), in addition to the old and new values of the ref. A
>> 	scripted Porcelain command can use set_reflog_action helper
>> 	function in git-sh-setup to set its name to this variable when
>> 	it is invoked as the top level command by the end user, to be
>> 	recorded in the body of the reflog.
>>
>> "git rebase" sets this itself, so it doesn't solve your problem.
>
> If it does so unconditionally, then that is a bug. If a script wants to set
> GIT_REFLOG_ACTION, but finds that it is already set, then it must not change
> the value. set_reflog_action in git-sh-setup does the right thing.
>
> So, if there is another script or application around git-rebase, then it
> should just set GIT_REFLOG_ACTION (if it is not already set) and export the
> environment variable to git-rebase.

Oh, good catch.  "git rebase" already generally does the right thing
when GIT_REFLOG_ACTION is set (by only appending to it and never
replacing it).

Ian, does that work well for you?  If so, any ideas where it should go
in the documentation to be more discoverable for next time?

Footnotes:

- git-rebase--interactive.sh has the following snippet:

	case "$orig_reflog_action" in
	''|rebase*)
		GIT_REFLOG_ACTION="rebase -i ($1)"

  This is a little too aggressive, since it's possible for a
  user-specified reflog action to start with "rebase" and
  contain additional information that shouldn't be removed.

- likewise in git-rebase--preserve-merges.sh.

Thanks,
Jonathan
