From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] glossary: explain "master" and "origin"
Date: Tue, 10 Jan 2006 16:36:45 -0500
Message-ID: <20060110213645.GF13450@fieldses.org>
References: <Pine.LNX.4.63.0601102226130.649@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jan 10 22:36:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwRAg-0001Up-Cp
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 22:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWAJVgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 16:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWAJVgs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 16:36:48 -0500
Received: from mail.fieldses.org ([66.93.2.214]:23944 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932354AbWAJVgr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 16:36:47 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1EwRAb-0005zn-Rg; Tue, 10 Jan 2006 16:36:45 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601102226130.649@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14459>

On Tue, Jan 10, 2006 at 10:26:46PM +0100, Johannes Schindelin wrote:
> +origin::
> +	The default upstream branch. Most projects have one upstream 
> +        project which is tracked, and augmented with local changes which
> +        eventually get merged back. You never commit to this branch,
> +	unless you are maintaining the upstream project.

The last line is somewhat confusing--a naive reader might take it to
mean that as an upstream maintainer it would make sense to commit to a
branch named "origin".  How about something like this?

	"The default upstream branch.  Most projects have one upstream
	project which they track.  This is is the branch used for
	tracking that project.  New updates from upstream will be
	fetched into this branch, but you should never commit to it
	yourself."

--b.
