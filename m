Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6922018F
	for <e@80x24.org>; Sun, 17 Jul 2016 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbcGQR0a (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 13:26:30 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:60148 "EHLO shell1.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbcGQR0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 13:26:30 -0400
Received: from nad.dad.org (m206-54.dsl.tsoft.com [198.144.206.54])
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTP id u6HHQShO005227;
	Sun, 17 Jul 2016 10:26:28 -0700 (PDT)
	(envelope-from norm@dad.org)
Message-Id: <201607171726.u6HHQShO005227@shell1.rawbw.com>
X-Authentication-Warning: shell1.rawbw.com: Host m206-54.dsl.tsoft.com [198.144.206.54] claimed to be nad.dad.org
To:	l.s.r@web.de
cc:	git@vger.kernel.org, norm@dad.org
Subject: Re: Question: Getting 'git diff' to generate /usr/bin/diff output
In-reply-to: Your message of "Sun, 17 Jul 2016 14:18:01 +0200."
             <578B7779.6090507@web.de>
Reply-To: Norman Shapiro <norm@dad.org>
From:	norm@dad.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26696.1468776387.1@nad.dad.org>
Date:	Sun, 17 Jul 2016 10:26:27 -0700
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

<l.s.r@web.de> writes:
>
>The other replies covered how to use the system's own diff instead.
>Just curious: What makes using git diff difficult and its output hard to
>deal with for you?

In decreasing importance order:

I am 84 years old. I have been using /usr/bin/diff for more than four decades.
And having to learn how to read the output of 'git diff' makes learning how
to use git a more difficult trick for this old dog to learn. True, the diff of
today is very different from the diff of 1972, but the changes happened
gradually.

I have scripts which process the output of /usr/bin/diff.

'git diff' outputs escape characters which clutter my terminal. Yes, I can sed
them out, but then why are they there?


    Norman Shapiro
