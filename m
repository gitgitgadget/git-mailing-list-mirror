Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8BC81F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 23:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdFEXSY (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 19:18:24 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35785 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdFEXSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 19:18:23 -0400
Received: by mail-pf0-f179.google.com with SMTP id l89so15323197pfi.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=uX+iXe4mp/zWbbDTyr42i+5/zxLTrexKR1AqvfKbNek=;
        b=f/NyAw6zV40XHCF3W/3E5Pt5uFs+ZXf5FfKOxWl7H4PyoTxup3ZCdAIXl0KJwEs0fZ
         9qAsXqp1c8zvLG0SRMJYnwrR4FXV07/SEO5Kz1aC60xviM/en3MsgGO12obcRFiSLTpo
         HeZhQaaSQjJO0YopxUtZntLMd/++xjh1lle2QbdXEQF/mQi7tmUwSC9j4gpUbXZju01c
         1tHjnt8SMfrXumAowQGBzPESca5gRd5nHSSH/vPEiEy04ov47pZ3Ex2EBElIa+dt4JKR
         lR5UOJdFB2MRUG6fxD7CchS86UiGQlRRtfjGANz8qca4XzDWCLhFN8Azlon33eTaKZR4
         Hj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=uX+iXe4mp/zWbbDTyr42i+5/zxLTrexKR1AqvfKbNek=;
        b=qHojHi5RGH40scuF8JoqJnTS0Ylne5Vy0+x3xz/Ny/lZoKnTp40UTNAQOjK5BKUGQA
         kRmT9rPw7AscNKkN++EzcLTRdmHssfKhZT6X8q5EAL3k3jF601dFQDHP0jbKc8DpOKEz
         HwjlSjc6cQ31musJqt9FIbAECFpC95oBLWHCP3xh3f7WC/bdv+4CQsdJBTm1JisP7wJR
         p1z/VUHNL5eVTJ5lrCGaUOQS6WEMOOgE7u7KxspgLUTXLwsMAAzyOTrVOYbqLr3JcUBz
         P0/bb9564f6zUTnGG3js6HriqDHFvhCR7hLq00KtOWGutUqoSax17T9yDcxpxOJ+ZG4j
         6dkA==
X-Gm-Message-State: AODbwcCDE/mqGJpibjsRMoSRuGrvU6kY3IB+1unrwnVfslnZisFlL5At
        +Vw31+7uMbYEJPLqjbcubT4TsnvFQEjD
X-Received: by 10.99.113.14 with SMTP id m14mr7628206pgc.63.1496704702887;
 Mon, 05 Jun 2017 16:18:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 16:18:22 -0700 (PDT)
In-Reply-To: <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
References: <1496671452.4809.2.camel@gmail.com> <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 16:18:22 -0700
Message-ID: <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
Subject: Re: What does this output of git supposed to mean ?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 4:10 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Jun 05, 2017 at 07:34:12PM +0530, Kaartic Sivaraam wrote:
>> Hello all,
>>
>> I noticed a weird output by git when trying to run 'git status' on a
>> newly initialized git repository. It prints the following,
>>
>> > On branch master
>> >
>> > Initial commit
>> >
>> > nothing to commit (create/copy files and use "git add" to track)
>>
>>
>> What's that "Initial commit" supposed to mean?
>
> It just means that it will be the first commit in the repository.  It's
> a helpful reminder that some operations (such as git log) won't work as
> expected.  In addition, many people want to commit certain files (such
> as .gitignore) in their initial commit, and this may jog their memory.

Tangent:

For any personal project (or git repository that I start)
I find myself doing one of the following:
1) I think about implications of the git history. And from what I understand
  there are a couple of issues with the very first commit (e.g.
  interactive rebase needs special flags to start from the 0-th commit)

  In this case I run git commit --allow-empty -m "initial commit"
  first and then proceed doing whatever

2. I do not think about history, so the first commit is a
  git commit -a -m "I made a shiny thing", ignoring any advice
  git gave me...


On the subject: maybe we want to rename initial commit
to root commit? (evil-me also thinks we could name it
"parent-less commit", to reinforce what the lovely git man
page generator tries to point at.)
