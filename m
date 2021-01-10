Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D2C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 07:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE64239CF
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 07:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbhAJH3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 02:29:48 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:56848 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbhAJH3r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 02:29:47 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kyV9t-001XST-IO; Sun, 10 Jan 2021 00:29:06 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kyV9s-006nYP-Pf; Sun, 10 Jan 2021 00:29:05 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 900F1500AB0;
        Sun, 10 Jan 2021 00:29:04 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZtEyAXOWynxR; Sun, 10 Jan 2021 00:29:04 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 3C96E500AAB;
        Sun, 10 Jan 2021 00:29:04 -0700 (MST)
Date:   Sun, 10 Jan 2021 00:29:02 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Message-ID: <20210110072902.GA247325@ellen>
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
 <20210109224236.50363-1-davvid@gmail.com>
 <20210109225400.GA156779@ellen>
 <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
 <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
X-XM-SPF: eid=1kyV9s-006nYP-Pf;;;mid=<20210110072902.GA247325@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 09, 2021 at 10:40:20PM -0800, Junio C Hamano wrote:
> An ugly workaround patch that caters only to difftool breakage is
> attached at the end; I did not look if a similar treatment is
> necessary for the mergetool side.

That fixup does the trick on my machine too. Thank you.

How wary are you of continuing with `initialize_merge_tool`? Do you see
a better approach to get `automerge_enabled `into scope? While it is
a nice feature to have, is it worth the risk vs. reward?

