Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65829E92FF9
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 08:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjJFIg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJFIg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 04:36:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B783
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 01:36:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9151fc5903so2026273276.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696581416; x=1697186216; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PiyXQISyXlQYMRXPVTnJODfIat22x/DGI/YK7TckhsA=;
        b=BAxNwpZ6XE41fD4zcyVYkUa9YqrEGu4MHWnIFSK9KBd1SkwXDVMchapu6bS2U6gVhq
         FpLeCF2wxODo+mslvP3txyYbWjsNHPD4WlwC76G07lMGWHOpWf70lRC6Rn/WisGwJxzy
         DTqU//pdYEnPDRz0+1C/Wx2vlVZsipn7iZ0EANsE5UGLClkQbiCxaHBo09TmojlIUc5L
         tMEJUSRnWPp6BqBD099WvPnadCI8LG2tSBzfzE+thFXJ1iA3hDYi2u/ZxRBk7WWz+LDJ
         B5S8syWxqrPeBNoH/6w0zg6F4XDI8+tB6NHmxmS16tY3RGZ8L4igvXKwmuLXmL2yX+a8
         s1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696581416; x=1697186216;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiyXQISyXlQYMRXPVTnJODfIat22x/DGI/YK7TckhsA=;
        b=u/lgyP/+Tcq7PBndq/7lH8mmb3lbtkWZBHu0N+Tw0TmqC4do/KdaLH8N0LXOUBYsNM
         rQ6rOV3rlJpa/95Ygl9fP1Q7I3N9C7LdTCEJprNa3o3BtZtorn6qt8OZw5SLjQEu5d15
         OFOo6fzu8ORjdaCiO83GcYUNyzoxW1BgiO0AYNRFMoWdfrEIcuNy1jsBU6bxbhG4JM3t
         tBTC5Od8mZOnwp7yp06KCHS+Ids1Du/2Xo5uePzMxeJMALBUBVSRzo+7MGprpwxG8EGj
         EDdkWRX/GoZklliOofGXxAqmoFwvRj0Pk9xuLK6//XvSdNAdPT7ajDw1USZG+Kgqm5ys
         R6Rw==
X-Gm-Message-State: AOJu0YyKnX4U9FriKmNAlL730T7rycblD9FklcucilUekxN+/cHohO5h
        byMxGEVPpjAAuxcZC6jbVdmcpxU7c/UFrsPefYZzJsHKB3Bedtg=
X-Google-Smtp-Source: AGHT+IEGWYycDkPwg7DqeWitmPmqPoI9AmelT55R5RgWP8OeEE9gYI8dn4H73qEjvH9SBZbJU45Z6NABGv1eSWMxDPw=
X-Received: by 2002:a25:eb04:0:b0:d89:47d6:b4f9 with SMTP id
 d4-20020a25eb04000000b00d8947d6b4f9mr6639608ybs.23.1696581416265; Fri, 06 Oct
 2023 01:36:56 -0700 (PDT)
MIME-Version: 1.0
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Fri, 6 Oct 2023 09:33:20 +0100
Message-ID: <CACS=G2wzmFKih0g2S3P8UHnn+wKog4sJFD6Z66iEpptGZ4w83g@mail.gmail.com>
Subject: [OUTREACHY] Links to Microprojects
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes I've checked the available links on Git internship on the
Outreachy dashboard but I could only find a link for the 2021-2022
winter round (https://git.github.io/Outreachy-23-Microprojects/) and
the patches on the mailing list look more advanced and not beginner
friendly too.

This link (https://github.com/gitgitgadget/git/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)
has "good-first-issues" from 2019-2022, considering the time when they
were recorded, are we allowed to pick an issue from there?
