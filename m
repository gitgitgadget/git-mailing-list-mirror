Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7292D1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 18:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeFCSSM (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 14:18:12 -0400
Received: from imap.thunk.org ([74.207.234.97]:58812 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeFCSSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 14:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HIll295E7Vtwa0nTfV0iO0u+Zc8xmq10b57Z66IlV/s=; b=sSc5wTXccFwD8U9Y3/t1US/3LZ
        YUDGLlkfPOrgj5+34r8YiQ4sXqh5mofJgiVtRJFfKHhdLN7vm+zrbQLgn9FvLjN2nzBw5JvXs75J+
        I80GXBTPnvIh4N/U1atRcFhwSqxWsVkC4ZzUZSNsDrGGDYMrRrtvEj5FEHVtTpNLrx+Q=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fPXZw-00057x-RV; Sun, 03 Jun 2018 18:18:08 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AB85F7A60A6; Sun,  3 Jun 2018 14:18:07 -0400 (EDT)
Date:   Sun, 3 Jun 2018 14:18:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603181807.GB1750@thunk.org>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 07:46:17PM +0200, Peter Backes wrote:
> 
> Let's be honest: We do not know what legitimization exactly in each 
> specific case the git metadata is being distributed under.

It seems like you are engaging in something even more dangerous than a
hardware engineering pretending they know how program, or a software
engineer knowing how to use as oldering iron --- and that's a
programmer pretending they know enough that they can speculate on the
law.

I would gently suggest that if you really want to engage in something
practical than speculating how the GPDR compliance will work out in
actual practice, that you contact a lawyer and get official legal
advice?

After getting that advice, if you or your company wants to implemnt,
you can then send patches, and those can get debated using the usual
patch submission process.

Cheers,

					- Ted
