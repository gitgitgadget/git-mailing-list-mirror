Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8900C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 21:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75EE206D6
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 21:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgBKVC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:02:58 -0500
Received: from unsecure-smtp.soverin.net ([94.130.159.241]:38868 "EHLO
        g02sm02.soverin.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729264AbgBKVC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 16:02:58 -0500
Received: from soverin.net by soverin.net
From:   Toon Claes <toon@iotcl.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: URL rewrites for submodules
References: <87wo8ucgar.fsf@iotcl.com>
        <xmqqv9oexfnr.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 11 Feb 2020 22:02:46 +0100
In-Reply-To: <xmqqv9oexfnr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 10 Feb 2020 14:04:40 -0800")
Message-ID: <87sgjgdeh5.fsf@iotcl.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at g02sm02
X-Virus-Status: Clean
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you define them instead in $HOME/.gitconfig, that would apply
> equally to all repositories you would access.

Yes, that makes sense to me too. But in my testing adding URL rewrites
did not apply to submodules anyway. So that feels to me this feature is
missing, WDYT?

-- 
Toon
