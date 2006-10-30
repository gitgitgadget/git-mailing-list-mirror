X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move deny_non_fast_forwards handling completely into receive-pack.
Date: Mon, 30 Oct 2006 15:06:45 -0800
Message-ID: <7vpsc9tncq.fsf@assigned-by-dhcp.cox.net>
References: <20061030223518.GF5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 23:07:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030223518.GF5775@spearce.org> (Shawn Pearce's message of
	"Mon, 30 Oct 2006 17:35:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30551>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GegDg-0001Wh-E8 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 00:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161537AbWJ3XGr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 18:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161532AbWJ3XGr
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 18:06:47 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8681 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1161343AbWJ3XGq
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 18:06:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030230646.YALR18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 18:06:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gn6S1V00f1kojtg0000000 Mon, 30 Oct 2006
 18:06:27 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> The 'receive.denynonfastforwards' option has nothing to do with
> the repository format version.  Since receive-pack already uses
> git_config to initialize itself before executing any updates we
> can use the normal configuration strategy and isolate the receive
> specific variables away from the core variables.

Sounds sane.  Thanks.

