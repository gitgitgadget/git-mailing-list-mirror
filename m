Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5684D1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdBLU4x (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 15:56:53 -0500
Received: from mail5.fer.hr ([161.53.72.235]:61727 "EHLO mail.fer.hr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbdBLU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 15:56:52 -0500
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Feb 2017 15:56:52 EST
Received: from POSTAR.fer.hr (2001:b68:16:250::72:237) by MAIL5.fer.hr
 (2001:b68:16:250::72:235) with Microsoft SMTP Server (TLS) id 14.3.319.2;
 Sun, 12 Feb 2017 21:51:22 +0100
Received: from mail-wr0-f181.google.com (209.85.128.181) by POSTAR.fer.hr
 (161.53.72.237) with Microsoft SMTP Server (TLS) id 14.3.319.2; Sun, 12 Feb
 2017 21:51:22 +0100
Received: by mail-wr0-f181.google.com with SMTP id 89so139208377wrr.2
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 12:51:22 -0800 (PST)
X-Gm-Message-State: AMke39myJWvGm8wDYpI0pGRNI3XtFCqleL9XOVAoTPTBJJ9MZrPaV1p94GRZEuhrruErE48UPClztcF3tas8Ww==
X-Received: by 10.223.150.58 with SMTP id b55mr17174725wra.192.1486932681934;
 Sun, 12 Feb 2017 12:51:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.102.136 with HTTP; Sun, 12 Feb 2017 12:50:41 -0800 (PST)
From:   Juraj <juraj.orsulic@fer.hr>
Date:   Sun, 12 Feb 2017 21:50:41 +0100
X-Gmail-Original-Message-ID: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
Message-ID: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
Subject: [git-gui] Amending doesn't preserve timestamp
To:     <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [209.85.128.181]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've just noticed that amending a commit from git-gui uses the time of
amending as the new timestamp of the commit, whereas git commit
--amend preserves the original timestamp. Maybe the two should work
the same, whatever it is decided to be the standard behavior.

Juraj
