X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 03:32:07 -0800
Message-ID: <7vbqn22w20.fsf@assigned-by-dhcp.cox.net>
References: <200611201157.23680.litvinov2004@gmail.com>
	<200611201022.10656.andyparkins@gmail.com>
	<7virha4cnm.fsf@assigned-by-dhcp.cox.net>
	<200611201101.04456.andyparkins@gmail.com>
	<ejs2lp$2r4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 11:32:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejs2lp$2r4$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	20 Nov 2006 12:15:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31907>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm7Nk-0003uu-Vo for gcvg-git@gmane.org; Mon, 20 Nov
 2006 12:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933739AbWKTLcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 06:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933755AbWKTLcJ
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 06:32:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:32216 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S933739AbWKTLcI
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 06:32:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120113208.SIKF5575.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 06:32:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ozXf1V0041kojtg0000000; Mon, 20 Nov 2006
 06:31:39 -0500
To: jnareb@gmail.com
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> That said, it should be fairly easy (if not that useful in true projects
> as I understand it, as stated above) to add to copy detection detection of
> pure copies by comparing hashes.

That is already done as a performance measure (notice the double
loop controlled with "contents_too" in diffcore_rename()).
