Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0510AC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjDDKo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjDDKoy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 06:44:54 -0400
Received: from server43.webgo24.de (server43.webgo24.de [185.30.32.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A75103
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 03:44:53 -0700 (PDT)
Received: from earendil.localnet (dynamic-089-013-004-129.89.13.pool.telefonica.de [89.13.4.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by server43.webgo24.de (Postfix) with ESMTPSA id 13B564110535;
        Tue,  4 Apr 2023 12:39:20 +0200 (CEST)
From:   Thorsten Otto <admin@tho-otto.de>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
Date:   Tue, 04 Apr 2023 12:39:09 +0200
Message-ID: <2349908.kWcu0K8Tai@earendil>
In-Reply-To: <8135fc7b-1953-4702-a9c4-b0f847e69887@app.fastmail.com>
References: <3473764.PTxrJRyG3s@earendil>
 <8135fc7b-1953-4702-a9c4-b0f847e69887@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dienstag, 4. April 2023 12:17:43 CEST Kristoffer Haugsbakk wrote:

> Do you use `.gitattributes` to get these binary diffs? What does it look
> like?

No, the repo was just created for demonstrating purposes. But when i commit 
that last change, then do a "git --format-patch -1", i get something like

diff --git a/b b/b
new file mode 100644
index 
0000000000000000000000000000000000000000..a64a5a93fb4aef4d5f63d79cb2582731b9ac5063
GIT binary patch
literal 512
NcmZQz7zHCa1ONg600961

literal 0
HcmV?d00001


I would expect "git diff" to output the same information. I don't see a reason 
why it outputs the diff for a new text file, but not for a binary file?





