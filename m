Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D614C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8B861027
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 10:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKNKOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 05:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNKOu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 05:14:50 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F25C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 02:11:56 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id m11so13432385ilh.5
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 02:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=9sLbDstTLmCJ7Mw1kxByiQ1B8IBUVQnMkUbBtJdUCGM=;
        b=H4DRm72Lg1wT7bD/T+cq5lQIAtRCj57zwNGrwC9ASYESDP3NiO/MX+fuc6PvEP3z5E
         Lqne4MMGQZ9rpjHBZ1LUIoQihY8fF56vZKTF+fUVl8TyGLQXqO93cqy328gEUWVL6yFS
         4PFD/HeO4W/4SgNJb799uSNJhhQmP/VBBECRc4S2SrasS4HXmjH/m6B+VAJqTLR98zsC
         o2WSjmGbY8ACqNoaMrOg7L56wiGO6VF+1Uk3RdZqvUilJsBfiP3VG7YFBp24FfJIY4Bs
         Ch9MhmIAFI1O/d1vzqxLDRv3iRgM0I5CKuUY6bXCGKUNPc3Zi8tzsCXNxwLdtS6bjHLW
         9fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9sLbDstTLmCJ7Mw1kxByiQ1B8IBUVQnMkUbBtJdUCGM=;
        b=1aA2/atkTs6b4qHqPtsyH/gG7CBRH5AhneA4OW0CIVyDIGsDgSjxQLqVg6BAce7RGo
         bLi/+mRIl5giRtLKAPBOZUaqadaIWVH6Rkta654t5jiFkG7XI09LVrJJClbzi0Q3/REe
         H3Det4FmtGGBJKm8ZZuRxq9w66nB573Me4M1oya037RUHJL/IVXOvJvNzQAXP2X8gcvV
         W7LGmRn5mbNj6ih9nGXwqWt7JbLvMPyxcVTrmVYGnKwWQar36wWpsXhxmxob45UiysbF
         IwB3Wx3nwpAOhPKyxGG0ed14IJMPciGIKZO3+K3Nr/VrRYfGx6YwoZbGIMLHjDc7j5Mb
         9oGA==
X-Gm-Message-State: AOAM530f/w2Zh4vA+ahpSvn+e7iPEekzdEQhV4ufoH52ABMcrHrsFtb9
        0ksrw/uA3yp2jZ1eOIzawz1XS0A2jhF4Bf2wu/bHHP7KKp8=
X-Google-Smtp-Source: ABdhPJzpYgK7yGgKL3VgX0CVNuDqwCSDsXkGnAl+lzrbBu5wrd0H9OwOJ9MZMHCfUi6W0wopxNCysf4J9K3vO+YEam8=
X-Received: by 2002:a05:6e02:ef3:: with SMTP id j19mr17240068ilk.212.1636884715844;
 Sun, 14 Nov 2021 02:11:55 -0800 (PST)
MIME-Version: 1.0
From:   tqfx su <sutqfx@gmail.com>
Date:   Sun, 14 Nov 2021 18:11:45 +0800
Message-ID: <CAH6-BcyoEy29-NPCqivWTPoqM0e8=Pp1ahrCaZpBko8cSyv-6Q@mail.gmail.com>
Subject: git-subtree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git maintainers,
  Can you add a GPG signature option to git-subtree?
  I do hope you can take the above suggestions into consideration and
thanks in advance.
