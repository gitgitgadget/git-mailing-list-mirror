Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C3FC83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbjHaOpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 10:45:05 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B5CC5
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 07:44:57 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id D019B24D1E
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 16:44:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 87FC324C59
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 16:44:54 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EC0Mihg8AaQe for <git@vger.kernel.org>;
        Thu, 31 Aug 2023 16:44:54 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 7D62724E39
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 16:44:52 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing without a forkpoint
Date:   Thu, 31 Aug 2023 10:44:37 -0400
Message-ID: <20230831144445.688269-1-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.29.gcd9da15a85
In-Reply-To: <20230819203528.562156-1-wesleys@opperschaap.net>
References: <20230819203528.562156-1-wesleys@opperschaap.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=UttIx32zK-AA:10 a=bLYw6Hc57TPvEFEMUrIA:9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> [snip]

I submitted this earlier this month. I think it wasn't noticed because of=
 the
release of v4.24.0. If someone could have a look at this, that would be
appreciated.=20

Cheers,
Wesley
