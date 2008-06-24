Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,
	MSGID_FROM_MTA_HEADER,MSGID_NOFQDN1,PLING_QUERY,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: (qmail 2713 invoked by uid 111); 24 Jun 2008 11:42:32 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 07:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759705AbYFXLmV (ORCPT <rfc822;peff@peff.net>);
	Tue, 24 Jun 2008 07:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759655AbYFXLmV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 07:42:21 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60122 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759620AbYFXLmU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 07:42:20 -0400
Received: (qmail 12644 invoked by uid 90); 24 Jun 2008 11:42:18 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@google.com>
To:	Jakub Narebski <jnareb@gmail.com>
Cc:	"Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
Subject: Re: why is git destructive by default? (i suggest it not be!)
X-Mailer: Willow v0.02
Date:	Tue, 24 Jun 2008 11:29:43 -0000
Message-ID: <willow-jeske-01l5pWdEFEDjCjLX>
Received: from 67.188.42.104 at Tue, 24 Jun 2008 11:29:43 -0000
References: <200806241322.14224.jnareb@gmail.com>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5p7eVFEDjCZRD>
In-Reply-To: <200806241322.14224.jnareb@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

-- Jakub Narebski wrote:
> If they are using '-f', i.e. force, they should know and be sure what
> they are doing; it is not much different from 'rm -f *'.

Sure, no problem. I don't want the ability to "rm -f *". I'm raising my hand
and saying "I don't want the power to do these things, so just turn off all the
git commands that could be destructive and give me an alternate way to do the
workflows I need to do". Just like a normal user on a unix machine doesn't run
around with the power to rm -f /etc all the time, even though they may be able
to su to root.

Let me guess, you're always running euid==0. :)
