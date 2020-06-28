Return-Path: <SRS0=levB=AJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2389C433E0
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7EF206C3
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 19:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgF1TW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Jun 2020 15:22:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55340 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgF1TW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jun 2020 15:22:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 609BC1F5AE;
        Sun, 28 Jun 2020 19:22:27 +0000 (UTC)
Date:   Sun, 28 Jun 2020 19:22:27 +0000
From:   Eric Wong <e@yhbt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: `seen' datapoint [was: What's cooking in git.git (Jun 2020, #04;
 Mon, 22)]
Message-ID: <20200628192227.GA20227@dcvr>
References: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> The 'pu' (proposed updates) branch has been renamed to 'seen' to use
> a more meaningful name (after all, the purpose of it is not to
> contain all proposals, but to merely serve as a place to park what
> the maintainer happened to have seen) and more importantly, to make
> room for topics from those contributors whose two-letter name
> abbreviation needs to be 'pu' under 'pu/$topicName'.

So I had receive.denyNonFastforwards=true set, and a
special cases for `pu':

	fetch = +refs/heads/pu:refs/remotes/origin/pu

Which necessitated s/pu/seen/.  So I wonder if there's other
denyNonFastforwards users out there affected.  Anyways, just
a data point...
