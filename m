X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: should git download missing objects?
Date: Mon, 13 Nov 2006 12:22:13 -0800
Message-ID: <7vac2v6qru.fsf@assigned-by-dhcp.cox.net>
References: <ej7fgp$8ca$1@sea.gmane.org>
	<7vwt60bggs.fsf@assigned-by-dhcp.cox.net>
	<20061113194532.GA4547@steel.home>
	<20061113195414.GD17244@spearce.org>
	<20061113200358.GF7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 20:22:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061113200358.GF7201@pasky.or.cz> (Petr Baudis's message of
	"Mon, 13 Nov 2006 21:03:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31319>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjiJz-0007qd-6g for gcvg-git@gmane.org; Mon, 13 Nov
 2006 21:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755261AbWKMUWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 15:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbWKMUWQ
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 15:22:16 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40130 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1755261AbWKMUWP
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 15:22:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061113202214.TIVL296.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Mon, 13
 Nov 2006 15:22:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id mLMo1V00C1kojtg0000000; Mon, 13 Nov 2006
 15:21:49 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> ... Junio, what's its life
> expectancy? I guess this usage scenario is something to take into
> account when thinking about removing it, I know that I wanted to get rid
> of it in the past but now my opinion is changing.

It uses the same commit walker semantics and mechanism so I do
not think it is too much burden to carry it, but I'd rather have
something that works over git native protocol if we really care
about this.  People without ssh access needs to be able to
recover over git:// protocol.

