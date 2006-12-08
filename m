X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Fri, 08 Dec 2006 11:18:16 -0800
Message-ID: <7vpsaui4cn.fsf@assigned-by-dhcp.cox.net>
References: <loom.20061208T131919-178@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 19:18:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <loom.20061208T131919-178@post.gmane.org> (pazu@pazu.com.br's
	message of "Fri, 8 Dec 2006 12:36:31 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33724>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GslEj-0007XS-Cu for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968828AbWLHTSS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968832AbWLHTSS
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:18:18 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:56015 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968828AbWLHTSR (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 14:18:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208191817.JFBZ7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 14:18:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wKHg1V00J1kojtg0000000; Fri, 08 Dec 2006
 14:17:41 -0500
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Pazu <pazu@pazu.com.br> writes:

> # Please enter the commit message for your changes.
> # (Comment lines starting with '#' will not be included)
> # On branch refs/heads/next
> # Updated but not checked in:
> #   (will commit)
> #
> #	modified:   perl/Makefile
> #	modified:   var.c
>
> Here's where the magic would happen. Removing the line "modified: var.c" would
> remove var.c from this commit. Of course, the template message should be
> modified to tell the user he can do that.
>
> So, what do you think about this?

Personally, I would refuse to use such a modified git, because
often the first thing I would do in the commit log buffer is
check the listed files and remove the '# ...' lines while
typing.  I do not want that to affect the set of changes I
staged in any way.

But maybe that is just me.
