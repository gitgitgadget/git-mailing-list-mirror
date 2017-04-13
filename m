Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74CC220960
	for <e@80x24.org>; Thu, 13 Apr 2017 20:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdDMUek (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 16:34:40 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34033 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdDMUei (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 16:34:38 -0400
Received: by mail-lf0-f47.google.com with SMTP id t144so35054249lff.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nVt/c+KRkJxd9YP44/SmpvmU/0PdBzb4QXa8UEbRXIg=;
        b=TAt71C+DswsR/AMtBb/I3OMH/ttrhj7Ve1aOJFcVhr3eZzofVFlxOafiB4+B4FlOAA
         k7BqnJyngha4i6theQ4hpzoJSp2gzwIdeL4awD0+U8vVNFXS63wCH8EEhtiGnBXBugES
         ryHbuVFSjya5BXaUZSd4rS9+i65JMgLLL0gaJ/UotvSCO9kdTMHdh8fCMhCXGJijfi2W
         GQJBIsYaqy0b094jBBhv6C7+GYSpw3EmW3FWCd2jgsEi975ILsFLpEIhV8rVedbDSMTA
         g0z7fNMMQIg740rwHo9903Fr8CzGo9+Tf9b9Iz/MIvHeT90rZFuRGUjej9tdx/eKwoCc
         imng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nVt/c+KRkJxd9YP44/SmpvmU/0PdBzb4QXa8UEbRXIg=;
        b=kOXRR0X2+MJpeIVBpRB8eGgTYMTeEglVnwEHmD8isUfIAs55Iw9oyiYCy9sSh+ItdY
         1Kn0lEZx5epuI00nbqdnOGTS/03L7wVnUV7b/9gzggngkcMo0CYfm3gfGEXH3eGuXFOI
         gRo7GYPW2lsXEj/JEJ1bo1NGKc2T4vH7Wz4A8jd8Ueisn26im6DXEeixChcNZP/S5fGM
         Xc5HJo1a7bfde+0nUmY3lVv4OVfSxLwhG7oG1HsL/CV8Y9L2k9T/03fTxGW4sVsYpvrl
         MxhlQM8lxENjRDshllM5epXVoNUAvcRtcilaV3z1PVW6p88+6YAmFiNskLh6ONvWJCVg
         3+gg==
X-Gm-Message-State: AN3rC/7pOsDYhr8imt/iRor5OnFVTHdxwiCMDD1kmx/00iLCdRl1ji8N
        dEibr35DnHSugP2v07cby55DdyqWtAtPx2A=
X-Received: by 10.46.74.9 with SMTP id x9mr1521815lja.4.1492115676614; Thu, 13
 Apr 2017 13:34:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.92.6 with HTTP; Thu, 13 Apr 2017 13:34:16 -0700 (PDT)
From:   Jeffrey Manian <jeffrey.manian@gmail.com>
Date:   Thu, 13 Apr 2017 16:34:16 -0400
Message-ID: <CALFtnmeRxgetuCVbO8ZmVkCR302vQ2s4hTPoHxAe5NEfmjtXEg@mail.gmail.com>
Subject: "up-to-date" vs. "up to date"
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git community,

This is about an issue of language style and punctuation, not anything
functional. Apologies in advance if I've brought this to the wrong
place.

There are a bunch of situations in which git will print a message like
"Your branch is up-to-date with 'origin/master'" or "Already
up-to-date."

In many of these cases, including the two examples I just gave, "up to
date" should not be hyphenated --- at least according to most (if not
all) English-language style guides.

Here are a couple posts in support of that, which also explain when it
should and should not be hyphenated:
https://english.stackexchange.com/questions/180611/do-i-keep-myself-up-to-date-or-up-to-date-on-something
http://grammarist.com/usage/up-to-date/

And the Chromium community dealing with the same issue:
https://groups.google.com/a/chromium.org/forum/#!topic/chromium-reviews/edodON6G2oY

I thought about submitting a patch, but I started looking through the
source code and found that "up-to-date" appears 61 times. So before I
get into that I thought I would check with the community to see if
this is something that's already been debated and decided.

Awaiting your thoughts,
Jeff Manian
