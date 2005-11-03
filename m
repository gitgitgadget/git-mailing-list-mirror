From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now What?
Date: Thu, 03 Nov 2005 14:51:31 -0800
Message-ID: <7vwtjp9wgc.fsf@assigned-by-dhcp.cox.net>
References: <E1EXTw5-00063o-Gt@jdl.com>
	<7vll05e9j3.fsf@assigned-by-dhcp.cox.net>
	<200511032317.15393.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 23:52:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXnvk-0007B2-4R
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbVKCWvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVKCWvd
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:51:33 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29828 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932612AbVKCWvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 17:51:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103225109.XHPY4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 17:51:09 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11107>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Thursday 03 November 2005 21:55, Junio C Hamano wrote:
>> be better suited to Wiki.  I wonder if there is a Wiki whose
>> document storage format is in asciidoc, and uses git as its
>> revision control backend.
>
> I wonder if Git is the best SCM for a Wiki, as you want per-file
> revisions in a Wiki: when reverting a page to a previous version,
> this should not modify other pages.

Sorry, I do not see why per-file revisioning is mandatory.
Wouldn't revert or edit of a single page be just a new commit of
the new whole tree with just a single path changed?

I understand that whole tree history may not be much useful in
Wiki environment, but I do not see why it would hurt to have a
whole tree history (except perhaps the commit log may not be
very useful).

In fact, wouldn't svnwiki already does the same thing?
