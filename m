From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Sun, 01 Oct 2006 11:56:27 -0700
Message-ID: <7vd59b27c4.fsf@assigned-by-dhcp.cox.net>
References: <efc2no$eti$2@sea.gmane.org>
	<20060926213236.79160.qmail@web31815.mail.mud.yahoo.com>
	<7v64f9hku2.fsf@assigned-by-dhcp.cox.net>
	<200610012041.15296.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 20:56:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6UK-0002VW-VM
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 20:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWJAS43 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWJAS43
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 14:56:29 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54180 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932198AbWJAS42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 14:56:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061001185628.BAUK6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sun, 1 Oct 2006 14:56:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id V6wW1V00y1kojtg0000000
	Sun, 01 Oct 2006 14:56:30 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610012041.15296.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 1 Oct 2006 20:41:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28189>

Jakub Narebski <jnareb@gmail.com> writes:

> ... That means that we cannot distinguish really well (at 
> least color) between tree and blob entries.

Do we even say links are blue and underlined by forcing that in
our css?

Doesn't leading drwxr-xr-x mean anything?

Why is making the distinction important in the first place?

> In the case of shortlog/log/history/heads/tags view, to clearly mark 
> subject/title of a commit or tag as link, we would have to use default 
> link decoration....
> But underlined text is harder to read, and blue underlined text even 
> more so...

This is something in which I can see some more sense than tree
vs blob issue, but only as a principle issue.  In practice, the
list of commit subjects is the first thing users encounter, and
as long as there is some visual indication (e.g. mousing over it
makes it obvious it is something that is clickable), I think
users will quickly pick up that it will lead to the commit's
detail.
