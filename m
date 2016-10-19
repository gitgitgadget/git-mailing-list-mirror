Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C11620987
	for <e@80x24.org>; Wed, 19 Oct 2016 20:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbcJSUlU (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:41:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35362 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbcJSUlT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 16:41:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CCC9C20986;
        Wed, 19 Oct 2016 20:41:18 +0000 (UTC)
Date:   Wed, 19 Oct 2016 20:41:18 +0000
From:   Eric Wong <e@80x24.org>
To:     K Richard Pixley <cnp637@zebra.com>
Cc:     git@vger.kernel.org
Subject: Re: Problems with "git svn clone"
Message-ID: <20161019204118.GA5982@starla>
References: <500ef24a-55f9-1b38-52bb-17347ebaabcd@zebra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <500ef24a-55f9-1b38-52bb-17347ebaabcd@zebra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

K Richard Pixley <cnp637@zebra.com> wrote:
> error: git-svn died of signal 11
> 
> This seems awfully early and blatant for a core dump.  What can I do to
> get this running?

Can you show us a backtrace?  Thanks.

> Initially discovered on git-2.7.4, (ubuntu-16.04), but also reproduced
> on freshly built top of tree git-2.10.1.445.g3cdd5d1.

This could be a problem with the SVN Perl libraries, and should
be fixed in newer versions (not sure if it's made it to distros,
yet):

https://public-inbox.org/git/0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net/T/

Seems like it is fixed in latest Debian, maybe it needs to trickle
into Ubuntu: https://bugs.debian.org/780246
