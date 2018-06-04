Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A6A1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 13:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeFDNr1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 09:47:27 -0400
Received: from imap.thunk.org ([74.207.234.97]:33156 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbeFDNrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 09:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Nx7opTm/+MRyLZThOmUsTcCeTvCe+qZgjx8CfOzm24g=; b=ozEJ7FFMTXGexribbx1OJ2vt4z
        mBccmBZYtOGGnwExA3mK5YGaypvpz/wTcExYPT7qJTL2DZdgIcZdkE3ITMoCmaXMNf193WCWugJKg
        u8PjGt6XXczG9YNpPZiSPikE4MvMTUK8IFQXSBESU8BcCK6tUjIey3Yu6uke6HyQeAUw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fPppQ-0001kF-5D; Mon, 04 Jun 2018 13:47:20 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F28E17A60AA; Mon,  4 Jun 2018 09:47:18 -0400 (EDT)
Date:   Mon, 4 Jun 2018 09:47:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180604134718.GA7198@thunk.org>
References: <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <20180603181807.GB1750@thunk.org>
 <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
 <20180603192417.GA12416@helen.PLASMA.Xg8.DE>
 <20180603200739.GC1750@thunk.org>
 <20180603205233.GA13451@helen.PLASMA.Xg8.DE>
 <20180603210344.GF1750@thunk.org>
 <20180603221616.GA14636@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603221616.GA14636@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 12:16:16AM +0200, Peter Backes wrote:
> 
> Verifying the commit ID by itself wouldn't be any less efficient than 
> before. Admitteldly, it wouldn't verify the author and authordate 
> integrity anymore without additional work. That would be some overhead, 
> sure, and could be done on demand, and would mostly affect clones.

For people who are doing real work on git repos, other commands that
we very much care about include "git log --author=<authorname>", "git
tag --contains", "git blame", etc.

At least for any repo that *I* control, slow those down, and I
wouldn't downgrade my git binary/repo just to make some imperialistic
European bureaucrats happy.

Cheers,

					- Ted
