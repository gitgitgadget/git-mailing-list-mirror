Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E35E75442
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 10:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjJCKVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjJCKVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 06:21:16 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3ED93
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 03:21:12 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3af6cd01323so456584b6e.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696328471; x=1696933271; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ykbCnsB+tMj2lTWLNrJQC/DeUTQIv/JISgr70MG/m4E=;
        b=mjVXZfWwj8qXKwqRtOP5i84+ERjuerUrKCjpsnhHiAjdmXDAIysDH6Ks39UPZwlrNQ
         GmJ2b8iNI0WqiJ39FoAZUzRt655rTdx13x74fpLumQDRejPCCbCD1Ps83zpQpcmTTWHZ
         k0oJNOgCAnI/i2mIdlodlugOLPNv+rQbvRmlZOo6wAUPs0ZhOjTUFS9UuhLA2EQZ4sWT
         UpX8iG/jOThfVPgqdsu7fA56MVWqmwzziG+Xac1WWoixNZ48y32uoDEUnbdTpsTUnZfc
         lQM+kbpCXIMkuvtDbrfjWU4tLgMlcz8xqITs7AcEDjexjx48b05/Rgp9kaeqUdZRkR+m
         uLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328471; x=1696933271;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykbCnsB+tMj2lTWLNrJQC/DeUTQIv/JISgr70MG/m4E=;
        b=dyey/TSNeuuzhP3IaFuwpWdZSa8g9lZ/qZQRkKUdJgWtvCSH0VNvbjXtqaVGL/yTX+
         MTK1Z6p1IADVUzAbhtArEEWVTx82jK9/F064k5QAESDhiGJ1R7aawhnc4GUK8T82zcHP
         M1S1spNze//FFVh2pEpMgagwVjMWZrGVpfrge9FhIlih/toe8C4IOpKVVJzvOzM3Og+d
         pUfwU23DgHeQpHdzrkNaCJJiBBIhQ9qiJRlhmhqpSlhGVW6GJGESaZarQZz3Oan/Jhib
         cvXLx7JX143vuNZmLezIbZVxxf0M2E7XrhaqBDIzQ/5sAicWMt8DCkKFaGVNOiohgnKK
         XMHA==
X-Gm-Message-State: AOJu0Ywn6rSC/r8yXiuodjHt5HfwscvKftuI5xj53ncgpwIhSt3kFvoq
        mJDvh70FFDIsxb9vi8PeVTaVSlr8SUVMdAbUNkTVOLCUjdBLEA==
X-Google-Smtp-Source: AGHT+IH0XNBh61QMi7KbM4zIDSFB+xdo2Cc7t/3XmSL9OzzmUL8xZbHxdCXzreWzk0vxzU3AB8eflgPsXCj/nueVen0=
X-Received: by 2002:a05:6808:10c8:b0:3af:66e5:5d3c with SMTP id
 s8-20020a05680810c800b003af66e55d3cmr19141248ois.26.1696328471420; Tue, 03
 Oct 2023 03:21:11 -0700 (PDT)
MIME-Version: 1.0
From:   Isoken Ibizugbe <isokenjune@gmail.com>
Date:   Tue, 3 Oct 2023 11:19:47 +0100
Message-ID: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
Subject: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Community,

I hope this email finds you well. My name is Isoken Ibizugbe, and I am
writing to express my strong interest in joining the Git community as
a contributor to the FOSS project. I recently came across the project
description regarding "Moving existing tests to a unit testing
framework" and was particularly intrigued by the opportunity to be
part of this exciting endeavor.

As an aspiring software engineer, I have always admired the incredible
work done by the Git community in developing and maintaining this
widely-used version control system. The project's commitment to
fostering collaboration and innovation aligns perfectly with my values
and aspirations as a developer.

I understand that Christian Couder is the mentor for this project, and
I would be honored to have the opportunity to work under his guidance
and expertise. I would greatly appreciate any advice or direction he
can provide to help me get started on this journey.

I am eager to learn, collaborate with the community, and contribute
meaningfully to this project. Please let me know how I can formally
start my journey as a Git contributor and if there are any specific
guidelines or resources that you recommend for newcomers, as it was a
bit confusing process for me to join this mailing list.

Once again, thank you for your time and for providing an opportunity
for individuals like me to contribute to this remarkable project. I am
enthusiastic about the potential of this project and the journey
ahead.

Best regards,

Isoken
