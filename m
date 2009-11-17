From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Document git-svn's first-parent rule
Date: Mon, 16 Nov 2009 23:42:08 -0800
Message-ID: <20091117074208.GA337@dcvr.yhbt.net>
References: <ea845c8757a629d692bb6cd3827887f0e811c044.1258366486.git.trast@student.ethz.ch> <20091116231455.GA13460@dcvr.yhbt.net> <7vd43his6n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 08:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAIhh-0005fr-BG
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 08:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbZKQHmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 02:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbZKQHmG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 02:42:06 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33969 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755749AbZKQHmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 02:42:05 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B55C1F509;
	Tue, 17 Nov 2009 07:42:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vd43his6n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133072>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Thomas Rast <trast@student.ethz.ch> wrote:
> >> git-svn has the following rule to detect the SVN base for its
> >> operations: find the first git-svn-id line reachable through
> >> first-parent ancestry.  IOW,
> >> 
> >>   git log --grep=^git-svn-id: --first-parent -1
> >> 
> >> Document this, as it is very important when using merges with git-svn.
> >> 
> >> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> >
> > Thanks Thomas,
> >
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> 
> Thanks; is it a good time to pull from your bogomips repository to get
> accumulated changes?

Now is, I just pushed to it:

Eric Wong (3):
      git svn: read global+system config for clone+init
      git svn: add authorsfile test case for ~/.gitconfig
      git svn: attempt to create empty dirs on clone+rebase

Thomas Rast (1):
      Document git-svn's first-parent rule

Toby Allsopp (1):
      git svn: handle SVN merges from revisions past the tip of the branch

HEAD=ce45a45f24cc7b3ccc7f6ebcd0025559b4421bda

-- 
Eric Wong
