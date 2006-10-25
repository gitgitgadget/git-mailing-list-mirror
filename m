X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 12:53:25 -0700
Message-ID: <7v4ptsp3yi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<453A7D7E.8060105@utoronto.ca>
	<20061022074513.GF29927@artax.karlin.mff.cuni.cz>
	<200610221105.26421.jnareb@gmail.com>
	<845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
	<87zmbozau2.wl%cworth@cworth.org>
	<20061022185350.GW75501@over-yonder.net>
	<Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	<20061023222131.GB17019@over-yonder.net> <453F41DE.6090405@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 19:54:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <453F41DE.6090405@op5.se> (Andreas Ericsson's message of "Wed, 25
	Oct 2006 12:52:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30097>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcopP-0002Zo-U6 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 21:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932278AbWJYTx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 15:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWJYTx1
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 15:53:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49388 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S932278AbWJYTx0
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 15:53:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025195325.CJWB13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 15:53:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ejt81V00Q1kojtg0000000 Wed, 25 Oct 2006
 15:53:09 -0400
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> See the attached screenshot. This is from qgit --all on the git
> repository, but the DAG output is identical to that of gitk. Note in
> particular the 'pu' and 'next' branches. By scrolling down, I can
> easily see the branch-point of any of them.

Looking at this picture I noticed the lack of circles or
rectangles on six commits near the tip of "pu" branch.  Nobody
should be doing an Octopus so it might be a non-issue, but
somehow it looks fishy.

