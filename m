Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1231F404
	for <e@80x24.org>; Sun, 28 Jan 2018 22:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeA1WMq (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 17:12:46 -0500
Received: from imap.thunk.org ([74.207.234.97]:36690 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751867AbeA1WMp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 17:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jj8n1MtVY7PND78QfeWX85X1qvvWOmu0FGJII/J845U=; b=Ing0rKKsHwRSg0UqLsZWxx/Qji
        LsbtnB28yNLO2gflmO5NjiLXr6ib/xVgp9y0d9G8dwfazdHj9mVv3x2Q7NlDT9E8JcLdDmBCRTBzm
        9pC4Ll4+9yCnhvI23jOw2yUslmSCn7E4ywiXg08ojcD+JocKI7rgOxEDsSrAU29ugG1w=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1efvBm-0006gH-2V; Sun, 28 Jan 2018 22:12:38 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7D3D57A36E4; Sun, 28 Jan 2018 17:12:31 -0500 (EST)
Date:   Sun, 28 Jan 2018 17:12:31 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     'Michal =?iso-8859-1?Q?Such=E1nek'?= <msuchanek@suse.de>,
        git@vger.kernel.org,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Subject: Re: git send-email sets date
Message-ID: <20180128221231.GB13621@thunk.org>
References: <20180126183230.0ae0c76b@kitsune.suse.cz>
 <20180128151536.GE431130@genre.crustytoothpaste.net>
 <001601d39850$a0a48ae0$e1eda0a0$@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001601d39850$a0a48ae0$e1eda0a0$@iee.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 03:56:57PM -0000, Philip Oakley wrote:
> Michal, you may want to hack up an option that can automatically create 
> that format if it is of use. I sometimes find the sort order an issue in 
> some of my mail clients.

If there is a From: header in the beginning of the mail body, it is
used as the Author instead of the From: header in the mail header.  It
would make sense if there is a Date: header in the beginning of the
mail body, it should be used instead of Date: field in the mail header.

The problem is that if existing git clients don't support this, it
wouldn't be safe to start emmiting patches with that format for at
least a year or two until the prerequisite version of git gets wide
adoption.  Alternatively, there could be a git option which causes
something like X-Git-Author-Date: to be set in the mail header.

	       			  	   	- Ted
