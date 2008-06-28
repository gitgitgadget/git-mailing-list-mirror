Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MSGID_FROM_MTA_HEADER,
	MSGID_NOFQDN1,RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 6236 invoked by uid 111); 28 Jun 2008 01:09:21 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 27 Jun 2008 21:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbYF1BJJ (ORCPT <rfc822;peff@peff.net>);
	Fri, 27 Jun 2008 21:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbYF1BJI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 21:09:08 -0400
Received: from w2.willowmail.com ([64.243.175.54]:33147 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752622AbYF1BJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 21:09:08 -0400
Received: (qmail 32069 invoked by uid 90); 28 Jun 2008 01:08:58 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@willowmail.com>
To:	"Robert Anderson" <rwa000@gmail.com>
Cc:	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
Subject: Re: An alternate model for preparing partial commits
X-Mailer: Willow v0.02
Date:	Sat, 28 Jun 2008 00:22:23 -0000
Message-ID: <willow-jeske-01l7er6OFEDjCcEC>
Received: from 67.188.42.104 at Sat, 28 Jun 2008 00:22:23 -0000
References: <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	<willow-jeske-01l7H4tHFEDjCgPV-01l7buicFEDjCagd>
In-Reply-To: <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

-- Robert Anderson wrote:
> Possibly a succinct way of moving this conversation forward is to say that:
>
> What is desired is a workflow where partial commits can be tested,
> when it is desirable not to change history.

Why don't we just make a model where history changes are handled safetly? Then
we don't have to be afraid to publish DAGs we may want to change later.
