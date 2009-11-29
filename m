From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [spf:guess] Re: git-svn: SVK merge commits can have >2 parents
Date: Sun, 29 Nov 2009 12:47:13 -0800
Message-ID: <20091129204713.GA3944@dcvr.yhbt.net>
References: <1259479636-sup-573@utwig> <1259480367-sup-6891@utwig> <20091129080815.GC24222@dcvr.yhbt.net> <1259493967.31767.4.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Vandiver <alex@chmrr.net>, git <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 21:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEqfy-0001cD-0B
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 21:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbZK2UrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 15:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbZK2UrI
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 15:47:08 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41694 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbZK2UrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 15:47:07 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D10A1F5F3;
	Sun, 29 Nov 2009 20:47:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1259493967.31767.4.camel@denix>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134037>

Sam Vilain <sam@vilain.net> wrote:
> On Sun, 2009-11-29 at 08:08 +0000, Eric Wong wrote:
> > Alex Vandiver <alex@chmrr.net> wrote:
> > > At Sun Nov 29 02:28:39 -0500 2009, Alex Vandiver wrote:
> > > > While converting a mildly complicated svn repository that was managed
> > > > with SVK, I ran across the following oddness.  `svk smerge` can only
> > > > merge between _two_ branches at once -- however, the way that svk
> > > > merge detection works, you can end up with erroneous extra parents
> > > > from long-dead branches.
> > > 
> > > Upon a little more inspection, I now understand that the rev-parse
> > > lines in find_extra_svk_parents are attempting to deal with this exact
> > > circumstance -- but they fail to properly sort the merge tickets
> > > first, which leads to this incorrect behavior.  Armed with this
> > > understanding, I'm more confident in the attached updated patch.  I
> > 
> > Hi Alex, Sam,
> > 
> > I'll defer to Sam for the Ack, my svk knowledge is limited. Thanks.
> 
> Yes, the change does make sense to me - nicely done, Alex.
> 
> Acked-By: Sam Vilain <sam@vilain.net>

Thanks Sam, acked and pushed to git://git.bogomips.org/git-svn

-- 
Eric Wong
