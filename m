Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95C71F955
	for <e@80x24.org>; Thu, 28 Jul 2016 22:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbcG1WHZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 18:07:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51350 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbcG1WHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 18:07:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52BCF1F858;
	Thu, 28 Jul 2016 22:07:23 +0000 (UTC)
Date:	Thu, 28 Jul 2016 22:07:23 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-svn: allow --version to work anywhere
Message-ID: <20160728220723.GB13110@dcvr>
References: <20160720004734.GA19635@whir>
 <xmqqeg6lbnow.fsf@gitster.mtv.corp.google.com>
 <20160722204610.GA20896@whir>
 <xmqqtwf9r013.fsf@gitster.mtv.corp.google.com>
 <xmqqd1lxqwxf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1lxqwxf.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] t9100: portability fix
> 
> Do not say "export VAR=VAL"; "VAR=VAL && export VAR" is always more
> portable.

Oops, sorry I should've caught that :x
