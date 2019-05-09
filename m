Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4481F45F
	for <e@80x24.org>; Thu,  9 May 2019 16:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfEIQu2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 12:50:28 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:49802 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfEIQu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 12:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1557420728; bh=VQlkNGhAC7nPQou+ysvd9vSvMHIrDhbm7t+HOj6Fo+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=POxC0NGFZbAkahuYBS3QOSZ5mRa9rsEMrc0MtCQ7iPtThspB3Wvd9FFUOrjP9kQWB
         UiCSewexvfFPKZt7Cs1a9lztMVAzh98aAy28kHI++RQocq49NcDKyUMxz65hjlfm7r
         OiWpRC/OYAY+xkm9p8CNdA+asqLE9vMPvXWbB4E0=
Date:   Thu, 9 May 2019 12:50:25 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: Remembering message IDs sent with git send-email
Message-ID: <20190509165025.GA18342@homura.localdomain>
References: <20190508231013.GA25216@homura.localdomain>
 <20190509001959.GB14000@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509001959.GB14000@google.com>
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-05-08  5:19 PM, Emily Shaffer wrote:
> What I think might be useful (and what I was hoping you were going to
> talk about when I saw the subject line) would be if the Message-Id is
> conveniently stored during `git send-email` on v1 and somehow saved in a
> useful place in order to apply to the In-Reply-To field on v2
> automatically upon `git format-patch -v2`. I'll admit I didn't know
> about --in-reply-to=ask and that helps with the pain point I've
> experienced sending out v2 before.

--in-reply-to=ask doesn't exist, that's what I'm looking to add. This
convenient storage mechanism is exactly what I'm talking about. Sorry
for the confusion.
