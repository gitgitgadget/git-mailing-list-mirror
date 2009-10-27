From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: add support for merges during 'git svn fetch'
Date: Tue, 27 Oct 2009 00:14:05 -0700
Message-ID: <20091027071405.GA3236@dcvr.yhbt.net>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz> <20091020211637.GA32474@dcvr.yhbt.net> <20091027124056.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 08:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2gFy-0006ZG-JI
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 08:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528AbZJ0HOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 03:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756520AbZJ0HOC
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 03:14:02 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35190 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756516AbZJ0HOB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 03:14:01 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id E93FB1F585;
	Tue, 27 Oct 2009 07:14:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091027124056.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131314>

Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Eric Wong <normalperson@yhbt.net>
> > Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> >> This series adds support for converting SVN merges - in the two
> >> popular formats, SVK and SVN 1.5+, into git parents.
> >
> > Thanks Sam,
> >
> > There's a couple of whitespace issues with lines being too long (using 8
> > character wide tabs).  Otherwise I'm happy to Ack and get them out for
> > more testing/exposure; especially since I'm unlikely to exercise the
> > functionality myself[1] and doesn't appear to break anything.
> >
> > Thanks again.
> 
> What is the status of this series and what should happen now?
> 
> Will Eric add his Ack and send you a pull request, or will you fix 
> them up, forge Eric's Ack and start cooking in your 'next' branch?

Thanks for the ping, I got sidetracked and forgot about this.  I've
fixed up minor formatting details, acked and pushed out Sam's changes to
git://git.bogomips.org/git-svn along with one I small fix I originally
sent out a bad patch for.

Eric Wong (1):
      git svn: fix fetch where glob is on the top-level URL

Sam Vilain (5):
      git-svn: add test data for SVK merge, with script.
      git-svn: allow test setup script to support PERL env. var
      git-svn: convert SVK merge tickets to extra parents
      git-svn: add test data for SVN 1.5+ merge, with script.
      git-svn: convert SVN 1.5+ / svnmerge.py svn:mergeinfo props to parents

(tests pass on the same box where I have my latest code this time :)

-- 
Eric Wong
