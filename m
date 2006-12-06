X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git patch
Date: Wed, 06 Dec 2006 02:00:57 -0800
Message-ID: <7vslft738m.fsf@assigned-by-dhcp.cox.net>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org>
	<45760545.2010801@gmail.com>
	<Pine.LNX.4.63.0612060053400.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<45761451.8020006@gmail.com>
	<Pine.LNX.4.63.0612060157020.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4576937D.1070402@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 10:02:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4576937D.1070402@xs4all.nl> (Han-Wen Nienhuys's message of "Wed,
	06 Dec 2006 10:55:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33418>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtbZ-00087E-0s for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760412AbWLFKBA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760416AbWLFKBA
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:01:00 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54626 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760408AbWLFKA6 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 05:00:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206100058.DGIB4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Wed, 6
 Dec 2006 05:00:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id vN0N1V00H1kojtg0000000; Wed, 06 Dec 2006
 05:00:23 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> I think it would be more logical to show those diffs as part of
> git-status and perhaps git-commit, eg.
>
>   git-commit --dry-run <commitoptions>
>
> shows the diff of what would be committed
>
>   git-status --diff
>
> shows diffs of modified files in the working tree.
>
> This makes it more clear what each diff means.

Just in case people did not know, "git status" is pronounced as
"git commit --dry-run".

It takes exactly the same set of parameters as "git commit", and
shows what would have been in the commit log message editor as
the status comments.

And it even takes the "-v" option that "git commit" takes.

