X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use new .git/config for storing "origin" shortcut repository
Date: Sat, 25 Nov 2006 19:52:01 -0800
Message-ID: <7vzmaeyie6.fsf@assigned-by-dhcp.cox.net>
References: <ekafpm@sea.gmane.org> <200611260003.31025.andyparkins@gmail.com>
	<Pine.LNX.4.63.0611260141390.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 03:52:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611260141390.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 26 Nov 2006 01:48:11 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32324>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoB3n-0002sO-UX for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967284AbWKZDwE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967286AbWKZDwE
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:52:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32465 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S967284AbWKZDwC
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:52:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126035202.IVEQ9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Sat, 25
 Nov 2006 22:52:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rFrW1V00s1kojtg0000000; Sat, 25 Nov 2006
 22:51:31 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This hunk is wrong: "git-repo-config remote.bla.fetch b" will _overwrite_ 
> remoter.bla.fetch. To avoid that, you have to use "git repo-config 
> remote.bla.fetch b ^$". (The last argument is a regular expression which 
> has to be matched by the value-to-be-oreplaced.)

Yup, one of the joys of working the config file everybody seems
to like ;-).
