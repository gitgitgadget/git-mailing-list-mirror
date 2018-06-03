Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BF51F403
	for <e@80x24.org>; Sun,  3 Jun 2018 21:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeFCVDs (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 17:03:48 -0400
Received: from imap.thunk.org ([74.207.234.97]:58994 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbeFCVDr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 17:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3/VNW5xq2gFQpQSaA+psPa7IwAVICTtW+qIcZ8qLwRI=; b=ozGSm1SwQe/43sl/UsQqlhFaLM
        w9GEwbnZoXf6QHPY2WLePX4Bnz/xmYTUzQGJeKa2HKtcYx0gauA+vlvC1sM5bZgoSmp1KUZcSEVLp
        83FoI1YbCgV+YOvlBs9OyYvy2aCMAspYYx3Fen+fB1L3Xu0HHAWoJPUoxpC5Wm+FlNPs=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fPaAD-0006FB-9C; Sun, 03 Jun 2018 21:03:45 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3AF277A60A6; Sun,  3 Jun 2018 17:03:44 -0400 (EDT)
Date:   Sun, 3 Jun 2018 17:03:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603210344.GF1750@thunk.org>
References: <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <20180603181807.GB1750@thunk.org>
 <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
 <20180603192417.GA12416@helen.PLASMA.Xg8.DE>
 <20180603200739.GC1750@thunk.org>
 <20180603205233.GA13451@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603205233.GA13451@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 10:52:33PM +02h00, hPeter Backes wrote:
> But I will take your message as saying you at least don't see any 
> obvious criticism leading to complete rejection of the approach.

If you don't think a potential 2x -- 10x performance hit isn't a
blocking factor --- sure, go ahead and try implementing it.  And good
luck to you.  And this is not a guarantee that it won't get rejected.
I certainly don't have the power to make that guarantee.

If you don't have time to implement, why do you think it's fair to
inflict on everyone else the request for time to do a design review
for something for which the need hasn't even been established?

Regards,

	      	    	     	    	 - Ted
