Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6403C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9502070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgFJSlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:41:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45816 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgFJSlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 14:41:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 57FEA1F55B;
        Wed, 10 Jun 2020 18:41:47 +0000 (UTC)
Date:   Wed, 10 Jun 2020 18:41:47 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: CFT: imaps://public-inbox.org/INBOX.comp.version-control.git.7
Message-ID: <20200610184147.GA1887@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all, I've been busy with public-inbox work this year.
I started working on a read-only IMAP/IMAPS server, and I expect
kernel.org to eventually host a v2 copy, too; and hopefully
other folks get interested in mirroring.

For now, you can access git@vger archives through 8 IMAP
mailboxes sliced into ~50K messages to not overload clients.
They go from 0..7, with 7 being the most recent:

imaps://public-inbox.org/INBOX.comp.version-control.git.0
imaps://public-inbox.org/INBOX.comp.version-control.git.1
imaps://public-inbox.org/INBOX.comp.version-control.git.2
imaps://public-inbox.org/INBOX.comp.version-control.git.3
imaps://public-inbox.org/INBOX.comp.version-control.git.4
imaps://public-inbox.org/INBOX.comp.version-control.git.5
imaps://public-inbox.org/INBOX.comp.version-control.git.6
imaps://public-inbox.org/INBOX.comp.version-control.git.7

When more messages show up,
imaps://public-inbox.org/INBOX.comp.version-control.git.8
should exist.

I've tested with mutt, offlineimap and mbsync (isync).

It's not yet complete (when is software ever?), but it's a
usable start, I think.  Some more info about it over on
meta@public-inbox.org:
https://public-inbox.org/meta/20200609113442.GA16856@dcvr/
https://public-inbox.org/meta/20200610070519.18252-1-e@yhbt.net/
And maybe JMAP is coming, too...
