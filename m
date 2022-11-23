Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CCFC433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 17:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiKWRRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiKWRRV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 12:17:21 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F4D2C645
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 09:17:16 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h2so8128359ile.11
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qcqRf65n6S5lZYWWExChmPvzRLOUPKRtwpt+jr824wc=;
        b=Q07EEuxtv7+BHTl/IaqfcaTBAvSTzSiBcFfR7opsXUwcFar+s2TiBrwZM0keN33DFP
         O/M2ndQMDiTkelHouENnvAgWDiIs5EJzeY5G79TlsjdvsRo2/Z+Vts/nAHzlYIuxhsnZ
         V7IO/b1BC4F3xaN/aLHlZKo8tlnHuKmekk322AZcJESl2sMRnc9PK76cBKONBewk1eVL
         jGYAc8eQCVpMTMl6xt3TWFiZlsIGk7ClsjU3a1moxYEgFSsnkiX+OawFKjPBX2sn9SZZ
         or787e3KTjfFDYJ4N+iOVKZw0B6sNLlYxnQq77GbeTbbAj8ib6cmm6Z9fQG2dH/1Ximc
         ZE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcqRf65n6S5lZYWWExChmPvzRLOUPKRtwpt+jr824wc=;
        b=X5yeB0pHpPCZcUzX7Lw8iD3ffMJcyKxrnXPEqI7Xt0pNaBAisA1aEAR+Eb6nngfvIo
         /fsL+da3z5Yzn+pahcY2TZFHPgM6gi5a81E/DKGBMN+iu3Q9R5FzMah5DDEzlygFk8/p
         Z0hftMy2ccXGsR9OUU0CE2bGLQExO7XKcaZtQsZChVLtpz2+Vzu5QFu5Le1xALr0U1tA
         TdkaXMbHOguAwiF0kg6/c5fU+/umB4oO3P3h4+Orqgdh6QsVeE3Vn7iQIifnjvwexePd
         MxlaHcirvI/bhLDTBGfK1sGTGJYSM06QDaThcAPTxHPCFCzz8cii8zaTWgjpzjiAt9Ep
         eRvQ==
X-Gm-Message-State: ANoB5pnlInUqVV+qhcWWfFym/V2hQD6SqtjrEVakrJNRWWlTUJ0u9ZJ4
        gQBExszseNy9OYQ1ElIWxPRa7xeGaKiOXliRnsJKsXHdRLh8pA==
X-Google-Smtp-Source: AA0mqf7KN2JbMgRK9qz2laPQpr28UkqPUHmaYzL4It4zwpe7OzTyT2ofe9e7d9ZK1XHQ2R+XbZGXyhk8wq/WUtmniH0=
X-Received: by 2002:a05:6e02:13cf:b0:302:bfcb:1fa1 with SMTP id
 v15-20020a056e0213cf00b00302bfcb1fa1mr4351658ilj.88.1669223835928; Wed, 23
 Nov 2022 09:17:15 -0800 (PST)
MIME-Version: 1.0
From:   Vasilij Demyanov <qvasic@gmail.com>
Date:   Wed, 23 Nov 2022 19:17:06 +0200
Message-ID: <CACtGy4i7Jv+UyjwKOLsMOQwUO81=o98AA5SNwi+=xUB76ehD_g@mail.gmail.com>
Subject: git download
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everybody!

I have a need to get just one file from a repository, it would be
useful to have a command something like this:

git download repo_url branch_or_commit path/to/file

Or maybe there is something like this, I just haven't found it in the docs?

Best regards,
Vasyl
