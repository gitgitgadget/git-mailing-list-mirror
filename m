Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AFBC433E0
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 00:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B2D2255F
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 00:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgFTAVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:21:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56452 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgFTAVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 20:21:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 453EE1F5AE;
        Sat, 20 Jun 2020 00:21:11 +0000 (UTC)
Date:   Sat, 20 Jun 2020 00:21:11 +0000
From:   Eric Wong <e@80x24.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Matthew DeVore <matvore@google.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 00/14] SHA-256 CVS and SVN patches
Message-ID: <20200620002111.GA30254@dcvr>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> The patches are ordered roughly with test-only fixes, then SVN, and then
> CVS.  There are no additional tests here because everything fails with
> SHA-256 before and passes afterwards.

Thanks brian.  I took a quick look at this series (including the
CVS stuff) and nothing objectionable jumped out(*).

Consider this series Acked-by: me

(*) except perhaps some of my original code :x
    which I hope to fix at some point this year
