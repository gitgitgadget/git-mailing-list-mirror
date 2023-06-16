Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0BCEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 11:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjFPLKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 07:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjFPLKn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 07:10:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FC1AC
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 04:10:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-519f6e1a16cso692843a12.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686913840; x=1689505840;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lIOAZcPpQRLxlAjGgLgXZFojDlquhjw91tApXRsgl8A=;
        b=ohDXH4T7rP+lQJTkCvWHmi36JgSgint2XTrvLaIBI8jE6PoIM2QT2OE/96295WTiPn
         vIIVzc8077OTtJQeAmioztF1b8fnjfswp6VYzC83SD6WVIynvNmZyJnvjJgy4pf8D9bs
         mQv8fTHFA+7TevdW6mWU9LpEiuotMtG2yMlAk2UGX0zK4MoKUcBcI3BlCaZPS0TtIcq3
         eI4l1SGN0EuJ1YntpU6GjfQLZNm6EdXMrnPUbRy8IbLx1qrq5qiUlSh//TLimmXgMV9h
         3Y23sg3d/FF2pgS/qho+MkBTOo1IM+ObpEagF32+/H0Ny7MyP/+rt580tt8SYNQEw+CM
         Nrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686913840; x=1689505840;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIOAZcPpQRLxlAjGgLgXZFojDlquhjw91tApXRsgl8A=;
        b=HN4n/CwMXvoIxQctt1GBix5zThMbwGLjd88W2BX0nkxcSzlB+/kj8LE7iZo+gdMbnJ
         uRXGQzd7QL1mQHO+g8Iy1F1jjBYmeN7sg0P1JKbY0IM+DjA1V+r4T9coy/CRcoz8vD8L
         8KeSd75UdAs4lHYEvhA4sufpTCzg2MOPssibTHI+GqS+k+BtnUlvKCcGMg6FghinbbW/
         jciehpdZtgm2Rv6mKPFKZoncqUYMEFDZyJC2b16ALo/B9OdGcnSncVESOT4Xizg2gf+n
         R9Z0LHUpAOA+GoAOQntAJzGZGTURNXqlnFXLbCijeO/0Lz9MuyLLh6vsGq34wesrNZ9q
         F2rQ==
X-Gm-Message-State: AC+VfDwFGNYVPpFGXeToLfTLmkXznJ+MT0XRIDa7c1EAzMmhbVqZekV4
        tM48vLhioqcUwFU2kKQvDBrrHbn4Ipu36t9yJsKAD7nevv4=
X-Google-Smtp-Source: ACHHUZ76KWuHYpgclavH/H4bEchOUbU0oROv8FeDso4O8a/fakqjZqNIQ5J90Vki4kaxOWFvgbB0ywZQ6SaNBXIsCUk=
X-Received: by 2002:a17:907:60ce:b0:97e:a9db:85f2 with SMTP id
 hv14-20020a17090760ce00b0097ea9db85f2mr1607256ejc.47.1686913840004; Fri, 16
 Jun 2023 04:10:40 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Jun 2023 13:10:27 +0200
Message-ID: <CAP8UFD3ErGRbKSoM+_ExHSqiDe6=HgxCSttvmaMVLcpccZMjhg@mail.gmail.com>
Subject: Reminder about the Git Rev News Reader Survey
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

This is a short reminder about our first Reader Survey
(https://survs.com/survey/jo07oxsaom) to help us improve Git Rev News.

We'd like to have more feedback before the next Git Rev News edition
at the end of this month. You can answer only the questions that you
feel are the most relevant. All the questions are optional.

Thanks in advance for participating in this survey!
Christian, Jakub, Markus and Kaartic.
