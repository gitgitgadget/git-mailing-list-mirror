X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: reorganize cvs-migration.txt
Date: Wed, 06 Dec 2006 21:51:10 -0800
Message-ID: <7vu008uucx.fsf@assigned-by-dhcp.cox.net>
References: <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com>
	<20061206.105251.144349770.wl@gnu.org>
	<Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org>
	<Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061206171950.GD1714@fieldses.org>
	<20061206172450.GE1714@fieldses.org>
	<7v7ix47wbr.fsf@assigned-by-dhcp.cox.net>
	<20061207041805.GC3457@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 05:51:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207041805.GC3457@fieldses.org> (J. Bruce Fields's message
	of "Wed, 6 Dec 2006 23:18:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33552>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsCA7-0005G1-Gt for gcvg-git@gmane.org; Thu, 07 Dec
 2006 06:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031366AbWLGFvN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 00:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031388AbWLGFvN
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 00:51:13 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:56022 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1031366AbWLGFvM (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 00:51:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207055111.WPRH7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Thu, 7
 Dec 2006 00:51:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vhqb1V00K1kojtg0000000; Thu, 07 Dec 2006
 00:50:36 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> writes:

> diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
> index 6812683..773fc99 100644
> --- a/Documentation/cvs-migration.txt
> +++ b/Documentation/cvs-migration.txt
> @@ -1,113 +1,21 @@

This conflicted in a funny way with your own commit but I think
this version (773fc99 blob) supersedes its contents.

I munged only one line, though.  The title of this section 
should not be "a CVS repository" but "a shared repository" for
obvious reasons ;-).

> +Developing against a CVS repository
>  -----------------------------------
>  
> +Suppose a shared repository is set up in /pub/repo.git on the host
>  foo.com.  Then as an individual committer you can clone the shared
> +repository over ssh with:
>  
>  ------------------------------------------------
>  $ git clone foo.com:/pub/repo.git/ my-project

