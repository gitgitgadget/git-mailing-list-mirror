Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC0F1F859
	for <e@80x24.org>; Sun, 21 Aug 2016 08:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbcHUINo (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 04:13:44 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43964 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbcHUINl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 04:13:41 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3sH8bg6PS6z3hsNG;
        Sun, 21 Aug 2016 10:13:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3sH8bg5jmzzvkKG;
        Sun, 21 Aug 2016 10:13:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id 69Dc-ruAhtsq; Sun, 21 Aug 2016 10:13:35 +0200 (CEST)
X-Auth-Info: 3nUxCjIb5hd2eTMuzMXW2iUHIbAkEZxHFrWmf/o5pSjwiqJQhvJzP3waeHd482i2
Received: from linux.local (ppp-88-217-9-240.dynamic.mnet-online.de [88.217.9.240])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Sun, 21 Aug 2016 10:13:35 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
        id EBA7D1E5465; Sun, 21 Aug 2016 10:13:33 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Subject: Re: Most recent revision that contains a string
References: <87d1l3ce40.fsf@thinkpad.rath.org>
        <20160821013040.4sfmg2v7rcovxxmb@x>
X-Yow:  I'm young..  I'm HEALTHY..  I can HIKE THRU CAPT GROGAN'S LUMBAR REGIONS!
Date:   Sun, 21 Aug 2016 10:13:33 +0200
In-Reply-To: <20160821013040.4sfmg2v7rcovxxmb@x> (Josh Triplett's message of
        "Sat, 20 Aug 2016 18:30:42 -0700")
Message-ID: <m2mvk6iloy.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 20 2016, Josh Triplett <josh@joshtriplett.org> wrote:

> If you want to find a change that introduces or removes a particular
> string, you could use "git log -S".  That doesn't allow regexes,

It does, actually, see --pickaxe-regex.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
