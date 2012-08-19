From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3 2/2] git-svn.perl: keep processing all commits in
 parents_exclude
Date: Sun, 19 Aug 2012 19:33:56 +0000
Message-ID: <20120819193356.GA6203@dcvr.yhbt.net>
References: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
 <1344705265-10939-2-git-send-email-stevenrwalter@gmail.com>
 <502FF250.6010402@vilain.net>
 <CAK8d-aKMsSQGMmLrUFDCr1VDbxGPVsPJFgR=Okd-=7BV3AjzOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, avarab@gmail.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 21:34:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3BG7-0006Yr-Jg
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 21:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab2HSTd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 15:33:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52113 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab2HSTd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 15:33:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68401F408;
	Sun, 19 Aug 2012 19:33:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAK8d-aKMsSQGMmLrUFDCr1VDbxGPVsPJFgR=Okd-=7BV3AjzOQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203733>

Steven Walter <stevenrwalter@gmail.com> wrote:
> On Sat, Aug 18, 2012 at 3:51 PM, Sam Vilain <sam@vilain.net> wrote:
> > On 08/11/2012 10:14 AM, Steven Walter wrote:
> >> ---
> >>   git-svn.perl                                     |    1 -
> >>   t/t9164-git-svn-fetch-merge-branch-of-branch2.sh |   53
> >> ++++++++++++++++++++++

Thanks all.

Steven: This doesn't apply cleanly to master since git-svn.perl is
split into separate files (git-svn.perl -> perl/Git/SVN*)

Can you rebase against Junio's current master?  Thanks again.
