Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEA11F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdFEU4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 16:56:31 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35791 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdFEU4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 16:56:30 -0400
Received: by mail-ua0-f181.google.com with SMTP id y4so82975002uay.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oCsSQX2IzGCn+V7Koqxy8xNjwMW+zATuaopkplZGL5I=;
        b=CgIgY/RXGrVj8aJ4N0GziYu2Jv4e79Wgh7G5ENwwVQrifwROROdk+b9GTtyKnGyaa5
         vPupzpOvrAicHtL+DCiuDLF1UbHmOK9UwdN1EB6mtzQQMNl5rzdNpPe3+SjBsjCWhIqa
         vcAosb/tIhaudB8uSRFeL4RPuxJQi0AjDXthh/9xpuMznkmBu85pEKneZsesPC7tEk2C
         euPLhWPwLJUi3a3l6HaJsqrNosBUj9SL5poYkjfWP2pfNWfOOkRN+pOWjpaD2EJIQqB6
         X5idWyzyMOW7FSbteDlbOtFZAzBh2C65FXRbsXJ/njCZFGyTvHz4HzQvVdXZ6FtnIRpD
         NP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oCsSQX2IzGCn+V7Koqxy8xNjwMW+zATuaopkplZGL5I=;
        b=M/ckJ3sKg4baNElY4Kg4uqPbgUp/fzV4PfnG4uabiHzkwjW37x0HiDO9Wupmoegl5C
         K5fqAxW9RMJ32P0uMk2uznBAbMW0/z/90w8Bc6BDuWY0t6wPQWtA3rZbQtllj+Swzleb
         e53mms8xAsyccYcC2hniA0QoNPvkFvsBagpWwXk5nFIDt2KZbNRTFbMC6iFOng4z2vxA
         nnHGQyzPvzfnL6aGV5tqWN/buFjxEU8C1XkBdNvYlYk+wXIC2o9T1ZiifRUHt2Ow08C5
         //JCnt/AVNOYTiO9DdyXPyNlAWzoCUIvxOnPllMxDGmvCDvoe5O8DPHB+MkhGq0zYVwg
         F6tA==
X-Gm-Message-State: AODbwcDDziiAavT0sBtv3TK6+rbdGY01dsR4qQkAkSojXliGSj7bAqcO
        iCs3xC/MCG7hghW/QE511M1vWn+zg8ds
X-Received: by 10.176.25.99 with SMTP id u35mr12754612uag.16.1496696189465;
 Mon, 05 Jun 2017 13:56:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.81.205 with HTTP; Mon, 5 Jun 2017 13:56:29 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 6 Jun 2017 02:26:29 +0530
Message-ID: <CAME+mvXACX7DejOKDJ=-qV8Ex9ZdYT4vXYV+7AeesaKYUk1sGw@mail.gmail.com>
Subject: [GSoC] Update: Week 3
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY OF MY PROJECT:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Mentors:
Stefan Beller <sbeller@google.com>
Christian Couder <christian.couder@gmail.com>

UPDATES:

As planned for the third week, most of the time was spent on improving the
conditions of the present patches, which deal with porting the following
submodule subcommands:
1. foreach: After a discussion over the issue of the path variable in
   windows, in this week my mentor, Stefan Beller came up with the
   appropriate solution for the problem after discussing it with Ramsay
   Jones. It is being posted on the mailing list for further discussion on
   including it.[2]
   Also, some changes are suggested to the posted version of ported foreach
   function which needs to be taken care of.[3]

2. status: The subcommand's porting is completed and has been discussed
   with the mentors for the last two week after which, a new version of the
   ported function is posted on the mailing list.[4][5]

3. sync: The subcommand's porting is completed and I am currently discussing
   it with my mentors for improving the ported function.

4. summary: Porting of this subcommand is underway and will be trying to
   finish it in the following week.

PLAN FOR WEEK-4 (6 June 2017 to 12 June 2017):

1. sync: since this ported function is currently under discussion with
   the mentors, firstly I'll be looking forward to improvising it as
   suggested and do the needful changes.

2. ported function on the mailing list: currently the ported functions
   foreach and status are on the mailing list, under discussion.
   I will be updating the patches on the list and improvising
   them as required for eventually getting these merged.

3. summary and deinit: I will resume porting submodule subcommands
   from shell to C, firstly git-submodule summary and then git-submodule
   deinit for this week.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/
[2]: https://public-inbox.org/git/20170603003710.5558-1-sbeller@google.com/
[3]: https://public-inbox.org/git/20170602112428.11131-2-pc44800@gmail.com/
[4]: https://public-inbox.org/git/20170605202529.22959-1-pc44800@gmail.com/
[5]: https://public-inbox.org/git/20170605202529.22959-2-pc44800@gmail.com/

Thanks,
Prathamesh Chavan
