Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28D7207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 21:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbcJIV0V (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 17:26:21 -0400
Received: from mail.pdinc.us ([67.90.184.27]:49900 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbcJIV0V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 17:26:21 -0400
Received: from black7 (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id u99LQHR5025821;
        Sun, 9 Oct 2016 17:26:17 -0400
Reply-To: <git@vger.kernel.org>, "Ian Kelling" <ian@iankelling.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Ian Kelling'" <ian@iankelling.org>
References: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
In-Reply-To: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
Subject: RE: How to watch a mailing list & repo for patches which affect a certain area of code?
Date:   Sun, 9 Oct 2016 17:26:16 -0400
Organization: PD Inc
Message-ID: <4B3747D8D2724E98B6AC000FE4072A09@black7>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdIiYPPSsvD7r163S/aaGnei2tZQIAADeZNw
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.23403
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Ian Kelling
> Sent: Sunday, October 09, 2016 15:03
> 
> I've got patches in various projects, and I don't have time to keep up
> with the mailing list, but I'd like to help out with 
> maintenance of that
> code, or the functions/files it touches. People don't cc me. 
> I figure I
> could filter the list, test patches submitted, commits made, 
> mentions of
> files/functions, build filters based on the code I have in 
> the repo even
> if it's been moved or changed subsequently. I'm wondering what other
> people have implemented already for automation around this, or general
> thoughts. Web search is not showing me much.
> 

One thought would be to apply every patch automatically (to the branches of interest?). Then trigger on the [successful] changed
code. This would simplify the logic to working on the source only and not parsing the emails.

-Jason

