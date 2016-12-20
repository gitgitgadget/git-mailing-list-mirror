Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9AA1FF40
	for <e@80x24.org>; Tue, 20 Dec 2016 05:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbcLTF32 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 00:29:28 -0500
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:34794
        "EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751088AbcLTF31 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Dec 2016 00:29:27 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Dec 2016 00:29:27 EST
Received: from wheezy.local ([82.181.81.240])
        by :SMTPAUTH: with SMTP
        id JCricNytooeIsJCrocfMeL; Mon, 19 Dec 2016 22:21:38 -0700
Date:   Tue, 20 Dec 2016 07:21:30 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Karsten Blees <blees@dcon.de>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] mingw: consider that UNICODE_STRING::Length counts bytes
Message-ID: <20161220052130.GA10028@wheezy.local>
References: <1482183120-21592-1-git-send-email-max@max630.net>
 <xmqqtw9zmvjq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw9zmvjq.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Envelope: MS4wfLNc9KjUohUxn17i8ELmFIsfON10z8/NwoiM99wA72pmVaGynPCIMuPipQ7yXZB13W1Q1mup9O7gj5j4bZ3cEzkcJTqGbtpOsYCJFN2F9NPy61ct2+yG
 jJ+SuMhXGFXaz2jGufxQGMBIMa7bRu/kX3NnSZWPFaHmnBL51bG5r5hXyM4dOihYi2AwACu+scFTNChxJYb3omaWrn9h5jNfmE2Etg7PTXB3RsZH1uWtK9q3
 6do29HxTq7WJ/+5oVkZD0cmnr+z3aw56OC8QMl8mxbw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 01:57:29PM -0800, Junio C Hamano wrote:
> Max, I see this is a resend from a few days ago

Sorry about resend. For some reason I don't get the list
copy (might be some clever duplicate elimination in my
forwardings), and marc.info seems to be slow to update, so I
had no indication the first message got into list. Now I see
they are there in the other archive.

PS: probably http://vger.kernel.org/vger-lists.html#git
should be updated because there is no archive at gmane
anymore.

-- 
Max
