Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE1A201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 18:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbdKLSXZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 13:23:25 -0500
Received: from ikke.info ([178.21.113.177]:55152 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbdKLSXY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 13:23:24 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 14A5F44080A; Sun, 12 Nov 2017 19:23:22 +0100 (CET)
Date:   Sun, 12 Nov 2017 19:23:22 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [RFC PATCH v3 4/4] builtin/branch: give more useful error
 messages when renaming
Message-ID: <20171112182322.GA17612@alpha.vpn.ikke.info>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 02, 2017 at 12:24:07PM +0530, Kaartic Sivaraam wrote:
> From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> 
> When trying to rename an inexistent branch to with a name of a branch

This sentence does not read well. Probably s/with a/the/ helps.

> that already exists the rename failed specifying the new branch name
> exists rather than specifying that the branch trying to be renamed
> doesn't exist.
> 
> [..]
> 
> Note: Thanks to the strbuf API that made it possible to easily construct
> the composite error message strings!

I'm not sure this note adds a lot, since the strbuf API is not that new.

Kevin
