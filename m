From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 12:57:30 -0700
Message-ID: <7vvemsymdx.fsf@assigned-by-dhcp.cox.net>
References: <egfo99$lg6$2@sea.gmane.org>
	<20061010191904.99261.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 21:57:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXNjK-0008My-O0
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 21:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWJJT5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 15:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWJJT5c
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 15:57:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10693 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030236AbWJJT5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 15:57:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010195730.FRDD6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 15:57:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YjxZ1V00E1kojtg0000000
	Tue, 10 Oct 2006 15:57:33 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061010191904.99261.qmail@web31809.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 10 Oct 2006 12:19:04 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28660>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Or,
>    "Click on the 'blob' link to get the ... Click on the 'tree' link to
>     get the ... Oh you didn't know what a 'tree' or 'blob' object is?
>     A 'blob' is ... A 'tree' is ..."
>
> At which point the engineer has lost 90% of his interest.
>
> It even gets even worse for the obnoxious "tree" link next to each commit
> in shortlog view:
>    "The tree link is the the tree object which is part of a commit object.
>     Oh you don't know the internals of a commit object?  A commit object
>     binds a tree object and a (parent) commit object, but blah, blah, blah..."

Isn't that a simple "labelling" question?  I do not think
anybody minds to show clickable string "contents" (instead of
"blob" or "tree") at the places you mention above and if we did
so everybody would be happy, right?
