Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D8C1FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 17:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbcKYRtc (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 12:49:32 -0500
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:39260 "EHLO
        wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754835AbcKYRta (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Nov 2016 12:49:30 -0500
Received: from p549a87ab.dip0.t-ipconnect.de ([84.154.135.171] helo=gentp.lnet); authenticated
        by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1cAJnS-0006r8-T0; Fri, 25 Nov 2016 17:56:22 +0100
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
        by gentp.lnet (Postfix) with ESMTP id CCACE2601B6
        for <git@vger.kernel.org>; Fri, 25 Nov 2016 17:56:19 +0100 (CET)
Date:   Fri, 25 Nov 2016 17:56:19 +0100
From:   Luis Ressel <aranea@aixah.de>
To:     git@vger.kernel.org
Subject: [feature request] Make "commit --only" work with new files
Message-ID: <20161125175619.19e13e59@gentp.lnet>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1480096170;9d4a21bf;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

currently "git commit --only <file>" only works if <file> is already
checked into the repo, but not with newly created and still untracked
files (builtin/commit.c:list_path() throws the error "error: pathspec
'<file>' did not match any file(s) known to git.")

I don't think this limitation is intented. I've had a look at the
relevant part of builtin/commit.c, but unfortunately it wasn't obvious
to me how to fix this.

Regards,
Luis Ressel
