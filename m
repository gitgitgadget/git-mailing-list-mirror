Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45EC120D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 02:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdFFCGk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 22:06:40 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33463 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdFFCGj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 22:06:39 -0400
Received: by mail-qt0-f171.google.com with SMTP id u12so88975264qth.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 19:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kjSjwQT1JA6RWPUqG3ny4lOCHZ2MuFviYZihv1ntshw=;
        b=s0AOU1hFnk+MmXHtQMExetfXdfArfq3jQYaHcBiRd9a/mPPDsPn0ZfXDq1Yxt9Uoxt
         rMXrIoKW3WwkdEiz1OZC1yYWn53K9VAeuhTaaq6SPcbx7fCRtLEtc5DQCutElbz420xd
         Z9jfx4YwdYWQiGxzoyU1u3wd70muBTt+V1QZsIa2KEduPJSqVK1sJQE3Io3Rs7jfe59V
         JJtx7nEQzkqiZzk9ZcMZUFAS1dwMXShOt3DZ7/pCLh9sQGyboEf6XDRaaHYoDo+dLPjX
         yOUUWZuEiK+hKhNf0UbQ8A5X1spV9DdyJ3MKIlnt0eHFyXuSbWmn0Hv4pp43jnxETiti
         /bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kjSjwQT1JA6RWPUqG3ny4lOCHZ2MuFviYZihv1ntshw=;
        b=tf6yrbVT5StXRw37TmZ8cZMhYzIKMIelmRGa6+1HzXw1Ww9DEVYAX7H46Gxf+0XmD/
         2+L2ZMZyelluVt3fK+lI8dTca8wR9XfZgzElA82NmZobs7kAioLgUnsLMmw6BqiiZhZ4
         mliIQSFX9deW2PzgwNtq3aXWqwWhPvZQtA8nbrgxyIi1KUDxRMr8vDt+KxdxGKQ0ATAx
         dE3Tq/3W1PSvhNItOMQt+F9/Dxt+9iiM7qS6twkWNVwAwpJ4M6nOhrKBOu1LGDKnel6s
         A7bCxTv82uRlpMyT0rhqdIBGeK9Heq6Wwdapvek7ZB6Yqw2L/XHcqTxLxYVR1MZ52gKs
         2GMQ==
X-Gm-Message-State: AODbwcCPgAm0u+9VXbfcWG3xxNpgDEdNeWFkveOy3uz7QoEFtzQlMv+s
        SAymlSyJ5VgfcHlXgTvTYV7d1uhwIw==
X-Received: by 10.237.63.182 with SMTP id s51mr15929540qth.61.1496714798251;
 Mon, 05 Jun 2017 19:06:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.3.44 with HTTP; Mon, 5 Jun 2017 19:06:37 -0700 (PDT)
In-Reply-To: <xmqqvao9991r.fsf@gitster.mtv.corp.google.com>
References: <1496671452.4809.2.camel@gmail.com> <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
 <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
 <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com> <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>
 <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com> <xmqqvao9991r.fsf@gitster.mtv.corp.google.com>
From:   David <bouncingcats@gmail.com>
Date:   Tue, 6 Jun 2017 12:06:37 +1000
Message-ID: <CAMPXz=oorE7MQa4a_1eC-+Huf1Tf2XQFjEBcQxsOdso9BJ1S-A@mail.gmail.com>
Subject: Re: What does this output of git supposed to mean ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 June 2017 at 11:52, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>> For what it's worth, I've never quite understood the "Initial commit"
>> message, because the repository is in a state where there are no
>> commits yet, not when HEAD is pointing to a root commit.
>
> In the context of "status", it probably is more logically correct if
> it said "No commit yet" or something.  This is no longer "is initial
> harder than root?" ;-)

Exactly. I agree with OP, in the context of running 'git status', I find
the string "Initial commit" confusing in the example below, because
at that time no commits exist. This creates confusion what git is
talking about. The 'git log' message is not very friendly either.

Perhaps say something like "Repository is empty." there.

$ mkdir test
$ cd test
$ git init
Initialized empty Git repository in /mnt/hart/home/david_d08/junk/test/.git/
$ git log
fatal: bad default revision 'HEAD'
$ git status
On branch master

Initial commit

nothing to commit (create/copy files and use "git add" to track)
