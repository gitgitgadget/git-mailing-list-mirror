Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MSGID_FROM_MTA_HEADER,
	MSGID_NOFQDN1,RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 4422 invoked by uid 111); 27 Jun 2008 20:58:55 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 27 Jun 2008 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbYF0U6o (ORCPT <rfc822;peff@peff.net>);
	Fri, 27 Jun 2008 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbYF0U6n
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 16:58:43 -0400
Received: from w2.willowmail.com ([64.243.175.54]:33090 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751328AbYF0U6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 16:58:42 -0400
Received: (qmail 28588 invoked by uid 90); 27 Jun 2008 20:58:37 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@willowmail.com>
To:	Jakub Narebski <jnareb@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: An alternate model for preparing partial commits
X-Mailer: Willow v0.02
Date:	Fri, 27 Jun 2008 20:51:41 -0000
Message-ID: <willow-jeske-01l7=918G8FEDjCYXH>
Received: from 72.14.229.81 at Fri, 27 Jun 2008 20:51:41 -0000
References: <g43jlg$54g$1@ger.gmane.org>
	<willow-jeske-01l7H4tHFEDjCgPV-01l7[1OFFEDjCYJV>
In-Reply-To: <g43jlg$54g$1@ger.gmane.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

-- Jakub Narebski wrote:
> git rebase --interactive?
> Any patch management interface (StGIT, Guilt)?

Yes, as I said, that set of operations can be performed with git today.

What git can't do, is let me "supercede" the old DAG-subset, so people I shared
them with can get my new changes without hurting their world. Currently git
seems to rely on the idea that "if you accept changes into your tree that will
be later rebased, it's up to you to figure it out". I don't see why that is the
case.
