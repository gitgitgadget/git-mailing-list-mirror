X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Optionally check for uncommitted changes before switching branches.
Date: Thu, 07 Dec 2006 15:01:12 -0800
Message-ID: <7vejrbqpjb.fsf@assigned-by-dhcp.cox.net>
References: <6ed9774cb95e873e76a4ac406dd740caf954bd3b.1165485618.git.spearce@spearce.org>
	<20061207100224.GB12966@spearce.org>
	<7vu007sdhp.fsf@assigned-by-dhcp.cox.net>
	<20061207194358.GF12143@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 23:01:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207194358.GF12143@spearce.org> (Shawn Pearce's message of
	"Thu, 7 Dec 2006 14:43:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33646>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsSF6-0003tD-OI for gcvg-git@gmane.org; Fri, 08 Dec
 2006 00:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163752AbWLGXBR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 18:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163664AbWLGXBQ
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 18:01:16 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:63452 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163752AbWLGXBN (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 18:01:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207230113.QBFY3525.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 18:01:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vz1N1V00j1kojtg0000000; Thu, 07 Dec 2006
 18:01:23 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> What about when this option is enabled then -m means do what we
> did before, and -m -m (or -mm, or -m2) does what -m does when the
> option is false?

Wouldn't --force be more appropriate?
