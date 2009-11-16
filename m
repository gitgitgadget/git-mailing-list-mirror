From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: add (failing) test for SVN 1.5+ merge
	with intervening commit
Date: Sun, 15 Nov 2009 17:30:13 -0800
Message-ID: <20091116013013.GA3829@dcvr.yhbt.net>
References: <874ooz5o8s.fsf@navakl084.mitacad.com> <20091114214031.GA3732@dcvr.yhbt.net> <87k4xrb785.fsf@navakl084.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Toby Allsopp <Toby.Allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Mon Nov 16 02:30:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9qQO-0000Zn-Dp
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 02:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbZKPBaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 20:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbZKPBaL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 20:30:11 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40551 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbZKPBaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 20:30:10 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8E01F679;
	Mon, 16 Nov 2009 01:30:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87k4xrb785.fsf@navakl084.mitacad.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132979>

Toby Allsopp <Toby.Allsopp@navman.co.nz> wrote:
> [Dropped Junio from CC]
> 
> On Sun, Nov 15 2009, Eric Wong wrote:
> 
> > Hi Toby,
> >
> > Thanks for this series, acked and squashed into a single commit to avoid
> > unnecessary bisection failures at git://git.bogomips.org/git-svn
> 
> Great, thanks.  I have no objection to being squashed, but I'm not sure
> what you mean by bisection failures.  Does a test_expect_failure cause
> problems for bisection?  It appears to be fairly common to introduce a
> failing test case and later fix it, e.g. ce06461 then 751c597.  I'd just
> like to understand any potential problems with what I did.

Oops.  I didn't even notice you had test_expect_failure there :x
I'll just leave it as is incase somebody has already pulled from me
(other, unrelated patches coming in a few)

-- 
Eric Wong
