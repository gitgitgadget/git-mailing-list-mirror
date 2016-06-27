Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186E82018A
	for <e@80x24.org>; Mon, 27 Jun 2016 20:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbcF0UHs (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 16:07:48 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38302 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbcF0UHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 16:07:47 -0400
Received: by mail-wm0-f41.google.com with SMTP id r201so130356102wme.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 13:07:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jcde9NGhKcPmdYjHVef3WYzxO2M0HlAejT9vw1ZwPBw=;
        b=eEViudZfR4/+Ia3M8yKw+w05PqKjGO9u3io3V0v0GM12Y9AuTXRzkKJa45iEpaoEUO
         99v0M7t8MwRUsKIVYjrMd9b/avOIuRfWcM0rkeFWXOiuse1brHvACctWOgNqHnF0LJjg
         dlbEVnZz6ocklweJyshzBB9hEp9EosFNYYturNfa+Xci2noV2OrqQExxZZ3TdnhCYMXk
         nwII6gOyliXZeoH78+NzXqXY7Jh4r3ZC4q/JUqrg9/Twad0XHKQPmGsjzbUrivOnjNck
         VUX1S2nzplVlTQlsZeOoMhV9JaqWWKz9dDGYF/0j7vyCry3m2oHSDA5/nDmBDgKPNmQg
         4bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jcde9NGhKcPmdYjHVef3WYzxO2M0HlAejT9vw1ZwPBw=;
        b=T9ZDcsfsM54FVJVLLqLQ/Wkb3zXm44xR1uav3zGqmWl2gVvCwXuyJ7m1TVscvvjMfK
         BAZX0OYsv3FwC6VEvCFpgrQzomm54ugyMpZPcdG8wc7V3T6JG7hStPLXIIH47dUGJBf+
         2kJiZcu/TkdcFCaS9X3BQkGoRONEjcZGlYK2WF+yO5Lm+MpZ9j8l1XAX5oABprrRUjCS
         3TWOusf/3V4r43kHtf7BBEmHNrZQAkhy/F9DHGEpXklze63nzANSK/MjWV6MHGvG2REd
         t1snQxoVnl34MjrETS5lyGYfrzlYjI+ICaKoCc4ACnqNrjfDS3PDeVFFssjo0Lt4bpzv
         8OiQ==
X-Gm-Message-State: ALyK8tLc3yzk7H44AStRMd3Lq6ig9BtE0p5Vf7hmNefbuY6jTRoMdqNjdxaXC0Ga/MemPCExjqNeprXk5HcFmw==
X-Received: by 10.194.109.199 with SMTP id hu7mr2501965wjb.6.1467058065931;
 Mon, 27 Jun 2016 13:07:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.107.170 with HTTP; Mon, 27 Jun 2016 13:07:06 -0700 (PDT)
In-Reply-To: <CAGZ79kYKBxL4xLyySALBv_-gqkss9_iCk-qSc4T7u7fKDMOFWw@mail.gmail.com>
References: <CAOG-3GJdH5q9fdj+7zdEv-UUZMTAnunZu1PRJYjFNV360r6+sQ@mail.gmail.com>
 <CAGZ79kYKBxL4xLyySALBv_-gqkss9_iCk-qSc4T7u7fKDMOFWw@mail.gmail.com>
From:	Bart Bogaerts <bartbogaerts@gmail.com>
Date:	Mon, 27 Jun 2016 23:07:06 +0300
Message-ID: <CAOG-3GJ5arRRixEAjMt00jp3A+ZQQ3bGXa+ZUQrpffJyAOP_4w@mail.gmail.com>
Subject: Re: Git mv -- submodule -- recursive
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I tested this on git version 2.9 and it still fails (exactly the same
behaviour as on the stackoverflow post; also the workarounded I posted
there still works).
Some output showing the bug follows below:


bartb@EB-Latitude-E5450 ~/Documents/papers $ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
bartb@EB-Latitude-E5450 ~/Documents/papers $ git --version
git version 2.9.0
bartb@EB-Latitude-E5450 ~/Documents/papers $ git mv fo-c-revisited/ 2016
bartb@EB-Latitude-E5450 ~/Documents/papers $ git status
fatal: Not a git repository:
idp-latex/../../.git/modules/fo-c-revisited/modules/idp-latex
fatal: 'git status --porcelain' failed in submodule 2016/fo-c-revisited
bartb@EB-Latitude-E5450 ~/Documents/papers $ rm
2016/fo-c-revisited/idp-latex/.git
bartb@EB-Latitude-E5450 ~/Documents/papers $ git submodule update
bartb@EB-Latitude-E5450 ~/Documents/papers $ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

modified:   .gitmodules
renamed:    fo-c-revisited -> 2016/fo-c-revisited

bartb@EB-Latitude-E5450 ~/Documents/papers $

2016-06-27 19:57 GMT+03:00 Stefan Beller <sbeller@google.com>:
> On Sun, Jun 26, 2016 at 11:01 PM, Bart Bogaerts <bartbogaerts@gmail.com> wrote:
>> With a repo structured as follows
>>
>> main-files
>> |- submod
>>     |- subsubmodule
>>
>> git mv submod newlocation
>>
>> does not do what it is supposed to do. It actually breaks the git repository.
>> It can be fixed easily.
>> A complete description of the bug, including a workaround, can be found on
>> http://stackoverflow.com/q/32782382/2274140
>
> Which version of Git are you using?
> I think this is fixed in a127331cd81233 (mv: allow moving nested
> submodules, 2016-04-19), which is first included in v2.8.3
> (or v2.9 and later).
>
> Thanks,
> Stefan
>
>>
>> --
>> Bart Bogaerts
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Bart Bogaerts
