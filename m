X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] add test case for recursive merge
Date: Sat, 09 Dec 2006 19:10:15 -0800
Message-ID: <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
References: <20061207101707.GA19139@spearce.org>
	<Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 03:10:24 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 10 Dec 2006 01:18:03 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33863>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtF54-0007nx-5b for gcvg-git@gmane.org; Sun, 10 Dec
 2006 04:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759876AbWLJDKS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 22:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759892AbWLJDKS
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 22:10:18 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62158 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759876AbWLJDKR (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 22:10:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210031016.RIDC4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 22:10:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wrAS1V00g1kojtg0000000; Sat, 09 Dec 2006
 22:10:27 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> this test succeeds consistently on the machine where I tested it 
> originally, but fails on another of my machines, but only when run without 
> "-v". Very annoying. I will not have time to investigate until Monday, 
> though.

There seem to be cases where stage #1 contains blob 'B' or 'A'
or nothing depending on something totally random.  Ring a bell?

