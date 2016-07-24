Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D713203E3
	for <e@80x24.org>; Sun, 24 Jul 2016 10:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbcGXK6f (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 06:58:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56864 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbcGXK6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 06:58:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87044203E2;
	Sun, 24 Jul 2016 10:58:33 +0000 (UTC)
Date:	Sun, 24 Jul 2016 10:58:33 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: escape "From " lines recognized by
 mailsplit
Message-ID: <20160724105833.GA25507@starla>
References: <20160722224739.GA22961@whir>
 <xmqqk2gb8q81.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2gb8q81.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> As a tool to produce mbox file, quoting like this in format-patch
> output may make sense, I would think, but shouldn't send-email undo
> this when sending individual patches?

Yes, that sounds like a good idea.  Thanks.
Will followup in a day or two.
