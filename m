Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ADEC4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiKSUUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 15:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSUUT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 15:20:19 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A1DFA4
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 12:20:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id cl5so14331853wrb.9
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wvPRGvpI/kpSuR6TUPE5eVWQmZ4rlwzIW9YuDABQd9Q=;
        b=L8OcK95Z8SkOmKHLK8iVP6S6apJDQsCILb2DDgkb3WHGqz1YXBePa7L57xDMp0epju
         oDQbwy9AIVlevvVUazm8B7RW/TTQjkOjqKAB784q91rNcZkb7RJnihSrECz3NU82hoI4
         p2+9b6j6QmPhp/IO8ZfUdPUSQSnlq/+/nkxFKm+wNq3xvTMCW2yJNS52ZV4U1ofHlRQU
         9VlIKbB751V3w6K1XU/4cAMQ5y8mA3iyoW3+oX+3JLKfyT32pDFl0HhgfP0vXUOGX46/
         S/QUCtDzEgJBtWF7mmai1DbwnH4iNxo3CFhPzNfv9ZUB4inpzpKnalKEs/1y+CqWrHVE
         Uczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvPRGvpI/kpSuR6TUPE5eVWQmZ4rlwzIW9YuDABQd9Q=;
        b=0mumbXoWq0UxFJh01M6qRMAeZz9mu590+uhlNW4Rs79MjbyLgZQvsClhvbBH8zyUGg
         5Wzd4oO79I9lnurpqpq0BKTKZeYBihRKkEk/4q3PxqPuVdQrpu5iMFGtvwrqlIT6tAXb
         8A4dAXH3T2SjjnT+P3p3awYwpArNwYf3clLGMvmoxmmF7cxnX4UCi36jHjIlOaCR/xuI
         P4ity2XjMDDUb623vFzS+uQr7KHpiAXprKULGMn9mfjrnJPH7/hgGfCl6uRcuNOJ1CmL
         LFH/vDdUFOeLdJ0z+ZyfQrpiDNWOF9E8W/yJCNpHz2TKFUutS3/SqnXdTbVLNvdSyUXq
         enyA==
X-Gm-Message-State: ANoB5plV5sBISXJXnaDFtHCAFLLYB4pKwzdooTbe4huhYT31jg43kanI
        fSIooSvoa5FGGKVOt+Ov8n4KHObZaR59x/Lh7/5r9D/btHo=
X-Google-Smtp-Source: AA0mqf7U9i6K9VKdYnI4R+h6SZyuVVS+NY/cYWX0IZI3NCMdhn0G9bz8CzQG7n8I5VN95RpUTHorCGfSPpEx0J566as=
X-Received: by 2002:a05:6000:a12:b0:241:c4d1:41a6 with SMTP id
 co18-20020a0560000a1200b00241c4d141a6mr4184878wrb.324.1668889215898; Sat, 19
 Nov 2022 12:20:15 -0800 (PST)
MIME-Version: 1.0
From:   Jensen Bean <jensen.bean@gmail.com>
Date:   Sat, 19 Nov 2022 13:20:07 -0700
Message-ID: <CANqKdC-qvoDZ9N_+7b+dofNog1-pvLYqRE6xngA3q7ORGmvdEw@mail.gmail.com>
Subject: Bug Report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,



I downloaded Git and Git Bash onto my windows laptop. A few hours
after, I noticed that my CTRL button was not working. I looked online
to see how to fix it. I reinstalled drivers, tried to enable and
disable CTRL shortcuts, turned on the on screen keyboard to see if it
was registering, but nothing has fixed it. The only thing that works
is uninstalling Git, and deleting all files related to it. Once I do
that my CTRL button works again. I can plug in an external keyboard,
but that limits the portability of having a laptop. I tried asking
software developers/engineers, but no one knows. I hope this isn=E2=80=99t =
a
completely unique case, any help would be greatly appreciated!!



Jensen
