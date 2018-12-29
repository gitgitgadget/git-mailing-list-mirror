Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056171F405
	for <e@80x24.org>; Sat, 29 Dec 2018 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeL2Ecr (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 23:32:47 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56802 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeL2Ecr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 23:32:47 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C4B1A1F804;
        Sat, 29 Dec 2018 03:56:21 +0000 (UTC)
Date:   Sat, 29 Dec 2018 03:56:21 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     meta@public-inbox.org
Subject: "IMAP IDLE"-like long-polling "git fetch"
Message-ID: <20181229035621.cwjpknctq3rjnlhs@dcvr>
References: <20181229034342.11543-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229034342.11543-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all, I just added this to the TODO file for public-inbox[1] but
obviously it's intended for git.git (meta@public-inbox cc-ed):

> +* Contribute something like IMAP IDLE for "git fetch".
> +  Inboxes (and any git repos) can be kept up-to-date without
> +  relying on polling.

I would've thought somebody had done this by now, but I guess
it's dependent on a bunch of things (TLS layer nowadays, maybe
HTTP/2), so git-daemon support alone wouldn't cut it...

Anyways, until this is implemented, feel free to continue
hammering a way on https://public-inbox.org/git/ with frequent
"git fetch".  I write C10K servers in my sleep -_-


[1] https://public-inbox.org/meta/20181229034342.11543-1-e@80x24.org/
