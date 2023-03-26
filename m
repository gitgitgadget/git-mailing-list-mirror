Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DFC74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 10:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCZKxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 06:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCZKxy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 06:53:54 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10FF8A76
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 03:53:51 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Pkt9542tMz9sSP;
        Sun, 26 Mar 2023 12:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
        t=1679828025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyJspBBzDBNyu1y0SRzuXoFvuqK/JUHK1+KgFSph4LI=;
        b=UW3eV+wJiXk93Di7c3DWUyP7LiZjfSH047Tk4qxH4rEcbAbIASEbN839Z60JaYP0E71wk0
        lTPWdMDDcE7zcI+JMe2Brma2iLUjSOkfdQIH9cLusHMhw2ovbNm7hPP64ds/5SK1ZIBnmY
        oCdwWOyvUB0o9m8GsVo/mA7CsIv0f62MymOdErGRPE3Ax4C0PJO+pCLpfJB2lozwCr3x2J
        K8xBYKsPOJ3yl1W0xhJnndSpwy42m8+vKcTmO3iWy/w9CLIv3QELtoouGYpjSF9Ai3VT9+
        D8k5e7wQGtIzTf1gqdjvlAd4LJ6qNYomritBrVUGI/Eimi6H3c34uXJkz07zOg==
From:   Hugo Sales <hugo@hsal.es>
To:     hugo@hsal.es
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] Add `restore.defaultLocation` option
Date:   Sun, 26 Mar 2023 11:53:39 +0100
Message-Id: <20230326105339.609573-1-hugo@hsal.es>
In-Reply-To: <00a07e7d-7605-48df-0192-775c2fee39a3@hsal.es>
References: <00a07e7d-7605-48df-0192-775c2fee39a3@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wanted to add that since `git status` suggests using `git restore --staged` to
reset index entries, I'm sure it has happened many times that a user ran `git
restore` and lost work
