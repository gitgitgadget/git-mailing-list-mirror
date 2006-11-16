X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: multi-project repos
Date: Thu, 16 Nov 2006 14:44:58 -0800
Message-ID: <7vmz6r3tat.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl>
	<Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
	<455C94FA.3050903@xs4all.nl>
	<Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
	<455CA2A8.5010700@xs4all.nl>
	<Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
	<Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 22:45:27 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 16 Nov 2006 23:21:55 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31629>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkpyj-00019a-OD for gcvg-git@gmane.org; Thu, 16 Nov
 2006 23:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755484AbWKPWpA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 17:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbWKPWpA
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 17:45:00 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:28846 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1755482AbWKPWo7
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 17:44:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116224459.PYKV18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 17:44:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nal51V00G1kojtg0000000; Thu, 16 Nov 2006
 17:45:05 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> _If_ you use git-fetch directly you virtually always want to store the 
> result. I was tempted quite often to submit a patch which adds a command 
> line switch --no-warn, which is passed to git-fetch by git-pull, and 
> without which git-fetch complains if the branch-to-be-fetched is not 
> stored right away (and refuses to go along).
>
> _Also_, git-pull not storing the fetched branches at least temporarily 
> often annoyed me: the pull did not work, and the SHA1 was so far away I 
> could not even scroll to it. The result: I had to pull (and fetch!) the 
> whole darned objects again. Again, I was tempted quite often to submit a 
> patch which makes git-pull fetch the branches into refs/fetch-temp/* and 
> only throw them away when the merge succeeded.

I think the earlier write-up by Linus on magic HEADs would help
documenting FETCH_HEAD better.
