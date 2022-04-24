Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794D3C433F5
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 11:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiDXLn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Apr 2022 07:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiDXLnz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 07:43:55 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3FF11170
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 04:40:53 -0700 (PDT)
Date:   Sun, 24 Apr 2022 13:40:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laumann.xyz; s=key1;
        t=1650800451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKmKs48zzDmqL53tD9SfdNGp5LkMEadji08KNl3XNFg=;
        b=ZsWCky//a9BPIK8+JWciUoiBbBYtQyQBunye85PIroXOKu+a/58zJQpry/d2up9wztu2NI
        4jsyqFs7SKbuisSn94+wB/0iD/YfZDd1oo+XvGMFS3KyjU8u+2k0CIq5Fh6XUFZ7ntK+pw
        uGrze6wY+4TfgSZ+OKvLj45MbgOxYVCrRpV1Wxl8oDLivGITFdz621IQG8xA2Iz7h44lOr
        g3Gaz62gSxojInPyvWUTdKnOnRCdUEqGMIpch2CDczJRUAVK5/nWa72Yqpfcm/BeIRVR1o
        0pCqsVaNs78HDGvRUrPfJZdQVEJe7rylEOevDzJK715VIbK7STgvA3CfhvxgCg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Thomas Bracht Laumann Jespersen <t@laumann.xyz>
To:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: git-log: Capitalize references to sections
Message-ID: <20220424114051.yjbn7lgogqdo5oa7@sofaking>
References: <20220424112826.6577-1-t@laumann.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220424112826.6577-1-t@laumann.xyz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: laumann.xyz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Minor inconsistency, in git-log(1) there's another reference to the
> PRETTY FORMATS section.

Ugh, just reread the commit message, I must've been distracted. What I was
trying to say is that in the git-log(1) man page there's another reference to
the PRETTY FORMATS section that is all-caps (like "PRETTY FORMATS") and I
figured it made sense to align the capitalization.

-- Thomas
