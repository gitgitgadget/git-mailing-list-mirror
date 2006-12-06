X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 06 Dec 2006 09:44:56 -0800
Message-ID: <7v7ix47wbr.fsf@assigned-by-dhcp.cox.net>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org>
	<45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org>
	<Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org>
	<Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061206171950.GD1714@fieldses.org>
	<20061206172450.GE1714@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 17:45:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061206172450.GE1714@fieldses.org> (J. Bruce Fields's message
	of "Wed, 6 Dec 2006 12:24:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33498>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs0pS-0001LL-KY for gcvg-git@gmane.org; Wed, 06 Dec
 2006 18:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936945AbWLFRo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 12:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936957AbWLFRo7
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 12:44:59 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:56070 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S936945AbWLFRo6 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 12:44:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206174457.MCXO2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 12:44:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vVl71V00G1kojtg0000000; Wed, 06 Dec 2006
 12:45:07 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> writes:

> And some day we should move that whole final CVS annotate section
> elsewhere.

I agree that we should make that particular document shorter by
catering the immediate need of CVS migrant.  No need for git
marketting and showing off the power.

In that spirit, I think we can lose the section on 'annotate'
altogether now.  It was written in June 2005, way before
'annotate' and 'blame', both of which came in Feb 2006.

