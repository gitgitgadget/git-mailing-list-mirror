X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] E-mail aliases
Date: Tue, 12 Dec 2006 10:37:48 -0800
Message-ID: <7vvekhufib.fsf@assigned-by-dhcp.cox.net>
References: <b0943d9e0612120449k4a13ac85t313df1e460ed46e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 18:38:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <b0943d9e0612120449k4a13ac85t313df1e460ed46e4@mail.gmail.com>
	(Catalin Marinas's message of "Tue, 12 Dec 2006 12:49:26 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34121>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCW4-0002EF-K4 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751573AbWLLSiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWLLSiI
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:38:08 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49961 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751573AbWLLSiF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 13:38:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212183749.XZBR29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Tue, 12
 Dec 2006 13:37:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xudA1V00D1kojtg0000000; Tue, 12 Dec 2006
 13:37:10 -0500
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> sets the "To:" header to "linux-kernel@vger.kernel.org".
>
> The aliases are read from the [aliases] section in the gitconfig files
> ("git repo-config aliases.lkml" in this case). I just want to make
> sure than there isn't any other intended use for the [aliases] section
> in the config files.

[alias] is used to hold command-line alias, and it seems
slightly confusing to have two sections that mean something
quite different.

Perhaps

[mail "alias"]
	lkml = linux-kernel@vger.kernel.org

if we are going to have other mail-related configurations that
might turn out be handy.  send-email would want smtp-server in
there, for example.

