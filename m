Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A9C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 15:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972C261041
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 15:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhIZPLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 11:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhIZPLl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06662C061575
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 08:10:05 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d207so34307245qkg.0
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2e1FTK6jj7RSaMD8x/0AlDbjgwCZ/o/ItHreKGfBDVQ=;
        b=JxX7ESj/2LpeRlZdtnpjy5EZ1XmCr7Nq3H5zUfHTPSaVI9GRVI5lJWIhvKaAaHztlR
         Ty9m/p11/HLiRIEqqw4lbLygjl0zXdvq0sawk+mnweB70QwASpy39IN6+MXEcaF/cVgS
         k1ywJ50s8aZQT3w5xzIEzvlMBP4oU6b1zRWcCZuak1d6P6wkPhU7GfY8oq3uathLlDf1
         aEdYS9oCofj51FZzgcGppPmIZnGeJOwce0OXEQYFNwhHxiYgn5zwAeSFa4Gy+ULzYbKy
         TvDS6TKPz+JlTsY+Ruo7OjqJ/ong+CBy1+eeOTbN4fypgbP3c+PQtTaa55qwJBIzsWVu
         IUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2e1FTK6jj7RSaMD8x/0AlDbjgwCZ/o/ItHreKGfBDVQ=;
        b=DJcL62km79kiM9mw8wLqZwILw+MPP0Szxm5S3GYSVMKTHmlBncLOjl122PVsXSUnTq
         q9EKxSN7icpZVssZBAVBUMlttC4UdHXow25OIsO5UVWEIEcHl8dxo2k3zpjT54rKE34n
         E7iCTSxDBJZ4fPid33It5QdCWAySJR4ywf2wzw06JxB2lZUgFDRWtqWph789qDFwMkj8
         wQKIfAar3HoB34gbs3B/D9Fz8oavx/HNvJ7b4P6+CG0r1RPSkL1oTFxyqD6APNWYFsVO
         ekjk0xHSqwYPX0tVpY70juOAO3VhtjXyXS7ryPd340ldMxkPuG/XCh+51ZuvodtDji3B
         215Q==
X-Gm-Message-State: AOAM533QnCftD7Jx+Lyd79qNSYlpLYekotqHApS2jzj0kat+j+wO9g4i
        +6zzABJWuV5pZaNCilQ0yoqcL5b80n1n/ynGHcAZTEZk5B7aZg==
X-Google-Smtp-Source: ABdhPJx3W35mYiZBqywzjsPmZ9EALGRVL/IHNxUAm5uB6PDPcu722b7KelJG7pGRPyYJQwkLb5JlRqpO8e1t69dL8QM=
X-Received: by 2002:a37:a095:: with SMTP id j143mr19894889qke.277.1632669004077;
 Sun, 26 Sep 2021 08:10:04 -0700 (PDT)
MIME-Version: 1.0
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Sun, 26 Sep 2021 20:39:54 +0530
Message-ID: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
Subject: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am new to the concept of mailing lists so please bear with me.

I'm a JS developer. I love Git GUI for its minimalism in both size and
layout. I have been using Git and Git GUI on Windows for a long time.
I think the only thing missing from the "Official" Git GUI is dark
mode.

I use dark mode on almost all places. Firefox, Discord, GitHub,
Outlook, Notepad++, VS Code and even Reddit too. The only place that
is missing dark mode in my workflow is Git GUI.

Is there any way I can make Git GUI dark mode ?

I don't know a lot of Tcl/Tk but I am currently trying to learn it. I
did a few edits and made the About page in dark mode.
You can look at it here:
https://user-images.githubusercontent.com/76554862/134190271-d861407a-31be-436d-aac4-9ea3d72f0fb0.png
.

I have found two threads in the mailing list but those are just dead
ends for me. Hence I reached this mailing list.
