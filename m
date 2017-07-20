Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E921F600
	for <e@80x24.org>; Thu, 20 Jul 2017 20:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935852AbdGTUwk (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 16:52:40 -0400
Received: from avasout05.plus.net ([84.93.230.250]:47524 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935802AbdGTUwk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 16:52:40 -0400
Received: from hashpling.plus.com ([212.159.69.125])
        by avasout05 with smtp
        id n8se1v0022iA9hg018sflF; Thu, 20 Jul 2017 21:52:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=kj9zAlcOel0A:10 a=G3gG6ho9WtcA:10 a=BNFp--SqAAAA:8 a=xhKhFfHbwTHzw-8hJM8A:9
 a=57jknnFgR3jVi3Ym:21 a=WKeWc3l4r90PVyjy:21 a=CjuIK1q_8ugA:10
 a=wCHOS_8tIzIYXQCUOVd6:22
Received: from charles by hashpling.plus.com with local (Exim 4.84_2)
        (envelope-from <charles@hashpling.org>)
        id 1dYIR3-0003lR-Vz; Thu, 20 Jul 2017 21:52:38 +0100
Date:   Thu, 20 Jul 2017 21:52:37 +0100
From:   Charles Bailey <charles@hashpling.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victor Toni <victor.toni@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: Handling of paths
Message-ID: <20170720205237.GA14368@hashpling.org>
References: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
 <xmqq7ez2lwsv.fsf@gitster.mtv.corp.google.com>
 <20170720200523.GA13792@hashpling.org>
 <xmqqwp72kg03.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwp72kg03.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2017 at 01:30:52PM -0700, Junio C Hamano wrote:
> 
> I've read the function again and I think the attached patch covers
> everything that ought to be a filename.
> 
> By the way, to credit you, do you prefer your bloomberg or hashpling
> address?

The patch looks good to me.

It's not critical which address you credit.

I mark patches which result from my work at Bloomberg with my Bloomberg
email address and anything that I do entirely outside of work with my
hashpling address, although I will tend to use my hashpling email for
all communications because it co-operates with the mailing list
conventions a lot better.

In this case, this is a follow on from a cbailey32@bloomberg.net patch
so crediting that address seems the more appropriate option.

Charles.
