Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA938C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9AB20747
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgFKAag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:30:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39458 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgFKAag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 20:30:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4CFDB1F55B;
        Thu, 11 Jun 2020 00:30:36 +0000 (UTC)
Date:   Thu, 11 Jun 2020 00:30:36 +0000
From:   Eric Wong <e@80x24.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, meta@public-inbox.org
Subject: Re: CFT: imaps://public-inbox.org/INBOX.comp.version-control.git.7
Message-ID: <20200611003036.GA5446@dcvr>
References: <20200610184147.GA1887@dcvr>
 <20200610233127.GA51956@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610233127.GA51956@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> wrote:
> Exciting news! Since I'm not actually subscribed to the mailing list,
> public-inbox has been integral in my workflow by letting me reply to
> messages that I'm not CC'd on. The IMAP gateway is a great development.
> 
> I fetched your message via IMAP just now ;)

Hi Denton, great to know you appreciate it :)

It's still in the early stages and there still seems to be a
problem where it still interacts badly with mutt's header cache.
Maybe checking over the old HTTPS/NNTPS endpoints once in a
while if things appear too quiet is a good idea while I shake
out some bugs.

I'm dreading the cost of ~100K RAM/storage overhead per-client
connection to support sequence numbers properly...
