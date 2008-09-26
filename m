From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/5] git-gui: Support for "Locators" - address templates
Date: Fri, 26 Sep 2008 07:33:51 -0700
Message-ID: <20080926143351.GY3669@spearce.org>
References: <20080924221249.037449176@suse.cz> <alpine.LNX.1.00.0809251705260.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pasky@suse.cz, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:35:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEPN-0005AX-K9
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYIZOdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbYIZOdx
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:33:53 -0400
Received: from george.spearce.org ([209.20.77.23]:38070 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbYIZOdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:33:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D1A203835F; Fri, 26 Sep 2008 14:33:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0809251705260.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96857>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Thu, 25 Sep 2008, pasky@suse.cz wrote:
> 
> > This patch allows "locators" to be configured and used in the GUI,
> > basically as URL templates the input string is subsituted into.
> 
> Can this be set up to use the "url.<base>.insteadOf" configuration? Part 
> of my goal with that feature was to make it easy for me to reference 
> projects on my work's central repository store. That is, put in your 
> ~/gitconfig:
> 
> [url "git://repo.or.cz/"]
> 	insteadOf = repo:
> 
> And "git clone repo:alt-git" works.

That's a good idea.

When I saw the locator patch come by I thought a bit about the
insteadOf idea, but didn't make it far enough to open an email
discussion about it.

Pasky?
 
-- 
Shawn.
