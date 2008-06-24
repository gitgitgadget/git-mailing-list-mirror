From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 21:59:07 +0200
Message-ID: <20080624195907.GI8421@neumann>
References: <alpine.DEB.1.00.0806241515460.9925@racer>
	<20080624163810.GA4654@sigill.intra.peff.net>
	<alpine.DEB.1.00.0806241750030.9925@racer>
	<alpine.DEB.1.00.0806241808400.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:00:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEgZ-00040j-E9
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYFXT7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYFXT7T
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:59:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:56313 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbYFXT7T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:59:19 -0400
Received: from [127.0.1.1] (p5B133023.dip0.t-ipconnect.de [91.19.48.35])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1KBEfT1j39-0007kd; Tue, 24 Jun 2008 21:59:08 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806241808400.9925@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX18PSeZEIczq97lGJilYrBEfqTA+V7uLKUcBFVN
 nbznNTy0FPxVPaJf5sKqSLhKAq2bAl29LVM3Jl/Yg8OufXPMzA
 aJajIwB1HLpelPFZapJ4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86131>

On Tue, Jun 24, 2008 at 06:09:28PM +0100, Johannes Schindelin wrote:
> So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.
And maybe this one squashed on it, to add completion support for the
new subcommands.


---
 contrib/completion/git-completion.bash |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ebf7cde..014adab 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -511,7 +511,9 @@ _git_add ()
 
 _git_bisect ()
 {
-	local subcommands="start bad good reset visualize replay log"
+	local subcommands="
+		start bad good reset visualize replay log fixed unfixed
+		"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
-- 
1.5.6.64.g7dc1df
