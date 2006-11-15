X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 20:58:03 -0800
Message-ID: <7vzmatqpb8.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 04:58:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611142306090.2591@xanadu.home> (Nicolas Pitre's
	message of "Tue, 14 Nov 2006 23:20:51 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31416>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkCr5-00068o-RD for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966644AbWKOE6L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966646AbWKOE6L
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:58:11 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14060 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S966644AbWKOE6J
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 23:58:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115045809.QFAK20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 23:58:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id msyE1V00l1kojtg0000000; Tue, 14 Nov 2006
 23:58:15 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> ...  We simply won't gain anything trying to teach people "a pull 
> in HG is a download in GIT".  If a pull becomes the same thing for both 
> then it's one less oddball in the GIT interface.

I personally do not have any issue with that, as long as you
would help us convert existing users that what was known as pull
is not available and new pull means fetching only.

If I recall correctly in this thread, you also advocated to
always have tracking branches.  I am a bit worried about losing
the promiscuous pull usage, which can easily become a regression
for people like Linus in the integrator role unless done with an
escape hatch.
