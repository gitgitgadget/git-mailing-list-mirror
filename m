Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F1C77B7A
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 02:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjFLCpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 22:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFLCp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 22:45:27 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFA919D
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 19:45:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77b00bb3fd6so30254439f.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 19:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686537925; x=1689129925;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ffdK5l0P9r+t65S1MkTFaNFQ0y+FzDGdpxE0a8a9kRw=;
        b=mXg/10wD4fc0otQZ39FZklYUPY6Zd0aslaMT5Svg2MLi6qa3P3IIzbcFlyrVCRcjFH
         mQgp5ZiCMyeFLx6j23uT6g0VEr4uM/6W/z4dBQF9v8snvVOouGFPvAqOXkd39IrKMLhU
         HTk4UE9aSK5ApcsZ23mIIQjdFbp5wMcuv418KqOlkLHbUDPCywG4N1E04kidRFUqkaJY
         J4d+eFTOh0YZ0UAHMOQSf3hBgZpPC4XhuxFBQatKCzAUBMtWGK+nkiK+iBjqf7Sqxu7D
         sA47uYXnP0mlBp8pgReRepIeyAZ7ff7E3itAtkJuAQ+iWsCkY9yjwn8ZaYS29t5m9s+b
         bSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686537925; x=1689129925;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffdK5l0P9r+t65S1MkTFaNFQ0y+FzDGdpxE0a8a9kRw=;
        b=ctNcQaQJRcfMIlJD+VNa1Q3JoMuZ5A5rbmAfu7/z8X3afqbbS6BnrfVHVqWH3mY1ps
         8dGQL05GiT/XyChJEtkyyHbHrQKWOBuQ5PaI5aOALgpeGXBl42wraulzH7IXkUSRmmKR
         5JIx2tKLTR3a+1i1Jn3uXokPuTwm2kpE54LkaH8rWLz2POQYwi+rb4rWnwL2Th+UXwOO
         KPMM94xPNlKSZ6Z8+cCKwVzQ8CXVDNlBKKwiXXM37U3sop1FZmObgQcyF+YkbjdxDvSQ
         LNYuWMcxCTYnWuFN3+cW5Sca2ZfaW08Dv+WS9nrLxQzivXAGcSGQFJw7+fnjNzcuAwAD
         XQDQ==
X-Gm-Message-State: AC+VfDz3Kpy2krO1o9PqKW3l/YZBA0e1xgIw3qnN+EHmVCSPcpCbzyU/
        2ZjPNiRqexU3MyxyuE1EgvnVR2s1lzmSF7IKfECyseg+UoI9
X-Google-Smtp-Source: ACHHUZ7woPKQg9ex/YbGPVfN6zZ6BSwtWby/4NSXkwM2XaGiKXxuk68rMwm12nVAbTV+LWvvPmSSzH37siYZLucQqBk=
X-Received: by 2002:a92:c686:0:b0:334:de38:d600 with SMTP id
 o6-20020a92c686000000b00334de38d600mr6034933ilg.3.1686537925499; Sun, 11 Jun
 2023 19:45:25 -0700 (PDT)
MIME-Version: 1.0
From:   Hazem Alrawi <hazemalrawi7@gmail.com>
Date:   Mon, 12 Jun 2023 05:45:13 +0300
Message-ID: <CAJf_aa3Xz7t31bzWbvcAkNW=K7Qga_awLuiipE6MSe7Bgv5_Zw@mail.gmail.com>
Subject: Newcomer
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  Hello,
My Name is Hazem Alrawi, CS student
I want to deep dive into git codebase and begin contributing to open
source but I encountered some problems and I have no idea how to solve
them, so can you please guide me to fully understand what's going on?
here is my prior background
-C++
-Data structures
-Algorithms
-OOP
I used to solve Problems on different platforms like Codeforces and leetcode
Codeforces Handle:HazemRawi
LeetCode Username:HazemRawi
I've solved more than 1500 problem on different algorithms and DS (You
will find them listed on leetcode account)
What is the prerequisite I have to learn in order to start fixing bugs
and begin contributing to open source projects like git?
