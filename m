Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0BA1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbdAYXUx (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:20:53 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51172 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbdAYXUw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:20:52 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4414E1F6DC;
        Wed, 25 Jan 2017 23:20:51 +0000 (UTC)
Date:   Wed, 25 Jan 2017 23:20:51 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Retire the `relink` command
Message-ID: <20170125232051.GA25810@whir>
References: <10319c47ff3f7222c3a601827ebd9398861d509d.1485363528.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10319c47ff3f7222c3a601827ebd9398861d509d.1485363528.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> Back in the olden days, when all objects were loose and rubber boots were
> made out of wood, it made sense to try to share (immutable) objects
> between repositories.
> 
> Ever since the arrival of pack files, it is but an anachronism.
> 
> Let's move the script to the contrib/examples/ directory and no longer
> offer it.

On the other hand, we have no idea if there are still people
using it for whatever reason...

I suggest we have a deprecation period where:

1) there is warning message when it's run
2) a note in the manpage indicating it's to-be-removed
3) ...then wait a few distro LTS cycles to remove it entirely
