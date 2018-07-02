Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACAD11F516
	for <e@80x24.org>; Mon,  2 Jul 2018 02:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbeGBCFN (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 22:05:13 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:53818 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932938AbeGBCFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 22:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1530497297; bh=ztLgOWO4dux2v5/FlaVdq/4NFf9nJh1C2PTayLmLYgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=vdWofIRhBSib518yYnobT/5Dq1eKj4/BMl384C7sNzhzsLcSrj2VrLgHTpOuO48/3
         5b0YpJLUEU9BkB0zXO/5eIO5hcne4e3o7esmyKaWAdY3CihALMnJbe2TWz1cKczD3J
         U20aXbWV2JJ/rrmLeziwF2rodDVvqqQr0KpnO5tQ=
Date:   Sun, 1 Jul 2018 22:05:08 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, contact@emersion.fr
Subject: Re: send-email: change the default value of sendmail.validate
Message-ID: <20180702020507.GA15354@homura.localdomain>
References: <20180629190751.GA2559@miku>
 <20180701181546.GD7965@genre.crustytoothpaste.net>
 <20180702001753.GA30086@homura.localdomain>
 <20180702015216.GA627376@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702015216.GA627376@genre.crustytoothpaste.net>
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I seem to be mistaken about the degree to which this is standardized and
supported. The Debian argument cinches it for me. Quoted printable is
probably the right way to go, then.
