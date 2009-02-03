From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3] bash: offer to show (un)staged changes
Date: Tue, 3 Feb 2009 10:11:21 -0800
Message-ID: <20090203181121.GY26880@spearce.org>
References: <20090201222937.GP26880@spearce.org> <1233652854-29306-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 03 19:13:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPlQ-0004gc-Oz
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbZBCSLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZBCSLY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:11:24 -0500
Received: from george.spearce.org ([209.20.77.23]:37508 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbZBCSLX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 13:11:23 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C659838210; Tue,  3 Feb 2009 18:11:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233652854-29306-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108233>

Thomas Rast <trast@student.ethz.ch> wrote:
> Add a bit of code to __git_ps1 that lets it append '*' to the branch
> name if there are any unstaged changes, and '+' if there are any
> staged changes.
> 
> Since this is a rather expensive operation and will force a lot of
> data into the cache whenever you first enter a repository, you have to
> enable it manually by setting GIT_PS1_SHOWDIRTYSTATE to a nonempty
> value.  The configuration variable bash.showDirtyState can then be
> used to disable it again for some repositories.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> Shawn O. Pearce wrote:
> > But I'm a bit worried about the config --bool test in the prompt.
> > Its a new fork+exec we weren't doing before.  I wonder if we should
> > use a shell variable to consider whether or not this should even
> > be executed and try to shortcut out if not.
> 
> Ok, why not.  I changed the default of bash.showDirtyState to true
> since the user already opts in via GIT_PS1_SHOWDIRTYSTATE.

Yea, that seems right.

-- 
Shawn.
