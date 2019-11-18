Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3111F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 17:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKRR32 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 12:29:28 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45222 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfKRR32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 12:29:28 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 9987C3C04C0;
        Mon, 18 Nov 2019 18:29:26 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5HHeYgedQuYc; Mon, 18 Nov 2019 18:29:21 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 0C1DC3C0022;
        Mon, 18 Nov 2019 18:29:21 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 18 Nov
 2019 18:29:20 +0100
Date:   Mon, 18 Nov 2019 18:29:17 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     <git@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Signal conflict on merging metadata-differing patches
Message-ID: <20191118172917.GA6063@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community,

Due to high inflow of patches which Linux maintainers carry on their
shoulders and due to occasionally intricate relationships between
consecutive revisions of the same series, it may [1] happen that two
distinct revisions of the same patch (differing only/mostly in
metadata, e.g. Author's time-stamp and commit description) may end up
being merged on the same branch, without git to complain about that.

Is there any "git merge" flag available off-the-shelf which (if used)
would signal such situations?

[1] https://patchwork.kernel.org/patch/11135107/#23007101

-- 
Best Regards,
Eugeniu
