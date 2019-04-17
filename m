Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B783C20248
	for <e@80x24.org>; Wed, 17 Apr 2019 17:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbfDQRLX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 13:11:23 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:48924 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQRLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 13:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1555521108; bh=NHyIoJXs9whTWASX16TYKuo41W4KmiqJw6cCTXrO+Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TZ5iVDVqFQROXjcutq2LeyM2NM/yUDuyjWJsR17zYMXKRjYfvkHmkVzqt/YCKngBP
         4TVgZg4vDuSGr3hza9U5geNm+LdyQKWo9P6je1P4Dw7EtNXxWdg9/FqdeTikNLaPCf
         iXEq6OnRtiK1iSUSu4sfO4/Ft35kdjferf5IB2y0=
Date:   Wed, 17 Apr 2019 13:11:19 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Generating a todo file for non-interactive rebasing
Message-ID: <20190417171118.GC1178@homura.localdomain>
References: <20190416153709.GA19000@homura.localdomain>
 <nycvar.QRO.7.76.6.1904171754060.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904171754060.46@tvgsbejvaqbjf.bet>
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for clarifying this, folks.

On 2019-04-17  6:11 PM, Johannes Schindelin wrote:
> To my surprise, Elijah Newren (who authored that change) then demonstrated
> that in most cases, the `--merge` backend is actually *faster* than the
> default (`--am`) backend. There were patches floating around to make it
> the default rebase backend for that reason, but those patches were not
> picked up yet.

Would be cool to see these picked up.
