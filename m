X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 14:59:15 -0800
Message-ID: <7v7iyhv29o.fsf@assigned-by-dhcp.cox.net>
References: <92622.251.qm@web31812.mail.mud.yahoo.com>
	<7vy7qyw6w6.fsf@assigned-by-dhcp.cox.net>
	<200610301043.22033.jnareb@gmail.com>
	<200610301458.33634.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:59:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610301458.33634.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 30 Oct 2006 14:58:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30547>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geg6C-0008RD-NL for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422743AbWJ3W7R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWJ3W7R
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:59:17 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33993 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1422743AbWJ3W7Q
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:59:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030225916.REWS18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 17:59:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gmyw1V00Y1kojtg0000000 Mon, 30 Oct 2006
 17:58:57 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I have realized that it is not as easy as it sounds, at least for the
> git-diff-tree output...

I do not think so.a The output is designed to be machine
parsable.  See Documentation/diff-format.txt and also please
refer to 65a9289d:diff-helper.c for a sample code to see how to
parse the output.


