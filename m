Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8D4208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 18:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755523AbdIGSNa (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 14:13:30 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:43067 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdIGSN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 14:13:29 -0400
Received: by mail-wm0-f43.google.com with SMTP id f145so801387wme.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=n8D1Xrc9yrPH27Y7eocldNk/4eSxaOPQKPUzsRRlNak=;
        b=iJAouoRgDhX7rQfNkrFJN8XkjkUqF1uUzMTWQOu9mwBl/6uifRFptDQ/50DnTY48M5
         SffFEffuCw8iIHPaWxKhG5EtNiQOmD1QdiofgAU3pTcHWPlDT0INVIvzGUvnKN7DhN1O
         tdeXDO3LLWthbbxpUXYcN8nyKqJ598h8FY0vtOl0Pq5JpuZ3edKiatg1TQzLIxlertSG
         hbkl0BhSIUWueej4crdve1jsY9LS6Fky4Uj2bmCKszzloALEBsqegVMbGx8WUOzbtz+B
         s0izxrX4J4sWCOvNeBe1gLcbvXPdj+Sbasc2rRcKOJ3u90zwr2H5dB9AiioDo8nPSN3G
         /LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n8D1Xrc9yrPH27Y7eocldNk/4eSxaOPQKPUzsRRlNak=;
        b=IEdvH5JQTO0Ju/eg/V0R+8NPn1Cfgvk/4YY8MqjZ5dbPwuif03IgPW6ht8/n9nu9h9
         e3IjkNG/ZAtekAOLLIdd0WVnTs4CAXO5C5tBkyqzJDO10gWqGYzudnkHHDZuV+dGLW3L
         VD1d2A0Y3RU4kCJZAC0mQnEwcEwUPoH2oqPxQcoi9CC78acNiMD3JeOfGtNLB58jrBIJ
         0J/akcLABXeMbvj3kFigKqv89aDYJ8ac4PvFoUhwHV6cv0e2fr44TRcoLjI4Tvl3KD8e
         u3BlwsNUxNNjoBn7UdAsdGmUYk+g9d7SSEVHUeBGwWWUNxv5bD2/pqAY3ZBUclxF6xVY
         CVOw==
X-Gm-Message-State: AHPjjUibTYZXQOFBhZJBVGttoiGD6NXW+Sldx6QAKyAhLWduCyhcHO6y
        f5yf8vFTDUAyYobmL5XmOgWemCchd/wd
X-Google-Smtp-Source: AOwi7QCkl1ZyMRsnf/yf4Z4WKkBFUIDSml5htFndkKVwfR7zEnYGCbwwFG2eqhODSJmx0oMkmezy9eWMIiTqAGcHrns=
X-Received: by 10.28.210.3 with SMTP id j3mr103261wmg.15.1504808007974; Thu,
 07 Sep 2017 11:13:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.10.197 with HTTP; Thu, 7 Sep 2017 11:13:27 -0700 (PDT)
From:   =?UTF-8?B?0JLQsNC70LXQvdGC0LjQvQ==?= <valiko.ua@gmail.com>
Date:   Thu, 7 Sep 2017 21:13:27 +0300
Message-ID: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
Subject: "git shortlog -sn --follow -- <path>" counts all commits to entire repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'll be short as shortlog :)

"git shortlog -sn -- <path>"
counts all commits to the specified path, as expected.

"git shortlog -sn --follow -- <path>"
counts all commits to the entire repo, which looks like a bug.

"--follow" switch is not listed on
https://git-scm.com/docs/git-shortlog so maybe it's not supported. In
this case I would expect error message.

Tried the following versions:
"git version 2.14.1.windows.1" on Windows 7
"git version 2.7.4" on Ubuntu 16.04

Thanks,
Valentine
