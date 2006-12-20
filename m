X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision: add --no-full-diff command line option
Date: Wed, 20 Dec 2006 11:55:05 -0800
Message-ID: <7vmz5ie412.fsf@assigned-by-dhcp.cox.net>
References: <20061220060102.GA540@coredump.intra.peff.net>
	<7v8xh3j86h.fsf@assigned-by-dhcp.cox.net>
	<20061220084107.GA6895@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 19:55:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061220084107.GA6895@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 20 Dec 2006 03:41:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34956>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx7Wz-0005lS-Pr for gcvg-git@gmane.org; Wed, 20 Dec
 2006 20:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030331AbWLTTzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWLTTzJ
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 14:55:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:65229 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030331AbWLTTzI (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 14:55:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220195505.KLII20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 14:55:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 17uP1W01K1kojtg0000000; Wed, 20 Dec 2006
 14:54:24 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On Wed, Dec 20, 2006 at 12:14:14AM -0800, Junio C Hamano wrote:
>
>> > I use --full-diff all the time, so this should save some typing. I can't
>> > think of a time when I wouldn't want it on, but if there is, we probably
>> > need a --no-full-diff.
>> 
>> Absolutely.
>
> I took this to mean "absolutely we need --no-full-diff." :)

Modulo s/\.$/, if we were to do log.fulldiff/, yes.

> I note that --full-diff sets rev->diff = 1. The log.fulldiff config
> option does not, and nor does --no-full-diff unset it. However, I'm not
> sure it makes sense to set it. Doing "git-log --full-diff" outputs an
> extra line (separating the diff from the commit log) but since we
> haven't told it any type of diff to output, the diff is blank. And if we
> had told it a type, then that would have turned on rev->diff. So I don't
> see a point in setting it.

I need to think about this one.
