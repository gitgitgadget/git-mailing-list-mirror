X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core.  Call with explicit path.
Date: Fri, 08 Dec 2006 12:45:35 -0800
Message-ID: <7v3b7qi0b4.fsf@assigned-by-dhcp.cox.net>
References: <elc6g3$v1m$1@sea.gmane.org> <20061208193718.GA11906@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 20:45:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061208193718.GA11906@soma> (Eric Wong's message of "Fri, 8 Dec
	2006 11:37:18 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33740>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsmbE-0002aW-I7 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761188AbWLHUpi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761192AbWLHUph
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:45:37 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54142 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1761187AbWLHUph (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 15:45:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208204536.ZDEY20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 15:45:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wLkz1V00A1kojtg0000000; Fri, 08 Dec 2006
 15:44:59 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
>> 
>> git-sh-setup isn't a 'normal' binary, in that it should be called by
>> bash only and not run in a subshell. Therefore, it should not be installed
>> in a executable directory, but rather in $prefix/share/git-core/
>
> This seems to break existing hooks, or at least old repositories can
> be stuck using an old version of git-sh-setup in those hooks.

Honestly speaking, I do not think this patch is worth it.
People who care deeply enough should just use gitexecdir that is
separate from bindir.

