X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: A call for better git-rebase messages
Date: Tue, 19 Dec 2006 02:30:30 -0800
Message-ID: <7v64c8rxdl.fsf@assigned-by-dhcp.cox.net>
References: <em8e32$s7b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 10:30:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <em8e32$s7b$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	19 Dec 2006 11:17:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34814>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcF0-0000zG-EW for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932750AbWLSKac (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWLSKab
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:30:31 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45783 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932750AbWLSKab (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 05:30:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219103031.UNUU2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 05:30:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0aWi1W00W1kojtg0000000; Tue, 19 Dec 2006
 05:30:43 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

>  $ git rebase abort
>  mkdir: cannot create directory `.dotest': File exists
>
>  It seems that I cannot create a .dotest directory, and I wonder if you
>  are in the middle of patch application or another rebase.  If that is not
>  the case, please rm -fr .dotest and run me again.  I am stopping in case
>  you still have something valuable there.
>
> Why we do not tell to run "git rebase --abort" here? I think the command
> know that it is a middle of git-rebase, not the middle of git-am...

Does it?  At least the original author of the command does not
know if you did this:

	$ git am mbox
        ... ugh, conflicted.
	$ git rebase master
