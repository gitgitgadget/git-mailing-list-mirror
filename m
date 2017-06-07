Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595BC1FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 22:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbdFGWqV (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 18:46:21 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38148 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdFGWqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 18:46:20 -0400
Received: by mail-wm0-f45.google.com with SMTP id n195so20199971wmg.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DaWemgteEvCJ1TzkIE5v9ZgfTEeACzd/kso2Wj/7eUg=;
        b=g6b4ec9zPe7o/RomnxBX6iXtJOuMCYAg1C398PobvyqHSRuin/pWi2/AcAwNdnBJg/
         IsANksbJh5rz38wLLm9RcXiUbo1teB74uAI6fAU0t9BArb6Lj14IyYUbhNgqo5QBBocY
         tPlgxKnmWwVr/4EfKGdfvnud6P1TazLAAACez2gakkszacy0l3WlaFis1k937k7yZssK
         DU33UW/TPIZnQIc50ovejxXXvwlfNjcr4b1iumKNRQlg4PyU1F8jc1gRWtTAbqAUNQn3
         6bYaIs5pBVWuT5k4Tku7h8N8Ya+ZFMe0Wypk9V0aWafL1doWrUCSzMDcNcdCE/YESlua
         Dp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DaWemgteEvCJ1TzkIE5v9ZgfTEeACzd/kso2Wj/7eUg=;
        b=QjKhHGOMy3dTDfxZ5NI3Iji11PxGuwd8LMC7fngMB8di08K4LN73EoQtN1oPfL5ca7
         EbeqGJcdp3K0hCvjTlg39IGML5KAfnvtYXG08zPNalskieTN2uA85YD1t3FIMTjaNQA2
         gV0Hwn2I/klkWAozIhXq0qKJ8qwaRU4S1cakE/t6AXUsn4GAbpKSzaWXJBXzvMrPLne7
         +wfwwJ7B7GAn46Fx0BEeW2iUm/U40xKKXV2qMaLupY3tYniM1S/rO0h6rkzdC36wFYap
         UUQVJTgh9Zfxjbg2EPJCCs4uqgozjTHGOCiJU2ZRbipgqNTGlZ1eiqbPY49RATCmm7eK
         8LgQ==
X-Gm-Message-State: AODbwcB6EeEpb2Qc/D/8nBQ4zuU3JA6BWjRiRZCkRAt9o2pnedLXyz9M
        r9OmTJdQ3kflXifR27DAFeNuk6qG7WaQ
X-Received: by 10.28.46.14 with SMTP id u14mr1320853wmu.82.1496875578957; Wed,
 07 Jun 2017 15:46:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.130.13 with HTTP; Wed, 7 Jun 2017 15:46:18 -0700 (PDT)
From:   Houston Fortney <houstonfortney@gmail.com>
Date:   Wed, 7 Jun 2017 18:46:18 -0400
Message-ID: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
Subject: Feature Request: Show status of the stash in git status command
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I sometimes forget about something that I stashed. It would be nice if
the git status command would just say "There are x entries in the
stash." It can say nothing if there is nothing stashed so it is
usually not adding clutter.
