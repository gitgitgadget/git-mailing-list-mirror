Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C7C433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 08:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B09604D2
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 08:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhJLIt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhJLItz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 04:49:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8532FC06161C
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 01:47:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e3so30915399wrc.11
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=3N/tTQDgjtcVyZyeaND1qEU3nazix7+teRLeMaeKGwM=;
        b=ivxyMHhfWrqJjOdfI95Ncla+aL6UA2Zm967HslrpdxEzOcOP0Au4pfJ2FQked/RYTx
         l0+QTvH6FCzdk2DGHF42kihg49Dk1pF7RZjYO3g+L2ICQ0p6Fks7RaCLRGF7yNQyJPKl
         O8+D867kU8ugtUT99fbXDj52vS688dBtNu61icyNJ9qwuTpCUaTT5nVFBxC5FeB7tlq+
         HCoykasYN16uAI0NSsvizbWd/pgeuhRN+oDkw8NoAbcTU2cYx1bS5+LctxvPXDUKa3gK
         YwK9lrj5bq0uQSnPL68je3xNaD6nMeRdOhzJ+aqUgbYJYujDWxAUZkeOvX6o0Z2tcyBp
         hxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3N/tTQDgjtcVyZyeaND1qEU3nazix7+teRLeMaeKGwM=;
        b=q7mZtdgw0BQC7LbwL4bspNxre9x8nnK7Z3tYLDVeAOqZbjI76Kjz5BoLsVRGpbdf+1
         HXfP2ne8vjXGksCYniesYK59gePvdIoACKSunKuxd6dwytrzL6qmFgYcvBuWUuimuBDN
         +5kBCM1QKthRSHied9XX7SttqSphXoeIQGGOVaaeMz/OsHON4eLWV9a1RD1XIgiHr8ui
         KAC0MPyr47JdW7j47EdZeOLTd0N3k6A0x+f61FmRgh9If/JrlMCGGOix8y+Gu5Cug/pr
         yGasWxqpU7rXWz8EWE+nc6GBFfhQZi81Eop3rEkpcV3MAVUQfnBo2o2QV/2L4QW3FGVk
         wtGg==
X-Gm-Message-State: AOAM530bUfak8L2pkTdbbIIMqmdCfdynwfyYI6DjYKabUaamctuMMN8z
        LbMXy9IZFcSbEMPfm6aUcJ6lYcga0G18hxacAOaziNmecRI=
X-Google-Smtp-Source: ABdhPJw14vAReRC55RqjOMHqJE5WqiMogQhlfpeCA1cnLJHdQZS1REOX14jgNWbAA5p49FxY2Bc3Lf3WosnEMPmB2SQ=
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr3400216wml.104.1634028473107;
 Tue, 12 Oct 2021 01:47:53 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?b23DoXIgc3dlaWTDoW4=?= <omcsesz@gmail.com>
Date:   Tue, 12 Oct 2021 10:47:14 +0200
Message-ID: <CAGHh5RDXPXFa5MSSzoGFW+zA6he7F0h5m-unsH+FG_1-nMwQGg@mail.gmail.com>
Subject: [support/possible bug] Permission denied even with Administrator privileges
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Team!

I'm experiencing an issue when using git from Windows. Sometimes when
doing a rebase, I'm getting the following message:

error: unable to create file (file_name): Permission denied

What is the cause of this? The file is not opened in any other editor.

Thanks in advance, Omar Sweidan
