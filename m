X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach receive-pack how to keep pack files when unpacklooseobjects = 0.
Date: Mon, 30 Oct 2006 15:04:55 -0800
Message-ID: <7vu01ltnfs.fsf@assigned-by-dhcp.cox.net>
References: <20061030223615.GH5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 23:05:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030223615.GH5775@spearce.org> (Shawn Pearce's message of
	"Mon, 30 Oct 2006 17:36:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30550>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GegBg-000182-EM for gcvg-git@gmane.org; Tue, 31 Oct
 2006 00:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161536AbWJ3XE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 18:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161371AbWJ3XE5
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 18:04:57 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17032 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1161537AbWJ3XE4
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 18:04:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030230456.JRYX2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 18:04:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gn4c1V00S1kojtg0000000 Mon, 30 Oct 2006
 18:04:37 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Currently this leaves every received pack as a kept pack.  We really
> don't want that as received packs will tend to be small.

Until this is resolved, I feel there should be some way to
control the behaviour, so while I agree with the general
direction, I think the patch to revert the sender's wish should
come at the end.
