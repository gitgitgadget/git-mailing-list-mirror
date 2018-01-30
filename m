Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819BF1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 19:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeA3T5P (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 14:57:15 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38939 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeA3T5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 14:57:14 -0500
Received: by mail-wm0-f49.google.com with SMTP id b21so3534197wme.4
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 11:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dbWc9CVO3Gxo5upph4pN2aKM1YZ5EIJSSOYOcEbsy50=;
        b=o8UmjFkHb7l4sSiyKlIXlu45oVW5J8hXrm2qO+REtfQCWpDnerXB/ByJl5PsrKWGvq
         fma8pRaGad5bRzR2dLEZDEvLcX+iQMPOdwoiNy5d4ckIxP5M4f8FACX8/dvhEF8miTDn
         tYjDPncFTLQ+H7vnmRVHONgorL0QDth58/erIbU9FY6Zb4fZ0nA3bgr/U4uhLYU3Cg2h
         jWwp52JqFMQaZEC4HQh8BlgwKLtuxU4Z28onK6Znba1W2BkqpTobUTKof1rDOYOBUOPb
         11TESDJeZVsS5dI5cySkDYgq649wu+f47K3B17fhfXKHRhYY3XGwWh5N57qz86eLsCgy
         tq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dbWc9CVO3Gxo5upph4pN2aKM1YZ5EIJSSOYOcEbsy50=;
        b=AJf4z2pPoXob4nlDKX2KqhBxzYlwdDVQAgjivEMGRwRAbAkEjylrreVl+HKacUvshQ
         ImHTrGdqvSbEg17QVfb+u7MggET4UHFmDg7GA4hNMbdduXvf0hoHzcvVeuCp5nbgG7YR
         Lg1ly/G11cqdVUUb+opHfkSk45V7WvQbVh9inFy+LZ5rSkV+AX4nBUPQfB27D8hXh3XK
         xc6CfgaR1coecwT8G+25WpRp8snGIV878NOA75m+DZmSJ9oXCT8Q7zNMI8yLr2R9AFJe
         OxSiU13o+vpUIgAlOl5/JnkwWBgUPm2NFqirymLu/JfhZvosci5bbhNY1LZTIdBKbm8D
         Vo9A==
X-Gm-Message-State: AKwxytfCO4mnP9+JpEicJG5Y1LowC3WVAtmrNQyywfjkzwRV9g3XukW/
        SP3jCiJEnHVJZVQQRJGqAgl5mdrA
X-Google-Smtp-Source: AH8x226ZT0UM+by4PtFLuwHV/AwP9F9Ru2DuCgf3P4/SIuQ6WRAMH7BzwFbuvgEJAdbsrOO7+6KTNQ==
X-Received: by 10.28.225.133 with SMTP id y127mr20262743wmg.55.1517342232419;
        Tue, 30 Jan 2018 11:57:12 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id k125sm30435279wmd.48.2018.01.30.11.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 11:57:11 -0800 (PST)
Subject: Re: git stash ; git stash pop unstages all staged changes
To:     =?UTF-8?Q?Martin_H=c3=a4cker?= <mhaecker@schwarz-online.org>
References: <454AAA27-B8D3-47F9-8E49-EC5415A26FCE@schwarz-online.org>
Cc:     git@vger.kernel.org
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <c5a811ac-8cd3-c389-ac6d-29020a648c87@gmail.com>
Date:   Tue, 30 Jan 2018 20:57:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <454AAA27-B8D3-47F9-8E49-EC5415A26FCE@schwarz-online.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marten,

On 30/01/2018 11:05, Martin Häcker wrote:
> 
> I just lost quite some work, because `git stash; git stash pop` 
> doesn’t seem to understand the concept of the index correctly.

I`m afraid it actually seems you`re not fully understanding how `git 
stash pop` works - but the good news is none of your work is lost, as 
long as you have the stash sha1 (or you can find/restore it through 
`git fsck`).

> What git stash does get right is that it does remove everything that 
> is stashed from the current state of the repo, but what it doesn’t 
> get right is restoring that state fatefully in `git stash pop`.

According `git stash pop`[1] documentation, this is as expected, but 
I see the confusing part:

  Remove a single stashed state from the stash list and apply it on top 
  of the current working tree state, i.e., do the inverse operation of 
  `git stash push`. The working directory must match the index.

It clearly says that stash is applied "on top of the current _working 
tree_ state" (so _not_ index), but then it says "i.e., do the inverse 
operation of `git stash push`", which is not exactly true (in regards 
to index handling, no options provided explicitly).

Later below, it notes what to do to restore index as well:

  If the `--index` option is used, then tries to reinstate not only the 
  working tree’s changes, but also the index’s ones. However, this can 
  fail, when you have conflicts (which are stored in the index, where 
  you therefore can no longer apply the changes as they were originally).

> As a user, I would expect that `git stash pop` undoes the change that 
> `git stash` inflicted.

This seems as a fair expectation, especially when documentation 
itself states that `git stash pop` is reverse operation of `git stash 
push`...

As to why `git stash pop` behaves like this, I would leave to someone 
more informed to answer, what I myself managed to dig out so far is that 
it seems `--index` was originally discussed to be a default indeed, 
with `--skip-index` to turn it off if needed, see "[PATCH] Teach 
git-stash to "apply --index""[2] (2007-07-02, Johannes Schindelin) 
(note that `git stash pop` is essentially `git stash apply && git 
stash drop`).

For the reference, here are some similar topics:
 - "[BUG] git stash doesn't use --index as default"[3] (2013-10-11, James)
 - "Asymmetric default behavior of git stash"[4] (2013-08-27, Uwe Storbeck)
 - "Newbie question: Is it possible to undo a stash?"[5] (2008-05-14, Iván V.)

Finally, here`s your demo script, just modified to use `git stash 
pop --index` instead, yielding desired results:

  mkdir test
  cd test
  git init
  touch foo
  git add foo
  git commit -m "initial commit"
  echo "bar" >> foo
  git status
  git add foo
  git status
  echo "baz" >> foo
  git diff
  git status
  git stash
  git status
  git stash pop --index
  git diff


Regards, Buga

[1] https://git-scm.com/docs/git-stash#git-stash-pop--index-q--quietltstashgt
[2] https://public-inbox.org/git/Pine.LNX.4.64.0707021213350.4438@racer.site/T/#u
[3] https://public-inbox.org/git/1381467430.4130.38.camel@freed.purpleidea.com/T/#u
[4] https://public-inbox.org/git/20130827132210.GA14266@ibr.ch/T/#u
[5] https://public-inbox.org/git/509f40850805141256gce6ac1brf5ced6436f81dae8@mail.gmail.com/T/#u
