Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0541F404
	for <e@80x24.org>; Mon, 19 Feb 2018 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932154AbeBSWIh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:08:37 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37502 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932116AbeBSWIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 17:08:37 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1JM8Z6L029993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Feb 2018 23:08:35 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1JM8ZAc029992;
        Mon, 19 Feb 2018 23:08:35 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1JM8Jek010564;
        Mon, 19 Feb 2018 23:08:19 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1JM8JKS010563;
        Mon, 19 Feb 2018 23:08:19 +0100
Date:   Mon, 19 Feb 2018 23:08:19 +0100
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Mon, Feb 19, 2018 at 10:58:12PM +0100, Johannes Schindelin wrote:
> Since you already assessed that it shouldn't be hard to do, you probably
> want to put your money where your mouth is and come up with a patch, and
> then offer it up for discussion on this here mailing list.

Well, it would be good to discuss this a bit beforehand, since my time 
is wasted if there's no chance to get it accepted. Perhaps there is 
some counterargument I don't know about.

Is there some existing code that could be used? I think I read 
somewhere that git once did preserve mtimes, but that this code was 
removed because of the build tool issues. Perhaps that code could 
simply be put back in, and surrounded by conditions.

Best wishes
Peter

PS: Given the opportunity, I want to thank you very much for 
maintaining the git repository for my cvsclone tool.

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
