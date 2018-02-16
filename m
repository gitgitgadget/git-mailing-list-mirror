Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9731F576
	for <e@80x24.org>; Fri, 16 Feb 2018 11:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965486AbeBPL47 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 06:56:59 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36763 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965036AbeBPL46 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 06:56:58 -0500
Received: by mail-qk0-f177.google.com with SMTP id 15so3425468qkl.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 03:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=w2tAi4Tq9i53F3jvyPUVpdUNDmoMoTAJMvZ9Q0ldERY=;
        b=YLfG1eHWO8WdV2gUc1GjvlG2mvqeHjAwuHpe1Wze//FzdOsRVN8XUg0hW0qpafzFYF
         Cg6tzD8NlhHrpTuY3ThLNggyO3Fsn8BrmXmJFbCLo+viroTx0q1SnpXKngxLQsd35D2M
         sL+rZx4f0xhK5Stl2LINkVA5AGlRPeMwJEaVoyVwZGJ+nRoNKgdqWSw+lgyAmZ3C590R
         d2dEhtXhgKoJGgpKHiECxRpWJXMDOpHZrDtQsoFyy0JZziCZHcCQkaCYA/Q1JKWXYGyr
         4S4sh7gSZc9AYYVX/8yVtsfvNb9dXMCzU2Fnvin7STN2bSgfP57uCw8uRjIrdbMMvzRK
         2xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w2tAi4Tq9i53F3jvyPUVpdUNDmoMoTAJMvZ9Q0ldERY=;
        b=GWOXZnxpatRDOiWir4TIopZM1zBvOfiCdVTXUzwkdzDqQDpKMXUDBUbX6RIsvzRVyl
         pU4fwno2Jgnlqm/UES9lV/ZVzQa3jnc1Yzya4wRV7wbXHlWJ5GmfXlsNgByg6BOgC2Ox
         F5oPiVHzrw9F/PB/PdFV/mYc1P2u5bEFHXq+SKWTaUxG3ZMsDQe/G1kvar6jUayvuieR
         TPN5r0aJmvRKy6zIve1fECkNXlDtbnYhbU49ubjLpKY6X+fiusmqp1S9z4GHU7lM+QP/
         hUVbIvgFv3c58bSwRxaxQdm2vCH8TRkRZ2+eJ6FyEX5XSauk2viunqCFnUWzWYBjyZju
         9QrA==
X-Gm-Message-State: APf1xPDsijXF7VxREIjuaPtHO/nKvGpvOwFfZexkVz+dD/UKWdoMtQwK
        fWJ6tsgm5z9LI0QaZ9I4jVhlg+rnzqRlEeBgou+e9Q==
X-Google-Smtp-Source: AH8x224RWd8Hl2RQTSlsTEYlnJo/X8gKywZypouBKXQQgyEMKPtMcr3SdHMaPb+S6JgjGDXXtATkWnaTARL/zSwn13c=
X-Received: by 10.55.76.17 with SMTP id z17mr9378662qka.145.1518782217705;
 Fri, 16 Feb 2018 03:56:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.194.147 with HTTP; Fri, 16 Feb 2018 03:56:57 -0800 (PST)
From:   Mike Nordell <tamlin.thefirst@gmail.com>
Date:   Fri, 16 Feb 2018 12:56:57 +0100
Message-ID: <CAF9mB_srRftVRy++Hg0ULtbeBni8U0tchSoJdhKKgRk7g21szA@mail.gmail.com>
Subject: [PATCH] git-worktree.txt (single char)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Missing ')' after the closing '`'.

"If <commit-ish> is a branch name (call it `<branch>` and"
