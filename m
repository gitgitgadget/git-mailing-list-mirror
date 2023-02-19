Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF1EC05027
	for <git@archiver.kernel.org>; Sun, 19 Feb 2023 20:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjBSUZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 15:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjBSUZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 15:25:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF304EFA7
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 12:25:50 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e9so579162pgw.11
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676838350;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VrQ/b9flG1orWK8r0TfeU5ahC+JPpxgBQRu50TBsDSI=;
        b=AZqv9jD5nqVgaspLNOznHiHuyalQ8M+XpRJVWrSckr8uWMwlSdsfAHjtDI5Z7ACmxU
         yHIjx+MnHNyLChfPRZwL3JdGk7VMJdJX4t3WIRYWxsm7md8tgocZhZh4AkQt2P0ZC97D
         nyVNV3OPjNJPganf6wQ32Bl/mhFtxEoPjR1h3R0aeMtcPDfLuO4M9Q/hTSUSWwL8hNzs
         I/uC4POiRTgRIqrVOQ0sdkm97/uCGB20PlPjKCOQ9+s96orrHoPEau00uEMGTsGoKK66
         DhlTpypEWDopMGylGkRTOmdq9xyncXXF/TX3RxZQK5QZS0gfG9KdlqVw/MV3FlRHbfXf
         c8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676838350;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrQ/b9flG1orWK8r0TfeU5ahC+JPpxgBQRu50TBsDSI=;
        b=YrA8s+bYegEcKquwqfvTTqp2cxvyFdf8dqWOeze/yFu+JzMFMZF8w0IR7mqgGm9+E9
         HHY0Ad8TcFRuFZBVK9Pc9oKQ6tVqY6Gz0dNbx0/koFSYLd65l4ymPg3hzNe5VjxjRy2H
         ke33ntUtgHNiQ0xUeC36uIBfOcLVKARmja11VU5kMhnsm/n+2EC/lnMYJqblHSPbr3Aq
         LJYllwnF4kcA5UnDycrQgUNS5ph6VeUEShvyuoQtSH0/9/Fv20qnFJj0D8Zb5nMEETX0
         DV8DMbLWnK+jdOnMjnceAaf2fe4YqBHpu3B0hc64rkm08haqpc9GMzCWpsDX7cC7/Dxk
         AGIA==
X-Gm-Message-State: AO0yUKU6yInwjLWfQ2fD3m4NDvsTVkfonW5Yt2zRoq7PlNIIGhSp/Bcd
        7km60sc/a4RaByJNYklgtXrVUHc8hd4fDzb5PISkSqGytLgc1A==
X-Google-Smtp-Source: AK7set/1LJQKQfn2aFvmLw0kcGTXd/+DkEIBKhLIOp8D4WVdzwZs//ju33v+6UsIFw2wC0PyRgPktw/2t4l6vLyxNvM=
X-Received: by 2002:a62:d450:0:b0:5a8:acca:d5c5 with SMTP id
 u16-20020a62d450000000b005a8accad5c5mr295413pfl.35.1676838349849; Sun, 19 Feb
 2023 12:25:49 -0800 (PST)
MIME-Version: 1.0
From:   Anushka Saxena <anushka.saxena.iips@gmail.com>
Date:   Mon, 20 Feb 2023 01:56:58 +0530
Message-ID: <CACkQP8tskwh6CcSFRCzyf82eoo9q_aLfSKD=2=jL+hgYH=f3Rg@mail.gmail.com>
Subject: Regarding candidature for Google Summer of Code 2023.
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings team Git!
I am Anushka Saxena. Currently, I am pursuing an integrated Master of
Technology in Information Technology from International Institute of
Professional Studies, Devi Ahilya Vishwavidyalaya, India. I have a
strong interest in open-source technology and the Git versioning
system. I am excited to introduce myself and express my interest in
contributing to Debian as part of the Google Summer of Code program.
I have been using Git & GitHub as the primary version control tools
for all of my projects and have been impressed with its stability,
security, and flexibility. As a student, I am eager to contribute to
this innovative and widely used distribution of Git and learn from
experienced members of the Git community.
However, I am new to the project and would appreciate guidance on how
to contribute effectively. I have reviewed the Git documentation
and familiarized myself with the project's goals and objectives.
I would be grateful if you could provide me with some guidance on how
to get started with contributing to Git. Specifically, I would
appreciate any advice on how to identify good first issues, best
practices for contributing code, and how to collaborate with the
community effectively.
Thank you for considering my request, and I look forward to hearing
from you soon.
Best regards,
Anushka Saxena.
