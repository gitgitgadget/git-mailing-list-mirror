From: Jeff King <peff@peff.net>
Subject: Re: Deleting branches in cogito
Date: Tue, 9 Jan 2007 10:16:11 -0500
Message-ID: <20070109151611.GD10633@coredump.intra.peff.net>
References: <11935db10701050229h215416afk9ac2008c4f176b36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 16:16:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Ii9-0005yk-Nz
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 16:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbXAIPQP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 10:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbXAIPQO
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 10:16:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3315 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932148AbXAIPQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 10:16:14 -0500
Received: (qmail 3435 invoked from network); 9 Jan 2007 10:16:25 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Jan 2007 10:16:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2007 10:16:11 -0500
To: Jonathan Trites <tritesnikov@gmail.com>
Content-Disposition: inline
In-Reply-To: <11935db10701050229h215416afk9ac2008c4f176b36@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36368>

On Fri, Jan 05, 2007 at 04:29:59AM -0600, Jonathan Trites wrote:

> Forgive my brain damage, but how does one go about deleting branches
> in cogito? I've been up and down google and the mailing lists and I
> can't find any mention of how one does this.

I haven't used cogito in a while, but IIRC, there isn't an automated way
to do it. You can always
  rm .git/branches/branch_name
Or did you mean a local branch (see below)?

> I see there are commands cg-switch, cg-branch-add, cg-branch-chg, and
> cg-branch-ls, but nowhere do I see a "cg-branch-rm" command or
> equivalent cg-switch command line option.

cg-switch works on local branches ('branches' in git, or 'heads', or
lines of development). Cogito remote branches (just 'branches' in
cogito, similar to 'remotes' in git) are handled by cg-branch-*.

For remote branches, see above.  If you want to delete a head or line of
development in cogito, I think you will need to use git-branch -d.

Hope that answers your question.

-Peff
