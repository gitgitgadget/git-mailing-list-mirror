From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: always use --first-parent
Date: Thu, 6 Sep 2007 17:37:45 -0700
Message-ID: <20070907003745.GA24713@hand.yhbt.net>
References: <11891232082570-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 02:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITRr6-0006lM-EB
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 02:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbXIGAhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 20:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbXIGAhr
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 20:37:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60582 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964821AbXIGAhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 20:37:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 88D232DC08D;
	Thu,  6 Sep 2007 17:37:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11891232082570-git-send-email-hjemli@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57956>

Lars Hjemli <hjemli@gmail.com> wrote:
> This makes git-svn unconditionally invoke git-log with --first-parent when
> it is trying to discover its upstream subversion branch and collecting the
> commit ids which should be pushed to it with dcommit. The reason for always
> using --first-parent is to make git-svn behave in a predictable way when the
> ancestry chain contains merges with other git-svn branches.
> 
> Since git-svn now always uses 'git-log --first-parent' there is no longer
> any need for the --first-parent option to git-svn, so this is removed.
> 
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
> 
> I'd like to add a '--upstream <revspec>' option, just for completeness, but
> that will also require a new test script and now it's way past my bedtime.

Sure thing.  We can work on getting --upstream another time, but for now
this is probably the best way to allow merges to work with git-svn.

Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
