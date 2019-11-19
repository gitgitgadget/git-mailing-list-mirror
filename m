Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DD51F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 14:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKSOW4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 09:22:56 -0500
Received: from feynman.df7cb.de ([195.49.152.168]:38236 "EHLO feynman.df7cb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfKSOW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 09:22:56 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Nov 2019 09:22:55 EST
Received: from msg.df7cb.de (unknown [IPv6:2003:5b:203b:100:7627:eaff:fe52:8e03])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by feynman.df7cb.de (Postfix) with ESMTPSA id 47HSXV1y4hz3DyC
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:15:38 +0100 (CET)
Date:   Tue, 19 Nov 2019 15:15:37 +0100
From:   Christoph Berg <myon@debian.org>
To:     git@vger.kernel.org
Subject: git clone git clone some://url
Message-ID: <20191119141537.GD18924@msg.df7cb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On some git hosting sites [*], if you copy the repository URL, you'll
actually get "git clone some://url" in the cut buffer. When you then
proceed to do "git clone <paste>" in the next terminal window, the
command executed is actually this:

$ git clone git clone some://url
fatal: Too many arguments.

As silly as the idea might sound, could the clone command possibly
ignore these very specific extra arguments, and just proceed? This has
happened countless times to me, and when I mentioned the idea on
#debian-devel, there were others who had the same problem.

Thanks,
Christoph

[*] hello sourceforge! example:
    https://sourceforge.net/p/wsjt/wsjtx/ci/master/tree/
