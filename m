Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	URI_HEX shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4028207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970389AbdDTVfg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:35:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:32827 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965863AbdDTVfb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Apr 2017 17:35:31 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id C744EA4C
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 17:35:29 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute7.internal (MEProxy); Thu, 20 Apr 2017 17:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=Q8VAaXpIB7A7Dq/rELU5owDJM/B7t8LHQZ6PBTCnAOM=; b=fSstTUMh
        nIqVYtHKw+/eqIrFRAZBKiHcpJTbwBDE5SiqF6mykluXSmKxCUxAdTthUDzaMkxa
        viNpRWoOecmsaF9IGBrgVonKmXM/diaB8mW5oo1TFPlEOSTHgAfoOJMm8OxWDMCh
        QWVXQRHAQSB5PbAkKj4BcY9CU3g91qNy3iIJrR8DIWNrFeSQyHoktEFFpxSwD72/
        k387x2sRRIVNrCGI69n+JfjodM+8+2PrEtUPcKW3rDKaZlVCp7x3MUgT7jAY6ZWU
        Ekol9yvCjYDhVEQR5vakJ4p8RwtvdIBJETyt/aIrmkUOy3dTz8ULUCHli4F4I8v7
        plATiSzby5RwnQ==
X-ME-Sender: <xms:oSn5WARNYpaI9uqWe6kX2MaQgp9n46A2ld5tHOutVw8kCf6Nmoe7qg>
X-Sasl-enc: QOwPlOucD1XUpMguiwasQHCOlGqW2sbu34CphvY7YnFI 1492724129
Received: from mjim.nabble.com (unknown [162.253.133.84])
        by mail.messagingengine.com (Postfix) with ESMTPA id 33322245DF
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 17:35:29 -0400 (EDT)
Date:   Thu, 20 Apr 2017 14:35:28 -0700 (MST)
From:   galt <galt@folkplanet.com>
To:     git@vger.kernel.org
Message-ID: <1492724128603-7657473.post@n2.nabble.com>
In-Reply-To: <4A951EFB.1010400@draigBrady.com>
References: <4A85F270.20703@draigBrady.com> <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com> <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com> <alpine.LFD.2.01.0908151315400.3162@localhost.localdomain> <alpine.LFD.2.01.0908151336530.3162@localhost.localdomain> <alpine.LFD.2.00.0908162151180.6044@xanadu.home> <4A951EFB.1010400@draigBrady.com>
Subject: Re: Linus' sha1 is much faster!
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I also wanted to include Linus' sha1 in our software at work.
But the GPLv2 license was incompatible.
Too bad it is just just in the public domain.
I grabbed Steve Reid's public domain code from 1999
and ran it. It produced the same output.
I ran it on a 3GB input file, and Linus' code from 2009 takes 37 to 40
seconds.
(Just reading the file in the same 4k buffers only takes 3 seconds 
so disk reading does not dominate the time.)
When I ran Steve's old version on the same input it was taking just 36 or 37
seconds.
So it is slightly faster.
Have compilers improved?
I am using gcc 4.4.7-17.





--
View this message in context: http://git.661346.n2.nabble.com/Linus-sha1-is-much-faster-tp3448007p7657473.html
Sent from the git mailing list archive at Nabble.com.
