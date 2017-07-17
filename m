Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371F22082F
	for <e@80x24.org>; Mon, 17 Jul 2017 09:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdGQJwN (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 05:52:13 -0400
Received: from 256bit.org ([144.76.87.176]:37766 "EHLO 256bit.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751265AbdGQJwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 05:52:12 -0400
X-Greylist: delayed 2573 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jul 2017 05:52:12 EDT
Received: from chrisbra by 256bit.org with local (Exim 4.86_2)
        (envelope-from <cb@256bit.org>)
        id 1dX218-0006yj-UM
        for git@vger.kernel.org; Mon, 17 Jul 2017 11:08:39 +0200
Date:   Mon, 17 Jul 2017 11:08:38 +0200
From:   Christian Brabandt <cb@256bit.org>
To:     git@vger.kernel.org
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
Message-ID: <20170717090838.GA17826@256bit.org>
Mail-Followup-To: git@vger.kernel.org
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
 <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
 <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
 <1499950837.2427.1.camel@gmail.com>
 <xmqqr2xkxlpo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2xkxlpo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: cb@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Do, 13 Jul 2017, Junio C Hamano wrote:

> I think many people know about and do use the "delete all lines"
> (i.e. ":1,$d" in vi, or \M-< \C-SPC \M-> \C-w in Emacs) to abort out
> of a commit or a merge.  I just do not think it is likely for them
> to leave Sign-off lines and remove everything else, which is more
> work than to delete everything, hence my reaction.

In Vim you can also abort the commit message using :cq which exits the 
editor with an error code.

Best,
Christian
-- 
Das Werk soll den Meister loben.
