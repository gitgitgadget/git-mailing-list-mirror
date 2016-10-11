Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28DCF1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 20:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbcJKUHI (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 16:07:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36402 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750717AbcJKUHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 16:07:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0778E1F4F8;
        Tue, 11 Oct 2016 20:06:05 +0000 (UTC)
Date:   Tue, 11 Oct 2016 20:06:04 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better
 handle distro changes to DEF_VER
Message-ID: <20161011200604.GA21967@starla>
References: <20161010025323.9415-1-jeremyhu@apple.com>
 <xmqqpon8gnp3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpon8gnp3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
> 
> > CC: Josh Triplett <josh@joshtriplett.org>
> > CC: Junio C Hamano <gitster@pobox.com>
> 
> Please don't do this in your log message.  These belong to your
> e-mail headers, not here.

Fwiw, I prefer having these trailers.  It makes it easier to
maintain the Cc: list through multiple iterations/authors and is
also common practice on LKML.
