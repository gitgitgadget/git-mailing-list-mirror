Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B07F20A17
	for <e@80x24.org>; Wed, 18 Jan 2017 10:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbdARKPl (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 05:15:41 -0500
Received: from ozlabs.org ([103.22.144.67]:36361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbdARKPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 05:15:39 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3v3NC32cFcz9t1d; Wed, 18 Jan 2017 21:15:27 +1100 (AEDT)
Date:   Wed, 18 Jan 2017 21:15:15 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] gitk: remove translated message from comments
Message-ID: <20170118101515.GA12161@fergus.ozlabs.ibm.com>
References: <xmqq4m0xpmbz.fsf@gitster.mtv.corp.google.com>
 <20170118035245.1757-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118035245.1757-1-davvid@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 07:52:45PM -0800, David Aguilar wrote:
> "make update-po" fails because a previously untranslated string
> has now been translated:
> 
> 	Updating po/sv.po
> 	po/sv.po:1388: duplicate message definition...
> 	po/sv.po:380: ...this is the location of the first definition
> 
> Remove the duplicate message definition.
> 
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>

Thanks, applied.

Junio, please do a pull from my repository to get this fix.
The new head is 7f03c6e32891.

Paul.
